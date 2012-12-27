http = require 'http'
express = require 'express'

assert = require('chai').assert
request = require 'supertest'

dispatch = require '../'

describe 'a simple one-controller scenario', ->

	controllers =
		test: require './controllers/TestController'

	routeMap =
		'get /test':  'test.get'
		'post /test': 'test.post'

	app = express()
	app.use express.bodyParser()
	dispatch.register(app, controllers, routeMap)

	server = http.createServer(app)
	before (done) -> server.listen(9999, done)
	after  (done) -> server.close(done)

	describe 'a GET request with query string parameters', ->

		it 'should call the appropriate action with the parameters bound to arguments of the function', (next) ->
			request(app)
			.get('/test')
			.query({foo: 'keyboard', bar: 'cat'})
			.expect(200)
			.expect('Content-Type', /json/)
			.end (err, res) ->
				assert res.body?
				assert res.body.foo == 'keyboard'
				assert res.body.bar == 'cat'
				next()

	describe 'a POST request with a urlencoded body', ->

		it 'should call the appropriate action with the parameters bound to arguments of the function', (next) ->
			request(app)
			.post('/test')
			.send({foo: 'keyboard', bar: 'cat'})
			.expect(200)
			.expect('Content-Type', /json/)
			.end (err, res) ->
				assert res.body?
				assert res.body.foo == 'keyboard'
				assert res.body.bar == 'cat'
				next()
