Controller = require('../../').Controller

class TestController extends Controller

	get: (foo, bar) ->
		@response.json {foo, bar}

	post: (foo, bar) ->
		@response.json {foo, bar}

module.exports = TestController
