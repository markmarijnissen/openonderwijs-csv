module.exports = 
  path: "json/duo/vo_board"
  query: "q=amsterdam"
  output: "csv/finance.csv"
  map:
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
        "financial_key_indicators_per_year.capitalization_ratio": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.capitalization_ratio)
        "financial_key_indicators_per_year.contract_activities_div_gov_funding": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.contract_activities_div_gov_funding)
        "financial_key_indicators_per_year.contractactivities_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.contractactivities_div_total_profits)
        "financial_key_indicators_per_year.equity_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.equity_div_total_profits)
        "financial_key_indicators_per_year.facilities_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.facilities_div_total_profits)
        "financial_key_indicators_per_year.general_reserve_div_total_income": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.general_reserve_div_total_income)
        "financial_key_indicators_per_year.gov_funding_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.gov_funding_div_total_profits)
        "financial_key_indicators_per_year.group": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.group)
        "financial_key_indicators_per_year.housing_expenses_div_total_expenses": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.housing_expenses_div_total_expenses)
        "financial_key_indicators_per_year.housing_investment_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.housing_investment_div_total_profits)
        "financial_key_indicators_per_year.investments_relative_to_equity": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.investments_relative_to_equity)
        "financial_key_indicators_per_year.liquidity_current_ratio": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.liquidity_current_ratio)
        "financial_key_indicators_per_year.liquidity_quick_ratio": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.liquidity_quick_ratio)
        "financial_key_indicators_per_year.operating_capital_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.operating_capital_div_total_profits)
        "financial_key_indicators_per_year.operating_capital": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.operating_capital)
        "financial_key_indicators_per_year.other_gov_funding_div_total_profits": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.other_gov_funding_div_total_profits)
        "financial_key_indicators_per_year.profitability": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.profitability)
        "financial_key_indicators_per_year.solvency_1": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.solvency_1)
        "financial_key_indicators_per_year.solvency_2": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.solvency_2)
        "financial_key_indicators_per_year.staff_costs_div_gov_funding": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.staff_costs_div_gov_funding)
        "financial_key_indicators_per_year.staff_expenses_div_total_expenses": (doc,split) ->
          for i,indicator of doc.financial_key_indicators_per_year
            split(indicator.year,indicator.staff_expenses_div_total_expenses)
