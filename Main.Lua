-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 8740 characters

local ScriptFunctions = {
function(script,require)
local debounce = false
local doormodel = nil
local ran = 0
local height = 0
function instance(link)
	if link ~= "No" then
		local HttpService = game:GetService("HttpService")
		local code = HttpService:GetAsync(link,true)
		local ins = loadstring(code)()
		return ins
	end
end
local corridortype = {}
corridortype.Straight={}
corridortype.Straight.Length=14.235
corridortype.Straight.up=0
corridortype.Straight.Instance="Straight"
corridortype.Straight.uproomheight=0
corridortype.Straight.roomdiagonalincrease=0
corridortype.Up={}
corridortype.Up.Length=28.93
corridortype.Up.Instance="Up"
corridortype.Up.up=11.192
corridortype.Up.uproomheight=0
corridortype.Up.roomdiagonalincrease=0
corridortype.Down={}
corridortype.Down.Length=28.93
corridortype.Down.Instance="Down"
corridortype.Down.up=-11.192
corridortype.Down.uproomheight=0
corridortype.Down.roomdiagonalincrease=0
corridortype.StraightAlt1={}
corridortype.StraightAlt1.Instance="Straight-1"
corridortype.StraightAlt1.Length=29.21
corridortype.StraightAlt1.up=0
corridortype.StraightAlt1.uproomheight=1.889
corridortype.StraightAlt1.roomdiagonalincrease=0
corridortype.Diag1={}
corridortype.Diag1.Instance="Diagonal-1"
corridortype.Diag1.Length=29.21
corridortype.Diag1.up=0
corridortype.Diag1.uproomheight=1.889
corridortype.Diag1.roomdiagonalincrease=46.04800
corridortype.Diag2={}
corridortype.Diag2.Instance="Diagonal-2"
corridortype.Diag2.Length=29.21
corridortype.Diag2.up=0
corridortype.Diag2.uproomheight=1.889
corridortype.Diag2.roomdiagonalincrease=-46.04800

script.Parent.Parent.Event.Event:Connect(function()
	ran = ran+1
	if debounce == false and ran == 1 then
		if doormodel == nil then
			doormodel = script.Parent:FindFirstChildOfClass("Model")
			if doormodel ~= nil then
				print("Door Model Created")
			end
		end
		local r = math.random(1,4)
		local corr
		if r == 1 or height == 10 and r == 2 or height == 0 and r == 3 then
			local f = math.random(1,2)
			if f == 1 then
				corr = corridortype.Straight
			else
				corr = corridortype.StraightAlt1
			end
		elseif r == 2 then
			corr = corridortype.Up
			height = height+1
		elseif r == 3 then
			corr = corridortype.Down
			height = height-1
		elseif r == 4 then
			local f = math.random(1,2)
			if f == 1 then
				corr = corridortype.Diag2
			else
				corr = corridortype.Diag1
			end
		end
		local cinst = script.Parent.Parent.Assets[corr.Instance]
		cinst = cinst:Clone()
		cinst.Parent=game.Workspace
		cinst:PivotTo(CFrame.new(doormodel.Door.Position+Vector3.new(-(corr.roomdiagonalincrease/2),(corr.up/2)+corr.uproomheight,-(corr.Length/2))))
		debounce=true
		wait(.06)
		local i = doormodel:Clone()
		i.Door:Destroy()
		i.DoorHitDetection:Destroy()
		doormodel:PivotTo(CFrame.new(doormodel.Door.Position+Vector3.new(-(corr.roomdiagonalincrease),corr.up,-corr.Length)))
		i.Parent=script
		wait(.06)
		debounce=false
	end
end)
while true do
	wait(.9)
	ran = 0
end
end,
function(script,require)
debounce = false
script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil and debounce == false then
		debounce = true
		script.Parent.Parent.Parent.Parent.Event:Fire()
		debounce = false
	end
end)
end
}
local ScriptIndex = 0
local Scripts,ModuleScripts,ModuleCache = {},{},{}
local _require = require
function require(obj,...)
	local index = ModuleScripts[obj]
	if not index then
		local a,b = pcall(_require,obj,...)
		return not a and error(b,2) or b
	end
	
	local res = ModuleCache[index]
	if res then return res end
	res = ScriptFunctions[index](obj,require)
	if res==nil then error("Module code did not return exactly one value",2) end
	ModuleCache[index] = res
	return res
end
local function Script(obj,ismodule)
	ScriptIndex = ScriptIndex + 1
	local t = ismodule and ModuleScripts or Scripts
	t[obj] = ScriptIndex
end

function RunScripts()
	for script, index in pairs(Scripts) do
		coroutine.wrap(function()
			ScriptFunctions[index](script, require)
		end)()
	end
end


local function Decode(str)
	local StringLength = #str
	
	-- Base64 decoding
	do
		local decoder = {}
		for b64code, char in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split('')) do
			decoder[char:byte()] = b64code-1
		end
		local n = StringLength
		local t,k = table.create(math.floor(n/4)+1),1
		local padding = str:sub(-2) == '==' and 2 or str:sub(-1) == '=' and 1 or 0
		for i = 1, padding > 0 and n-4 or n, 4 do
			local a, b, c, d = str:byte(i,i+3)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8),bit32.extract(v,0,8))
			k = k + 1
		end
		if padding == 1 then
			local a, b, c = str:byte(n-3,n-1)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8))
		elseif padding == 2 then
			local a, b = str:byte(n-3,n-2)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000
			t[k] = string.char(bit32.extract(v,16,8))
		end
		str = table.concat(t)
	end
	
	local Position = 1
	local function Parse(fmt)
		local Values = {string.unpack(fmt,str,Position)}
		Position = table.remove(Values)
		return table.unpack(Values)
	end
	
	local Settings = Parse('B')
	local Flags = Parse('B')
	Flags = {
		--[[ValueIndexByteLength]] bit32.extract(Flags,6,2)+1,
		--[[InstanceIndexByteLength]] bit32.extract(Flags,4,2)+1,
		--[[ConnectionsIndexByteLength]] bit32.extract(Flags,2,2)+1,
		--[[MaxPropertiesLengthByteLength]] bit32.extract(Flags,0,2)+1,
		--[[Use Double instead of Float]] bit32.band(Settings,0b1) > 0
	}
	
	local ValueFMT = ('I'..Flags[1])
	local InstanceFMT = ('I'..Flags[2])
	local ConnectionFMT = ('I'..Flags[3])
	local PropertyLengthFMT = ('I'..Flags[4])
	
	local ValuesLength = Parse(ValueFMT)
	local Values = table.create(ValuesLength)
	local CFrameIndexes = {}
	
	local ValueDecoders = {
		--!!Start
		[1] = function(Modifier)
			return Parse('s'..Modifier)
		end,
		--!!Split
		[2] = function(Modifier)
			return Modifier ~= 0
		end,
		--!!Split
		[3] = function()
			return Parse('d')
		end,
		--!!Split
		[4] = function(_,Index)
			table.insert(CFrameIndexes,{Index,Parse(('I'..Flags[1]):rep(3))})
		end,
		--!!Split
		[5] = {CFrame.new,Flags[5] and 'dddddddddddd' or 'ffffffffffff'},
		--!!Split
		[6] = {Color3.fromRGB,'BBB'},
		--!!Split
		[7] = {BrickColor.new,'I2'},
		--!!Split
		[8] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = ColorSequenceKeypoint.new(Parse('f'),Color3.fromRGB(Parse('BBB')))
			end
			return ColorSequence.new(kpts)
		end,
		--!!Split
		[9] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = NumberSequenceKeypoint.new(Parse(Flags[5] and 'ddd' or 'fff'))
			end
			return NumberSequence.new(kpts)
		end,
		--!!Split
		[10] = {Vector3.new,Flags[5] and 'ddd' or 'fff'},
		--!!Split
		[11] = {Vector2.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[12] = {UDim2.new,Flags[5] and 'di2di2' or 'fi2fi2'},
		--!!Split
		[13] = {Rect.new,Flags[5] and 'dddd' or 'ffff'},
		--!!Split
		[14] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Axes.new(unpack(t))
		end,
		--!!Split
		[15] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Faces.new(unpack(t))
		end,
		--!!Split
		[16] = {PhysicalProperties.new,Flags[5] and 'ddddd' or 'fffff'},
		--!!Split
		[17] = {NumberRange.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[18] = {UDim.new,Flags[5] and 'di2' or 'fi2'},
		--!!Split
		[19] = function()
			return Ray.new(Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')),Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')))
		end
		--!!End
	}
	
	for i = 1,ValuesLength do
		local TypeAndModifier = Parse('B')
		local Type = bit32.band(TypeAndModifier,0b11111)
		local Modifier = (TypeAndModifier - Type) / 0b100000
		local Decoder = ValueDecoders[Type]
		if type(Decoder)=='function' then
			Values[i] = Decoder(Modifier,i)
		else
			Values[i] = Decoder[1](Parse(Decoder[2]))
		end
	end
	
	for i,t in pairs(CFrameIndexes) do
		Values[t[1]] = CFrame.fromMatrix(Values[t[2]],Values[t[3]],Values[t[4]])
	end
	
	local InstancesLength = Parse(InstanceFMT)
	local Instances = {}
	local NoParent = {}
	
	for i = 1,InstancesLength do
		local ClassName = Values[Parse(ValueFMT)]
		local obj
		local MeshPartMesh,MeshPartScale
		if ClassName == "UnionOperation" then
			obj = DecodeUnion(Values,Flags,Parse)
			obj.UsePartColor = true
		elseif ClassName:find("Script") then
			obj = Instance.new("Folder")
			Script(obj,ClassName=='ModuleScript')
		elseif ClassName == "MeshPart" then
			obj = Instance.new("Part")
			MeshPartMesh = Instance.new("SpecialMesh")
			MeshPartMesh.MeshType = Enum.MeshType.FileMesh
			MeshPartMesh.Parent = obj
		else
			obj = Instance.new(ClassName)
		end
		local Parent = Instances[Parse(InstanceFMT)]
		local PropertiesLength = Parse(PropertyLengthFMT)
		local AttributesLength = Parse(PropertyLengthFMT)
		Instances[i] = obj
		for i = 1,PropertiesLength do
			local Prop,Value = Values[Parse(ValueFMT)],Values[Parse(ValueFMT)]
			
			-- ok this looks awful
			if MeshPartMesh then
				if Prop == "MeshId" then
					MeshPartMesh.MeshId = Value
					continue
				elseif Prop == "TextureID" then
					MeshPartMesh.TextureId = Value
					continue
				elseif Prop == "Size" then
					if not MeshPartScale then
						MeshPartScale = Value
					else
						MeshPartMesh.Scale = Value / MeshPartScale
					end
				elseif Prop == "MeshSize" then
					if not MeshPartScale then
						MeshPartScale = Value
						MeshPartMesh.Scale = obj.Size / Value
					else
						MeshPartMesh.Scale = MeshPartScale / Value
					end
					continue
				end
			end
			
			obj[Prop] = Value
		end
		if MeshPartMesh then
			if MeshPartMesh.MeshId=='' then
				if MeshPartMesh.TextureId=='' then
					MeshPartMesh.TextureId = 'rbxasset://textures/meshPartFallback.png'
				end
				MeshPartMesh.Scale = obj.Size
			end
		end
		for i = 1,AttributesLength do
			obj:SetAttribute(Values[Parse(ValueFMT)],Values[Parse(ValueFMT)])
		end
		if not Parent then
			table.insert(NoParent,obj)
		else
			obj.Parent = Parent
		end
	end
	
	local ConnectionsLength = Parse(ConnectionFMT)
	for i = 1,ConnectionsLength do
		local a,b,c = Parse(InstanceFMT),Parse(ValueFMT),Parse(InstanceFMT)
		Instances[a][Values[b]] = Instances[c]
	end
	
	return NoParent
end


local Objects = Decode('AEAhASEFTW9kZWwhCldvcmxkUGl2b3QECwEMAQ0BBA4BDAENAQQPAQwBDQEhBlNjcmlwdCEETmFtZSEERG9vcgQQAQwBDQEhBFBhcnQhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgdpASEGQ0ZyYW1lBBgADAENASEFQ29sb3IG'
..'VkI2IQhNYXRlcmlhbAMAAAAAAACAQCEIUG9zaXRpb24KhMlXwmxikEAFiCTCIQRTaXplCtpFx0Dt1gNBGIUjPyEKVG9wU3VyZmFjZSEQRG9vckhpdERldGVjdGlvbgdMAQQjAAwBDQEhCkNhbkNvbGxpZGUCBnUAAAMAAAAAAMCYQAqEyVfCbGKQQF8sJMIKdjHfQFK4'
..'CkFcj0I/B+oDBCgADAENAQbNzc0KUIZKwjvnjUBR4yTCCuD74z475w1BAKMtPwQrAAwBDQEKCnlXwrj4DEFR4yTCCmpr3UAg/d4+AKMtPwQuAAwBDQEKSD5lwmxikEBR4yTCCkAiFj9rYhBBAKMtPwQxAAwBDQEKcAZYwiC3Yj5R4yTCCsZB5kBAtuI+AKMtPyENQmlu'
..'ZGFibGVFdmVudCEGQXNzZXRzBBEBDAENASEIU3RyYWlnaHQEEgEMAQ0BBDkADAENAQp0WTDC5pcRQuhREsIKxkHmQEC24j6dw2NBBDwADAENAQrndz7CoCkAQuhREsIKAEbWPuaHEkGdw2NBBD8ADAENAQrE2yHCoCkAQuhREsIEQQAMAQ0BCnRZMMKKjtxBUlgSwgrG'
..'QeZAQLbiPuj2Y0EhBVJDRU5UBEUADAENAQqMKTDCpN//QULoEcIKAACAQAAAgD8AAABAIQxUcmFuc3BhcmVuY3kDAAAAAAAA8D8hCkF0dGFjaG1lbnQhA0VuZARMAAwBDQEKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcETwAMAQ0BCgAAAAAAAAAAj8LjQCECVXAEEwEM'
..'AQ0BBFMADAENAQrDL4HCmsU+QgaGMMIKNhPpQGA5LD+osupBB20BBFgAFAENAQZqOQkKvxOBwn6bGUL4L1vCCv/Q5kAAAIA/NnP5QARbABQBDQEKvxOBwn6bDULGmD/CCv/Q5kAAAIA/mZmZPwReABQBDQEKvxOBwn6bEUKSZUTCBGAAFAENAQq/E4HCfpsVQmAyScIE'
..'YgAMAQ0BCi5JdMI2+hZCvgAwwgrAvHU+XI+kQYid6EEEZQAMAQ0BCl0siMI2+hZCvgAwwgRnAAwBDQEKwy+BwhT5KEIg+OzBCjYT6UDOJzlBALSiPgRqAAwBDQEKvyqBwor6FkL0hTDCBGwADAENAQoAOjS9AACsQKRwZ8EEbgAMAQ0BCgAAVTw3ibXAMLJjQQRwABQB'
..'DQEKvxOBwn6bBUIs/zXCBHIAFAENAQq/E4HCfpsJQvjLOsIEdAAUAQ0BCr8TgcL8NvNBxpgnwgR2ABQBDQEKvxOBwvw2+0GSZSzCBHgAFAENAQq/E4HCfpsBQmAyMcIEegAMAQ0BClYZgcKPcd1BvgAwwgrGQeZAQLbiPoid6EEEfQAVAQ0BCr8TgcL8NuNBLP8dwgR/'
..'ABQBDQEKvxOBwvw260H4yyLCIQpTdHJhaWdodC0xBBYBFwENAQdrAASIABcBDQEGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKvWPMwo9x3UFOCzHCIQhSb3RhdGlvbgoAADTDAAAAAAAANMMKPibWQUC24j6InehBBI0AFwENAQq+5ubCOykI'
..'Qk8LMcIKgI6DPhiZUkGInehBBJAAFwENAQqSprHCOykIQk4LMcIEkgAXAQ0BCr5jzMKPcd1B0o7uwQo+JtZBQLbiPgD5Rj4ElQAXAQ0BCr1jzMJNyCFCTgsxwgSXABcBDQEKwUC7wjspCEIbpWrCCvy/HUEYmVJBEqmNPgSaABcBDQEK9lHdwjspCEIbpWrCBJwAFwEN'
..'AQpgF9XCF3EaQhulasIKqrSQQXC0gEASqY0+BJ8AFwENAQr2Ud3COykIQv5f7sEEoQAXAQ0BCmAX1cIXcRpC/l/uwQSjABcBDQEKwUC7wjspCEL+X+7BBKUAFwENAQqoRszC9igIQkQLMcIEqAAYAQ0BCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEqwAMAQ0B'
..'CgDAVDzByvG/FK5pwSEERG93bgQZAQwBDQEErwAaAQ0BCpWKlcKaxT5CBoYwwgSxABsBDQEKmaaVwn6bGUIU3AXCBLMAGwENAQqZppXCfpsNQkZzIcIEtQAbAQ0BCpmmlcJ+mxFCeqYcwgS3ABsBDQEKmaaVwn6bFUKs2RfCBLkAGgENAQrBlZzCNvoWQk4LMcIEuwAa'
..'AQ0BCvuNjsI2+hZCTgsxwgS9ABoBDQEKlYqVwhT5KEL8j2rCBL8AGgENAQqZj5XCivoWQhiGMMIEwQAbAQ0BCpmmlcJ+mwVC4AwrwgTDABsBDQEKmaaVwn6bCUIUQCbCBMUAGwENAQqZppXC/DbzQUZzOcIExwAbAQ0BCpmmlcL8NvtBeqY0wgTJABsBDQEKmaaVwn6b'
..'AUKs2S/CBMsAGgENAQoCoZXCj3HdQU4LMcIEzQAcAQ0BCpmmlcL8NuNB4AxDwgTPABsBDQEKmaaVwvw260EUQD7CIQpEaWFnb25hbC0xBB0BDAENAQTTABcBDQEKT/4lw49x3UFPCzHCCmRDkUJAtuI+iJ3oQQTWABcBDQEKyi9KwzspCEJOCzHCBNgAFwENAQpEsQHD'
..'OykIQk4LMcIE2gAXAQ0BCtoPD8OPcd1B0Y7uwQTdAB4BDQEKAAAAAAAANMMAAAAACrQIJsNNyCFCTwsxwgoAbZFCQLbiPoid6EEE4AAXAQ0BCoRZHcM7KQhCGqVqwgq1kV9CGJlSQRKpjT4E4wAXAQ0BChhERcM7KQhCGqVqwgTlABcBDQEKzSZBwxdxGkIbpWrCBOcA'
..'FwENAQrPZi7DOykIQv9f7sEKN49fQhiZUkESqY0+BOoAFwENAQqraRPDF3EaQv1f7sEE7AAXAQ0BClt+BsM7KQhC/l/uwQTuAB4BDQEKouUlw4NACEJ/6jDCIQpEaWFnb25hbC0yBB8BDAENAQTyABcBDQEKSSMmwzAQKkJPCzHCBPQAFwENAQrEVErDo4BDQk4LMcIE'
..'9gAXAQ0BCj7WAcOjgENCTgsxwgT4ABcBDQEK1DQPwzAQKkLRju7BBPoAHgENAQquLSbDtR9dQk8LMcIE/AAeAQ0BCpwKJsPrl0NCf+owwgQgAR4BDQEE/wAeAQ0BCn17BsMGgUNC3qRqwgQBAR4BDQEK8WMuwwaBQ0LdpGrCBAMBHgENAQrNZhPD4shVQt2kasIEIQEe'
..'AQ0BBAYBHgENAQprph3DlKJGQkJg7sEECAEeAQ0BCrRzQcNw6lhCQ2DuwQQKAR4BDQEK/5BFw5SiRkI/YO7BChz7WMIOHsBBBoYwwgoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACnAGWMKsdJBA7HIkwgqqTTPC/8+QQNcTcsIKcAZYwrl0kEDrciTCCnRZMMIr3/9B'
..'4OcRwgrWKTDCK9//QeDnEcIKyiqBwhD6FkIGhjDCCv3/fz8AAAAAAAAAAAr//38/AAAAAAAAAAAKqEbMwjgpCEJOCzHCCgAAgL8AAAAALr27swoAAIA/AAAAAC69O7QKjo+VwhD6FkIGhjDCCgAAgL8AAAAAAAAAAAr9/3+/AAAAAAAAAAAK//9/vwAAAAAAAAAACqLl'
..'JcOKQAhCjeowwgoAAIC/AAAAAC69uzMKnAomw/KXQ0KN6jDCCqrxJcMGgUNC3aRqwgqaGSbDlKJGQkJg7sFtAQAAAQACAAMAAQABAQACAAQAAQACAQACAAUABgADAAABAAMCAAcACAACAAkACgAFCgAHAAgACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAb'
..'AA4ACgAFCwAHABwACwAMAA0ADgAPAB0AEQAeAB8AIAATACEAFQAiABcAIwAZACQAGwAOAAYABwAACgAFCAALAAwADQAOAA8AJQARACYAEwAnABcAKAAZACkAGwAOAAoABQgACwAMAA0ADgAPACUAEQAqABMAJwAXACsAGQAsABsADgAKAAUIAAsADAANAA4ADwAlABEA'
..'LQATACcAFwAuABkALwAbAA4ACgAFCAALAAwADQAOAA8AJQARADAAEwAnABcAMQAZADIAGwAOADMAAgAAAQACAgAHADQAAgA1AAEADgIABwA2AAIANwAKAA8GAAsADAANAA4AEQA4ABcAOQAZADoAGwAOAAoADwYACwAMAA0ADgARADsAFwA8ABkAPQAbAA4ACgAPBgAL'
..'AAwADQAOABEAPgAXAD8AGQA9ABsADgAKAA8GAAsADAANAA4AEQBAABcAQQAZAEIAGwAOAAoADwsABwBDAAsADAANAA4ADwAlABEARAAfACAAEwAnABcARQAZAEYAGwAOAEcASABJABQDAAcASgARAEsAFwBMAEkAFAMABwBNABEATgAXAE8AAQAOAgAHAFAAAgBRAAoA'
..'FwYACwAMAA0ADgARAFIAFwBTABkAVAAbAA4ACgAXCQALAAwADQAOAA8AVQARAFYAEwBXABUAFgAXAFgAGQBZABsADgAKABcJAAsADAANAA4ADwBVABEAWgATAFcAFQAWABcAWwAZAFwAGwAOAAoAFwkACwAMAA0ADgAPAFUAEQBdABMAVwAVABYAFwBeABkAXAAbAA4A'
..'CgAXCQALAAwADQAOAA8AVQARAF8AEwBXABUAFgAXAGAAGQBcABsADgAKABcGAAsADAANAA4AEQBhABcAYgAZAGMAGwAOAAoAFwYACwAMAA0ADgARAGQAFwBlABkAYwAbAA4ACgAXBgALAAwADQAOABEAZgAXAGcAGQBoABsADgAKABcLAAcAQwALAAwADQAOAA8AJQAR'
..'AGkAHwAgABMAJwAXAGoAGQBGABsADgBHAEgASQAgAwAHAEoAEQBrABcAbABJACADAAcATQARAG0AFwBuAAoAFwkACwAMAA0ADgAPAFUAEQBvABMAVwAVABYAFwBwABkAXAAbAA4ACgAXCQALAAwADQAOAA8AVQARAHEAEwBXABUAFgAXAHIAGQBcABsADgAKABcJAAsA'
..'DAANAA4ADwBVABEAcwATAFcAFQAWABcAdAAZAFwAGwAOAAoAFwkACwAMAA0ADgAPAFUAEQB1ABMAVwAVABYAFwB2ABkAXAAbAA4ACgAXCQALAAwADQAOAA8AVQARAHcAEwBXABUAFgAXAHgAGQBcABsADgAKABcGAAsADAANAA4AEQB5ABcAegAZAHsAGwAOAAoAFwkA'
..'CwAMAA0ADgAPAFUAEQB8ABMAVwAVABYAFwB9ABkAXAAbAA4ACgAXCQALAAwADQAOAA8AVQARAH4AEwBXABUAFgAXAH8AGQBcABsADgABAA4CAAcAgAACAIEACgArCwALAAwADQAOAA8AggARAIMAEwCEABUAhQCGAIcAFwCIAIkAigAZAIsAGwAOAAoAKwgACwAMAA0A'
..'DgARAIwAhgCHABcAjQCJAIoAGQCOABsADgAKACsIAAsADAANAA4AEQCPAIYAhwAXAJAAiQCKABkAjgAbAA4ACgArCAALAAwADQAOABEAkQCGAIcAFwCSAIkAigAZAJMAGwAOAAoAKwgACwAMAA0ADgARAJQAhgCHABcAlQCJAIoAGQCLABsADgAKACsIAAsADAANAA4A'
..'EQCWAIYAhwAXAJcAiQCKABkAmAAbAA4ACgArCAALAAwADQAOABEAmQCGAIcAFwCaAIkAigAZAJgAGwAOAAoAKwgACwAMAA0ADgARAJsAhgCHABcAnACJAIoAGQCdABsADgAKACsIAAsADAANAA4AEQCeAIYAhwAXAJ8AiQCKABkAmAAbAA4ACgArCAALAAwADQAOABEA'
..'oACGAIcAFwChAIkAigAZAJ0AGwAOAAoAKwgACwAMAA0ADgARAKIAhgCHABcAowCJAIoAGQCYABsADgAKACsNAAcAQwALAAwADQAOAA8AJQARAKQAHwAgABMAJwCGAIcAFwClAIkAigAZAEYAGwAOAEcASABJADcEAAcASgARAKYAhgCnABcAqABJADcDAAcAqQARAKoA'
..'FwCrAAEADgIABwCsAAIArQAKADoIAAsADAANAA4AEQCuAIYAhwAXAK8AiQCKABkAVAAbAA4ACgA6CwALAAwADQAOAA8AVQARALAAEwBXABUAFgCGAIcAFwCxAIkAigAZAFkAGwAOAAoAOgsACwAMAA0ADgAPAFUAEQCyABMAVwAVABYAhgCHABcAswCJAIoAGQBcABsA'
..'DgAKADoLAAsADAANAA4ADwBVABEAtAATAFcAFQAWAIYAhwAXALUAiQCKABkAXAAbAA4ACgA6CwALAAwADQAOAA8AVQARALYAEwBXABUAFgCGAIcAFwC3AIkAigAZAFwAGwAOAAoAOggACwAMAA0ADgARALgAhgCHABcAuQCJAIoAGQBjABsADgAKADoIAAsADAANAA4A'
..'EQC6AIYAhwAXALsAiQCKABkAYwAbAA4ACgA6CAALAAwADQAOABEAvACGAIcAFwC9AIkAigAZAGgAGwAOAAoAOg0ABwBDAAsADAANAA4ADwAlABEAvgAfACAAEwAnAIYAhwAXAL8AiQCKABkARgAbAA4ARwBIAEkAQwMABwBKABEAawAXAGwASQBDAwAHAE0AEQBtABcA'
..'bgAKADoLAAsADAANAA4ADwBVABEAwAATAFcAFQAWAIYAhwAXAMEAiQCKABkAXAAbAA4ACgA6CwALAAwADQAOAA8AVQARAMIAEwBXABUAFgCGAIcAFwDDAIkAigAZAFwAGwAOAAoAOgsACwAMAA0ADgAPAFUAEQDEABMAVwAVABYAhgCHABcAxQCJAIoAGQBcABsADgAK'
..'ADoLAAsADAANAA4ADwBVABEAxgATAFcAFQAWAIYAhwAXAMcAiQCKABkAXAAbAA4ACgA6CwALAAwADQAOAA8AVQARAMgAEwBXABUAFgCGAIcAFwDJAIkAigAZAFwAGwAOAAoAOggACwAMAA0ADgARAMoAhgCHABcAywCJAIoAGQB7ABsADgAKADoLAAsADAANAA4ADwBV'
..'ABEAzAATAFcAFQAWAIYAhwAXAM0AiQCKABkAXAAbAA4ACgA6CwALAAwADQAOAA8AVQARAM4AEwBXABUAFgCGAIcAFwDPAIkAigAZAFwAGwAOAAEADgIABwDQAAIA0QAKAE4LAAsADAANAA4ADwCCABEA0gATAIQAFQCFAIYAhwAXANMAiQCKABkA1AAbAA4ACgBOCAAL'
..'AAwADQAOABEA1QCGAIcAFwDWAIkAigAZAI4AGwAOAAoATggACwAMAA0ADgARANcAhgCHABcA2ACJAIoAGQCOABsADgAKAE4IAAsADAANAA4AEQDZAIYAhwAXANoAiQCKABkAkwAbAA4ACgBOCAALAAwADQAOABEA2wCGANwAFwDdAIkAigAZAN4AGwAOAAoATggACwAM'
..'AA0ADgARAN8AhgCHABcA4ACJAIoAGQDhABsADgAKAE4IAAsADAANAA4AEQDiAIYAhwAXAOMAiQCKABkAmAAbAA4ACgBOCAALAAwADQAOABEA5ACGAIcAFwDlAIkAigAZAJ0AGwAOAAoATggACwAMAA0ADgARAOYAhgCHABcA5wCJAIoAGQDoABsADgAKAE4IAAsADAAN'
..'AA4AEQDpAIYAhwAXAOoAiQCKABkAnQAbAA4ACgBOCAALAAwADQAOABEA6wCGAIcAFwDsAIkAigAZAJgAGwAOAAoATg0ABwBDAAsADAANAA4ADwAlABEA7QAfACAAEwAnAIYA3AAXAO4AiQCKABkARgAbAA4ARwBIAEkAWgQABwBKABEApgCGAKcAFwCoAEkAWgMABwCp'
..'ABEAqgAXAKsAAQAOAgAHAO8AAgDwAAoAXQsACwAMAA0ADgAPAIIAEQDxABMAhAAVAIUAhgCHABcA8gCJAIoAGQDUABsADgAKAF0IAAsADAANAA4AEQDzAIYAhwAXAPQAiQCKABkAjgAbAA4ACgBdCAALAAwADQAOABEA9QCGAIcAFwD2AIkAigAZAI4AGwAOAAoAXQgA'
..'CwAMAA0ADgARAPcAhgCHABcA+ACJAIoAGQCTABsADgAKAF0IAAsADAANAA4AEQD5AIYA3AAXAPoAiQCKABkA3gAbAA4ACgBdDQAHAEMACwAMAA0ADgAPACUAEQD7AB8AIAATACcAhgDcABcA/ACJAIoAGQBGABsADgBHAEgASQBjBAAHAEoAEQCmAIYApwAXAKgASQBj'
..'AwAHAKkAEQCqABcAqwABAF0BAAIA/QAKAGYIAAsADAANAA4AEQD+AIYA3AAXAP8AiQCKABkAmAAbAA4ACgBmCAALAAwADQAOABEAAAGGANwAFwABAYkAigAZAOgAGwAOAAoAZggACwAMAA0ADgARAAIBhgDcABcAAwGJAIoAGQCdABsADgABAF0BAAIABAEKAGoIAAsA'
..'DAANAA4AEQAFAYYA3AAXAAYBiQCKABkA4QAbAA4ACgBqCAALAAwADQAOABEABwGGANwAFwAIAYkAigAZAJ0AGwAOAAoAaggACwAMAA0ADgARAAkBhgDcABcACgGJAIoAGQCYABsADgAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
