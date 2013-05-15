_ = require('prelude-ls')

module.exports =
  # extracts CSV columns from the MAP
  getColumns: (map) ->
    map = require('./map') if not map
    columns = ["_index","_type","_id","_expansion"] 
    for i,index of map
      for i,type of index
        for column,value of type
          columns.push column
    _.unique(columns)

  flatten: (doc,map) ->
    expansion = {}
    createAddFunction = (column) -> 
      (index,value) ->
        expansion[index] = {} if not expansion[index]
        expansion[index][column] = value
        null

    row = 
      _index: doc._index
      _type: doc._type
      _id: doc._id
      _expansion: ""
    for column,value of map[doc._index][doc._type]
      if typeof value is "string"
        row[column] = doc[value]
      else
        value = value(doc,createAddFunction(column))
        row[column] = value if value

    results = [^^row <<< data <<< _expansion: index for index,data of expansion]
    if results.length is 0 then results = [row]
    results