disable_authorization_checks do

  # unless ExtendedMetadataType.where(title: 'bioimage_archive_study_author_affiliation').any?
  #   study_author_affiliation = ExtendedMetadataType.new(title: 'bioimage_archive_study_author_affiliation', supported_type: 'ExtendedMetadata')
  #   study_author_affiliation.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_organisation_name', required: true,
  #                                                                                          sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Name',
  #                                                                                          description: 'The name of the organisation.')
  #   study_author_affiliation.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_organisation_address', required: true,
  #                                                                                          sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Address',
  #                                                                                          description: 'The address of the organisation.')
  #   study_author_affiliation.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_organisation_url', required: true,
  #                                                                                          sample_attribute_type: SampleAttributeType.find_by(title: 'URI'), label: 'URL',
  #                                                                                          description: 'The URL of the organisation.')
  #   study_author_affiliation.save!
  # end
  # study_author_affiliation_emt = ExtendedMetadataType.where(title: 'bioimage_archive_study_author_affiliation').first

  # unless ExtendedMetadataType.where(title: 'bioimage_archive_study_author_metadata').any?
  #   study_author = ExtendedMetadataType.new(title: 'bioimage_archive_study_author_metadata', supported_type: 'ExtendedMetadata')
  #   study_author.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_last_name', required: true,
  #                                                                              sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Last Name',
  #                                                                              description: 'The last name of the author.')
  #   study_author.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_fist_name', required: true,
  #                                                                              sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'First Name',
  #                                                                              description: 'The first name of the author.')
  #   study_author.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_email', required: false,
  #                                                                              sample_attribute_type: SampleAttributeType.find_by(title: 'Email address'), label: 'Email',
  #                                                                              description: 'The email address of the author.')
  #   study_author.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_orcid', required: false,
  #                                                                              sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'ORCID',
  #                                                                              description: 'The ORCID of the author.')
  #   study_author.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_author_affiliation', required: true, label: 'Affiliation',
  #                                                                              sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata').first,
  #                                                                              linked_extended_metadata_type: study_author_affiliation_emt)
  #
  #   study_author.save!
  # end
  # study_author_emt = ExtendedMetadataType.where(title: 'bioimage_archive_study_author_metadata').first

  unless ExtendedMetadataType.where(title: 'Bioimage_archive_study_funding_grant_references_metadata').any?
    study_funding_grant_references = ExtendedMetadataType.new(title: 'Bioimage_archive_study_funding_grant_references_metadata', supported_type: 'ExtendedMetadata')
    study_funding_grant_references.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_funding_grant_references_identifier', required: true,
                                                                                                 sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Identifier',
                                                                                                 description: 'The identifier of the grant.')
    study_funding_grant_references.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_funding_grant_references_funder', required: true,
                                                                                                 sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Funder',
                                                                                                 description: 'The funding body providing the support.')
    study_funding_grant_references.save!
  end
  study_funding_grant_references_emt = ExtendedMetadataType.where(title: 'Bioimage_archive_study_funding_grant_references_metadata').first

  unless ExtendedMetadataType.where(title: 'Bioimage_archive_study_funding_metadata').any?
    study_funding = ExtendedMetadataType.new(title: 'Bioimage_archive_study_funding_metadata', supported_type: 'ExtendedMetadata')
    study_funding.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_funding_statement', required: true,
                                                                                sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Funding statement',
                                                                                description: 'A description of how the data generation was funded.')
    study_funding.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_funding_grant_references', required: false, label: 'Grant References',
                                                                                sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata').first,
                                                                                linked_extended_metadata_type: study_funding_grant_references_emt)
    study_funding.save!
  end
  study_funding_emt = ExtendedMetadataType.where(title: 'Bioimage_archive_study_funding_metadata').first

  # unless ExtendedMetadataType.where(title: 'Bioimage_archive_study_publication_metadata').any?
  #   study_publication = ExtendedMetadataType.new(title: 'Bioimage_archive_study_publication_metadata', supported_type: 'ExtendedMetadata')
  #   study_publication.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publication_title', required: true,
  #                                                                                   sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Title',
  #                                                                                   description: 'The title of the publication.')
  #   study_publication.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publication_authors', required: true,
  #                                                                                   sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Authors',
  #                                                                                   description: 'The authors of the publication.')
  #   study_publication.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publication_doi', required: true,
  #                                                                                   sample_attribute_type: SampleAttributeType.find_by(title: 'DOI'), label: 'DOI',
  #                                                                                   description: 'The DOI of the publication.')
  #   study_publication.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publication_year', required: false,
  #                                                                                   sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Year',
  #                                                                                   description: 'The year of the publication.')
  #   study_publication.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publication_pubmed_id', required: false,
  #                                                                                   sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'PubMed ID',
  #                                                                                   description: 'The PubMed ID of the publication.')
  #   study_publication.save!
  # end
  # study_publication_emt = ExtendedMetadataType.where(title: 'Bioimage_archive_study_publication_metadata').first

  unless ExtendedMetadataType.where(title: 'Bioimage_archive_study_link_metadata').any?
    study_link = ExtendedMetadataType.new(title: 'Bioimage_archive_study_link_metadata', supported_type: 'ExtendedMetadata')
    study_link.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_link_url', required: true,
                                                                             sample_attribute_type: SampleAttributeType.find_by(title: 'URI'), label: 'Link URL',
                                                                             description: 'The URL of the link.')
    study_link.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_link_type', required: false,
                                                                             sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Link Type',
                                                                             description: 'The type of the link.')
    study_link.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_link_description', required: false,
                                                                             sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Link Description',
                                                                             description: 'A description of the link.')

    study_link.save!
  end
  study_link_emt = ExtendedMetadataType.where(title: 'Bioimage_archive_study_link_metadata').first


  unless ExtendedMetadataType.where(title: 'bioimage_archive_study_metadata', supported_type: 'ExtendedMetadata').any?
    bia_study = ExtendedMetadataType.new(title: 'bioimage_archive_study_metadata', supported_type: 'ExtendedMetadata')
    # bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_title', required: true,
    #                                                                         sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Title',
    #                                                                         description: 'The title for your dataset. This will be displayed when search results including your data are shown. Often this will be the same as an associated publication. Must me at least 25 characters long.')
    # bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_description', required: true,
    #                                                                         sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Description',
    #                                                                         description: 'Use this field to describe your dataset. This can be the abstract to an accompanying publication.')
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_private_until_date', required: true,
                                                                            sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Private Until Date',
                                                                            description: 'Date when the data will be made public.')
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_study_keywords', required: true,
                                                                            sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Keywords',
                                                                            description: 'Keywords describing your data that can be used to aid search and classification.')
    # bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_authors', required: true, label: 'Authors',
    #                                                                         sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata (multiple)').first,
    #                                                                         linked_extended_metadata_type: study_author_emt)
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_license', required: false,
                                                                            sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'License',
                                                                            description: 'The license under which the data are available.')
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_funding', required: false, label: 'Funding',
                                                                            sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata').first,
                                                                            linked_extended_metadata_type: study_funding_emt)
    # bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_publications', required: false, label: 'Publications',
    #                                                                         sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata (multiple)').first,
    #                                                                         linked_extended_metadata_type: study_publication_emt)
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_links', required: false, label: 'Links',
                                                                            sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata (multiple)').first,
                                                                            linked_extended_metadata_type: study_link_emt)
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_acknowledgements', required: false,
                                                                            sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'Acknowledgements',
                                                                            description: 'Any people or groups that should be acknowledged as part of the dataset.')
    bia_study.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'bia_study_rembi_version', required: false,
                                                                            sample_attribute_type: SampleAttributeType.find_by(title: 'String'), label: 'REMBI version',
                                                                            description: 'REMBI version.')
    bia_study.save!
  end
end

bia_study_emt = ExtendedMetadataType.where(title: 'bioimage_archive_study_metadata').first

unless ExtendedMetadataType.where(title: 'Bioimage Archive REMBI metadata').any?
  rembi_emt = ExtendedMetadataType.new(title: 'Bioimage Archive REMBI metadata', supported_type: 'Assay')

  rembi_emt.extended_metadata_attributes << ExtendedMetadataAttribute.new(title: 'BioImage Archive Study', 
                                                                          required: true,
                                                                          sample_attribute_type: SampleAttributeType.where(title: 'Linked Extended Metadata').first,
                                                                          linked_extended_metadata_type: bia_study_emt)
  rembi_emt.save!
end
puts 'Seeded Bioimage Archive extended metadata'
