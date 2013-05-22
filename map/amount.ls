module.exports = 
  path: "json/duo/vo_branch"
  query: "q=amsterdam"
  output: "csv/amount.csv"
  map:
    "duo":
      "vo_branch":
        "name":"name"
        "brin":"brin"
        "board_id":"board_id"
        "brand_id":"brand_id"
        "website":"website"
        "reference_year":"reference_year"
        "amount": (doc,split) ->
          if doc?.student_residences?.length
            for r in doc.student_residences 
              for year in ["year_1","year_2","year_3","year_4","year_5","year_6"]
                split(r.zip_code+"_"+year,r[year])
        "amount_per_zip_over_6years": (doc,split) ->
          if doc?.student_residences?.length
            for r in doc.student_residences 
              amount = 0
              for year in ["year_1","year_2","year_3","year_4","year_5","year_6"]
                amount += r[year]
              for year in ["year_1","year_2","year_3","year_4","year_5","year_6"]
                split(r.zip_code+"_"+year,amount)
        "total_amount_per_branch": (doc,split) ->
          if doc?.student_residences?.length
            amount = 0
            for r in doc.student_residences 
              for year in ["year_1","year_2","year_3","year_4","year_5","year_6"]
                amount += r[year]
            for r in doc.student_residences 
              for year in ["year_1","year_2","year_3","year_4","year_5","year_6"]
                split(r.zip_code+"_"+year,amount)

