prompt = require('prompt')
http = require('http')
fs = require('fs') #FileSystem
config = require('./config')
csv = require('./csv')

# add functions to the global namespace
global <<< require('./functions')

prompt.start!
(err,input) <- prompt.get 'query'
input.query = input.query 
url = "#{config.url}/search?#{input.query}"
log url
(err,response) <- request url
if err and err.statusCode is 400
  message = JSON.parse(response)?.message or response
  error "Invalid Query: #message"
else if err
  error 'Unknown Error:'
  log err
else
  response = JSON.parse(response)
  log "Found #{response.total} documents."
  (err,input) <- prompt.get {name:'filename',description:'Output CSV-file'}
  csv.save(input.filename,response)