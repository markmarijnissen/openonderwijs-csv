prompt = require('prompt')
http = require('http')
fs = require('fs') #FileSystem
json2csv = require('json2csv')
_ = require 'prelude-ls'
global <<< require('./functions.ls')

################################################################
#                         CONFIG
config = 
  url: "http://openonderwijsdata.staging.dispectu.com/api/v1"

###############################################################
##             PRIVATE FUNCTIONS

# flattens nested JSON from results to flat JSON 
# according to the MAP 
flattenSearchHits = (searchHits,map) ->
  results = []
  for hit in searchHits
    item = 
      "_index": hit._index
      "_type": hit._type
      "_id": hit._id
    hit <<< hit._source
    results = results.concat(flatten(hit,map))

  results

# convenience method for console.log
log = console.log

# convenience method for console.error
error = console.error

# synchronous version of http request
request = (url,callback) ->
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
save = (filename,map,searchResult) ->
  searchResult = JSON.parse(searchResult) if typeof searchResult is "string"
  args = 
    data: flattenSearchHits(searchResult?.hits,map)
    fields: getColumns(map)
  (err,csv) <- json2csv args
  if err
    console.error err,args.data
  else
    (err) <- fs.writeFile filename,csv
    console.error "Could not save file:",err if err

################################################################
#                         MAIN
prompt.start!

# perform request
(err,input) <- prompt.get 'query'
input.query = input.query 
url = "#{config.url}/search?#{input.query}"
log url

# handle request
(err,response) <- request url
# query is invalid
if err and err.statusCode is 400
  message = JSON.parse(response)?.message or response
  error "Invalid Query: #message"
# other error
else if err
  error 'Unknown Error:'
  log err
# succes! save as *.csv
else
  response = JSON.parse(response)
  log "Found #{response.total} documents."
  options = 
    * name: 'map'
      description: 'JSON-to-CSV mapping'
      default: "map.ls"
    * name:'filename'
      description:'Output CSV-file'
      default:"output.csv"
  (err,input) <- prompt.get options
  save(input.filename,require("./"+input.map),response)