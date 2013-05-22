module.exports = 
  path: "json/duo/vo_school"
  query: "q=amsterdam"
  output: "csv/dropout.csv"
  map:
    "duo":
      "vo_school":
        "name":"name"
        "brin":"brin"      
        "reference_year":"reference_year"
        "corop_area":"corop_area"
        "website":"website"
        "denomination":"denomination"
        "muncipality":"muncipality"
        "education_area":"education_area"
        "education_area_code":"education_area_code"
        "rmc_region":"rmc_region"
        "rmc_region_code":"rmc_region_code"
        "education_structures": (doc) -> doc.education_structures?.join("|")
        "muncipality_code":"muncipality_code"
        "dropouts_per_year_reference_date":"dropouts_per_year_reference_date"
        "dropouts_per_year_url":"dropouts_per_year_url"
        "rpa_area":"rpa_area"
        "rpa_area_code":"rpa_area_code"
        "wgr_area":"wgr_area"
        "wgr_area_code":"wgr_area_code" 
        "dropouts_per_year.dropouts_with_mbo1_diploma": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.dropouts_with_mbo1_diploma)
        "dropouts_per_year.dropouts_with_vmbo_diploma": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.dropouts_with_vmbo_diploma)
        "dropouts_per_year.dropouts_without_diploma": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.dropouts_without_diploma)
        "dropouts_per_year.education_structure": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.education_structure)
        "dropouts_per_year.sector": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.sector)
        "dropouts_per_year.total_dropouts": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.total_dropouts)
        "dropouts_per_year.total_students": (doc,split) ->
          for i,dropout of doc.dropouts_per_year
            split(dropout.year,dropout.total_students)