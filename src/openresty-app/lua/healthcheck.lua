local cjson = require("cjson")
local redis = require "resty.redis"

local red = redis:new()
local ok, err = red:connect("redis", 6379)
if not ok then
    ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR
    ngx.say(cjson.encode({
        result = "failed",
        message = "failed to connect to Redis",
        error = err
    }))
    ngx.exit(ngx.status)
end

ngx.say(cjson.encode({
    result = "ok"
}))
