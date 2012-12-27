Controller = exports.Controller = require './src/Controller'
Route = exports.Route = require './src/Route'

exports.register = (app, controllers, routeMap) ->
	for pattern, target of routeMap
		route = new Route(pattern, target, controllers)
		route.register(app)
