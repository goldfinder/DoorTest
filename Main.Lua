-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11436 characters

local ScriptFunctions = {
function(script,require)
debounce = false
script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil and debounce == false then
		debounce = true
		script.Parent.Parent.Parent.Parent.Event:Fire()
		debounce = false
	end
end)
end,
function(script,require)
local debounce = false
local doormodel = nil
local ran = 0
local height = 0
local door = 0
local horizonal = 0
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
corridortype.Library={}
corridortype.Library.Instance="LIB"
corridortype.Library.Length=175.5
corridortype.Library.up=6
corridortype.Library.uproomheight=1.793
corridortype.Library.roomdiagonalincrease=0


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
		if door%50 == 0 and door ~= 0 then
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
		else
			corr = corridortype.Library
		end
		door = door+1
		local cinst = script.Parent.Parent.Assets[corr.Instance]
		cinst = cinst:Clone()
		cinst.Parent=script
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


local function DecodeUnion(Values,Flags,Parse,data)
	local m = Instance.new("Folder")
	m.Name = "UnionCache ["..tostring(math.random(1,9999)).."]"
	m.Archivable = false
	m.Parent = game:GetService("ServerStorage")
	local Union,Subtract = {},{}
	if not data then
		data = Parse('B')
	end
	local ByteLength = (data % 4) + 1
	local Length = Parse('I'..ByteLength)
	local ValueFMT = ('I'..Flags[1])
	for i = 1,Length do
		local data = Parse('B')
		local part
		local isNegate = bit32.band(data,0b10000000) > 0
		local isUnion =  bit32.band(data,0b01000000) > 0
		if isUnion then
			part = DecodeUnion(Values,Flags,Parse,data)
		else
			local isMesh = data % 2 == 1
			local ClassName = Values[Parse(ValueFMT)]
			part = Instance.new(ClassName)
			part.Size = Values[Parse(ValueFMT)]
			part.Position = Values[Parse(ValueFMT)]
			part.Orientation = Values[Parse(ValueFMT)]
			if isMesh then
				local mesh = Instance.new("SpecialMesh")
				mesh.MeshType = Values[Parse(ValueFMT)]
				mesh.Scale = Values[Parse(ValueFMT)]
				mesh.Offset = Values[Parse(ValueFMT)]
				mesh.Parent = part
			end
		end
		part.Parent = m
		table.insert(isNegate and Subtract or Union,part)
	end
	local first = table.remove(Union,1)
	if #Union>0 then
		first = first:UnionAsync(Union)
	end
	if #Subtract>0 then
		first = first:SubtractAsync(Subtract)
	end
	m:Destroy()
	return first
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


local Objects = Decode('AECBASEFTW9kZWwhCldvcmxkUGl2b3QEagFrAWwBBG0BawFsAQRuAWsBbAEhBE5hbWUhBERvb3IEbwFrAWwBIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IHaQEhBkNGcmFtZQQXAGsBbAEhBUNvbG9yBlZCNiEITWF0'
..'ZXJpYWwDAAAAAAAAgEAhCFBvc2l0aW9uCpq7Z0KwYpBAFCAOwSEEU2l6ZQraRcdA7dYDQRiFIz8hClRvcFN1cmZhY2UhEERvb3JIaXREZXRlY3Rpb24HTAEEIgBrAWwBIQpDYW5Db2xsaWRlAgZ1AAADAAAAAADAmEAKmrtnQrBikEB7sQzBCnYx30BSuApBXI9CPyEG'
..'U2NyaXB0B+oDBCgAawFsAQbNzc0Kzv50Qn3njUBDjQ/BCuD74z475w1BAKMtPwQrAGsBbAEKFAxoQtn4DEFDjQ/BCmpr3UAg/d4+AKMtPwQuAGsBbAEK1kZaQrBikEBDjQ/BCkAiFj9rYhBBAKMtPwQxAGsBbAEKrn5nQqXAYj5DjQ/BCsZB5kBAtuI+AKMtPyENQmlu'
..'ZGFibGVFdmVudCEGQXNzZXRzBHABawFsASEIU3RyYWlnaHQEcQFrAWwBBDkAawFsAQrVlYdC8JcRQj+PisAKxkHmQEC24j6dw2NBBDwAawFsAQqchoBCqikAQj+PisAKAEbWPuaHEkGdw2NBBD8AawFsAQqt1I5CqikAQj+PisAEQQBrAWwBCtWVh0KejtxBj8KKwArG'
..'QeZAQLbiPuj2Y0EhBVJDRU5UBEUAawFsAQrJrYdCud//QQ9Ch8AKAACAQAAAgD8AAABAIQxUcmFuc3BhcmVuY3kDAAAAAAAA8D8hCkF0dGFjaG1lbnQhA0VuZARMAGsBbAEKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcETwBrAWwBCgAAAAAAAAAAj8LjQCECVXAEcgFr'
..'AWwBBFMAawFsAQqYJT1CpMU+QhgYPsEKNhPpQGA5LD+osupBB20BBFgAcwFsAQZqOQkKoF09QoebGULwX7TBCv/Q5kAAAIA/NnP5QARbAHMBbAEKoF09QoebDUIXY3rBCv/Q5kAAAIA/mZmZPwReAHMBbAEKoF09QoebEUIky4bBBGAAcwFsAQqgXT1Ch5sVQsBkkMEE'
..'YgBrAWwBCvA7S0JB+hZC9wI8wQrAvHU+XI+kQYid6EEEZQBrAWwBCmQsL0JB+hZC9wI8wQRnAGsBbAEKmCU9Qh/5KEL/PihACjYT6UDOJzlBALSiPgRqAGsBbAEKoC89QpP6FkLQFz7BBGwAawFsAQoAOjS9AACsQKRwZ8EEbgBrAWwBCgAAVTw3ibXAMLJjQQRwAHMB'
..'bAEKoF09QoibBUKv/FPBBHIAcwFsAQqgXT1Ch5sJQuAvZ8EEdABzAWwBCqBdPUIPN/NBF2MawQR2AHMBbAEKoF09QhE3+0FIli3BBHgAcwFsAQqgXT1CiJsBQoDJQMEEegBrAWwBCnJSPUKjcd1B9wI8wQrGQeZAQLbiPoid6EEEfQB0AWwBCqBdPUIPN+NBX/nnwAR/'
..'AHMBbAEKoF09Qg8360HgLwfBIQpTdHJhaWdodC0xBHUBdgFsAQdrAASIAHcBeAEGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKkPYaQaNx3UE4LUDBIQhSb3RhdGlvbgoAADRDAAAAAAAANEMKPibWQUC24j6InehBBI0AdwF4AQrghWTARSkI'
..'QjwtQMEKgI6DPhiZUkGInehBBJAAdwF4AQr0b7hBRSkIQjgtQMEEkgB3AXgBCoj2GkGjcd1BbokbQAo+JtZBQLbiPgD5Rj4ElQB3AXgBCpD2GkFXyCFCOC1AwQSXAHcBeAEKOAeSQUUpCEI2StPBCvy/HUEYmVJBEqmNPgSaAHcBeAEKPiacP0UpCEI2StPBBJwAdwF4'
..'AQrwsqpAIXEaQjZK08EKqrSQQXC0gEASqY0+BJ8AdwF4AQo+Jpw/RSkIQhEAHUAEoQB3AXgBCvCyqkAhcRpCEQAdQASjAHcBeAEKOAeSQUUpCEIRAB1ABKUAdwF4AQo33xtB/ygIQhAtQMEEqAB5AWwBCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEqwBrAWwB'
..'CgDAVDzByvG/FK5pwSEERG93bgR6AWsBbAEErwB3AXgBCvRvFEKkxT5CGBg+wQSxAHcBeAEK7DcUQoebGUKAgpu/BLMAdwF4AQrsNxRCh5sNQhfNAcEEtQB3AXgBCuw3FEKHmxFC0DPdwAS3AHcBeAEK7DcUQoebFUJgzbbABLkAdwF4AQqcWQZCQfoWQjgtQMEEuwB3'
..'AXgBCihpIkJB+hZCOC1AwQS9AHcBeAEK9G8UQh/5KEL4H9PBBL8AdwF4AQrsZRRCk/oWQl8YPsEEwQB3AXgBCuw3FEKImwVCfzMowQTDAHcBeAEK7DcUQoebCUJQABXBBMUAdwF4AQrsNxRCDzfzQRjNYcEExwB3AXgBCuw3FEIRN/tB55lOwQTJAHcBeAEK7DcUQoib'
..'AUKwZjvBBMsAdwF4AQoaQxRCo3HdQTgtQMEEzQB3AXgBCuw3FEIPN+NBvRmEwQTPAHcBeAEK7DcUQg8360FQAHXBIQpEaWFnb25hbC0xBHsBawFsAQTTAHcBeAEKHnRYwqNx3UE8LUDBCmRDkUJAtuI+iJ3oQQTWAHcBeAEKBZ20wkUpCEI4LUDBBNgAdwF4AQrkf47B'
..'RSkIQjgtQMEE2gB3AXgBCpR0+cGjcd1BdokbQATcAHcBeAEKsp1YwlfIIUI8LUDBCgBtkUJAtuI+iJ3oQQTfAHcBeAEK8uA1wkUpCEI0StPBCrWRX0IYmVJBEqmNPgTiAHcBeAEKocWqwkUpCEI0StPBBOQAdwF4AQoLi6LCIXEaQjZK08EE5gB3AXgBCh4WesJFKQhC'
..'CAAdQAo3j19CGJlSQRKpjT4E6QB3AXgBCo4hDsIhcRpCGQAdQATrAHcBeAEKnOi0wUUpCEIRAB1ABO0AdwF4AQppEVjCjkAIQvypP8EhCkRpYWdvbmFsLTIEfAFrAWwBBPEAdwF4AQoGCFnCOhAqQjwtQMEE8wB3AXgBCvnmtMKugENCOC1AwQT1AHcBeAEKtKePwa6A'
..'Q0I4LUDBBPcAdwF4AQpknPrBOhAqQnaJG0AE+QB3AXgBCpoxWcK+H11CPC1AwQT7AHcBeAEKUqVYwvSXQ0L8qT/BBH0BfgFsAQT+AHcBeAEKrNG0wRCBQ0K8SdPBBAABdwF4AQqmCnrCEIFDQrpJ08EEAgF3AXgBChYWDsLtyFVCuknTwQR/AX4BbAEEBQGAAXgBCo4U'
..'N8InjUNC8P0cQAQHAYABeAEK2SSjwgPVVULn/RxABAkBgAF4AQpvX6vCJ41DQgr+HEAhA0xJQgSBAWsBbAEEDQFrAWwBCuH9c8IIrABCgqxJQwp6FFhC///bQQ4DYT4EEQF+AWwBCgAAAAAAADTDAAAAAApt5/PBCKwAQsP140IKAAA0wwAAAAAAADTDBBQBawFsAQoA'
..'AAAABoHlv+L6r0IEFgFrAWwBCgAAAAD6fvLAX+WvwgQYAWsBbAEKwfvvwcDKFUKCrElDCj0K6EIehYdBDgNhPgQbAWsBbAEKRufzwQisNELm0+NCCgAA6kIAAMA/Sw8wQwQeAWsBbAEKQBcDPwisAEKCrElDCgAAXEIAANxBDgNhPgQhAWsBbAEKi2zzwfCfnEEYz+NC'
..'CgBA5kIAAIA/AAAwQwQkAWsBbAEKGNuwwgisAELm0+NCCgAAgD8AANxBSw8wQwQnAWsBbAEKuhjcQQisAELm0+NCBCkBawFsAQpA/SI/vp+kQT73hEIKYMOkQQAAgD/A738/BCwBawFsAQpA/SI/vp+oQV/3gkIKYMOkQQAAAEDA738/BC8BawFsAQqUtjNBvp/AQcD3'
..'gEIKAACAPwAAAEH4/Z9ABDIBawFsAQpsSRzBvp/AQcD3gEIENAFrAWwBCliFQsK+n8BBwe95Qgr+cp1CAAAAQcDvfz8hDlVuaW9uT3BlcmF0aW9uB8IABDoBawFsAQajoqUKzE9Dwm4SAUILK4FCCrgenUI/CsNBwHeUQAquR+E+PQrDQaZFkUAKuEkcwW8SAUKcRIFC'
..'CgAAAAAAAAAAAAAAAAq4Hp1CPQrDQS4n4T4Ky09Dwm4SAULB73lCBEIBawFsAQpABJpBbhIBQgsrgUIK4nqEQTwKw0HAd5RACr0SM0FvEgFCnESBQgrrUYRBPQrDQS4n4T4KvBiaQW4SAULB73lCBEgBawFsAQpA/SI/vp+sQYD3gEIKYMOkQQAAQEDA738/BEsBawFs'
..'AQpA/SI/vp+wQUDvfUIKYMOkQQAAgEDA738/BE4BawFsAQpA/SI/vp+0QYHveUIKYMOkQQAAoEDA738/BFEBawFsAQoAexI/Q4u4QejGcUIKAACpQSlcv0AAF0VABFQBawFsAQrkdJtBvp/AQcHveUIKZmZ2QQAAAEHA738/BFcBawFsAQopbPPBv5+4QejGL0IKAkDm'
..'QggAwEBxURBCCgCAHEIAAMBAcFEEQgpcT/JAvp+4QejGKUIKAACBQQAAwEBwURBCCteTmEG+n7hB6MYvQgoAQJxCAADAQHBREEIKFLZDwr6fuEHoxi9CBGABawFsAQoStPLBWmQhQqYmz0EKmZkRQXA9MkEA6NY+BGMBawFsAQqtynXCCKwAQqYmz0EKCtdbQgAA3EEA'
..'6NY+BGYBawFsAQpalfPBEFixQaYmz0EKKFwPQQAA8EAA6NY+BGkBawFsAQoANgg/CKwAQqYmz0EKAopmQiEewEEYGD7BCgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKrn5nQvl0kECwyw3BCrobhkJM0JBArifiwQqufmdCBnWQQKzLDcEK1ZWHQj7f/0EAP4fACqSt'
..'h0I+3/9BAD+HwAqKLz1CGvoWQhgYPsEK/f9/PwAAAAAAAAAACv//fz8AAAAAAAAAAAo43xtBQikIQjgtQMEKAACAvwAAAAAuvbuzCgAAgL8uvbuz7a0JKAouvbuzAACAPy69u7MKAACAPwAAAAAuvTu0CgJmFEIa+hZCGBg+wQpqEVjClEAIQjSqP8EKUqVYwvyXQ0I0'
..'qj/BCopBWMIQgUNCuknTwQoAAIC/AAAAAC69uzMKSuFYwimNQ0Lw/RxACgAAgL8uvbuzAAAAKApG5/PBCKwAQsX140KJAQAAAQACAAMAAQABAQACAAQAAQACAQACAAUAAQADAgAGAAcAAgAIAAkABAoABgAHAAoACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkA'
..'GgANAAkABAsABgAbAAoACwAMAA0ADgAcABAAHQAeAB8AEgAgABQAIQAWACIAGAAjABoADQAkAAYAAAkABAgACgALAAwADQAOACUAEAAmABIAJwAWACgAGAApABoADQAJAAQIAAoACwAMAA0ADgAlABAAKgASACcAFgArABgALAAaAA0ACQAECAAKAAsADAANAA4AJQAQ'
..'AC0AEgAnABYALgAYAC8AGgANAAkABAgACgALAAwADQAOACUAEAAwABIAJwAWADEAGAAyABoADQAkAAMAADMAAgAAAQACAgAGADQAAgA1AAEADgIABgA2AAIANwAJAA8GAAoACwAMAA0AEAA4ABYAOQAYADoAGgANAAkADwYACgALAAwADQAQADsAFgA8ABgAPQAaAA0A'
..'CQAPBgAKAAsADAANABAAPgAWAD8AGAA9ABoADQAJAA8GAAoACwAMAA0AEABAABYAQQAYAEIAGgANAAkADwsABgBDAAoACwAMAA0ADgAlABAARAAeAB8AEgAnABYARQAYAEYAGgANAEcASABJABQDAAYASgAQAEsAFgBMAEkAFAMABgBNABAATgAWAE8AAQAOAgAGAFAA'
..'AgBRAAkAFwYACgALAAwADQAQAFIAFgBTABgAVAAaAA0ACQAXCQAKAAsADAANAA4AVQAQAFYAEgBXABQAFQAWAFgAGABZABoADQAJABcJAAoACwAMAA0ADgBVABAAWgASAFcAFAAVABYAWwAYAFwAGgANAAkAFwkACgALAAwADQAOAFUAEABdABIAVwAUABUAFgBeABgA'
..'XAAaAA0ACQAXCQAKAAsADAANAA4AVQAQAF8AEgBXABQAFQAWAGAAGABcABoADQAJABcGAAoACwAMAA0AEABhABYAYgAYAGMAGgANAAkAFwYACgALAAwADQAQAGQAFgBlABgAYwAaAA0ACQAXBgAKAAsADAANABAAZgAWAGcAGABoABoADQAJABcLAAYAQwAKAAsADAAN'
..'AA4AJQAQAGkAHgAfABIAJwAWAGoAGABGABoADQBHAEgASQAgAwAGAEoAEABrABYAbABJACADAAYATQAQAG0AFgBuAAkAFwkACgALAAwADQAOAFUAEABvABIAVwAUABUAFgBwABgAXAAaAA0ACQAXCQAKAAsADAANAA4AVQAQAHEAEgBXABQAFQAWAHIAGABcABoADQAJ'
..'ABcJAAoACwAMAA0ADgBVABAAcwASAFcAFAAVABYAdAAYAFwAGgANAAkAFwkACgALAAwADQAOAFUAEAB1ABIAVwAUABUAFgB2ABgAXAAaAA0ACQAXCQAKAAsADAANAA4AVQAQAHcAEgBXABQAFQAWAHgAGABcABoADQAJABcGAAoACwAMAA0AEAB5ABYAegAYAHsAGgAN'
..'AAkAFwkACgALAAwADQAOAFUAEAB8ABIAVwAUABUAFgB9ABgAXAAaAA0ACQAXCQAKAAsADAANAA4AVQAQAH4AEgBXABQAFQAWAH8AGABcABoADQABAA4CAAYAgAACAIEACQArCwAKAAsADAANAA4AggAQAIMAEgCEABQAhQCGAIcAFgCIAIkAigAYAIsAGgANAAkAKwgA'
..'CgALAAwADQAQAIwAhgCHABYAjQCJAIoAGACOABoADQAJACsIAAoACwAMAA0AEACPAIYAhwAWAJAAiQCKABgAjgAaAA0ACQArCAAKAAsADAANABAAkQCGAIcAFgCSAIkAigAYAJMAGgANAAkAKwgACgALAAwADQAQAJQAhgCHABYAlQCJAIoAGACLABoADQAJACsIAAoA'
..'CwAMAA0AEACWAIYAhwAWAJcAiQCKABgAmAAaAA0ACQArCAAKAAsADAANABAAmQCGAIcAFgCaAIkAigAYAJgAGgANAAkAKwgACgALAAwADQAQAJsAhgCHABYAnACJAIoAGACdABoADQAJACsIAAoACwAMAA0AEACeAIYAhwAWAJ8AiQCKABgAmAAaAA0ACQArCAAKAAsA'
..'DAANABAAoACGAIcAFgChAIkAigAYAJ0AGgANAAkAKwgACgALAAwADQAQAKIAhgCHABYAowCJAIoAGACYABoADQAJACsNAAYAQwAKAAsADAANAA4AJQAQAKQAHgAfABIAJwCGAIcAFgClAIkAigAYAEYAGgANAEcASABJADcEAAYASgAQAKYAhgCnABYAqABJADcDAAYA'
..'qQAQAKoAFgCrAAEADgIABgCsAAIArQAJADoIAAoACwAMAA0AEACuAIYAhwAWAK8AiQCKABgAVAAaAA0ACQA6CwAKAAsADAANAA4AVQAQALAAEgBXABQAFQCGAIcAFgCxAIkAigAYAFkAGgANAAkAOgsACgALAAwADQAOAFUAEACyABIAVwAUABUAhgCHABYAswCJAIoA'
..'GABcABoADQAJADoLAAoACwAMAA0ADgBVABAAtAASAFcAFAAVAIYAhwAWALUAiQCKABgAXAAaAA0ACQA6CwAKAAsADAANAA4AVQAQALYAEgBXABQAFQCGAIcAFgC3AIkAigAYAFwAGgANAAkAOggACgALAAwADQAQALgAhgCHABYAuQCJAIoAGABjABoADQAJADoIAAoA'
..'CwAMAA0AEAC6AIYAhwAWALsAiQCKABgAYwAaAA0ACQA6CAAKAAsADAANABAAvACGAIcAFgC9AIkAigAYAGgAGgANAAkAOg0ABgBDAAoACwAMAA0ADgAlABAAvgAeAB8AEgAnAIYAhwAWAL8AiQCKABgARgAaAA0ARwBIAEkAQwMABgBKABAAawAWAGwASQBDAwAGAE0A'
..'EABtABYAbgAJADoLAAoACwAMAA0ADgBVABAAwAASAFcAFAAVAIYAhwAWAMEAiQCKABgAXAAaAA0ACQA6CwAKAAsADAANAA4AVQAQAMIAEgBXABQAFQCGAIcAFgDDAIkAigAYAFwAGgANAAkAOgsACgALAAwADQAOAFUAEADEABIAVwAUABUAhgCHABYAxQCJAIoAGABc'
..'ABoADQAJADoLAAoACwAMAA0ADgBVABAAxgASAFcAFAAVAIYAhwAWAMcAiQCKABgAXAAaAA0ACQA6CwAKAAsADAANAA4AVQAQAMgAEgBXABQAFQCGAIcAFgDJAIkAigAYAFwAGgANAAkAOggACgALAAwADQAQAMoAhgCHABYAywCJAIoAGAB7ABoADQAJADoLAAoACwAM'
..'AA0ADgBVABAAzAASAFcAFAAVAIYAhwAWAM0AiQCKABgAXAAaAA0ACQA6CwAKAAsADAANAA4AVQAQAM4AEgBXABQAFQCGAIcAFgDPAIkAigAYAFwAGgANAAEADgIABgDQAAIA0QAJAE4LAAoACwAMAA0ADgCCABAA0gASAIQAFACFAIYAhwAWANMAiQCKABgA1AAaAA0A'
..'CQBOCAAKAAsADAANABAA1QCGAIcAFgDWAIkAigAYAI4AGgANAAkATggACgALAAwADQAQANcAhgCHABYA2ACJAIoAGACOABoADQAJAE4IAAoACwAMAA0AEADZAIYAhwAWANoAiQCKABgAkwAaAA0ACQBOCAAKAAsADAANABAA2wCGAIcAFgDcAIkAigAYAN0AGgANAAkA'
..'TggACgALAAwADQAQAN4AhgCHABYA3wCJAIoAGADgABoADQAJAE4IAAoACwAMAA0AEADhAIYAhwAWAOIAiQCKABgAmAAaAA0ACQBOCAAKAAsADAANABAA4wCGAIcAFgDkAIkAigAYAJ0AGgANAAkATggACgALAAwADQAQAOUAhgCHABYA5gCJAIoAGADnABoADQAJAE4I'
..'AAoACwAMAA0AEADoAIYAhwAWAOkAiQCKABgAnQAaAA0ACQBOCAAKAAsADAANABAA6gCGAIcAFgDrAIkAigAYAJgAGgANAAkATg0ABgBDAAoACwAMAA0ADgAlABAA7AAeAB8AEgAnAIYAhwAWAO0AiQCKABgARgAaAA0ARwBIAEkAWgQABgBKABAApgCGAKcAFgCoAEkA'
..'WgMABgCpABAAqgAWAKsAAQAOAgAGAO4AAgDvAAkAXQsACgALAAwADQAOAIIAEADwABIAhAAUAIUAhgCHABYA8QCJAIoAGADUABoADQAJAF0IAAoACwAMAA0AEADyAIYAhwAWAPMAiQCKABgAjgAaAA0ACQBdCAAKAAsADAANABAA9ACGAIcAFgD1AIkAigAYAI4AGgAN'
..'AAkAXQgACgALAAwADQAQAPYAhgCHABYA9wCJAIoAGACTABoADQAJAF0IAAoACwAMAA0AEAD4AIYAhwAWAPkAiQCKABgA3QAaAA0ACQBdDQAGAEMACgALAAwADQAOACUAEAD6AB4AHwASACcAhgCHABYA+wCJAIoAGABGABoADQBHAEgASQBjBAAGAEoAEACmAIYApwAW'
..'AKgASQBjAwAGAKkAEACqABYAqwABAF0BAAIA/AAJAGYIAAoACwAMAA0AEAD9AIYAhwAWAP4AiQCKABgAmAAaAA0ACQBmCAAKAAsADAANABAA/wCGAIcAFgAAAYkAigAYAOcAGgANAAkAZggACgALAAwADQAQAAEBhgCHABYAAgGJAIoAGACdABoADQABAF0BAAIAAwEJ'
..'AGoIAAoACwAMAA0AEAAEAYYAhwAWAAUBiQCKABgA4AAaAA0ACQBqCAAKAAsADAANABAABgGGAIcAFgAHAYkAigAYAJ0AGgANAAkAaggACgALAAwADQAQAAgBhgCHABYACQGJAIoAGACYABoADQABAA4CAAYACgECAAsBCQBuBgAKAAsADAANABAADAEWAA0BGAAOARoA'
..'DQAJAG4NAAYAQwAKAAsADAANAA4AJQAQAA8BHgAfABIAJwCGABABFgARAYkAEgEYAEYAGgANAEcASABJAHADAAYASgAQABMBFgAUAUkAcAMABgCpABAAFQEWABYBCQBuBgAKAAsADAANABAAFwEWABgBGAAZARoADQAJAG4GAAoACwAMAA0AEAAaARYAGwEYABwBGgAN'
..'AAkAbgYACgALAAwADQAQAB0BFgAeARgAHwEaAA0ACQBuCQAKAAsADAANAA4AVQAQACABEgBXABQAFQAWACEBGAAiARoADQAJAG4GAAoACwAMAA0AEAAjARYAJAEYACUBGgANAAkAbgYACgALAAwADQAQACYBFgAnARgAJQEaAA0ACQBuCQAKAAsADAANAA4AVQAQACgB'
..'EgBXABQAFQAWACkBGAAqARoADQAJAG4JAAoACwAMAA0ADgBVABAAKwESAFcAFAAVABYALAEYAC0BGgANAAkAbgYACgALAAwADQAQAC4BFgAvARgAMAEaAA0ACQBuBgAKAAsADAANABAAMQEWADIBGAAwARoADQAJAG4GAAoACwAMAA0AEAAzARYANAEYADUBGgANADYB'
..'QAIACQA8AT0BPgEACQA/AUABPgFuBwAKAAsADgA3ARAAOAESADkBFAAhABYAOgEYADsBNgFAAgAJADwBRAE+AQAJAEUBRgE+AW4HAAoACwAOADcBEABBARIAOQEUACEAFgBCARgAQwEJAG4JAAoACwAMAA0ADgBVABAARwESAFcAFAAVABYASAEYAEkBGgANAAkAbgkA'
..'CgALAAwADQAOAFUAEABKARIAVwAUABUAFgBLARgATAEaAA0ACQBuCQAKAAsADAANAA4AVQAQAE0BEgBXABQAFQAWAE4BGABPARoADQAJAG4JAAoACwAMAA0ADgBVABAAUAESAFcAFAAVABYAUQEYAFIBGgANAAkAbgYACgALAAwADQAQAFMBFgBUARgAVQEaAA0ANgFA'
..'AwAJAFkBWgE+AQAJAFsBXAE+AQAJAF0BXgE+AW4HAAoACwAOAIIAEABWARIAhAAUAIUAFgBXARgAWAEJAG4GAAoACwAMAA0AEABfARYAYAEYAGEBGgANAAkAbgYACgALAAwADQAQAGIBFgBjARgAZAEaAA0ACQBuBgAKAAsADAANABAAZQEWAGYBGABnARoADQAJAG4G'
..'AAoACwAMAA0AEABoARYAaQEYAGQBGgANAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
