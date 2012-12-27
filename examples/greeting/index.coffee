express = require 'express'
dispatch = require '../..'

app = express()

# This is necessary to support POST.
app.use express.bodyParser()

app.get '/', (req, res, next) -> res.sendfile "#{__dirname}/views/index.html"

controllers = require './controllers'
routes      = require './routes'

dispatch.register(app, controllers, routes)

app.listen(9999)
console.log "server listening at http://127.0.0.1:9999/"
