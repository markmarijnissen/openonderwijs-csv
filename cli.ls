prompt = require('prompt')
http = require('http')
fs = require('fs') #FileSystem

# add functions to the global namespace
global <<< require('./functions')
# config variables are here
config = 
  url: "http://openonderwijsdata.staging.dispectu.com/api/v1"

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
  (err,input) <- prompt.get {name:'filename',description:'Output CSV-file'}
  save(input.filename,response)