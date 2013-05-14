http = require 'http'
json2csv = require('json2csv')
fs = require('fs')
map = require('./map')
_ = require 'prelude-ls'

# extracts CSV columns from the MAP
getColumns = ->
  columns = []
  for i,index of map
    for i,type of index
      for column,value of type
        columns.push column
  _.unique(columns)

# flattens nested JSON from results to flat JSON 
# according to the MAP from map.ls
flatten = (list) ->
  result = []
  for old-item in list
    new-item = {}
    for column,value of map[old-item._index][old-item._type]
      if typeof value is "string"
        new-item[column] = old-item._source[value]
      else
        new-item[column] = value(old-item._source)
    result.push(new-item)
  result

module.exports = 
  # log a JSON-object pretty-printed
  log-json: (data) -> 
    data = JSON.parse(data) if typeof data is "string"
    console.log(JSON.stringify(data,null,2))
  
  # convenience method for console.log
  log: console.log
  
  # convenience method for console.error
  error: console.error

  # synchronous version of http request
  request: (url,callback) ->
    # response handler handles the http-response
    responseHandler = (response) ->
      # otherwise build string of incoming chunks
      result = ""
      response.on 'data', (chunk) -> result := result + chunk
      # call callback when finished
      response.on 'end', -> 
        # error callback if status isnt 200
        err = response if response.statusCode isnt 200
        callback?(err,result)
    # perform request (and catch errors)
    http.get(url,responseHandler)
      ..on 'error',(err) -> callback?(err,null)

  # save a JSON search-result as CSV according to the map
  save: (filename,searchResult) ->
    searchResult = JSON.parse(searchResult) if typeof searchResult is "string"
    args = 
      data: flatten(searchResult?.hits)
      fields: getColumns()
    (err,csv) <- json2csv args
    if err
      console.error err
    else
      (err) <- fs.writeFile filename,csv
      console.error "Could not save file:",err if err