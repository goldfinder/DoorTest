-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 23292 characters

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
		currdoor.DoorHitDetection.ClickDetector.Clicked:Connect(function()
			script.Parent.Parent.Events.LoadNextRoom:Fire(currdoor.DID.Value)
		end)
		wait(.06)
		debounce=false
	elseif door ~= "No more doors :(" then
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets")["Door"]:Clone()
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


local Objects = Decode('AFCbAiEFTW9kZWwhCldvcmxkUGl2b3QEcgJzAnQCBHUCcwJ0AgR2AnMCdAIEdwJzAnQCIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQEeAJzAnQCIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUAHMCdAIhCFBv'
..'c2l0aW9uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQBzAnQCCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHABzAnQCCsXOr0OPM/VC98CLxAQeAHMCdAIKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNr'
..'Q29sb3IH6gMEKABzAnQCIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AcwJ0AgoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyAHMCdAIKAAAAAAAA'
..'AACPwuNAIQJVcAR5AnMCdAIENgBzAnQCCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQB6AnQCBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAAHoCdAIKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDAHoCdAIK'
..'lWaQQw6v/UJhXo3EBEUAegJ0AgqVZpBDDq//QseEjcQERwBzAnQCCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgBzAnQCCm2gjkM2LwBDOruMxARMAHMCdAIKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPAHMCdAIK1WCQQ0ovAENkv4zEBFEAcwJ0AgoAOjS9'
..'AACsQKRwZ8EEUwBzAnQCCgAAVTw3ibXAMLJjQQRVAHoCdAIKlWaQQw6v90Iu64zEBFcAegJ0AgqVZpBDDq/5QpQRjcQEWQB6AnQCCpVmkEMOr/FC+neMxARbAHoCdAIKlWaQQw+v80JhnozEBF0AegJ0AgqVZpBDDq/1QsfEjMQEXwBzAnQCCi9lkEOzPexCOruMxArG'
..'QeZAQLbiPoid6EEEYgB7AnQCCpVmkEMOr+1CLiuMxARkAHoCdAIKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBHwCfQJ0AgdrAARtAH4CfwIGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAA'
..'AAAANEMKPibWQUC24j6InehBBHIAfgJ/Agr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBHUAfgJ/AgoLXqZDHSn5QvW5jsQEdwB+An8CCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegB+An8CCr+un0NU/AJD9bmOxAR8AH4CfwIKf/ejQx0p+ULDhpDECvy/HUEY'
..'mVJBEqmNPgR/AH4CfwIKMXObQx0p+ULDhpDEBIEAfgJ/AgrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BIQAfgJ/Agoxc5tDHSn5QhvrjMQEhgB+An8CCteBnUOGJgFDG+uMxASIAH4CfwIKf/ejQx0p+UIb64zEBIoAfgJ/AgoFtp9D+yj5QvW5jsQEjQCAAnQCCgAA'
..'AACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkABzAnQCCgDAVDzByvG/FK5pwSEERG93bgSBAnMCdAIElAB+An8CCjPBikN+XwpDb7aMxASWAH4CfwIKM7qKQ/cUAUMfYYvEBJgAfgJ/AgozuopD7in8Qtk9jMQEmgB+An8CCjO6ikPuKf5CcheMxAScAH4CfwIKM7qK'
..'Q/cUAEMM8YvEBJ4AfgJ/Agpp/ohDpmwAQ5m6jMQEoAB+An8CClmAjEOmbABDmbqMxASiAH4CfwIKM8GKQ13sBEO+ho7EBKQAfgJ/Agrzv4pDumwAQ2+2jMQEpgB+An8CCjO6ikPuKfhCpYqMxASoAH4CfwIKM7qKQ+4p+kI/ZIzEBKoAfgJ/AgozuopD7inyQtn9jMQE'
..'rAB+An8CCjO6ikPvKfRCcteMxASuAH4CfwIKM7qKQ+4p9kIMsYzEBLAAfgJ/AgqZu4pDk7jsQpm6jMQEsgB+An8CCjO6ikPuKe5CpUqNxAS0AH4CfwIKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBIICcwJ0AgS4AH4CfwIKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3o'
..'QQS7AH4CfwIKIqI/Q1Fc+ULgG5HEBL0AfgJ/AgpVEIRDUVz5QuAbkcQEvwB+An8CChLCekMXpOxCwU2PxATBAH4CfwIKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEAH4CfwIKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHAH4CfwIK0o1EQ1Fc+UKv6JLEBMkA'
..'fgJ/Agoeq0hDIEABQ6/oksQEywB+An8CChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgB+An8CCkJodkMgQAFDBk2PxATQAH4CfwIKyamBQ1Fc+UIGTY/EBNIAfgJ/AgpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEgwJzAnQCBNYAfgJ/AgoycWRD9qvsQtY0jMQE'
..'2AB+An8CCro/QEMwZPlC1jSMxATaAH4CfwIKH1+EQzBk+ULWNIzEBNwAfgJ/AgqqX3tD9qvsQrdmisQE3gB+An8CCs5mZEPcGQND1jSMxATgAH4CfwIK4olkQ9Jv+ULQM4zEBIQChQJ0AgTjAH4CfwIKfwyCQ2Bk+UKjAY7EBOUAfgJ/AgqKMFxDYGT5QqMBjsQE5wB+'
..'An8CCq4td0MoRAFDowGOxASGAoUCdAIE6gB+An8CChLubENsavlC/WWKxATsAH4CfwIKyiBJQy1HAUP9ZYrEBO4AfgJ/Agp6A0VDbGr5Qv1lisQhA0xJQgSHAogCdAIE8gCJAooCCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYAiwJ0Agp5'
..'k6RDfj8DQ17PfMQE+ABzAnQCCgAAAAAGgeW/4vqvQgT6AHMCdAIKAAAAAPp+8sBf5a/CBPwAiQKKAgq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BP8AiQKKAgp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBiQKKAgp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+'
..'BAUBfgJ/AgrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBiQKKAgrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBiQKKAgp3k4dDfj8DQyLLfMQEDQGJAooCCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAGJAooCCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDv'
..'fz8EEwGJAooCCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgGJAooCCk03mkPnUPZCnm9wxAQYAYkCigIKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEHwGJAooCBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HA'
..'d5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBiQKKAgq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQND'
..'oO9vxAQuAYkCigIKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAYkCigIKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AYkCigIKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3AYkCigIKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AYkCigIKtZ2LQ+dQ'
..'9kKi72/ECmZmdkEAAABBwO9/PwQ9AYkCigIKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQAAwEBwURBCCsXLi0PoUPRCFE1rxARGAYkCigIKQ4CkQ5JtC0PayWbE'
..'CpmZEUFwPTJBAOjWPgRJAYkCigIKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAYkCigIKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAYkCigIK5xCVQ34/A0PayWbEBIwCcwJ0AgRqAYgCdAIHxwAEVgF+An8CBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QK'
..'ANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAY0CjgIKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABfgJ/Agp+SqpDKITwQos2h8QHagAEZQF+An8CBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAA'
..'gD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagGNAo4CCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQFzAnQCCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAFzAnQCCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEcwFzAnQCCsdLnkM9ngNDizaHxAR/AXMC'
..'dAIEdgFzAnQCCg/NnkPWy/5CizaHxAR5AY8CkAIKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7AXMCdAIKD82eQyiE8EKLNofEBH0BcwJ0AgoPzZ5DZY7wQos2h8QEfwGPApACCg7NnkP/p/dCizaHxCEEQXJjaASRAnMCdAIEjAGIAnQCBIQBfgJ/Agp+SqpD1sv+'
..'Qou2hMQEhgGNAo4CCn5KqkP/p/dCi7aExASIAX4CfwIKfkqqQyiE8EKLtoTEBIoBfgJ/Agp+SqpDZY7wQou2hMQEjAGNAo4CCn9KqkP/p/dCi7aExASOAXMCdAIKx8uqQz2eA0OLtoTEBJABcwJ0AgrHi6RDeqgGQ4u2hMQEkgFzAnQCCsdLnkM9ngNDi7aExASdAXMC'
..'dAIElQFzAnQCCg/NnkPWy/5Ci7aExASXAY8CkAIKD82eQ/+n90KLtoTEBJkBcwJ0AgoPzZ5DKITwQou2hMQEmwFzAnQCCg/NnkNljvBCi7aExASdAY8CkAIKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABcwJ0AgrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABAIQpTdXJm'
..'YWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/'
..'AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQSSAnMCdAIEvwGIAnQCBLcBfgJ/Agp+SqpD1sv+Qos2gsQEuQGNAo4CCn5KqkP/p/dCizaCxAS7AX4CfwIKfkqqQyiE8EKLNoLEBL0BfgJ/Agp+SqpDZY7wQos2'
..'gsQEvwGNAo4CCn9KqkP/p/dCizaCxATBAXMCdAIKx8uqQz2eA0OLNoLEBMMBcwJ0AgrHi6RDeqgGQ4s2gsQExQFzAnQCCsdLnkM9ngNDizaCxATQAXMCdAIEyAFzAnQCCg/NnkPWy/5CizaCxATKAY8CkAIKD82eQ/+n90KLNoLEBMwBcwJ0AgoPzZ5DKITwQos2gsQE'
..'zgFzAnQCCg/NnkNljvBCizaCxATQAY8CkAIKDs2eQ/+n90KLNoLEBJMCcwJ0AgTcAYgCdAIE1AF+An8CCn5KqkPWy/5CFm1/xATWAY0CjgIKfkqqQ/+n90IWbX/EBNgBfgJ/Agp+SqpDKITwQhZtf8QE2gF+An8CCn5KqkNljvBCFm1/xATcAY0CjgIKf0qqQ/+n90IW'
..'bX/EBN4BcwJ0AgrHy6pDPZ4DQxZtf8QE4AFzAnQCCseLpEN6qAZDFm1/xATiAXMCdAIKx0ueQz2eA0MWbX/EBO0BcwJ0AgTlAXMCdAIKD82eQ9bL/kIWbX/EBOcBjwKQAgoPzZ5D/6f3QhZtf8QE6QFzAnQCCg/NnkMohPBCFm1/xATrAXMCdAIKD82eQ2WO8EIWbX/E'
..'BO0BjwKQAgoOzZ5D/6f3QhZtf8QElAJzAnQCBPkBiAJ0AgTxAX4CfwIKfkqqQ9bL/kIWbXrEBPMBjQKOAgp+SqpD/6f3QhZtesQE9QF+An8CCn5KqkMohPBCFm16xAT3AX4CfwIKfkqqQ2WO8EIWbXrEBPkBjQKOAgp/SqpD/6f3QhZtesQE+wFzAnQCCsfLqkM9ngND'
..'Fm16xAT9AXMCdAIKx4ukQ3qoBkMWbXrEBP8BcwJ0AgrHS55DPZ4DQxZtesQECgJzAnQCBAICcwJ0AgoPzZ5D1sv+QhZtesQEBAKPApACCg/NnkP/p/dCFm16xAQGAnMCdAIKD82eQyiE8EIWbXrEBAgCcwJ0AgoPzZ5DZY7wQhZtesQECgKPApACCg7NnkP/p/dCFm16'
..'xASVAnMCdAIEFgKIAnQCBA4CfgJ/Agp+SqpD1sv+QhZtdcQEEAKNAo4CCn5KqkP/p/dCFm11xAQSAn4CfwIKfkqqQyiE8EIWbXXEBBQCfgJ/Agp+SqpDZY7wQhZtdcQEFgKNAo4CCn9KqkP/p/dCFm11xAQYAnMCdAIKx8uqQz2eA0MWbXXEBBoCcwJ0AgrHi6RDeqgG'
..'QxZtdcQEHAJzAnQCCsdLnkM9ngNDFm11xAQnAnMCdAIEHwJzAnQCCg/NnkPWy/5CFm11xAQhAo8CkAIKD82eQ/+n90IWbXXEBCMCcwJ0AgoPzZ5DKITwQhZtdcQEJQJzAnQCCg/NnkNljvBCFm11xAQnAo8CkAIKDs2eQ/+n90IWbXXEIQIyMASWApcCmAIhAy0tLQQs'
..'ApkCfwIKsYWkQy0HAkOIimfECo/CXUF7FDZBCtfDQCEGU2NyaXB0IQREb29yBJoCcwJ0AgdpAQQ0AnMCdAIGVkI2CsfpFEMXWPVClBSQxAraRcdA7dYDQRiFIz8MAAAAAAAAzczMPQAADAAAgD8AAAAAAABkACERUGxhY2Vob2xkZXJDb2xvcjMhBFRleHQhATADAAAA'
..'AAAAREAhEERvb3JIaXREZXRlY3Rpb24HTAEEQAJzAnQCBnUAAArH6RRDF1j1QrcRkMQKdjHfQFK4CkFcj0I/IQ1DbGlja0RldGVjdG9yBEQCcwJ0AgqUOhhDZDD1Qm4XkMQK4PvjPjvnDUEAoy0/BEcCcwJ0Agrm/RRDB/H9Qm4XkMQKamvdQCD93j4Aoy0/BEoCcwJ0'
..'AgqWjBFDF1j1Qm4XkMQKQCIWP2tiEEEAoy0/IQJTUAROAnMCdAIKjNoUQ0zD7EJuF5DECsZB5kBAtuI+AKMtPyEFU291bmQhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8xNTcxNjcyMDMhC051bWJlclZhbHVlIQNESUQhBU1haW5zIQVTRG9vcgSbAnMCdAIEWQJzAnQC'
..'Cpq7Z0IXWPVClBSQxARbAnMCdAIKmrtnQhdY9UK3EZDEBF0CcwJ0AgrO/nRCZDD1Qm4XkMQEXwJzAnQCChQMaEIH8f1CbheQxARhAnMCdAIK1kZaQhdY9UJuF5DEBGMCcwJ0AgqufmdCTMPsQm4XkMQhBkV2ZW50cyENQmluZGFibGVFdmVudCEMTG9hZE5leHRSb29t'
..'IQlBc3NldFBhdGgEaQJzAnQCChCbZkIlhexCmZqLxAowM7FCj8L1PSlcj0IEbAJzAnQCCgAAAACuR5FAAAAAAAoAAIA/AACAPwAAgD8hD1Byb3hpbWl0eVByb21wdCEKT2JqZWN0VGV4dCE9R29sZDNuRjFyMydzIERvb3JzIEVuZ2luZS4KCkludGVyYWN0IHdpdGgg'
..'bWUgdG8gcGxheSAiZG9vcnMiLiETUmVxdWlyZXNMaW5lT2ZTaWdodAo/9b9DvAmVQh/NEsQKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAoCimZCuiwOQyd1h8QKrn5nQjtZ9UKOFIfECrobhkLwXvVCloGJxAoDBa5DiRb1Qqa9i8QK02CQQywvAENkv4zECv3/fz8A'
..'AAAAAAAAAAr//38/AAAAAAAAAAAKBbafQx0p+UL1uY7ECgAAgL8AAAAALr27swoAAIC/Lr27s+2tCSgKLr27swAAgD8uvbuzCgAAgD8AAAAALr07tAr1v4pDnGwAQ2+2jMQKSuxjQ/hn+ULaGpHECuKJZEPWb/lC0DOMxArSomRDYGT5QqMBjsQKAACAvwAAAAAuvbsz'
..'CuJ6ZENtavlC/WWKxAp3k6RDfj8DQ17PfMQKAACAvwAAAAAAAAAACgAAgL8uvbsz7a0JKAouvbszAACAPy69uzMKAACAPwAAAAAuvbuzCseLpEM9ngNDizaHxAouvTuzAACAPy69u7MKAACAPy69OzPtrYmnCi69O7MAAIA/AAAAAAoAAIC/Lr07swAAAAAKx4ukQz2e'
..'A0OLtoTECseLpEM9ngNDizaCxArHi6RDPZ4DQxZtf8QKx4ukQz2eA0MWbXrECseLpEM9ngNDFm11xAo7laRD9yAGQy/PhMQKAACAPy69OzPtrQmnCi69O7MAAIA/Lr07swoAAIA/Lr27M1ocjicKjNoUQzxZ9ULrE5DECq5+Z0I8WfVC6xOQxDkBAQAAAAEAAgADAAEA'
..'AQABAAIABAABAAIAAQACAAUAAQADAAEAAgAGAAcABAABAAgACQABAAUAAgAIAAoAAgALAAwABgAGAA0ADgAPABAAEQASABMAFAAVABYAFwAQAAwABgAGAA0ADgAPABAAEQAYABMAGQAVABoAFwAQAAwABgAGAA0ADgAPABAAEQAbABMAHAAVABoAFwAQAAwABgAGAA0A'
..'DgAPABAAEQAdABMAHgAVAB8AFwAQAAwABgALAAgAIAANAA4ADwAQACEAIgARACMAJAAlACYAJwATACgAFQApABcAEAAqACsALAALAAMACAAtABEALgATAC8ALAALAAMACAAwABEAMQATADIAAQAFAAIACAAzAAIANAAMAA4ABgANAA4ADwAQABEANQATADYAFQA3ABcA'
..'EAAMAA4ACQANAA4ADwAQACEAOAARADkAJgA6ADsAPAATAD0AFQA+ABcAEAAMAA4ACQANAA4ADwAQACEAOAARAD8AJgA6ADsAPAATAEAAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAEIAJgA6ADsAPAATAEMAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAEQA'
..'JgA6ADsAPAATAEUAFQBBABcAEAAMAA4ABgANAA4ADwAQABEARgATAEcAFQBIABcAEAAMAA4ABgANAA4ADwAQABEASQATAEoAFQBIABcAEAAMAA4ABgANAA4ADwAQABEASwATAEwAFQBNABcAEAAMAA4ACwAIACAADQAOAA8AEAAhACIAEQBOACQAJQAmACcAEwBPABUA'
..'KQAXABAAKgArACwAFwADAAgALQARAFAAEwBRACwAFwADAAgAMAARAFIAEwBTAAwADgAJAA0ADgAPABAAIQA4ABEAVAAmADoAOwA8ABMAVQAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAVgAmADoAOwA8ABMAVwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEA'
..'WAAmADoAOwA8ABMAWQAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAWgAmADoAOwA8ABMAWwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAXAAmADoAOwA8ABMAXQAVAEEAFwAQAAwADgAGAA0ADgAPABAAEQBeABMAXwAVAGAAFwAQAAwADgAJAA0ADgAPABAA'
..'IQA4ABEAYQAmADoAOwA8ABMAYgAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAYwAmADoAOwA8ABMAZAAVAEEAFwAQAAEABQACAAgAZQACAGYADAAiAAsADQAOAA8AEAAhAGcAEQBoACYAaQA7AGoAawBsABMAbQBuAG8AFQBwABcAEAAMACIACAANAA4ADwAQABEA'
..'cQBrAGwAEwByAG4AbwAVAHMAFwAQAAwAIgAIAA0ADgAPABAAEQB0AGsAbAATAHUAbgBvABUAcwAXABAADAAiAAgADQAOAA8AEAARAHYAawBsABMAdwBuAG8AFQB4ABcAEAAMACIACAANAA4ADwAQABEAeQBrAGwAEwB6AG4AbwAVAHAAFwAQAAwAIgAIAA0ADgAPABAA'
..'EQB7AGsAbAATAHwAbgBvABUAfQAXABAADAAiAAgADQAOAA8AEAARAH4AawBsABMAfwBuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAgABrAGwAEwCBAG4AbwAVAIIAFwAQAAwAIgAIAA0ADgAPABAAEQCDAGsAbAATAIQAbgBvABUAfQAXABAADAAiAAgADQAOAA8A'
..'EAARAIUAawBsABMAhgBuAG8AFQCCABcAEAAMACIACAANAA4ADwAQABEAhwBrAGwAEwCIAG4AbwAVAH0AFwAQAAwAIgANAAgAIAANAA4ADwAQACEAIgARAIkAJAAlACYAJwBrAGwAEwCKAG4AbwAVACkAFwAQACoAKwAsAC4ABAAIAC0AEQCLAGsAjAATAI0ALAAuAAMA'
..'CACOABEAjwATAJAAAQAFAAIACACRAAIAkgAMADEACAANAA4ADwAQABEAkwBrAGwAEwCUAG4AbwAVADcAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAlQAmADoAOwA8AGsAbAATAJYAbgBvABUAPgAXABAADAAxAAsADQAOAA8AEAAhADgAEQCXACYAOgA7ADwAawBsABMA'
..'mABuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAJkAJgA6ADsAPABrAGwAEwCaAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAmwAmADoAOwA8AGsAbAATAJwAbgBvABUAQQAXABAADAAxAAgADQAOAA8AEAARAJ0AawBsABMAngBuAG8AFQBIABcA'
..'EAAMADEACAANAA4ADwAQABEAnwBrAGwAEwCgAG4AbwAVAEgAFwAQAAwAMQAIAA0ADgAPABAAEQChAGsAbAATAKIAbgBvABUATQAXABAADAAxAA0ACAAgAA0ADgAPABAAIQAiABEAowAkACUAJgAnAGsAbAATAKQAbgBvABUAKQAXABAAKgArACwAOgADAAgALQARAFAA'
..'EwBRACwAOgADAAgAMAARAFIAEwBTAAwAMQALAA0ADgAPABAAIQA4ABEApQAmADoAOwA8AGsAbAATAKYAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCnACYAOgA7ADwAawBsABMAqABuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKkAJgA6ADsA'
..'PABrAGwAEwCqAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAqwAmADoAOwA8AGsAbAATAKwAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCtACYAOgA7ADwAawBsABMArgBuAG8AFQBBABcAEAAMADEACAANAA4ADwAQABEArwBrAGwAEwCwAG4A'
..'bwAVAGAAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAsQAmADoAOwA8AGsAbAATALIAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCzACYAOgA7ADwAawBsABMAtABuAG8AFQBBABcAEAABAAUAAgAIALUAAgC2AAwARQALAA0ADgAPABAAIQBnABEAtwAmAGkA'
..'OwBqAGsAbAATALgAbgBvABUAuQAXABAADABFAAgADQAOAA8AEAARALoAawBsABMAuwBuAG8AFQBzABcAEAAMAEUACAANAA4ADwAQABEAvABrAGwAEwC9AG4AbwAVAHMAFwAQAAwARQAIAA0ADgAPABAAEQC+AGsAbAATAL8AbgBvABUAeAAXABAADABFAAgADQAOAA8A'
..'EAARAMAAawBsABMAwQBuAG8AFQDCABcAEAAMAEUACAANAA4ADwAQABEAwwBrAGwAEwDEAG4AbwAVAMUAFwAQAAwARQAIAA0ADgAPABAAEQDGAGsAbAATAMcAbgBvABUAfQAXABAADABFAAgADQAOAA8AEAARAMgAawBsABMAyQBuAG8AFQCCABcAEAAMAEUACAANAA4A'
..'DwAQABEAygBrAGwAEwDLAG4AbwAVAMwAFwAQAAwARQAIAA0ADgAPABAAEQDNAGsAbAATAM4AbgBvABUAggAXABAADABFAAgADQAOAA8AEAARAM8AawBsABMA0ABuAG8AFQB9ABcAEAAMAEUADQAIACAADQAOAA8AEAAhACIAEQDRACQAJQAmACcAawBsABMA0gBuAG8A'
..'FQApABcAEAAqACsALABRAAQACAAtABEAiwBrAIwAEwCNACwAUQADAAgAjgARAI8AEwCQAAEABQACAAgA0wACANQADABUAAsADQAOAA8AEAAhAGcAEQDVACYAaQA7AGoAawBsABMA1gBuAG8AFQC5ABcAEAAMAFQACAANAA4ADwAQABEA1wBrAGwAEwDYAG4AbwAVAHMA'
..'FwAQAAwAVAAIAA0ADgAPABAAEQDZAGsAbAATANoAbgBvABUAcwAXABAADABUAAgADQAOAA8AEAARANsAawBsABMA3ABuAG8AFQB4ABcAEAAMAFQACAANAA4ADwAQABEA3QBrAGwAEwDeAG4AbwAVAMIAFwAQAAwAVAANAAgAIAANAA4ADwAQACEAIgARAN8AJAAlACYA'
..'JwBrAGwAEwDgAG4AbwAVACkAFwAQACoAKwAsAFoABAAIAC0AEQCLAGsAjAATAI0ALABaAAMACACOABEAjwATAJAAAQBUAAEAAgDhAAwAXQAIAA0ADgAPABAAEQDiAGsAbAATAOMAbgBvABUAfQAXABAADABdAAgADQAOAA8AEAARAOQAawBsABMA5QBuAG8AFQDMABcA'
..'EAAMAF0ACAANAA4ADwAQABEA5gBrAGwAEwDnAG4AbwAVAIIAFwAQAAEAVAABAAIA6AAMAGEACAANAA4ADwAQABEA6QBrAGwAEwDqAG4AbwAVAMUAFwAQAAwAYQAIAA0ADgAPABAAEQDrAGsAbAATAOwAbgBvABUAggAXABAADABhAAgADQAOAA8AEAARAO0AawBsABMA'
..'7gBuAG8AFQB9ABcAEAABAAUAAgAIAO8AAgDwAAwAZQAIAA0ADgAPABAAEQDxAGsAbAATAPIAbgDzABUA9AAXABAADABlAAsACAAgAA0ADgAPABAAIQAiABEA9QAkACUAJgAnABMA9gAVACkAFwAQACoAKwAsAGcAAwAIAC0AEQD3ABMA+AAsAGcAAwAIAI4AEQD5ABMA'
..'+gAMAGUACAANAA4ADwAQABEA+wBrAGwAEwD8AG4A8wAVAP0AFwAQAAwAZQAIAA0ADgAPABAAEQD+AGsAbAATAP8AbgDzABUAAAEXABAADABlAAgADQAOAA8AEAARAAEBawBsABMAAgFuAPMAFQADARcAEAAMAGUACwANAA4ADwAQACEAOAARAAQBJgA6ADsAPABrAGwA'
..'EwAFAW4AbwAVAAYBFwAQAAwAZQAIAA0ADgAPABAAEQAHAWsAbAATAAgBbgDzABUACQEXABAADABlAAgADQAOAA8AEAARAAoBawBsABMACwFuAPMAFQAJARcAEAAMAGUACwANAA4ADwAQACEAOAARAAwBJgA6ADsAPABrAGwAEwANAW4A8wAVAA4BFwAQAAwAZQALAA0A'
..'DgAPABAAIQA4ABEADwEmADoAOwA8AGsAbAATABABbgDzABUAEQEXABAADABlAAgADQAOAA8AEAARABIBawBsABMAEwFuAPMAFQAUARcAEAAMAGUACAANAA4ADwAQABEAFQFrAGwAEwAWAW4A8wAVABQBFwAQAAwAZQAIAA0ADgAPABAAEQAXAWsAbAATABgBbgDzABUA'
..'GQEXABAAGgFAAgAMACIBIwFsAAAMACQBJQFsAGUACgANAA4AIQAbAREAHAEmAB0BOwAeAWsAbAATAB8BbgDzABUAIAEhAQ4AGgFAAgAMACkBKgFsAAAMACsBLAFsAGUACgANAA4AIQAbAREAJgEmAB0BOwAeAWsAbAATACcBbgDzABUAKAEhAQ4ADABlAAsADQAOAA8A'
..'EAAhADgAEQAtASYAOgA7ADwAawBsABMALgFuAPMAFQAvARcAEAAMAGUACwANAA4ADwAQACEAOAARADABJgA6ADsAPABrAGwAEwAxAW4A8wAVADIBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEAMwEmADoAOwA8AGsAbAATADQBbgDzABUANQEXABAADABlAAsADQAOAA8A'
..'EAAhADgAEQA2ASYAOgA7ADwAawBsABMANwFuAPMAFQA4ARcAEAAMAGUACAANAA4ADwAQABEAOQFrAGwAEwA6AW4A8wAVADsBFwAQABoBQAMADAA/AUABbAAADABBAUIBbAAADABDAUQBbABlAAoADQAOACEAZwARADwBJgBpADsAagBrAGwAEwA9AW4A8wAVAD4BIQEO'
..'AAwAZQAIAA0ADgAPABAAEQBFAWsAbAATAEYBbgDzABUARwEXABAADABlAAgADQAOAA8AEAARAEgBawBsABMASQFuAPMAFQBKARcAEAAMAGUACAANAA4ADwAQABEASwFrAGwAEwBMAW4A8wAVAE0BFwAQAAwAZQAIAA0ADgAPABAAEQBOAWsAbAATAE8BbgDzABUASgEX'
..'ABAAAQBlAAEAAgBQAQEAgQABAAIAUQEMAIIADAANAA4ADwAQACEAUgERAFMBJgBUATsAVQFrAGwAEwBWAW4AbwAVAFcBFwAQAFgBWQEMAIIACwANAA4ADwAQACEAUgERAFoBJgBUATsAVQFrAFsBEwBcAW4AXQEVAF4BFwAQAAwAggAMAA0ADgAPABAAIQBSAREAXwEm'
..'AFQBOwBVAWsAbAATAGABbgBvABUAVwEXABAAWAFZAQwAggAMAA0ADgAPABAAIQBhAREAYgEmAGMBOwBkAWsAbAATAGUBbgBvABUAZgEXABAAWAFZAWcBhgACACYAYwFoARAADACCAAsADQAOAA8AEAAhAGEBEQBpASYAYwE7AGQBawBbARMAagFuAF0BFQBrARcAEABn'
..'AYgAAgAmAGMBaAEQAAwAggAMAA0ADgAPABAAIQBhAREAUwEmAGMBOwBkAWsAbAATAFYBbgBvABUAZgEXABAAWAFZAWcBigACACYAYwFoARAADACBAAYADQAOAA8AEAARAGwBEwBtARUAbgEXABAADACBAAYADQAOAA8AEAARAG8BEwBwARUAcQEXABAADACBAAYADQAO'
..'AA8AEAARAHIBEwBzARUAbgEXABAAAQCBAAEAAgB0AQwAjwAKAA0ADgAPABAAIQBSAREAdQEmAFQBOwBVARMAdgEVAFcBFwAQAFgBWQEMAI8ACwANAA4ADwAQACEAUgERAHcBJgBUATsAVQFrAHgBEwB5AW4AeAEVAF4BFwAQAAwAjwAKAA0ADgAPABAAIQBSAREAegEm'
..'AFQBOwBVARMAewEVAFcBFwAQAFgBWQEMAI8ACgANAA4ADwAQACEAYQERAHwBJgBjATsAZAETAH0BFQBmARcAEABYAVkBZwGTAAIAJgBjAWgBEAAMAI8ACwANAA4ADwAQACEAYQERAH4BJgBjATsAZAFrAHgBEwB/AW4AeAEVAGsBFwAQAGcBlQACACYAYwFoARAADACP'
..'AAoADQAOAA8AEAAhAGEBEQB1ASYAYwE7AGQBEwB2ARUAZgEXABAAWAFZAWcBlwACACYAYwFoARAAAQBlAAIACACAAQIAgQEBAJkAAQACAIIBDACaAAwADQAOAA8AEAAhAFIBEQCDASYAVAE7AFUBawBsABMAhAFuAG8AFQBXARcAEABYAVkBDACaAAsADQAOAA8AEAAh'
..'AFIBEQCFASYAVAE7AFUBawBbARMAhgFuAF0BFQBeARcAEAAMAJoADAANAA4ADwAQACEAUgERAIcBJgBUATsAVQFrAGwAEwCIAW4AbwAVAFcBFwAQAFgBWQEMAJoADAANAA4ADwAQACEAYQERAIkBJgBjATsAZAFrAGwAEwCKAW4AbwAVAGYBFwAQAFgBWQFnAZ4AAgAm'
..'AGMBaAEQAAwAmgALAA0ADgAPABAAIQBhAREAiwEmAGMBOwBkAWsAWwETAIwBbgBdARUAawEXABAAZwGgAAIAJgBjAWgBEAAMAJoADAANAA4ADwAQACEAYQERAIMBJgBjATsAZAFrAGwAEwCEAW4AbwAVAGYBFwAQAFgBWQFnAaIAAgAmAGMBaAEQAAwAmQAGAA0ADgAP'
..'ABAAEQCNARMAjgEVAG4BFwAQAAwAmQAGAA0ADgAPABAAEQCPARMAkAEVAHEBFwAQAAwAmQAGAA0ADgAPABAAEQCRARMAkgEVAG4BFwAQAAEAmQABAAIAkwEMAKcACgANAA4ADwAQACEAUgERAJQBJgBUATsAVQETAJUBFQBXARcAEABYAVkBDACnAAsADQAOAA8AEAAh'
..'AFIBEQCWASYAVAE7AFUBawB4ARMAlwFuAHgBFQBeARcAEAAMAKcACgANAA4ADwAQACEAUgERAJgBJgBUATsAVQETAJkBFQBXARcAEABYAVkBDACnAAoADQAOAA8AEAAhAGEBEQCaASYAYwE7AGQBEwCbARUAZgEXABAAWAFZAWcBqwACACYAYwFoARAADACnAAsADQAO'
..'AA8AEAAhAGEBEQCcASYAYwE7AGQBawB4ARMAnQFuAHgBFQBrARcAEABnAa0AAgAmAGMBaAEQAAwApwAKAA0ADgAPABAAIQBhAREAlAEmAGMBOwBkARMAlQEVAGYBFwAQAFgBWQFnAa8AAgAmAGMBaAEQAAwAmQAHAAgAngENAA4ADwAQABEAnwETAKABFQChARcAEACi'
..'AbEABQCjASsApAEOAKUBKwCmAacBqAErAKkBsgADAKoBqwGsASsAFQCtAa4BswAGAKoBqwGsASsAFQCtAa8BsAGxAbIBswGnAQEAZQABAAIAtAEBALUAAQACALUBDAC2AAwADQAOAA8AEAAhAFIBEQC2ASYAVAE7AFUBawBsABMAtwFuAG8AFQBXARcAEABYAVkBDAC2'
..'AAsADQAOAA8AEAAhAFIBEQC4ASYAVAE7AFUBawBbARMAuQFuAF0BFQBeARcAEAAMALYADAANAA4ADwAQACEAUgERALoBJgBUATsAVQFrAGwAEwC7AW4AbwAVAFcBFwAQAFgBWQEMALYADAANAA4ADwAQACEAYQERALwBJgBjATsAZAFrAGwAEwC9AW4AbwAVAGYBFwAQ'
..'AFgBWQFnAboAAgAmAGMBaAEQAAwAtgALAA0ADgAPABAAIQBhAREAvgEmAGMBOwBkAWsAWwETAL8BbgBdARUAawEXABAAZwG8AAIAJgBjAWgBEAAMALYADAANAA4ADwAQACEAYQERALYBJgBjATsAZAFrAGwAEwC3AW4AbwAVAGYBFwAQAFgBWQFnAb4AAgAmAGMBaAEQ'
..'AAwAtQAGAA0ADgAPABAAEQDAARMAwQEVAG4BFwAQAAwAtQAGAA0ADgAPABAAEQDCARMAwwEVAHEBFwAQAAwAtQAGAA0ADgAPABAAEQDEARMAxQEVAG4BFwAQAAEAtQABAAIAxgEMAMMACgANAA4ADwAQACEAUgERAMcBJgBUATsAVQETAMgBFQBXARcAEABYAVkBDADD'
..'AAsADQAOAA8AEAAhAFIBEQDJASYAVAE7AFUBawB4ARMAygFuAHgBFQBeARcAEAAMAMMACgANAA4ADwAQACEAUgERAMsBJgBUATsAVQETAMwBFQBXARcAEABYAVkBDADDAAoADQAOAA8AEAAhAGEBEQDNASYAYwE7AGQBEwDOARUAZgEXABAAWAFZAWcBxwACACYAYwFo'
..'ARAADADDAAsADQAOAA8AEAAhAGEBEQDPASYAYwE7AGQBawB4ARMA0AFuAHgBFQBrARcAEABnAckAAgAmAGMBaAEQAAwAwwAKAA0ADgAPABAAIQBhAREAxwEmAGMBOwBkARMAyAEVAGYBFwAQAFgBWQFnAcsAAgAmAGMBaAEQAAEAZQABAAIA0QEBAM0AAQACANIBDADO'
..'AAwADQAOAA8AEAAhAFIBEQDTASYAVAE7AFUBawBsABMA1AFuAG8AFQBXARcAEABYAVkBDADOAAsADQAOAA8AEAAhAFIBEQDVASYAVAE7AFUBawBbARMA1gFuAF0BFQBeARcAEAAMAM4ADAANAA4ADwAQACEAUgERANcBJgBUATsAVQFrAGwAEwDYAW4AbwAVAFcBFwAQ'
..'AFgBWQEMAM4ADAANAA4ADwAQACEAYQERANkBJgBjATsAZAFrAGwAEwDaAW4AbwAVAGYBFwAQAFgBWQFnAdIAAgAmAGMBaAEQAAwAzgALAA0ADgAPABAAIQBhAREA2wEmAGMBOwBkAWsAWwETANwBbgBdARUAawEXABAAZwHUAAIAJgBjAWgBEAAMAM4ADAANAA4ADwAQ'
..'ACEAYQERANMBJgBjATsAZAFrAGwAEwDUAW4AbwAVAGYBFwAQAFgBWQFnAdYAAgAmAGMBaAEQAAwAzQAGAA0ADgAPABAAEQDdARMA3gEVAG4BFwAQAAwAzQAGAA0ADgAPABAAEQDfARMA4AEVAHEBFwAQAAwAzQAGAA0ADgAPABAAEQDhARMA4gEVAG4BFwAQAAEAzQAB'
..'AAIA4wEMANsACgANAA4ADwAQACEAUgERAOQBJgBUATsAVQETAOUBFQBXARcAEABYAVkBDADbAAsADQAOAA8AEAAhAFIBEQDmASYAVAE7AFUBawB4ARMA5wFuAHgBFQBeARcAEAAMANsACgANAA4ADwAQACEAUgERAOgBJgBUATsAVQETAOkBFQBXARcAEABYAVkBDADb'
..'AAoADQAOAA8AEAAhAGEBEQDqASYAYwE7AGQBEwDrARUAZgEXABAAWAFZAWcB3wACACYAYwFoARAADADbAAsADQAOAA8AEAAhAGEBEQDsASYAYwE7AGQBawB4ARMA7QFuAHgBFQBrARcAEABnAeEAAgAmAGMBaAEQAAwA2wAKAA0ADgAPABAAIQBhAREA5AEmAGMBOwBk'
..'ARMA5QEVAGYBFwAQAFgBWQFnAeMAAgAmAGMBaAEQAAEAZQABAAIA7gEBAOUAAQACAO8BDADmAAwADQAOAA8AEAAhAFIBEQDwASYAVAE7AFUBawBsABMA8QFuAG8AFQBXARcAEABYAVkBDADmAAsADQAOAA8AEAAhAFIBEQDyASYAVAE7AFUBawBbARMA8wFuAF0BFQBe'
..'ARcAEAAMAOYADAANAA4ADwAQACEAUgERAPQBJgBUATsAVQFrAGwAEwD1AW4AbwAVAFcBFwAQAFgBWQEMAOYADAANAA4ADwAQACEAYQERAPYBJgBjATsAZAFrAGwAEwD3AW4AbwAVAGYBFwAQAFgBWQFnAeoAAgAmAGMBaAEQAAwA5gALAA0ADgAPABAAIQBhAREA+AEm'
..'AGMBOwBkAWsAWwETAPkBbgBdARUAawEXABAAZwHsAAIAJgBjAWgBEAAMAOYADAANAA4ADwAQACEAYQERAPABJgBjATsAZAFrAGwAEwDxAW4AbwAVAGYBFwAQAFgBWQFnAe4AAgAmAGMBaAEQAAwA5QAGAA0ADgAPABAAEQD6ARMA+wEVAG4BFwAQAAwA5QAGAA0ADgAP'
..'ABAAEQD8ARMA/QEVAHEBFwAQAAwA5QAGAA0ADgAPABAAEQD+ARMA/wEVAG4BFwAQAAEA5QABAAIAAAIMAPMACgANAA4ADwAQACEAUgERAAECJgBUATsAVQETAAICFQBXARcAEABYAVkBDADzAAsADQAOAA8AEAAhAFIBEQADAiYAVAE7AFUBawB4ARMABAJuAHgBFQBe'
..'ARcAEAAMAPMACgANAA4ADwAQACEAUgERAAUCJgBUATsAVQETAAYCFQBXARcAEABYAVkBDADzAAoADQAOAA8AEAAhAGEBEQAHAiYAYwE7AGQBEwAIAhUAZgEXABAAWAFZAWcB9wACACYAYwFoARAADADzAAsADQAOAA8AEAAhAGEBEQAJAiYAYwE7AGQBawB4ARMACgJu'
..'AHgBFQBrARcAEABnAfkAAgAmAGMBaAEQAAwA8wAKAA0ADgAPABAAIQBhAREAAQImAGMBOwBkARMAAgIVAGYBFwAQAFgBWQFnAfsAAgAmAGMBaAEQAAEAZQABAAIACwIBAP0AAQACAAwCDAD+AAwADQAOAA8AEAAhAFIBEQANAiYAVAE7AFUBawBsABMADgJuAG8AFQBX'
..'ARcAEABYAVkBDAD+AAsADQAOAA8AEAAhAFIBEQAPAiYAVAE7AFUBawBbARMAEAJuAF0BFQBeARcAEAAMAP4ADAANAA4ADwAQACEAUgERABECJgBUATsAVQFrAGwAEwASAm4AbwAVAFcBFwAQAFgBWQEMAP4ADAANAA4ADwAQACEAYQERABMCJgBjATsAZAFrAGwAEwAU'
..'Am4AbwAVAGYBFwAQAFgBWQFnAQIBAgAmAGMBaAEQAAwA/gALAA0ADgAPABAAIQBhAREAFQImAGMBOwBkAWsAWwETABYCbgBdARUAawEXABAAZwEEAQIAJgBjAWgBEAAMAP4ADAANAA4ADwAQACEAYQERAA0CJgBjATsAZAFrAGwAEwAOAm4AbwAVAGYBFwAQAFgBWQFn'
..'AQYBAgAmAGMBaAEQAAwA/QAGAA0ADgAPABAAEQAXAhMAGAIVAG4BFwAQAAwA/QAGAA0ADgAPABAAEQAZAhMAGgIVAHEBFwAQAAwA/QAGAA0ADgAPABAAEQAbAhMAHAIVAG4BFwAQAAEA/QABAAIAHQIMAAsBCgANAA4ADwAQACEAUgERAB4CJgBUATsAVQETAB8CFQBX'
..'ARcAEABYAVkBDAALAQsADQAOAA8AEAAhAFIBEQAgAiYAVAE7AFUBawB4ARMAIQJuAHgBFQBeARcAEAAMAAsBCgANAA4ADwAQACEAUgERACICJgBUATsAVQETACMCFQBXARcAEABYAVkBDAALAQoADQAOAA8AEAAhAGEBEQAkAiYAYwE7AGQBEwAlAhUAZgEXABAAWAFZ'
..'AWcBDwECACYAYwFoARAADAALAQsADQAOAA8AEAAhAGEBEQAmAiYAYwE7AGQBawB4ARMAJwJuAHgBFQBrARcAEABnAREBAgAmAGMBaAEQAAwACwEKAA0ADgAPABAAIQBhAREAHgImAGMBOwBkARMAHwIVAGYBFwAQAFgBWQFnARMBAgAmAGMBaAEQAAEAZQACAAgAKAIC'
..'ACkCDAAVAQoACAAqAg0ADgAPABAAIQBhAREAKwImAGMBOwAeARMALAIVAC0CFwAQAC4CBQAAAAEABQACAAgALwICADACDAAYAQoACAAvAg0ADgAPABAAIQAxAhEAMgImADMCOwA8ABMANAIVADUCFwAQAKIBGQEFAKMBKwCkAQ4AaAFZAaUBKwCoASsAqQEaAQQAqgGr'
..'AawBKwATADYCFQA3Aq4BGwEIAKoBqwGsASsAFQCtAa8BsAE4AqsBOQI6ArEBqwGzATsCDAAYAQwACAA8Ag0ADgAPABAAIQA9AhEAPgIkACUAJgA/AjsAHgETAEACFQBBAhcAEAAqACsAQgIdAQAADAAYAQgADQAOAA8AEAAhACIAEQBDAiYAJwATAEQCFQBFAhcAEAAM'
..'ABgBCAANAA4ADwAQACEAIgARAEYCJgAnABMARwIVAEgCFwAQAAwAGAEIAA0ADgAPABAAIQAiABEASQImACcAEwBKAhUASwIXABAADAAYAQkACABMAg0ADgAPABAAIQAiABEATQImACcAEwBOAhUATwIXABAAUAIiAQEAUQJSAlMCGAEBAAgAVAIuAgQAAQAIAFUCAQAE'
..'AAIACABWAgIAVwIMACYBCgAIAC8CDQAOAA8AEAAhADECEQBYAiYAMwI7ADwAEwBZAhUANQIXABAAogEnAQUAowErAKQBDgBoAVkBpQErAKgBKwCpASgBBACqAasBrAErABMANgIVADcCrgEpAQgAqgGrAawBKwAVAK0BrwGwATgCqwE5AjoCsQGrAbMBOwIMACYBDAAI'
..'ADwCDQAOAA8AEAAhAD0CEQBaAiQAJQAmAD8COwAeARMAWwIVAEECFwAQACoAKwAuAisBAABTAiwBAQAIAFQCDAAmAQgADQAOAA8AEAAhACIAEQBcAiYAJwATAF0CFQBFAhcAEAAMACYBCAANAA4ADwAQACEAIgARAF4CJgAnABMAXwIVAEgCFwAQAAwAJgEIAA0ADgAP'
..'ABAAIQAiABEAYAImACcAEwBhAhUASwIXABAADAAmAQkACABMAg0ADgAPABAAIQAiABEAYgImACcAEwBjAhUATwIXABAAUAIxAQEAUQJSAgcAAwABAAgAZAJlAjMBAQAIAGYCZQIzAQEACABnAgwAAQAJAA0ADgAPABAAIQBnABEAaAImAGkAOwAeARMAaQIVAGoCFwAQ'
..'AAwAAQAKAA0ADgAPABAAIQBnABEAawIkACUAJgBpADsAHgETAGwCFQBtAhcAEABuAjcBAgBvAnACcQIlAC4CNwEAAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
