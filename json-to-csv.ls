prompt = require('prompt')
fs = require('fs') #FileSystem
walk = require('walk') # recursive file walker
json2csv = require('json2csv')
_ = require('prelude-ls')
global <<< require('./functions')

################################################################
#                         CONFIG
config =
  delimiter: ";"
  quotechar: '"'
  lineterminator: "\r\n"
  alwaysquote: no
  allcolumns: yes

###############################################################
##             PRIVATE FUNCTIONS
csv-field = (string) -> 
  string = string+""
  regex = new RegExp(config.quotechar,'g')
  string = string.replace regex,config.quotechar+config.quotechar
  if config.alwaysquote or string.match("(#{config.quotechar}|#{config.delimiter}|#{config.lineterminator})") isnt null
    string = config.quotechar+string+config.quotechar
  string

################################################################
#                         MAIN
prompt.start!
options = 
  * name: 'path'
    description: 'JSON directory'
    default: 'data'
  * name: 'mapping'
    description: 'JSON-to-CSV mapping'
    default: "map.ls"
  * name:'output'
    description:'CSV-file'
    default:"output.csv"

(err,input) <- prompt.get options
mapping = require("./"+input.mapping)
columns = getColumns(mapping)
header = _.map(csv-field,columns).join(config.delimiter)+config.lineterminator
fs.writeFile input.output,header

walker = walk.walk(input.path)
walker.on "file", (root,stats,next) ->
  next()
  (err,json) <- fs.readFile "#{root}/#{stats.name}"
  if err then return throw err
  doc = JSON.parse(json)
  [...,doc._index,doc._type] = root.split "/"
  doc._id = stats.name.slice(0,-5)
  #console.log "parsing #{doc._index}/#{doc._type}/#{doc._id}"
  datas = flatten(doc,mapping)
  csv = ""
  for data in datas
    csv += [csv-field(data[column] or "") for column in columns].join(config.delimiter)+config.lineterminator
  (err) <- fs.appendFile input.output,csv
  if err then return throw err
