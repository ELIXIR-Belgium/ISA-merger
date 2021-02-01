const parser = require("xml2js").parseString;
const fs = require("fs");
const fsPromises = fs.promises;

const getData = async () => {
  const ISA_XML = await fsPromises.readFile("./input/ISA.xml");
  const ENA_XML = await fsPromises.readFile("./input/ENA.xml");

  const ISAParsed = await dataParse(ISA_XML);
  const ENAParsed = await dataParse(ENA_XML);

  const ISAData = ISAExtract(ISAParsed);
  const ENAData = ENAExtract(ENAParsed);

  const finalRes = [...ISAData, ...ENAData];
  writeOutput(finalRes);
};

const dataParse = async (data) => {
  return new Promise((r) => {
    parser(data, (e, result) => {
      r(result);
    });
  });
};

const ISAExtract = (data) => {
  const temp = data["isatab-config-file"]["isatab-configuration"][0]["field"];
  return temp.map((x) => {
    return {
      name: x["$"]["header"],
      description: x["description"][0].trim(),
      dataType: x["$"]["data-type"],
      required: x["$"]["is-required"],
      CVList: undefined,
    };
  });
};

const ENAExtract = (data) => {
  const temp = data["CHECKLIST_SET"]["CHECKLIST"][0]["DESCRIPTOR"][0]["FIELD_GROUP"];
  let res = [];
  temp.forEach((x) => {
    return x.FIELD.forEach((y) => {
      const dt = getENADataType(y["FIELD_TYPE"][0]);
      const description = y["DESCRIPTION"] ? y["DESCRIPTION"][0].trim() : "";
      res.push({
        name: y["NAME"][0],
        description,
        required: y["MANDATORY"] == "optional" ? false : true,
        ontology: extractOntology(description),
        ...dt,
      });
    });
  });
  return res;
};

const getENADataType = (data) => {
  let dataType, CVList;
  if (data.TEXT_FIELD) {
    if (data.TEXT_FIELD[0] == "") dataType = "string";
    else
      dataType =
        Array.isArray(data.TEXT_FIELD) && Array.isArray(data.TEXT_FIELD[0]["REGEX_VALUE"])
          ? data.TEXT_FIELD[0]["REGEX_VALUE"][0]
          : "";
  } else if (data.TEXT_AREA_FIELD) dataType = "string";
  else if (data.TEXT_CHOICE_FIELD) {
    dataType = "string";
    CVList = Array.isArray(data.TEXT_CHOICE_FIELD)
      ? data.TEXT_CHOICE_FIELD[0].TEXT_VALUE.map((x) => x["VALUE"][0])
      : undefined;
  }
  return {
    dataType,
    CVList,
  };
};

const URLExpression = /(?:(?:https?|ftp|file):\/\/|www\.|ftp\.)(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#\/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[A-Z0-9+&@#\/%=~_|$])/gim;
const regex = new RegExp(URLExpression);

const extractOntology = (data) => {
  const match = data.match(regex);
  return match ? match[0] : null;
};

const writeOutput = async (data) => {
  try {
    await fsPromises.writeFile("./output/result.txt", JSON.stringify(data));
    console.log("Data was extracted successfully!");
  } catch (e) {
    console.log(`Error writing to file: ${e}`);
  }
};

getData();
