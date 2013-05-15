_ = require('prelude-ls')
fs = require('fs')
prompt = require('prompt')

config =
    url: "http://openonderwijsdata.staging.dispectu.com/api/v1"
    delimiter: ";"
    quotechar: '"'
    lineterminator: "\r\n"
    alwaysquote: no
    allcolumns: yes

module.exports =
  config: config

  run: (params,func) ->
    input = false
    if process.argv.length is 3
      try
        input = require("./map/"+process.argv[2])
        summary = {} <<< input
        delete summary["map"]
        console.log(JSON.stringify(summary,null,2).grey)
    if not input
      prompt.start!
      (err,input) <- prompt.get params
      input.map = require('./map/'+input.map).map
      func(input)
    else
      func(input)

  csv-field: (string) -> 
    string = string+""
    regex = new RegExp(config.quotechar,'g')
    string = string.replace regex,config.quotechar+config.quotechar
    if config.alwaysquote or string.match("(#{config.quotechar}|#{config.delimiter}|#{config.lineterminator})") isnt null
      string = config.quotechar+string+config.quotechar
    string

  # extracts CSV columns from the MAP
  get-columns: (map) ->
    columns = ["_index","_type","_id","_split"] 
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
      _split: ""
    for column,value of map[doc._index]?[doc._type] or {}
      if typeof value is "string"
        row[column] = doc[value]
      else
        value = value(doc,createAddFunction(column))
        row[column] = value if value

    results = [^^row <<< data <<< _split: index for index,data of expansion]
    if results.length is 0 then results = [row]
    results

  obj-arr-to-csv: (obj-arr,columns) ->
    csv = ""
    for data in obj-arr
      csv += [csv-field(data[column] or "") for column in columns].join(config.delimiter)+config.lineterminator
    csv

  write-csv-header: (filename,columns) ->
    header = _.map(csv-field,columns).join(config.delimiter)+config.lineterminator
    fs.writeFile filename,header