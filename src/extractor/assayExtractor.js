const xml2js = require("xml2js"); //.parseString;
const parser = new xml2js.Parser({ explicitChildren: true, preserveChildrenOrder: true }).parseString;
const fs = require("fs");
const { isArray } = require("util");
const fsPromises = fs.promises;

const getENAData = async (options) => {
  const { ISAConfiguration, outputPath } = options;
  const ISA_XML = await fsPromises.readFile(ISAConfiguration);
  const ISAParsed = await dataParse(ISA_XML);
  const ISAData = ISAExtract(ISAParsed);
  writeOutput(ISAData, outputPath);
};

const getMetabolightsData = async (options) => {
  const { firstInput, secondInput, outputPath } = options;
  const firstInput_XML = await fsPromises.readFile(firstInput);
  const firstInputParsed = await dataParse(firstInput_XML);
  let firstInputData = ISAExtract(firstInputParsed);
  firstInputData["data"]["Extraction_ms"] = firstInputData["data"]["Extraction"];
  delete firstInputData["data"]["Extraction"];

  const secondInput_XML = await fsPromises.readFile(secondInput);
  const secondInputParsed = await dataParse(secondInput_XML);
  let secondInputData = ISAExtract(secondInputParsed);
  secondInputData["data"]["Extraction_nmr"] = secondInputData["data"]["Extraction"];
  delete secondInputData["data"]["Extraction"];

  firstInputData.data = { ...firstInputData.data, ...secondInputData.data };
  writeOutput(firstInputData, outputPath);
};

const dataParse = async (data) => {
  return new Promise((r) => {
    parser(data, (e, result) => {
      r(result);
    });
  });
};

const ISAExtract = (data) => {
  const temp = data["isatab-config-file"]["isatab-configuration"][0]["$$"];
  console.log(temp);
  let result = { meta: {}, data: {} };
  let lastProtocol = "";
  temp.forEach((x) => {
    const ontologies = x["recommended-ontologies"] || null;
    if (x["#name"] == "protocol-field") {
      result.data[x["$"]["protocol-type"]] = [];
      lastProtocol = x["$"]["protocol-type"];
    } else if (x["#name"] == "field") {
      if (lastProtocol != "") {
        result.data[lastProtocol].push({
          name: x["$"]["header"],
          description: x["description"][0].trim(),
          dataType: x["$"]["data-type"],
          required: x["$"]["is-required"],
          ontology: ontologies ? extractMetabolightsOntology(ontologies) : null,
          CVList: x?.["list-values"] ? x["list-values"].toString().split(",") : null,
        });
      }
    } else if (x["#name"] == "measurement") {
      result.meta["measurement"] = x["$"]["term-label"];
    } else if (x["#name"] == "technology") {
      result.meta["technology"] = x["$"]["term-label"];
    } else if (x["#name"] == "unit-field") {
      if (lastProtocol != "") {
        result.data[lastProtocol][result.data[lastProtocol].length - 1]["unit"] = x["description"][0].trim();
      }
    }
  });
  console.log(result);
  return result;
};

const extractMetabolightsOntology = (data) => {
  const temp = data[0]["ontology"];
  let output = [];
  temp.forEach((x, i) => {
    output.push({
      name: x["$"]["name"],
      version: x["$"]["version"],
      abbreviation: x["$"]["abbreviation"],
      id: x["$"]["id"],
    });
  });

  return output;
};

const writeOutput = async (data, outputPath) => {
  try {
    await fsPromises.writeFile(outputPath, JSON.stringify(data));
    console.log("Data was extracted successfully!");
  } catch (e) {
    console.log(`Error writing to file: ${e}`);
  }
};

module.exports = { getENAData, getMetabolightsData };
