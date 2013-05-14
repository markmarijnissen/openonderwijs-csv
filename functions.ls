http = require 'http'

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
