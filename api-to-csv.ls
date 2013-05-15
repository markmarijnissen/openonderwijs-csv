http = require('http')
colors = require('colors')
fs = require('fs') #FileSystem
global <<< require('./functions.ls')

###############################################################
##             PRIVATE FUNCTIONS

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

################################################################
#                         MAIN
api-to-csv = (input) ->
  size = 50
  input.max = 1000 if not input.max
  one-round = (from) ->
    # handle request
    url = "#{config.url}/search?#{input.query}&from=#{from}&size=#{size}"
    console.log url.cyan if from is 0
    @from = from
    (err,response) <~ request url
    # query is invalid
    if err and err.statusCode is 400
      message = JSON.parse(response)?.message or response
      console.error "Invalid Query: #message".red
    # other error
    else if err
      console.error 'Unknown Error:'.red
      console.log err
    # succes! save as *.csv
    else
      response = JSON.parse(response)
      columns =  get-columns(input.map)
      if @from is 0
        console.log "Found #{response.total} documents.".green
        write-csv-header(input.output,columns)
      for hit in response.hits
        item = 
          "_index": hit._index
          "_type": hit._type
          "_id": hit._id
        hit <<< hit._source
        obj-arr = flatten(hit,input.map)
        csv = obj-arr-to-csv(obj-arr,columns)
        fs.appendFile input.output,csv
      @from = @from + 50
      if @from > response.total or @from > input.max
        console.log "Done!".green
      else
        console.log "#{@from} / #{Math.min(response.total,input.max)}".yellow
        one-round(@from)
  one-round(0)

params = 
    * name: 'query'
      description: 'Query'
      default: ''
    * name: 'max'
      description: 'Maximum number of results'
      default: '1000'
    * name: 'map'
      description: 'JSON-to-CSV mapping'
      default: "info.ls"
    * name:'output'
      description:'Output CSV-file'
      default:"csv/output.csv"
run(params,api-to-csv)