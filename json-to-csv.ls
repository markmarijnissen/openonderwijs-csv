fs = require('fs') #FileSystem
colors = require('colors')
walk = require('walk') # recursive file walker
global <<< require('./functions')

json-to-csv = (input) ->
  console.log "...converting...".yellow
  columns = getColumns(input.map)
  write-csv-header(input.output,columns)

  walker = walk.walk(input.path)
  i = 0
  walker.on "file", (root,stats,next) ->
    i++
    next()
    (err,json) <- fs.readFile "#{root}/#{stats.name}"
    if stats.name.substr(-5) isnt ".json" then return
    if err then return throw err
    
    try
      doc = JSON.parse(json)
    catch
      console.error "Invalid JSON file: #{root}/#{stats.name}".red
      return
    [...,doc._index,doc._type] = root.split "/"
    doc._id = stats.name.slice(0,-5)
    
    obj-arr = flatten(doc,input.map)
    csv = obj-arr-to-csv(obj-arr,columns)
    (err) <- fs.appendFile input.output,csv
    if err then return throw err
  walker.on "end", -> console.log "Done!".green

params = 
  * name: 'path'
    description: 'JSON directory'
    default: 'json'
  * name: 'map'
    description: 'JSON-to-CSV mapping'
    default: "info.ls"
  * name:'output'
    description:'CSV-file'
    default:"csv/info.csv"
run(params,json-to-csv)