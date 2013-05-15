module.exports = 
  "duo":
    "vo_board":
      "name":"name"
      #"phone":"phone"
      "reference_year":"reference_year"
      "website":"website"
      "muncipality":"muncipality"
      "muncipality_code":"muncipality_code"
      "financial_key_indicators_per_year_reference_date":"financial_key_indicators_per_year_reference_date"
      "financial_key_indicators_per_year_url":"financial_key_indicators_per_year_url"
      "denomination":"denomination"
      "board_id":"board_id"
      "financial_key_indicators_per_year.capitalization_ratio": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.capitalization_ratio)
      "financial_key_indicators_per_year.contract_activities_div_gov_funding": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.contract_activities_div_gov_funding)
      "financial_key_indicators_per_year.contractactivities_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.contractactivities_div_total_profits)
      "financial_key_indicators_per_year.equity_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.equity_div_total_profits)
      "financial_key_indicators_per_year.facilities_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.facilities_div_total_profits)
      "financial_key_indicators_per_year.general_reserve_div_total_income": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.general_reserve_div_total_income)
      "financial_key_indicators_per_year.gov_funding_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.gov_funding_div_total_profits)
      "financial_key_indicators_per_year.group": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.group)
      "financial_key_indicators_per_year.housing_expenses_div_total_expenses": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.housing_expenses_div_total_expenses)
      "financial_key_indicators_per_year.housing_investment_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.housing_investment_div_total_profits)
      "financial_key_indicators_per_year.investments_relative_to_equity": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.investments_relative_to_equity)
      "financial_key_indicators_per_year.liquidity_current_ratio": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.liquidity_current_ratio)
      "financial_key_indicators_per_year.liquidity_quick_ratio": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.liquidity_quick_ratio)
      "financial_key_indicators_per_year.operating_capital_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.operating_capital_div_total_profits)
      "financial_key_indicators_per_year.operating_capital": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.operating_capital)
      "financial_key_indicators_per_year.other_gov_funding_div_total_profits": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.other_gov_funding_div_total_profits)
      "financial_key_indicators_per_year.profitability": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.profitability)
      "financial_key_indicators_per_year.solvency_1": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.solvency_1)
      "financial_key_indicators_per_year.solvency_2": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.solvency_2)
      "financial_key_indicators_per_year.staff_costs_div_gov_funding": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.staff_costs_div_gov_funding)
      "financial_key_indicators_per_year.staff_expenses_div_total_expenses": (doc,add) ->
        for i,indicator of doc.financial_key_indicators_per_year
          add(indicator.year,indicator.staff_expenses_div_total_expenses)

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
      "dropouts_per_year.dropouts_with_mbo1_diploma": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.dropouts_with_mbo1_diploma)
      "dropouts_per_year.dropouts_with_vmbo_diploma": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.dropouts_with_vmbo_diploma)
      "dropouts_per_year.dropouts_without_diploma": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.dropouts_without_diploma)
      "dropouts_per_year.education_structure": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.education_structure)
      "dropouts_per_year.sector": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.sector)
      "dropouts_per_year.total_dropouts": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.total_dropouts)
      "dropouts_per_year.total_students": (doc,add) ->
        for i,dropout of doc.dropouts_per_year
          add(dropout.year,dropout.total_students)


    "vo_branch":
      "name":"name"

  "onderwijsinspectie":
    "vo_branch":
      "name":"name"

  "schoolvo":
    "vo_branch":
      "name":"name"
