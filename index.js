// Require the framework and instantiate it
const api = require("lambda-api")()

// Define a route
api.get("/", async (req, res) => {
  console.log("hello world")
  return "hello world"
})

api.get("/foo", async (req, res) => {
  console.log("/foo hit")
  return "/foo hit"
})

api.get("/bar", async (req, res) => {
  console.log("/bar hit")
  return "/bar hit"
})

// Declare your Lambda handler
exports.handler = async (event, context) => {
  return await api.run(event, context)
}
