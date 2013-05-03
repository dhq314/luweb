local fs = require("fs")
local os = require("os")
local io = require("io")
local string = require("string")
local Template = require ("template")
local util = require("util")
local getContentType = require('mime').getType

local dispatch = {}



function dispatch.index(req, res, filename)
	env = {
		name = "Luvit",
		request_time = os.date("%Y-%m-%d %H:%M:%S", os.time()),
		clock = os.clock()
	}
	render(req, res, env, filename)
end

function dispatch.tool(req, res, filename)
	env = {
		name = "Luvit",
		request_time = os.time(),
	}
	render(req, res, env, filename)
end

function dispatch.other(req, res, filename)
	render(req, res, {}, filename)
end

function render(req, res, env, filename)
	Template.render_file(filename, env, function(result, content)
		local content_type = getContentType(filename)
		if content_type == "application/octet-stream" then
			content_type = "text/html"
		end
		res:writeHead(200, {
    		["Content-Type"] = content_type,
    		["Content-Length"] = #content
 		})
  		res:finish(content)
	end)
end

function dispatch.time(req, res)
	local timestamp = string.match(req.url, "/time/(.*)")
	if not util.is_numeric(timestamp) then
		timestamp = os.time()
	end
	local content = os.date("%Y-%m-%d %H:%M:%S", timestamp)
	res:writeHead(200, {
    	["Content-Type"] = "text/plain",
    	["Content-Length"] = #content
 	})
  	res:finish(content)
end

return dispatch
