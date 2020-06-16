local cjson = require("cjson")

ngx.say(cjson.encode({
    result = "ok"
}))
