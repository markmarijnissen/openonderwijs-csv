json2csv = require('json2csv')
fs = require('fs')
map = require('./map')
_ = require 'prelude-ls'

getColumns = ->
  columns = []
  for i,index of map
    for i,type of index
      for column,value of type
        columns.push column
  _.unique(columns)

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