dispatch = require '../../..'

class ExampleController extends dispatch.Controller

	greet: (name, color) ->
		@response.send "Hello, <span style='color:#{color}'>#{name}</span>!"

module.exports = ExampleController
