This is a simple library that adds controller classes and parameter binding to [express](http://expressjs.org/).
It's really just a gimmick that I was tinkering with. I'm not sure if it's useful or even a remotely good idea.

To install, just run `npm install express-dispatch`.

## Example

Instead of just binding to a function, as is normal with express, dispatch lets you bind to a class and function.

Here's an example controller:

```coffeescript
dispatch = require 'express-dispatch'

class ExampleController extends dispatch.Controller

  greet: (name) ->
    @response.send "Hello, #{name}!"

module.exports = ExampleController
```

Dispatch lets you connect a route pattern (like `get /user/:userid` or `post /users`) to an action method on a controller.
Everything is connected up by name. Here's how we'd register our example controller to respond to GET requests at `/greet`:

```coffeescript
express = require 'express'
dispatch = require 'express-dispatch'

controllers =
  example: ExampleController

routes =
  'get /greet': 'example.greet'

app = express()
dispatch.register(app, controllers, routes)
app.listen(9999)
```

Now, when someone GETs `/greet`, a new instance of `ExampleController` will be created, and its `greet()` function
will be called with the arguments bound by name to query string parameters.

```
$ curl -XGET http://127.0.0.1:9999/greet?name=Nate
Hello, Nate!
$ 
```

This also works with POSTs. If we changed our route to:

```
routes =
  'post /greet': 'example.greet'
```

Then we could do this:

```
$ curl -XPOST http://127.0.0.1:9999/greet -d 'name=Nate'
Hello, Nate!
$
```

(Note that this requires using the `bodyParser` express middleware.)

For more information, check out the examples and tests.
