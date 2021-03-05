const xml2js = require("xml2js"); //.parseString;
const parser = new xml2js.Parser({ explicitChildren: true, preserveChildrenOrder: true }).parseString;
const fs = require("fs");
const fsPromises = fs.promises;

const getData = async (options) => {
  const { ISAConfiguration, outputPath } = options;
  const ISA_XML = await fsPromises.readFile(ISAConfiguration);
  const ISAParsed = await dataParse(ISA_XML);
  const ISAData = ISAExtract(ISAParsed);
  writeOutput(ISAData, outputPath);
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
  let result = { meta: {}, data: {} };
  let lastProtocol = "";
  temp.forEach((x) => {
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
        });
      }
    } else if (x["#name"] == "measurement") {
      result.meta["measurement"] = x["$"]["term-label"];
    } else if (x["#name"] == "technology") {
      result.meta["technology"] = x["$"]["term-label"];
    }
  });
  // console.log(result);
  return result;
};

const writeOutput = async (data, outputPath) => {
  try {
    await fsPromises.writeFile(outputPath, JSON.stringify(data));
    console.log("Data was extracted successfully!");
  } catch (e) {
    console.log(`Error writing to file: ${e}`);
  }
};

module.exports = { getData };
