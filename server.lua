local http = require("http")
local string = require("string")
local pathJoin = require('path').join
local root = pathJoin(__dirname, 'public')
local port = process.env.PORT or 8080

local dispatch = require("dispatch")



http.createServer(function (req, res)
	if req.url == "/" or req.url == "/index.html" then
		filename = root .. "/index.html"
		dispatch.index(req, res, filename)
	elseif req.url == "/tool.html" then
		filename = root .. req.url
		dispatch.tool(req, res, filename)
	elseif string.match(req.url, "/time/") then
		dispatch.time(req, res)
	else
		filename = root .. req.url
		dispatch.other(req, res, filename)
	end
end):listen(port)

print("Server started " .. port)
