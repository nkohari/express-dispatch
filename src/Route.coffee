class Route

	constructor: (url, target, controllers) ->
		[@verb, @pattern] = url.split(/\s+/, 2)
		[name, @action] = target.split('.', 2)
		@controller = controllers[name]
		@params = @getParameterNames(@controller.prototype[@action])

	register: (app) ->
		app[@verb] @pattern, @execute

	execute: (req, res, pass) =>
		instance = new @controller(req, res, pass)
		args = (req.param(param) for param in @params)
		instance[@action].apply(instance, args)

	getParameterNames: (func) ->
		regex = /^function \((.*)\) {/g
		matches = regex.exec func.toString()
		if matches[1].length == 0
			return []
		else
			return matches[1].split /[,\s]+/

module.exports = Route
