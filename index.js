const extractor = require("./src/extractor");

// The source extractor
const options = {
  ENAChecklist: "./input/Source/ENA.xml",
  ISAConfiguration: "./input/Source/ISA.xml",
  outputPath: "./output/result.txt",
};
extractor.sourceExtractor.getData(options);

// // The assay extractor
// extractor.assayExtractor.getData();
