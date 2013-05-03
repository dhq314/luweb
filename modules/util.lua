local table = require("table")
local string = require("string")

local util = {}


-- 规则打印 
function util.print_r(tab)
	local tconcat = table.concat
	local tinsert = table.insert
	local srep = string.rep
	local type = type
	local pairs = pairs
	local tostring = tostring
	local next = next
	local cache = { [tab] = "." }
	local function _dump(t, space, name)
		local temp = {}
		for k, v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp, "+" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp, "+" .. key .. _dump(v, space .. (next(t, k) and "|" or " " ) .. srep(" ", #key), new_key))
			else
				tinsert(temp, "+" .. key .. " [" .. tostring(v).."]")
			end
		end
		return tconcat(temp, "\n"..space)
	end
	print(_dump(tab, "", ""))
end


-- 判断文件是否存在
function util.file_exists(filepath)
	local file = io.open(filepath, "r")
   	if file ~= nil then 
 		io.close(file) 
 		return true 
 	else 
 		return false 
 	end
end


-- 是否数字或数字字符串
function util.is_numeric(val)
	if tonumber(val) ~= nil then
		return true
	else
		return false
	end
end

return util

