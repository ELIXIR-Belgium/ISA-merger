const extractor = require("./src/extractor");

// *** The ENA source extractor
const sourceOptions = {
  ENAChecklist: "./input/ENA/Source/ENA.xml",
  ISAConfiguration: "./input/ENA/Source/ISA.xml",
  outputPath: "./output/sourceMerged.txt",
};
extractor.sourceExtractor.getENAData(sourceOptions);

// *** The assay extractor
const assayOptions = {
  ISAConfiguration: "./input/ENA/Assay/genome_seq.xml",
  outputPath: "./output/assayMerged.txt",
};
extractor.assayExtractor.getENAData(assayOptions);

// *** The Metabolights source extractor
const MetabolightsSourceOptions = {
  ISAConfiguration: "./input/Metabolights/Source/studySample.xml",
  outputPath: "./output/MetabolightsSourceExtracted.txt",
};
extractor.sourceExtractor.getMetabolightsData(MetabolightsSourceOptions);

// *** The Metabolights assay extractor
const MetabolightsAssayOptions = {
  firstInput: "./input/Metabolights/Assay/metaboliteprofiling_ms.xml",
  secondInput: "./input/Metabolights/Assay/metaboliteprofiling_nmr.xml",
  outputPath: "./output/MetabolightsAssayMerged.txt",
};
extractor.assayExtractor.getMetabolightsData(MetabolightsAssayOptions);
