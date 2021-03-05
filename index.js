const extractor = require("./src/extractor");

// *** The source extractor
const sourceOptions = {
  ENAChecklist: "./input/Source/ENA.xml",
  ISAConfiguration: "./input/Source/ISA.xml",
  outputPath: "./output/sourceMerged.txt",
};
extractor.sourceExtractor.getData(sourceOptions);

// *** The assay extractor
const assayOptions = {
  ISAConfiguration: "./input/Assay/genome_seq.xml",
  outputPath: "./output/assayMerged.txt",
};
extractor.assayExtractor.getData(assayOptions);
