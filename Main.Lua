-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 23048 characters

local ScriptFunctions = {
function(script,require)
wait(5)
while true do
	wait()
	local h = script.Parent:GetChildren()
	local c = 0
	for i=1,#h do
		if h[i].ClassName=="Model" then
			c=c+1
		end
	end
	if 8 == c then
		g = Instance.new("Folder")
		g.Parent=game.ReplicatedStorage
		g.Name = "Assets"
		local f = script.Parent:GetChildren()
		for i=1,#f do
			wait()
			if f[i].ClassName == "Model" then
				f[i].Parent = g
			end
		end
		script.Parent:Destroy()
	end
end
end,
function(script,require)
local debounce = false
script.Parent.SDoor.Door.SurfaceGui.Frame.TextBox.Text="0"
local doormodel = nil
local currdoor = script.Parent.SDoor
local lastdoor = nil
local height = 0
local door = 0
local horizonal = 0
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
corridortype.Library.up=5.785
corridortype.Library.uproomheight=4.753
corridortype.Library.roomdiagonalincrease=0

script.Parent.Parent.Events.LoadNextRoom.Event:Connect(function(doorid)
	print("Event Called")
	if doorid ~= door then print "Unable to use doorID" return end
	if doormodel == nil then
		doormodel = script.Parent:FindFirstChildOfClass("Model")
		if doormodel ~= nil then
			print("Door Model Created")
		end
	end
	local r = math.random(1,4)
	local corr
	local librarymod = door % 50
	print(librarymod,door)
	if librarymod==0 and door ~= 0 then
		corr = corridortype.Library
	else
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
	end
	if door == 1000 and door ~= "No more doors :(" then
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets")["Door"]:Clone()
		if lastdoor ~= nil then
			lastdoor.DoorHitDetection:Destroy()
		end
		currdoor.DID.Value=door+1
		local cinst = game.ReplicatedStorage:FindFirstChild("Assets")[corr.Instance]
		cinst = cinst:Clone()
		if cinst.Name=="LIB" then
			cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
		end
		local c = true
		door = "No more doors :("
		cinst.Parent=script
		cinst:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new(-(corr.roomdiagonalincrease/2),(corr.up/2)+corr.uproomheight,-(corr.Length/2))))
		debounce=true
		wait(.06)
		lastdoor.SP.Sound:Play()
		currdoor:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new(-(corr.roomdiagonalincrease),corr.up,-corr.Length)))
		currdoor.Parent=script
		lastdoor.Door:destroy()
		currdoor.Door.SurfaceGui.Frame.TextBox.Text=door
		wait(.06)
		debounce=false
	elseif door ~= "No more doors :(" then
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets")["Door"]:Clone()
		if lastdoor ~= nil then
			lastdoor.DoorHitDetection:Destroy()
		end
		currdoor.DID.Value=door+1
		local cinst = game.ReplicatedStorage:FindFirstChild("Assets")[corr.Instance]
		cinst = cinst:Clone()
		if cinst.Name=="LIB" then
			cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
			if door~=1000 then
				cinst["20"]:Destroy()
			end
		end
		local c = true
		door = door+1
		cinst.Parent=script
		cinst:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new(-(corr.roomdiagonalincrease/2),(corr.up/2)+corr.uproomheight,-(corr.Length/2))))
		debounce=true
		wait(.06)
		lastdoor.SP.Sound:Play()
		currdoor:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new(-(corr.roomdiagonalincrease),corr.up,-corr.Length)))
		currdoor.DoorHitDetection.Touched:Connect(function()
			script.Parent.Parent.Events.LoadNextRoom:Fire(currdoor.DID.Value)
		end)
		currdoor.Parent=script
		lastdoor.Door:destroy()
		currdoor.Door.SurfaceGui.Frame.TextBox.Text=door
		wait(.06)
		debounce=false
	end
end)
end,
function(script,require)
script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
		script.Parent.Parent.Parent.Parent.Events.LoadNextRoom:Fire(script.DID.Value)
	end
end)

end,
function(script,require)
script.Parent.ProximityPrompt.TriggerEnded:Connect(function(plr)
	plr.Character:PivotTo(CFrame.new(65.14, 132.56, -1118.46))
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


local Objects = Decode('AFCQAiEFTW9kZWwhCldvcmxkUGl2b3QEawJsAm0CBG4CbAJtAgRvAmwCbQIEcAJsAm0CIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQEcQJsAm0CIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUAGwCbQIhCFBv'
..'c2l0aW9uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQBsAm0CCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHABsAm0CCsXOr0OPM/VC98CLxAQeAGwCbQIKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNr'
..'Q29sb3IH6gMEKABsAm0CIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AbAJtAgoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyAGwCbQIKAAAAAAAA'
..'AACPwuNAIQJVcARyAmwCbQIENgBsAm0CCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQBzAm0CBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAAHMCbQIKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDAHMCbQIK'
..'lWaQQw6v/UJhXo3EBEUAcwJtAgqVZpBDDq//QseEjcQERwBsAm0CCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgBsAm0CCm2gjkM2LwBDOruMxARMAGwCbQIKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPAGwCbQIK1WCQQ0ovAENkv4zEBFEAbAJtAgoAOjS9'
..'AACsQKRwZ8EEUwBsAm0CCgAAVTw3ibXAMLJjQQRVAHMCbQIKlWaQQw6v90Iu64zEBFcAcwJtAgqVZpBDDq/5QpQRjcQEWQBzAm0CCpVmkEMOr/FC+neMxARbAHMCbQIKlWaQQw+v80JhnozEBF0AcwJtAgqVZpBDDq/1QsfEjMQEXwBsAm0CCi9lkEOzPexCOruMxArG'
..'QeZAQLbiPoid6EEEYgB0Am0CCpVmkEMOr+1CLiuMxARkAHMCbQIKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBHUCdgJtAgdrAARtAHcCeAIGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAA'
..'AAAANEMKPibWQUC24j6InehBBHIAdwJ4Agr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBHUAdwJ4AgoLXqZDHSn5QvW5jsQEdwB3AngCCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegB3AngCCr+un0NU/AJD9bmOxAR8AHcCeAIKf/ejQx0p+ULDhpDECvy/HUEY'
..'mVJBEqmNPgR/AHcCeAIKMXObQx0p+ULDhpDEBIEAdwJ4AgrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BIQAdwJ4Agoxc5tDHSn5QhvrjMQEhgB3AngCCteBnUOGJgFDG+uMxASIAHcCeAIKf/ejQx0p+UIb64zEBIoAdwJ4AgoFtp9D+yj5QvW5jsQEjQB5Am0CCgAA'
..'AACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkABsAm0CCgDAVDzByvG/FK5pwSEERG93bgR6AmwCbQIElAB3AngCCjPBikN+XwpDb7aMxASWAHcCeAIKM7qKQ/cUAUMfYYvEBJgAdwJ4AgozuopD7in8Qtk9jMQEmgB3AngCCjO6ikPuKf5CcheMxAScAHcCeAIKM7qK'
..'Q/cUAEMM8YvEBJ4AdwJ4Agpp/ohDpmwAQ5m6jMQEoAB3AngCClmAjEOmbABDmbqMxASiAHcCeAIKM8GKQ13sBEO+ho7EBKQAdwJ4Agrzv4pDumwAQ2+2jMQEpgB3AngCCjO6ikPuKfhCpYqMxASoAHcCeAIKM7qKQ+4p+kI/ZIzEBKoAdwJ4AgozuopD7inyQtn9jMQE'
..'rAB3AngCCjO6ikPvKfRCcteMxASuAHcCeAIKM7qKQ+4p9kIMsYzEBLAAdwJ4AgqZu4pDk7jsQpm6jMQEsgB3AngCCjO6ikPuKe5CpUqNxAS0AHcCeAIKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBHsCbAJtAgS4AHcCeAIKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3o'
..'QQS7AHcCeAIKIqI/Q1Fc+ULgG5HEBL0AdwJ4AgpVEIRDUVz5QuAbkcQEvwB3AngCChLCekMXpOxCwU2PxATBAHcCeAIKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEAHcCeAIKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHAHcCeAIK0o1EQ1Fc+UKv6JLEBMkA'
..'dwJ4Agoeq0hDIEABQ6/oksQEywB3AngCChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgB3AngCCkJodkMgQAFDBk2PxATQAHcCeAIKyamBQ1Fc+UIGTY/EBNIAdwJ4AgpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEfAJsAm0CBNYAdwJ4AgoycWRD9qvsQtY0jMQE'
..'2AB3AngCCro/QEMwZPlC1jSMxATaAHcCeAIKH1+EQzBk+ULWNIzEBNwAdwJ4AgqqX3tD9qvsQrdmisQE3gB3AngCCs5mZEPcGQND1jSMxATgAHcCeAIK4olkQ9Jv+ULQM4zEBH0CfgJtAgTjAHcCeAIKfwyCQ2Bk+UKjAY7EBOUAdwJ4AgqKMFxDYGT5QqMBjsQE5wB3'
..'AngCCq4td0MoRAFDowGOxAR/An4CbQIE6gB3AngCChLubENsavlC/WWKxATsAHcCeAIKyiBJQy1HAUP9ZYrEBO4AdwJ4Agp6A0VDbGr5Qv1lisQhA0xJQgSAAoECbQIE8gCCAoMCCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYAhAJtAgp5'
..'k6RDfj8DQ17PfMQE+ABsAm0CCgAAAAAGgeW/4vqvQgT6AGwCbQIKAAAAAPp+8sBf5a/CBPwAggKDAgq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BP8AggKDAgp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBggKDAgp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+'
..'BAUBdwJ4AgrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBggKDAgrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBggKDAgp3k4dDfj8DQyLLfMQEDQGCAoMCCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAGCAoMCCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDv'
..'fz8EEwGCAoMCCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgGCAoMCCk03mkPnUPZCnm9wxAQYAYICgwIKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEHwGCAoMCBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HA'
..'d5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBggKDAgq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQND'
..'oO9vxAQuAYICgwIKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAYICgwIKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AYICgwIKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3AYICgwIKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AYICgwIKtZ2LQ+dQ'
..'9kKi72/ECmZmdkEAAABBwO9/PwQ9AYICgwIKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQAAwEBwURBCCsXLi0PoUPRCFE1rxARGAYICgwIKQ4CkQ5JtC0PayWbE'
..'CpmZEUFwPTJBAOjWPgRJAYICgwIKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAYICgwIKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAYICgwIK5xCVQ34/A0PayWbEBIUCbAJtAgRqAYECbQIHxwAEVgF3AngCBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QK'
..'ANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAYYChwIKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABdwJ4Agp+SqpDKITwQos2h8QHagAEZQF3AngCBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAA'
..'gD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagGGAocCCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQFsAm0CCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAFsAm0CCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEcwFsAm0CCsdLnkM9ngNDizaHxAR/AWwC'
..'bQIEdgFsAm0CCg/NnkPWy/5CizaHxAR5AYgCiQIKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7AWwCbQIKD82eQyiE8EKLNofEBH0BbAJtAgoPzZ5DZY7wQos2h8QEfwGIAokCCg7NnkP/p/dCizaHxCEEQXJjaASKAmwCbQIEjAGBAm0CBIQBdwJ4Agp+SqpD1sv+'
..'Qou2hMQEhgGGAocCCn5KqkP/p/dCi7aExASIAXcCeAIKfkqqQyiE8EKLtoTEBIoBdwJ4Agp+SqpDZY7wQou2hMQEjAGGAocCCn9KqkP/p/dCi7aExASOAWwCbQIKx8uqQz2eA0OLtoTEBJABbAJtAgrHi6RDeqgGQ4u2hMQEkgFsAm0CCsdLnkM9ngNDi7aExASdAWwC'
..'bQIElQFsAm0CCg/NnkPWy/5Ci7aExASXAYgCiQIKD82eQ/+n90KLtoTEBJkBbAJtAgoPzZ5DKITwQou2hMQEmwFsAm0CCg/NnkNljvBCi7aExASdAYgCiQIKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABbAJtAgrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABAIQpTdXJm'
..'YWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/'
..'AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQSLAmwCbQIEvwGBAm0CBLcBdwJ4Agp+SqpD1sv+Qos2gsQEuQGGAocCCn5KqkP/p/dCizaCxAS7AXcCeAIKfkqqQyiE8EKLNoLEBL0BdwJ4Agp+SqpDZY7wQos2'
..'gsQEvwGGAocCCn9KqkP/p/dCizaCxATBAWwCbQIKx8uqQz2eA0OLNoLEBMMBbAJtAgrHi6RDeqgGQ4s2gsQExQFsAm0CCsdLnkM9ngNDizaCxATQAWwCbQIEyAFsAm0CCg/NnkPWy/5CizaCxATKAYgCiQIKD82eQ/+n90KLNoLEBMwBbAJtAgoPzZ5DKITwQos2gsQE'
..'zgFsAm0CCg/NnkNljvBCizaCxATQAYgCiQIKDs2eQ/+n90KLNoLEBIwCbAJtAgTcAYECbQIE1AF3AngCCn5KqkPWy/5CFm1/xATWAYYChwIKfkqqQ/+n90IWbX/EBNgBdwJ4Agp+SqpDKITwQhZtf8QE2gF3AngCCn5KqkNljvBCFm1/xATcAYYChwIKf0qqQ/+n90IW'
..'bX/EBN4BbAJtAgrHy6pDPZ4DQxZtf8QE4AFsAm0CCseLpEN6qAZDFm1/xATiAWwCbQIKx0ueQz2eA0MWbX/EBO0BbAJtAgTlAWwCbQIKD82eQ9bL/kIWbX/EBOcBiAKJAgoPzZ5D/6f3QhZtf8QE6QFsAm0CCg/NnkMohPBCFm1/xATrAWwCbQIKD82eQ2WO8EIWbX/E'
..'BO0BiAKJAgoOzZ5D/6f3QhZtf8QEjQJsAm0CBPkBgQJtAgTxAXcCeAIKfkqqQ9bL/kIWbXrEBPMBhgKHAgp+SqpD/6f3QhZtesQE9QF3AngCCn5KqkMohPBCFm16xAT3AXcCeAIKfkqqQ2WO8EIWbXrEBPkBhgKHAgp/SqpD/6f3QhZtesQE+wFsAm0CCsfLqkM9ngND'
..'Fm16xAT9AWwCbQIKx4ukQ3qoBkMWbXrEBP8BbAJtAgrHS55DPZ4DQxZtesQECgJsAm0CBAICbAJtAgoPzZ5D1sv+QhZtesQEBAKIAokCCg/NnkP/p/dCFm16xAQGAmwCbQIKD82eQyiE8EIWbXrEBAgCbAJtAgoPzZ5DZY7wQhZtesQECgKIAokCCg7NnkP/p/dCFm16'
..'xASOAmwCbQIEFgKBAm0CBA4CdwJ4Agp+SqpD1sv+QhZtdcQEEAKGAocCCn5KqkP/p/dCFm11xAQSAncCeAIKfkqqQyiE8EIWbXXEBBQCdwJ4Agp+SqpDZY7wQhZtdcQEFgKGAocCCn9KqkP/p/dCFm11xAQYAmwCbQIKx8uqQz2eA0MWbXXEBBoCbAJtAgrHi6RDeqgG'
..'QxZtdcQEHAJsAm0CCsdLnkM9ngNDFm11xAQnAmwCbQIEHwJsAm0CCg/NnkPWy/5CFm11xAQhAogCiQIKD82eQ/+n90IWbXXEBCMCbAJtAgoPzZ5DKITwQhZtdcQEJQJsAm0CCg/NnkNljvBCFm11xAQnAogCiQIKDs2eQ/+n90IWbXXEIQZTY3JpcHQhBERvb3IEjwJs'
..'Am0CB2kBBC4CbAJtAgZWQjYKx+kUQxdY9UKUFJDECtpFx0Dt1gNBGIUjPwwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIRFQbGFjZWhvbGRlckNvbG9yMyEEVGV4dCEBMAMAAAAAAABEQCEQRG9vckhpdERldGVjdGlvbgdMAQQ6AmwCbQIGdQAACsfpFEMXWPVCtxGQ'
..'xAp2Md9AUrgKQVyPQj8EPQJsAm0CCpQ6GENkMPVCbheQxArg++M+O+cNQQCjLT8EQAJsAm0CCub9FEMH8f1CbheQxApqa91AIP3ePgCjLT8EQwJsAm0CCpaMEUMXWPVCbheQxApAIhY/a2IQQQCjLT8hAlNQBEcCbAJtAgqM2hRDTMPsQm4XkMQKxkHmQEC24j4Aoy0/'
..'IQVTb3VuZCEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzE1NzE2NzIwMyELTnVtYmVyVmFsdWUhA0RJRCEFTWFpbnMhBVNEb29yBJACbAJtAgRSAmwCbQIKmrtnQhdY9UKUFJDEBFQCbAJtAgqau2dCF1j1QrcRkMQEVgJsAm0CCs7+dEJkMPVCbheQxARYAmwCbQIKFAxo'
..'Qgfx/UJuF5DEBFoCbAJtAgrWRlpCF1j1Qm4XkMQEXAJsAm0CCq5+Z0JMw+xCbheQxCEGRXZlbnRzIQ1CaW5kYWJsZUV2ZW50IQxMb2FkTmV4dFJvb20hCUFzc2V0UGF0aARiAmwCbQIKEJtmQiWF7EKZmovECjAzsUKPwvU9KVyPQgRlAmwCbQIKAAAAAK5HkUAAAAAA'
..'CgAAgD8AAIA/AACAPyEPUHJveGltaXR5UHJvbXB0IQpPYmplY3RUZXh0IT1Hb2xkM25GMXIzJ3MgRG9vcnMgRW5naW5lLgoKSW50ZXJhY3Qgd2l0aCBtZSB0byBwbGF5ICJkb29ycyIuIRNSZXF1aXJlc0xpbmVPZlNpZ2h0Cj/1v0O8CZVCH80SxAoAAIA/AAAAAAAA'
..'AAAKAAAAAAAAgD8AAAAACgKKZkK6LA5DJ3WHxAqufmdCO1n1Qo4Uh8QKuhuGQvBe9UKWgYnECgMFrkOJFvVCpr2LxArTYJBDLC8AQ2S/jMQK/f9/PwAAAAAAAAAACv//fz8AAAAAAAAAAAoFtp9DHSn5QvW5jsQKAACAvwAAAAAuvbuzCgAAgL8uvbuz7a0JKAouvbuz'
..'AACAPy69u7MKAACAPwAAAAAuvTu0CvW/ikOcbABDb7aMxApK7GND+Gf5QtoakcQK4olkQ9Zv+ULQM4zECtKiZENgZPlCowGOxAoAAIC/AAAAAC69uzMK4npkQ21q+UL9ZYrECneTpEN+PwNDXs98xAoAAIC/AAAAAAAAAAAKAACAvy69uzPtrQkoCi69uzMAAIA/Lr27'
..'MwoAAIA/AAAAAC69u7MKx4ukQz2eA0OLNofECi69O7MAAIA/Lr27swoAAIA/Lr07M+2tiacKLr07swAAgD8AAAAACgAAgL8uvTuzAAAAAArHi6RDPZ4DQ4u2hMQKx4ukQz2eA0OLNoLECseLpEM9ngNDFm1/xArHi6RDPZ4DQxZtesQKx4ukQz2eA0MWbXXECozaFEM8'
..'WfVC6xOQxAqufmdCPFn1QusTkMQ2AQEAAAABAAIAAwABAAEAAQACAAQAAQACAAEAAgAFAAEAAwABAAIABgAHAAQAAQAIAAkAAQAFAAIACAAKAAIACwAMAAYABgANAA4ADwAQABEAEgATABQAFQAWABcAEAAMAAYABgANAA4ADwAQABEAGAATABkAFQAaABcAEAAMAAYA'
..'BgANAA4ADwAQABEAGwATABwAFQAaABcAEAAMAAYABgANAA4ADwAQABEAHQATAB4AFQAfABcAEAAMAAYACwAIACAADQAOAA8AEAAhACIAEQAjACQAJQAmACcAEwAoABUAKQAXABAAKgArACwACwADAAgALQARAC4AEwAvACwACwADAAgAMAARADEAEwAyAAEABQACAAgA'
..'MwACADQADAAOAAYADQAOAA8AEAARADUAEwA2ABUANwAXABAADAAOAAkADQAOAA8AEAAhADgAEQA5ACYAOgA7ADwAEwA9ABUAPgAXABAADAAOAAkADQAOAA8AEAAhADgAEQA/ACYAOgA7ADwAEwBAABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBCACYAOgA7ADwA'
..'EwBDABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBEACYAOgA7ADwAEwBFABUAQQAXABAADAAOAAYADQAOAA8AEAARAEYAEwBHABUASAAXABAADAAOAAYADQAOAA8AEAARAEkAEwBKABUASAAXABAADAAOAAYADQAOAA8AEAARAEsAEwBMABUATQAXABAADAAOAAsA'
..'CAAgAA0ADgAPABAAIQAiABEATgAkACUAJgAnABMATwAVACkAFwAQACoAKwAsABcAAwAIAC0AEQBQABMAUQAsABcAAwAIADAAEQBSABMAUwAMAA4ACQANAA4ADwAQACEAOAARAFQAJgA6ADsAPAATAFUAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFYAJgA6ADsA'
..'PAATAFcAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFgAJgA6ADsAPAATAFkAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFoAJgA6ADsAPAATAFsAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFwAJgA6ADsAPAATAF0AFQBBABcAEAAMAA4ABgANAA4A'
..'DwAQABEAXgATAF8AFQBgABcAEAAMAA4ACQANAA4ADwAQACEAOAARAGEAJgA6ADsAPAATAGIAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAGMAJgA6ADsAPAATAGQAFQBBABcAEAABAAUAAgAIAGUAAgBmAAwAIgALAA0ADgAPABAAIQBnABEAaAAmAGkAOwBqAGsA'
..'bAATAG0AbgBvABUAcAAXABAADAAiAAgADQAOAA8AEAARAHEAawBsABMAcgBuAG8AFQBzABcAEAAMACIACAANAA4ADwAQABEAdABrAGwAEwB1AG4AbwAVAHMAFwAQAAwAIgAIAA0ADgAPABAAEQB2AGsAbAATAHcAbgBvABUAeAAXABAADAAiAAgADQAOAA8AEAARAHkA'
..'awBsABMAegBuAG8AFQBwABcAEAAMACIACAANAA4ADwAQABEAewBrAGwAEwB8AG4AbwAVAH0AFwAQAAwAIgAIAA0ADgAPABAAEQB+AGsAbAATAH8AbgBvABUAfQAXABAADAAiAAgADQAOAA8AEAARAIAAawBsABMAgQBuAG8AFQCCABcAEAAMACIACAANAA4ADwAQABEA'
..'gwBrAGwAEwCEAG4AbwAVAH0AFwAQAAwAIgAIAA0ADgAPABAAEQCFAGsAbAATAIYAbgBvABUAggAXABAADAAiAAgADQAOAA8AEAARAIcAawBsABMAiABuAG8AFQB9ABcAEAAMACIADQAIACAADQAOAA8AEAAhACIAEQCJACQAJQAmACcAawBsABMAigBuAG8AFQApABcA'
..'EAAqACsALAAuAAQACAAtABEAiwBrAIwAEwCNACwALgADAAgAjgARAI8AEwCQAAEABQACAAgAkQACAJIADAAxAAgADQAOAA8AEAARAJMAawBsABMAlABuAG8AFQA3ABcAEAAMADEACwANAA4ADwAQACEAOAARAJUAJgA6ADsAPABrAGwAEwCWAG4AbwAVAD4AFwAQAAwA'
..'MQALAA0ADgAPABAAIQA4ABEAlwAmADoAOwA8AGsAbAATAJgAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCZACYAOgA7ADwAawBsABMAmgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAJsAJgA6ADsAPABrAGwAEwCcAG4AbwAVAEEAFwAQAAwA'
..'MQAIAA0ADgAPABAAEQCdAGsAbAATAJ4AbgBvABUASAAXABAADAAxAAgADQAOAA8AEAARAJ8AawBsABMAoABuAG8AFQBIABcAEAAMADEACAANAA4ADwAQABEAoQBrAGwAEwCiAG4AbwAVAE0AFwAQAAwAMQANAAgAIAANAA4ADwAQACEAIgARAKMAJAAlACYAJwBrAGwA'
..'EwCkAG4AbwAVACkAFwAQACoAKwAsADoAAwAIAC0AEQBQABMAUQAsADoAAwAIADAAEQBSABMAUwAMADEACwANAA4ADwAQACEAOAARAKUAJgA6ADsAPABrAGwAEwCmAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEApwAmADoAOwA8AGsAbAATAKgAbgBvABUA'
..'QQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCpACYAOgA7ADwAawBsABMAqgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKsAJgA6ADsAPABrAGwAEwCsAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEArQAmADoAOwA8AGsAbAATAK4AbgBvABUA'
..'QQAXABAADAAxAAgADQAOAA8AEAARAK8AawBsABMAsABuAG8AFQBgABcAEAAMADEACwANAA4ADwAQACEAOAARALEAJgA6ADsAPABrAGwAEwCyAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAswAmADoAOwA8AGsAbAATALQAbgBvABUAQQAXABAAAQAFAAIA'
..'CAC1AAIAtgAMAEUACwANAA4ADwAQACEAZwARALcAJgBpADsAagBrAGwAEwC4AG4AbwAVALkAFwAQAAwARQAIAA0ADgAPABAAEQC6AGsAbAATALsAbgBvABUAcwAXABAADABFAAgADQAOAA8AEAARALwAawBsABMAvQBuAG8AFQBzABcAEAAMAEUACAANAA4ADwAQABEA'
..'vgBrAGwAEwC/AG4AbwAVAHgAFwAQAAwARQAIAA0ADgAPABAAEQDAAGsAbAATAMEAbgBvABUAwgAXABAADABFAAgADQAOAA8AEAARAMMAawBsABMAxABuAG8AFQDFABcAEAAMAEUACAANAA4ADwAQABEAxgBrAGwAEwDHAG4AbwAVAH0AFwAQAAwARQAIAA0ADgAPABAA'
..'EQDIAGsAbAATAMkAbgBvABUAggAXABAADABFAAgADQAOAA8AEAARAMoAawBsABMAywBuAG8AFQDMABcAEAAMAEUACAANAA4ADwAQABEAzQBrAGwAEwDOAG4AbwAVAIIAFwAQAAwARQAIAA0ADgAPABAAEQDPAGsAbAATANAAbgBvABUAfQAXABAADABFAA0ACAAgAA0A'
..'DgAPABAAIQAiABEA0QAkACUAJgAnAGsAbAATANIAbgBvABUAKQAXABAAKgArACwAUQAEAAgALQARAIsAawCMABMAjQAsAFEAAwAIAI4AEQCPABMAkAABAAUAAgAIANMAAgDUAAwAVAALAA0ADgAPABAAIQBnABEA1QAmAGkAOwBqAGsAbAATANYAbgBvABUAuQAXABAA'
..'DABUAAgADQAOAA8AEAARANcAawBsABMA2ABuAG8AFQBzABcAEAAMAFQACAANAA4ADwAQABEA2QBrAGwAEwDaAG4AbwAVAHMAFwAQAAwAVAAIAA0ADgAPABAAEQDbAGsAbAATANwAbgBvABUAeAAXABAADABUAAgADQAOAA8AEAARAN0AawBsABMA3gBuAG8AFQDCABcA'
..'EAAMAFQADQAIACAADQAOAA8AEAAhACIAEQDfACQAJQAmACcAawBsABMA4ABuAG8AFQApABcAEAAqACsALABaAAQACAAtABEAiwBrAIwAEwCNACwAWgADAAgAjgARAI8AEwCQAAEAVAABAAIA4QAMAF0ACAANAA4ADwAQABEA4gBrAGwAEwDjAG4AbwAVAH0AFwAQAAwA'
..'XQAIAA0ADgAPABAAEQDkAGsAbAATAOUAbgBvABUAzAAXABAADABdAAgADQAOAA8AEAARAOYAawBsABMA5wBuAG8AFQCCABcAEAABAFQAAQACAOgADABhAAgADQAOAA8AEAARAOkAawBsABMA6gBuAG8AFQDFABcAEAAMAGEACAANAA4ADwAQABEA6wBrAGwAEwDsAG4A'
..'bwAVAIIAFwAQAAwAYQAIAA0ADgAPABAAEQDtAGsAbAATAO4AbgBvABUAfQAXABAAAQAFAAIACADvAAIA8AAMAGUACAANAA4ADwAQABEA8QBrAGwAEwDyAG4A8wAVAPQAFwAQAAwAZQALAAgAIAANAA4ADwAQACEAIgARAPUAJAAlACYAJwATAPYAFQApABcAEAAqACsA'
..'LABnAAMACAAtABEA9wATAPgALABnAAMACACOABEA+QATAPoADABlAAgADQAOAA8AEAARAPsAawBsABMA/ABuAPMAFQD9ABcAEAAMAGUACAANAA4ADwAQABEA/gBrAGwAEwD/AG4A8wAVAAABFwAQAAwAZQAIAA0ADgAPABAAEQABAWsAbAATAAIBbgDzABUAAwEXABAA'
..'DABlAAsADQAOAA8AEAAhADgAEQAEASYAOgA7ADwAawBsABMABQFuAG8AFQAGARcAEAAMAGUACAANAA4ADwAQABEABwFrAGwAEwAIAW4A8wAVAAkBFwAQAAwAZQAIAA0ADgAPABAAEQAKAWsAbAATAAsBbgDzABUACQEXABAADABlAAsADQAOAA8AEAAhADgAEQAMASYA'
..'OgA7ADwAawBsABMADQFuAPMAFQAOARcAEAAMAGUACwANAA4ADwAQACEAOAARAA8BJgA6ADsAPABrAGwAEwAQAW4A8wAVABEBFwAQAAwAZQAIAA0ADgAPABAAEQASAWsAbAATABMBbgDzABUAFAEXABAADABlAAgADQAOAA8AEAARABUBawBsABMAFgFuAPMAFQAUARcA'
..'EAAMAGUACAANAA4ADwAQABEAFwFrAGwAEwAYAW4A8wAVABkBFwAQABoBQAIADAAiASMBbAAADAAkASUBbABlAAoADQAOACEAGwERABwBJgAdATsAHgFrAGwAEwAfAW4A8wAVACABIQEOABoBQAIADAApASoBbAAADAArASwBbABlAAoADQAOACEAGwERACYBJgAdATsA'
..'HgFrAGwAEwAnAW4A8wAVACgBIQEOAAwAZQALAA0ADgAPABAAIQA4ABEALQEmADoAOwA8AGsAbAATAC4BbgDzABUALwEXABAADABlAAsADQAOAA8AEAAhADgAEQAwASYAOgA7ADwAawBsABMAMQFuAPMAFQAyARcAEAAMAGUACwANAA4ADwAQACEAOAARADMBJgA6ADsA'
..'PABrAGwAEwA0AW4A8wAVADUBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEANgEmADoAOwA8AGsAbAATADcBbgDzABUAOAEXABAADABlAAgADQAOAA8AEAARADkBawBsABMAOgFuAPMAFQA7ARcAEAAaAUADAAwAPwFAAWwAAAwAQQFCAWwAAAwAQwFEAWwAZQAKAA0ADgAh'
..'AGcAEQA8ASYAaQA7AGoAawBsABMAPQFuAPMAFQA+ASEBDgAMAGUACAANAA4ADwAQABEARQFrAGwAEwBGAW4A8wAVAEcBFwAQAAwAZQAIAA0ADgAPABAAEQBIAWsAbAATAEkBbgDzABUASgEXABAADABlAAgADQAOAA8AEAARAEsBawBsABMATAFuAPMAFQBNARcAEAAM'
..'AGUACAANAA4ADwAQABEATgFrAGwAEwBPAW4A8wAVAEoBFwAQAAEAZQABAAIAUAEBAIEAAQACAFEBDACCAAwADQAOAA8AEAAhAFIBEQBTASYAVAE7AFUBawBsABMAVgFuAG8AFQBXARcAEABYAVkBDACCAAsADQAOAA8AEAAhAFIBEQBaASYAVAE7AFUBawBbARMAXAFu'
..'AF0BFQBeARcAEAAMAIIADAANAA4ADwAQACEAUgERAF8BJgBUATsAVQFrAGwAEwBgAW4AbwAVAFcBFwAQAFgBWQEMAIIADAANAA4ADwAQACEAYQERAGIBJgBjATsAZAFrAGwAEwBlAW4AbwAVAGYBFwAQAFgBWQFnAYYAAgAmAGMBaAEQAAwAggALAA0ADgAPABAAIQBh'
..'AREAaQEmAGMBOwBkAWsAWwETAGoBbgBdARUAawEXABAAZwGIAAIAJgBjAWgBEAAMAIIADAANAA4ADwAQACEAYQERAFMBJgBjATsAZAFrAGwAEwBWAW4AbwAVAGYBFwAQAFgBWQFnAYoAAgAmAGMBaAEQAAwAgQAGAA0ADgAPABAAEQBsARMAbQEVAG4BFwAQAAwAgQAG'
..'AA0ADgAPABAAEQBvARMAcAEVAHEBFwAQAAwAgQAGAA0ADgAPABAAEQByARMAcwEVAG4BFwAQAAEAgQABAAIAdAEMAI8ACgANAA4ADwAQACEAUgERAHUBJgBUATsAVQETAHYBFQBXARcAEABYAVkBDACPAAsADQAOAA8AEAAhAFIBEQB3ASYAVAE7AFUBawB4ARMAeQFu'
..'AHgBFQBeARcAEAAMAI8ACgANAA4ADwAQACEAUgERAHoBJgBUATsAVQETAHsBFQBXARcAEABYAVkBDACPAAoADQAOAA8AEAAhAGEBEQB8ASYAYwE7AGQBEwB9ARUAZgEXABAAWAFZAWcBkwACACYAYwFoARAADACPAAsADQAOAA8AEAAhAGEBEQB+ASYAYwE7AGQBawB4'
..'ARMAfwFuAHgBFQBrARcAEABnAZUAAgAmAGMBaAEQAAwAjwAKAA0ADgAPABAAIQBhAREAdQEmAGMBOwBkARMAdgEVAGYBFwAQAFgBWQFnAZcAAgAmAGMBaAEQAAEAZQACAAgAgAECAIEBAQCZAAEAAgCCAQwAmgAMAA0ADgAPABAAIQBSAREAgwEmAFQBOwBVAWsAbAAT'
..'AIQBbgBvABUAVwEXABAAWAFZAQwAmgALAA0ADgAPABAAIQBSAREAhQEmAFQBOwBVAWsAWwETAIYBbgBdARUAXgEXABAADACaAAwADQAOAA8AEAAhAFIBEQCHASYAVAE7AFUBawBsABMAiAFuAG8AFQBXARcAEABYAVkBDACaAAwADQAOAA8AEAAhAGEBEQCJASYAYwE7'
..'AGQBawBsABMAigFuAG8AFQBmARcAEABYAVkBZwGeAAIAJgBjAWgBEAAMAJoACwANAA4ADwAQACEAYQERAIsBJgBjATsAZAFrAFsBEwCMAW4AXQEVAGsBFwAQAGcBoAACACYAYwFoARAADACaAAwADQAOAA8AEAAhAGEBEQCDASYAYwE7AGQBawBsABMAhAFuAG8AFQBm'
..'ARcAEABYAVkBZwGiAAIAJgBjAWgBEAAMAJkABgANAA4ADwAQABEAjQETAI4BFQBuARcAEAAMAJkABgANAA4ADwAQABEAjwETAJABFQBxARcAEAAMAJkABgANAA4ADwAQABEAkQETAJIBFQBuARcAEAABAJkAAQACAJMBDACnAAoADQAOAA8AEAAhAFIBEQCUASYAVAE7'
..'AFUBEwCVARUAVwEXABAAWAFZAQwApwALAA0ADgAPABAAIQBSAREAlgEmAFQBOwBVAWsAeAETAJcBbgB4ARUAXgEXABAADACnAAoADQAOAA8AEAAhAFIBEQCYASYAVAE7AFUBEwCZARUAVwEXABAAWAFZAQwApwAKAA0ADgAPABAAIQBhAREAmgEmAGMBOwBkARMAmwEV'
..'AGYBFwAQAFgBWQFnAasAAgAmAGMBaAEQAAwApwALAA0ADgAPABAAIQBhAREAnAEmAGMBOwBkAWsAeAETAJ0BbgB4ARUAawEXABAAZwGtAAIAJgBjAWgBEAAMAKcACgANAA4ADwAQACEAYQERAJQBJgBjATsAZAETAJUBFQBmARcAEABYAVkBZwGvAAIAJgBjAWgBEAAM'
..'AJkABwAIAJ4BDQAOAA8AEAARAJ8BEwCgARUAoQEXABAAogGxAAUAowErAKQBDgClASsApgGnAagBKwCpAbIAAwCqAasBrAErABUArQGuAbMABgCqAasBrAErABUArQGvAbABsQGyAbMBpwEBAGUAAQACALQBAQC1AAEAAgC1AQwAtgAMAA0ADgAPABAAIQBSAREAtgEm'
..'AFQBOwBVAWsAbAATALcBbgBvABUAVwEXABAAWAFZAQwAtgALAA0ADgAPABAAIQBSAREAuAEmAFQBOwBVAWsAWwETALkBbgBdARUAXgEXABAADAC2AAwADQAOAA8AEAAhAFIBEQC6ASYAVAE7AFUBawBsABMAuwFuAG8AFQBXARcAEABYAVkBDAC2AAwADQAOAA8AEAAh'
..'AGEBEQC8ASYAYwE7AGQBawBsABMAvQFuAG8AFQBmARcAEABYAVkBZwG6AAIAJgBjAWgBEAAMALYACwANAA4ADwAQACEAYQERAL4BJgBjATsAZAFrAFsBEwC/AW4AXQEVAGsBFwAQAGcBvAACACYAYwFoARAADAC2AAwADQAOAA8AEAAhAGEBEQC2ASYAYwE7AGQBawBs'
..'ABMAtwFuAG8AFQBmARcAEABYAVkBZwG+AAIAJgBjAWgBEAAMALUABgANAA4ADwAQABEAwAETAMEBFQBuARcAEAAMALUABgANAA4ADwAQABEAwgETAMMBFQBxARcAEAAMALUABgANAA4ADwAQABEAxAETAMUBFQBuARcAEAABALUAAQACAMYBDADDAAoADQAOAA8AEAAh'
..'AFIBEQDHASYAVAE7AFUBEwDIARUAVwEXABAAWAFZAQwAwwALAA0ADgAPABAAIQBSAREAyQEmAFQBOwBVAWsAeAETAMoBbgB4ARUAXgEXABAADADDAAoADQAOAA8AEAAhAFIBEQDLASYAVAE7AFUBEwDMARUAVwEXABAAWAFZAQwAwwAKAA0ADgAPABAAIQBhAREAzQEm'
..'AGMBOwBkARMAzgEVAGYBFwAQAFgBWQFnAccAAgAmAGMBaAEQAAwAwwALAA0ADgAPABAAIQBhAREAzwEmAGMBOwBkAWsAeAETANABbgB4ARUAawEXABAAZwHJAAIAJgBjAWgBEAAMAMMACgANAA4ADwAQACEAYQERAMcBJgBjATsAZAETAMgBFQBmARcAEABYAVkBZwHL'
..'AAIAJgBjAWgBEAABAGUAAQACANEBAQDNAAEAAgDSAQwAzgAMAA0ADgAPABAAIQBSAREA0wEmAFQBOwBVAWsAbAATANQBbgBvABUAVwEXABAAWAFZAQwAzgALAA0ADgAPABAAIQBSAREA1QEmAFQBOwBVAWsAWwETANYBbgBdARUAXgEXABAADADOAAwADQAOAA8AEAAh'
..'AFIBEQDXASYAVAE7AFUBawBsABMA2AFuAG8AFQBXARcAEABYAVkBDADOAAwADQAOAA8AEAAhAGEBEQDZASYAYwE7AGQBawBsABMA2gFuAG8AFQBmARcAEABYAVkBZwHSAAIAJgBjAWgBEAAMAM4ACwANAA4ADwAQACEAYQERANsBJgBjATsAZAFrAFsBEwDcAW4AXQEV'
..'AGsBFwAQAGcB1AACACYAYwFoARAADADOAAwADQAOAA8AEAAhAGEBEQDTASYAYwE7AGQBawBsABMA1AFuAG8AFQBmARcAEABYAVkBZwHWAAIAJgBjAWgBEAAMAM0ABgANAA4ADwAQABEA3QETAN4BFQBuARcAEAAMAM0ABgANAA4ADwAQABEA3wETAOABFQBxARcAEAAM'
..'AM0ABgANAA4ADwAQABEA4QETAOIBFQBuARcAEAABAM0AAQACAOMBDADbAAoADQAOAA8AEAAhAFIBEQDkASYAVAE7AFUBEwDlARUAVwEXABAAWAFZAQwA2wALAA0ADgAPABAAIQBSAREA5gEmAFQBOwBVAWsAeAETAOcBbgB4ARUAXgEXABAADADbAAoADQAOAA8AEAAh'
..'AFIBEQDoASYAVAE7AFUBEwDpARUAVwEXABAAWAFZAQwA2wAKAA0ADgAPABAAIQBhAREA6gEmAGMBOwBkARMA6wEVAGYBFwAQAFgBWQFnAd8AAgAmAGMBaAEQAAwA2wALAA0ADgAPABAAIQBhAREA7AEmAGMBOwBkAWsAeAETAO0BbgB4ARUAawEXABAAZwHhAAIAJgBj'
..'AWgBEAAMANsACgANAA4ADwAQACEAYQERAOQBJgBjATsAZAETAOUBFQBmARcAEABYAVkBZwHjAAIAJgBjAWgBEAABAGUAAQACAO4BAQDlAAEAAgDvAQwA5gAMAA0ADgAPABAAIQBSAREA8AEmAFQBOwBVAWsAbAATAPEBbgBvABUAVwEXABAAWAFZAQwA5gALAA0ADgAP'
..'ABAAIQBSAREA8gEmAFQBOwBVAWsAWwETAPMBbgBdARUAXgEXABAADADmAAwADQAOAA8AEAAhAFIBEQD0ASYAVAE7AFUBawBsABMA9QFuAG8AFQBXARcAEABYAVkBDADmAAwADQAOAA8AEAAhAGEBEQD2ASYAYwE7AGQBawBsABMA9wFuAG8AFQBmARcAEABYAVkBZwHq'
..'AAIAJgBjAWgBEAAMAOYACwANAA4ADwAQACEAYQERAPgBJgBjATsAZAFrAFsBEwD5AW4AXQEVAGsBFwAQAGcB7AACACYAYwFoARAADADmAAwADQAOAA8AEAAhAGEBEQDwASYAYwE7AGQBawBsABMA8QFuAG8AFQBmARcAEABYAVkBZwHuAAIAJgBjAWgBEAAMAOUABgAN'
..'AA4ADwAQABEA+gETAPsBFQBuARcAEAAMAOUABgANAA4ADwAQABEA/AETAP0BFQBxARcAEAAMAOUABgANAA4ADwAQABEA/gETAP8BFQBuARcAEAABAOUAAQACAAACDADzAAoADQAOAA8AEAAhAFIBEQABAiYAVAE7AFUBEwACAhUAVwEXABAAWAFZAQwA8wALAA0ADgAP'
..'ABAAIQBSAREAAwImAFQBOwBVAWsAeAETAAQCbgB4ARUAXgEXABAADADzAAoADQAOAA8AEAAhAFIBEQAFAiYAVAE7AFUBEwAGAhUAVwEXABAAWAFZAQwA8wAKAA0ADgAPABAAIQBhAREABwImAGMBOwBkARMACAIVAGYBFwAQAFgBWQFnAfcAAgAmAGMBaAEQAAwA8wAL'
..'AA0ADgAPABAAIQBhAREACQImAGMBOwBkAWsAeAETAAoCbgB4ARUAawEXABAAZwH5AAIAJgBjAWgBEAAMAPMACgANAA4ADwAQACEAYQERAAECJgBjATsAZAETAAICFQBmARcAEABYAVkBZwH7AAIAJgBjAWgBEAABAGUAAQACAAsCAQD9AAEAAgAMAgwA/gAMAA0ADgAP'
..'ABAAIQBSAREADQImAFQBOwBVAWsAbAATAA4CbgBvABUAVwEXABAAWAFZAQwA/gALAA0ADgAPABAAIQBSAREADwImAFQBOwBVAWsAWwETABACbgBdARUAXgEXABAADAD+AAwADQAOAA8AEAAhAFIBEQARAiYAVAE7AFUBawBsABMAEgJuAG8AFQBXARcAEABYAVkBDAD+'
..'AAwADQAOAA8AEAAhAGEBEQATAiYAYwE7AGQBawBsABMAFAJuAG8AFQBmARcAEABYAVkBZwECAQIAJgBjAWgBEAAMAP4ACwANAA4ADwAQACEAYQERABUCJgBjATsAZAFrAFsBEwAWAm4AXQEVAGsBFwAQAGcBBAECACYAYwFoARAADAD+AAwADQAOAA8AEAAhAGEBEQAN'
..'AiYAYwE7AGQBawBsABMADgJuAG8AFQBmARcAEABYAVkBZwEGAQIAJgBjAWgBEAAMAP0ABgANAA4ADwAQABEAFwITABgCFQBuARcAEAAMAP0ABgANAA4ADwAQABEAGQITABoCFQBxARcAEAAMAP0ABgANAA4ADwAQABEAGwITABwCFQBuARcAEAABAP0AAQACAB0CDAAL'
..'AQoADQAOAA8AEAAhAFIBEQAeAiYAVAE7AFUBEwAfAhUAVwEXABAAWAFZAQwACwELAA0ADgAPABAAIQBSAREAIAImAFQBOwBVAWsAeAETACECbgB4ARUAXgEXABAADAALAQoADQAOAA8AEAAhAFIBEQAiAiYAVAE7AFUBEwAjAhUAVwEXABAAWAFZAQwACwEKAA0ADgAP'
..'ABAAIQBhAREAJAImAGMBOwBkARMAJQIVAGYBFwAQAFgBWQFnAQ8BAgAmAGMBaAEQAAwACwELAA0ADgAPABAAIQBhAREAJgImAGMBOwBkAWsAeAETACcCbgB4ARUAawEXABAAZwERAQIAJgBjAWgBEAAMAAsBCgANAA4ADwAQACEAYQERAB4CJgBjATsAZAETAB8CFQBm'
..'ARcAEABYAVkBZwETAQIAJgBjAWgBEAAoAgUAAAABAAUAAgAIACkCAgAqAgwAFgEKAAgAKQINAA4ADwAQACEAKwIRACwCJgAtAjsAPAATAC4CFQAvAhcAEACiARcBBQCjASsApAEOAGgBWQGlASsAqAErAKkBGAEEAKoBqwGsASsAEwAwAhUAMQKuARkBCACqAasBrAEr'
..'ABUArQGvAbABMgKrATMCNAKxAasBswE1AgwAFgEMAAgANgINAA4ADwAQACEANwIRADgCJAAlACYAOQI7AB4BEwA6AhUAOwIXABAAKgArAAwAFgEIAA0ADgAPABAAIQAiABEAPAImACcAEwA9AhUAPgIXABAADAAWAQgADQAOAA8AEAAhACIAEQA/AiYAJwATAEACFQBB'
..'AhcAEAAMABYBCAANAA4ADwAQACEAIgARAEICJgAnABMAQwIVAEQCFwAQAAwAFgEJAAgARQINAA4ADwAQACEAIgARAEYCJgAnABMARwIVAEgCFwAQAEkCHwEBAEoCSwJMAhYBAQAIAE0CKAIEAAEACABOAgEABAACAAgATwICAFACDAAjAQoACAApAg0ADgAPABAAIQAr'
..'AhEAUQImAC0COwA8ABMAUgIVAC8CFwAQAKIBJAEFAKMBKwCkAQ4AaAFZAaUBKwCoASsAqQElAQQAqgGrAawBKwATADACFQAxAq4BJgEIAKoBqwGsASsAFQCtAa8BsAEyAqsBMwI0ArEBqwGzATUCDAAjAQwACAA2Ag0ADgAPABAAIQA3AhEAUwIkACUAJgA5AjsAHgET'
..'AFQCFQA7AhcAEAAqACsAKAIoAQAATAIpAQEACABNAgwAIwEIAA0ADgAPABAAIQAiABEAVQImACcAEwBWAhUAPgIXABAADAAjAQgADQAOAA8AEAAhACIAEQBXAiYAJwATAFgCFQBBAhcAEAAMACMBCAANAA4ADwAQACEAIgARAFkCJgAnABMAWgIVAEQCFwAQAAwAIwEJ'
..'AAgARQINAA4ADwAQACEAIgARAFsCJgAnABMAXAIVAEgCFwAQAEkCLgEBAEoCSwIHAAMAAQAIAF0CXgIwAQEACABfAl4CMAEBAAgAYAIMAAEACQANAA4ADwAQACEAZwARAGECJgBpADsAHgETAGICFQBjAhcAEAAMAAEACgANAA4ADwAQACEAZwARAGQCJAAlACYAaQA7'
..'AB4BEwBlAhUAZgIXABAAZwI0AQIAaAJpAmoCJQAoAjQBAAAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
