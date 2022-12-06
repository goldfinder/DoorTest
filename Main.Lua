-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 23272 characters

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
script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil then
		script.Parent.Parent.Parent.Parent.Parent.Events.LoadNextRoom:Fire(script.Parent.Parent.DID.Value)
	end
end)

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


local Objects = Decode('AFCaAiEFTW9kZWwhCldvcmxkUGl2b3QEcQJyAnMCBHQCcgJzAgR1AnICcwIEdgJyAnMCIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQEdwJyAnMCIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUAHICcwIhCFBv'
..'c2l0aW9uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQByAnMCCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHAByAnMCCsXOr0OPM/VC98CLxAQeAHICcwIKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNr'
..'Q29sb3IH6gMEKAByAnMCIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AcgJzAgoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyAHICcwIKAAAAAAAA'
..'AACPwuNAIQJVcAR4AnICcwIENgByAnMCCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQB5AnMCBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAAHkCcwIKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDAHkCcwIK'
..'lWaQQw6v/UJhXo3EBEUAeQJzAgqVZpBDDq//QseEjcQERwByAnMCCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgByAnMCCm2gjkM2LwBDOruMxARMAHICcwIKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPAHICcwIK1WCQQ0ovAENkv4zEBFEAcgJzAgoAOjS9'
..'AACsQKRwZ8EEUwByAnMCCgAAVTw3ibXAMLJjQQRVAHkCcwIKlWaQQw6v90Iu64zEBFcAeQJzAgqVZpBDDq/5QpQRjcQEWQB5AnMCCpVmkEMOr/FC+neMxARbAHkCcwIKlWaQQw+v80JhnozEBF0AeQJzAgqVZpBDDq/1QsfEjMQEXwByAnMCCi9lkEOzPexCOruMxArG'
..'QeZAQLbiPoid6EEEYgB6AnMCCpVmkEMOr+1CLiuMxARkAHkCcwIKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBHsCfAJzAgdrAARtAH0CfgIGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAA'
..'AAAANEMKPibWQUC24j6InehBBHIAfQJ+Agr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBHUAfQJ+AgoLXqZDHSn5QvW5jsQEdwB9An4CCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegB9An4CCr+un0NU/AJD9bmOxAR8AH0CfgIKf/ejQx0p+ULDhpDECvy/HUEY'
..'mVJBEqmNPgR/AH0CfgIKMXObQx0p+ULDhpDEBIEAfQJ+AgrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BIQAfQJ+Agoxc5tDHSn5QhvrjMQEhgB9An4CCteBnUOGJgFDG+uMxASIAH0CfgIKf/ejQx0p+UIb64zEBIoAfQJ+AgoFtp9D+yj5QvW5jsQEjQB/AnMCCgAA'
..'AACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkAByAnMCCgDAVDzByvG/FK5pwSEERG93bgSAAnICcwIElAB9An4CCjPBikN+XwpDb7aMxASWAH0CfgIKM7qKQ/cUAUMfYYvEBJgAfQJ+AgozuopD7in8Qtk9jMQEmgB9An4CCjO6ikPuKf5CcheMxAScAH0CfgIKM7qK'
..'Q/cUAEMM8YvEBJ4AfQJ+Agpp/ohDpmwAQ5m6jMQEoAB9An4CClmAjEOmbABDmbqMxASiAH0CfgIKM8GKQ13sBEO+ho7EBKQAfQJ+Agrzv4pDumwAQ2+2jMQEpgB9An4CCjO6ikPuKfhCpYqMxASoAH0CfgIKM7qKQ+4p+kI/ZIzEBKoAfQJ+AgozuopD7inyQtn9jMQE'
..'rAB9An4CCjO6ikPvKfRCcteMxASuAH0CfgIKM7qKQ+4p9kIMsYzEBLAAfQJ+AgqZu4pDk7jsQpm6jMQEsgB9An4CCjO6ikPuKe5CpUqNxAS0AH0CfgIKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBIECcgJzAgS4AH0CfgIKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3o'
..'QQS7AH0CfgIKIqI/Q1Fc+ULgG5HEBL0AfQJ+AgpVEIRDUVz5QuAbkcQEvwB9An4CChLCekMXpOxCwU2PxATBAH0CfgIKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEAH0CfgIKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHAH0CfgIK0o1EQ1Fc+UKv6JLEBMkA'
..'fQJ+Agoeq0hDIEABQ6/oksQEywB9An4CChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgB9An4CCkJodkMgQAFDBk2PxATQAH0CfgIKyamBQ1Fc+UIGTY/EBNIAfQJ+AgpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEggJyAnMCBNYAfQJ+AgoycWRD9qvsQtY0jMQE'
..'2AB9An4CCro/QEMwZPlC1jSMxATaAH0CfgIKH1+EQzBk+ULWNIzEBNwAfQJ+AgqqX3tD9qvsQrdmisQE3gB9An4CCs5mZEPcGQND1jSMxATgAH0CfgIK4olkQ9Jv+ULQM4zEBIMChAJzAgTjAH0CfgIKfwyCQ2Bk+UKjAY7EBOUAfQJ+AgqKMFxDYGT5QqMBjsQE5wB9'
..'An4CCq4td0MoRAFDowGOxASFAoQCcwIE6gB9An4CChLubENsavlC/WWKxATsAH0CfgIKyiBJQy1HAUP9ZYrEBO4AfQJ+Agp6A0VDbGr5Qv1lisQhA0xJQgSGAocCcwIE8gCIAokCCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYAigJzAgp5'
..'k6RDfj8DQ17PfMQE+AByAnMCCgAAAAAGgeW/4vqvQgT6AHICcwIKAAAAAPp+8sBf5a/CBPwAiAKJAgq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BP8AiAKJAgp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBiAKJAgp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+'
..'BAUBfQJ+AgrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBiAKJAgrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBiAKJAgp3k4dDfj8DQyLLfMQEDQGIAokCCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAGIAokCCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDv'
..'fz8EEwGIAokCCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgGIAokCCk03mkPnUPZCnm9wxAQYAYgCiQIKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEHwGIAokCBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HA'
..'d5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBiAKJAgq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQND'
..'oO9vxAQuAYgCiQIKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAYgCiQIKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AYgCiQIKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3AYgCiQIKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AYgCiQIKtZ2LQ+dQ'
..'9kKi72/ECmZmdkEAAABBwO9/PwQ9AYgCiQIKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQAAwEBwURBCCsXLi0PoUPRCFE1rxARGAYgCiQIKQ4CkQ5JtC0PayWbE'
..'CpmZEUFwPTJBAOjWPgRJAYgCiQIKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAYgCiQIKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAYgCiQIK5xCVQ34/A0PayWbEBIsCcgJzAgRqAYcCcwIHxwAEVgF9An4CBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QK'
..'ANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAYwCjQIKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABfQJ+Agp+SqpDKITwQos2h8QHagAEZQF9An4CBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAA'
..'gD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagGMAo0CCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQFyAnMCCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAFyAnMCCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEcwFyAnMCCsdLnkM9ngNDizaHxAR/AXIC'
..'cwIEdgFyAnMCCg/NnkPWy/5CizaHxAR5AY4CjwIKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7AXICcwIKD82eQyiE8EKLNofEBH0BcgJzAgoPzZ5DZY7wQos2h8QEfwGOAo8CCg7NnkP/p/dCizaHxCEEQXJjaASQAnICcwIEjAGHAnMCBIQBfQJ+Agp+SqpD1sv+'
..'Qou2hMQEhgGMAo0CCn5KqkP/p/dCi7aExASIAX0CfgIKfkqqQyiE8EKLtoTEBIoBfQJ+Agp+SqpDZY7wQou2hMQEjAGMAo0CCn9KqkP/p/dCi7aExASOAXICcwIKx8uqQz2eA0OLtoTEBJABcgJzAgrHi6RDeqgGQ4u2hMQEkgFyAnMCCsdLnkM9ngNDi7aExASdAXIC'
..'cwIElQFyAnMCCg/NnkPWy/5Ci7aExASXAY4CjwIKD82eQ/+n90KLtoTEBJkBcgJzAgoPzZ5DKITwQou2hMQEmwFyAnMCCg/NnkNljvBCi7aExASdAY4CjwIKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABcgJzAgrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABAIQpTdXJm'
..'YWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/'
..'AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQSRAnICcwIEvwGHAnMCBLcBfQJ+Agp+SqpD1sv+Qos2gsQEuQGMAo0CCn5KqkP/p/dCizaCxAS7AX0CfgIKfkqqQyiE8EKLNoLEBL0BfQJ+Agp+SqpDZY7wQos2'
..'gsQEvwGMAo0CCn9KqkP/p/dCizaCxATBAXICcwIKx8uqQz2eA0OLNoLEBMMBcgJzAgrHi6RDeqgGQ4s2gsQExQFyAnMCCsdLnkM9ngNDizaCxATQAXICcwIEyAFyAnMCCg/NnkPWy/5CizaCxATKAY4CjwIKD82eQ/+n90KLNoLEBMwBcgJzAgoPzZ5DKITwQos2gsQE'
..'zgFyAnMCCg/NnkNljvBCizaCxATQAY4CjwIKDs2eQ/+n90KLNoLEBJICcgJzAgTcAYcCcwIE1AF9An4CCn5KqkPWy/5CFm1/xATWAYwCjQIKfkqqQ/+n90IWbX/EBNgBfQJ+Agp+SqpDKITwQhZtf8QE2gF9An4CCn5KqkNljvBCFm1/xATcAYwCjQIKf0qqQ/+n90IW'
..'bX/EBN4BcgJzAgrHy6pDPZ4DQxZtf8QE4AFyAnMCCseLpEN6qAZDFm1/xATiAXICcwIKx0ueQz2eA0MWbX/EBO0BcgJzAgTlAXICcwIKD82eQ9bL/kIWbX/EBOcBjgKPAgoPzZ5D/6f3QhZtf8QE6QFyAnMCCg/NnkMohPBCFm1/xATrAXICcwIKD82eQ2WO8EIWbX/E'
..'BO0BjgKPAgoOzZ5D/6f3QhZtf8QEkwJyAnMCBPkBhwJzAgTxAX0CfgIKfkqqQ9bL/kIWbXrEBPMBjAKNAgp+SqpD/6f3QhZtesQE9QF9An4CCn5KqkMohPBCFm16xAT3AX0CfgIKfkqqQ2WO8EIWbXrEBPkBjAKNAgp/SqpD/6f3QhZtesQE+wFyAnMCCsfLqkM9ngND'
..'Fm16xAT9AXICcwIKx4ukQ3qoBkMWbXrEBP8BcgJzAgrHS55DPZ4DQxZtesQECgJyAnMCBAICcgJzAgoPzZ5D1sv+QhZtesQEBAKOAo8CCg/NnkP/p/dCFm16xAQGAnICcwIKD82eQyiE8EIWbXrEBAgCcgJzAgoPzZ5DZY7wQhZtesQECgKOAo8CCg7NnkP/p/dCFm16'
..'xASUAnICcwIEFgKHAnMCBA4CfQJ+Agp+SqpD1sv+QhZtdcQEEAKMAo0CCn5KqkP/p/dCFm11xAQSAn0CfgIKfkqqQyiE8EIWbXXEBBQCfQJ+Agp+SqpDZY7wQhZtdcQEFgKMAo0CCn9KqkP/p/dCFm11xAQYAnICcwIKx8uqQz2eA0MWbXXEBBoCcgJzAgrHi6RDeqgG'
..'QxZtdcQEHAJyAnMCCsdLnkM9ngNDFm11xAQnAnICcwIEHwJyAnMCCg/NnkPWy/5CFm11xAQhAo4CjwIKD82eQ/+n90IWbXXEBCMCcgJzAgoPzZ5DKITwQhZtdcQEJQJyAnMCCg/NnkNljvBCFm11xAQnAo4CjwIKDs2eQ/+n90IWbXXEIQIyMASVApYClwIhAy0tLQQs'
..'ApgCfgIKsYWkQy0HAkOIimfECo/CXUF7FDZBCtfDQCEGU2NyaXB0IQREb29yBJkCcgJzAgdpAQQ0AnICcwIGVkI2CsfpFEMXWPVClBSQxAraRcdA7dYDQRiFIz8MAAAAAAAAzczMPQAADAAAgD8AAAAAAABkACERUGxhY2Vob2xkZXJDb2xvcjMhBFRleHQhATADAAAA'
..'AAAAREAhEERvb3JIaXREZXRlY3Rpb24HTAEEQAJyAnMCBnUAAArH6RRDF1j1QrcRkMQKdjHfQFK4CkFcj0I/BEMCcgJzAgqUOhhDZDD1Qm4XkMQK4PvjPjvnDUEAoy0/BEYCcgJzAgrm/RRDB/H9Qm4XkMQKamvdQCD93j4Aoy0/BEkCcgJzAgqWjBFDF1j1Qm4XkMQK'
..'QCIWP2tiEEEAoy0/IQJTUARNAnICcwIKjNoUQ0zD7EJuF5DECsZB5kBAtuI+AKMtPyEFU291bmQhB1NvdW5kSWQhFnJieGFzc2V0aWQ6Ly8xNTcxNjcyMDMhC051bWJlclZhbHVlIQNESUQhBU1haW5zIQVTRG9vcgSaAnICcwIEWAJyAnMCCpq7Z0IXWPVClBSQxARa'
..'AnICcwIKmrtnQhdY9UK3EZDEBFwCcgJzAgrO/nRCZDD1Qm4XkMQEXgJyAnMCChQMaEIH8f1CbheQxARgAnICcwIK1kZaQhdY9UJuF5DEBGICcgJzAgqufmdCTMPsQm4XkMQhBkV2ZW50cyENQmluZGFibGVFdmVudCEMTG9hZE5leHRSb29tIQlBc3NldFBhdGgEaAJy'
..'AnMCChCbZkIlhexCmZqLxAowM7FCj8L1PSlcj0IEawJyAnMCCgAAAACuR5FAAAAAAAoAAIA/AACAPwAAgD8hD1Byb3hpbWl0eVByb21wdCEKT2JqZWN0VGV4dCE9R29sZDNuRjFyMydzIERvb3JzIEVuZ2luZS4KCkludGVyYWN0IHdpdGggbWUgdG8gcGxheSAiZG9v'
..'cnMiLiETUmVxdWlyZXNMaW5lT2ZTaWdodAo/9b9DvAmVQh/NEsQKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAoCimZCuiwOQyd1h8QKrn5nQjtZ9UKOFIfECrobhkLwXvVCloGJxAoDBa5DiRb1Qqa9i8QK02CQQywvAENkv4zECv3/fz8AAAAAAAAAAAr//38/AAAA'
..'AAAAAAAKBbafQx0p+UL1uY7ECgAAgL8AAAAALr27swoAAIC/Lr27s+2tCSgKLr27swAAgD8uvbuzCgAAgD8AAAAALr07tAr1v4pDnGwAQ2+2jMQKSuxjQ/hn+ULaGpHECuKJZEPWb/lC0DOMxArSomRDYGT5QqMBjsQKAACAvwAAAAAuvbszCuJ6ZENtavlC/WWKxAp3'
..'k6RDfj8DQ17PfMQKAACAvwAAAAAAAAAACgAAgL8uvbsz7a0JKAouvbszAACAPy69uzMKAACAPwAAAAAuvbuzCseLpEM9ngNDizaHxAouvTuzAACAPy69u7MKAACAPy69OzPtrYmnCi69O7MAAIA/AAAAAAoAAIC/Lr07swAAAAAKx4ukQz2eA0OLtoTECseLpEM9ngND'
..'izaCxArHi6RDPZ4DQxZtf8QKx4ukQz2eA0MWbXrECseLpEM9ngNDFm11xAo7laRD9yAGQy/PhMQKAACAPy69OzPtrQmnCi69O7MAAIA/Lr07swoAAIA/Lr27M1ocjicKjNoUQzxZ9ULrE5DECq5+Z0I8WfVC6xOQxDkBAQAAAAEAAgADAAEAAQABAAIABAABAAIAAQAC'
..'AAUAAQADAAEAAgAGAAcABAABAAgACQABAAUAAgAIAAoAAgALAAwABgAGAA0ADgAPABAAEQASABMAFAAVABYAFwAQAAwABgAGAA0ADgAPABAAEQAYABMAGQAVABoAFwAQAAwABgAGAA0ADgAPABAAEQAbABMAHAAVABoAFwAQAAwABgAGAA0ADgAPABAAEQAdABMAHgAV'
..'AB8AFwAQAAwABgALAAgAIAANAA4ADwAQACEAIgARACMAJAAlACYAJwATACgAFQApABcAEAAqACsALAALAAMACAAtABEALgATAC8ALAALAAMACAAwABEAMQATADIAAQAFAAIACAAzAAIANAAMAA4ABgANAA4ADwAQABEANQATADYAFQA3ABcAEAAMAA4ACQANAA4ADwAQ'
..'ACEAOAARADkAJgA6ADsAPAATAD0AFQA+ABcAEAAMAA4ACQANAA4ADwAQACEAOAARAD8AJgA6ADsAPAATAEAAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAEIAJgA6ADsAPAATAEMAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAEQAJgA6ADsAPAATAEUAFQBB'
..'ABcAEAAMAA4ABgANAA4ADwAQABEARgATAEcAFQBIABcAEAAMAA4ABgANAA4ADwAQABEASQATAEoAFQBIABcAEAAMAA4ABgANAA4ADwAQABEASwATAEwAFQBNABcAEAAMAA4ACwAIACAADQAOAA8AEAAhACIAEQBOACQAJQAmACcAEwBPABUAKQAXABAAKgArACwAFwAD'
..'AAgALQARAFAAEwBRACwAFwADAAgAMAARAFIAEwBTAAwADgAJAA0ADgAPABAAIQA4ABEAVAAmADoAOwA8ABMAVQAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAVgAmADoAOwA8ABMAVwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAWAAmADoAOwA8ABMAWQAV'
..'AEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAWgAmADoAOwA8ABMAWwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAXAAmADoAOwA8ABMAXQAVAEEAFwAQAAwADgAGAA0ADgAPABAAEQBeABMAXwAVAGAAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAYQAmADoAOwA8'
..'ABMAYgAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAYwAmADoAOwA8ABMAZAAVAEEAFwAQAAEABQACAAgAZQACAGYADAAiAAsADQAOAA8AEAAhAGcAEQBoACYAaQA7AGoAawBsABMAbQBuAG8AFQBwABcAEAAMACIACAANAA4ADwAQABEAcQBrAGwAEwByAG4AbwAV'
..'AHMAFwAQAAwAIgAIAA0ADgAPABAAEQB0AGsAbAATAHUAbgBvABUAcwAXABAADAAiAAgADQAOAA8AEAARAHYAawBsABMAdwBuAG8AFQB4ABcAEAAMACIACAANAA4ADwAQABEAeQBrAGwAEwB6AG4AbwAVAHAAFwAQAAwAIgAIAA0ADgAPABAAEQB7AGsAbAATAHwAbgBv'
..'ABUAfQAXABAADAAiAAgADQAOAA8AEAARAH4AawBsABMAfwBuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAgABrAGwAEwCBAG4AbwAVAIIAFwAQAAwAIgAIAA0ADgAPABAAEQCDAGsAbAATAIQAbgBvABUAfQAXABAADAAiAAgADQAOAA8AEAARAIUAawBsABMAhgBu'
..'AG8AFQCCABcAEAAMACIACAANAA4ADwAQABEAhwBrAGwAEwCIAG4AbwAVAH0AFwAQAAwAIgANAAgAIAANAA4ADwAQACEAIgARAIkAJAAlACYAJwBrAGwAEwCKAG4AbwAVACkAFwAQACoAKwAsAC4ABAAIAC0AEQCLAGsAjAATAI0ALAAuAAMACACOABEAjwATAJAAAQAF'
..'AAIACACRAAIAkgAMADEACAANAA4ADwAQABEAkwBrAGwAEwCUAG4AbwAVADcAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAlQAmADoAOwA8AGsAbAATAJYAbgBvABUAPgAXABAADAAxAAsADQAOAA8AEAAhADgAEQCXACYAOgA7ADwAawBsABMAmABuAG8AFQBBABcAEAAM'
..'ADEACwANAA4ADwAQACEAOAARAJkAJgA6ADsAPABrAGwAEwCaAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAmwAmADoAOwA8AGsAbAATAJwAbgBvABUAQQAXABAADAAxAAgADQAOAA8AEAARAJ0AawBsABMAngBuAG8AFQBIABcAEAAMADEACAANAA4ADwAQ'
..'ABEAnwBrAGwAEwCgAG4AbwAVAEgAFwAQAAwAMQAIAA0ADgAPABAAEQChAGsAbAATAKIAbgBvABUATQAXABAADAAxAA0ACAAgAA0ADgAPABAAIQAiABEAowAkACUAJgAnAGsAbAATAKQAbgBvABUAKQAXABAAKgArACwAOgADAAgALQARAFAAEwBRACwAOgADAAgAMAAR'
..'AFIAEwBTAAwAMQALAA0ADgAPABAAIQA4ABEApQAmADoAOwA8AGsAbAATAKYAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCnACYAOgA7ADwAawBsABMAqABuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKkAJgA6ADsAPABrAGwAEwCqAG4AbwAV'
..'AEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAqwAmADoAOwA8AGsAbAATAKwAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCtACYAOgA7ADwAawBsABMArgBuAG8AFQBBABcAEAAMADEACAANAA4ADwAQABEArwBrAGwAEwCwAG4AbwAVAGAAFwAQAAwAMQAL'
..'AA0ADgAPABAAIQA4ABEAsQAmADoAOwA8AGsAbAATALIAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCzACYAOgA7ADwAawBsABMAtABuAG8AFQBBABcAEAABAAUAAgAIALUAAgC2AAwARQALAA0ADgAPABAAIQBnABEAtwAmAGkAOwBqAGsAbAATALgAbgBv'
..'ABUAuQAXABAADABFAAgADQAOAA8AEAARALoAawBsABMAuwBuAG8AFQBzABcAEAAMAEUACAANAA4ADwAQABEAvABrAGwAEwC9AG4AbwAVAHMAFwAQAAwARQAIAA0ADgAPABAAEQC+AGsAbAATAL8AbgBvABUAeAAXABAADABFAAgADQAOAA8AEAARAMAAawBsABMAwQBu'
..'AG8AFQDCABcAEAAMAEUACAANAA4ADwAQABEAwwBrAGwAEwDEAG4AbwAVAMUAFwAQAAwARQAIAA0ADgAPABAAEQDGAGsAbAATAMcAbgBvABUAfQAXABAADABFAAgADQAOAA8AEAARAMgAawBsABMAyQBuAG8AFQCCABcAEAAMAEUACAANAA4ADwAQABEAygBrAGwAEwDL'
..'AG4AbwAVAMwAFwAQAAwARQAIAA0ADgAPABAAEQDNAGsAbAATAM4AbgBvABUAggAXABAADABFAAgADQAOAA8AEAARAM8AawBsABMA0ABuAG8AFQB9ABcAEAAMAEUADQAIACAADQAOAA8AEAAhACIAEQDRACQAJQAmACcAawBsABMA0gBuAG8AFQApABcAEAAqACsALABR'
..'AAQACAAtABEAiwBrAIwAEwCNACwAUQADAAgAjgARAI8AEwCQAAEABQACAAgA0wACANQADABUAAsADQAOAA8AEAAhAGcAEQDVACYAaQA7AGoAawBsABMA1gBuAG8AFQC5ABcAEAAMAFQACAANAA4ADwAQABEA1wBrAGwAEwDYAG4AbwAVAHMAFwAQAAwAVAAIAA0ADgAP'
..'ABAAEQDZAGsAbAATANoAbgBvABUAcwAXABAADABUAAgADQAOAA8AEAARANsAawBsABMA3ABuAG8AFQB4ABcAEAAMAFQACAANAA4ADwAQABEA3QBrAGwAEwDeAG4AbwAVAMIAFwAQAAwAVAANAAgAIAANAA4ADwAQACEAIgARAN8AJAAlACYAJwBrAGwAEwDgAG4AbwAV'
..'ACkAFwAQACoAKwAsAFoABAAIAC0AEQCLAGsAjAATAI0ALABaAAMACACOABEAjwATAJAAAQBUAAEAAgDhAAwAXQAIAA0ADgAPABAAEQDiAGsAbAATAOMAbgBvABUAfQAXABAADABdAAgADQAOAA8AEAARAOQAawBsABMA5QBuAG8AFQDMABcAEAAMAF0ACAANAA4ADwAQ'
..'ABEA5gBrAGwAEwDnAG4AbwAVAIIAFwAQAAEAVAABAAIA6AAMAGEACAANAA4ADwAQABEA6QBrAGwAEwDqAG4AbwAVAMUAFwAQAAwAYQAIAA0ADgAPABAAEQDrAGsAbAATAOwAbgBvABUAggAXABAADABhAAgADQAOAA8AEAARAO0AawBsABMA7gBuAG8AFQB9ABcAEAAB'
..'AAUAAgAIAO8AAgDwAAwAZQAIAA0ADgAPABAAEQDxAGsAbAATAPIAbgDzABUA9AAXABAADABlAAsACAAgAA0ADgAPABAAIQAiABEA9QAkACUAJgAnABMA9gAVACkAFwAQACoAKwAsAGcAAwAIAC0AEQD3ABMA+AAsAGcAAwAIAI4AEQD5ABMA+gAMAGUACAANAA4ADwAQ'
..'ABEA+wBrAGwAEwD8AG4A8wAVAP0AFwAQAAwAZQAIAA0ADgAPABAAEQD+AGsAbAATAP8AbgDzABUAAAEXABAADABlAAgADQAOAA8AEAARAAEBawBsABMAAgFuAPMAFQADARcAEAAMAGUACwANAA4ADwAQACEAOAARAAQBJgA6ADsAPABrAGwAEwAFAW4AbwAVAAYBFwAQ'
..'AAwAZQAIAA0ADgAPABAAEQAHAWsAbAATAAgBbgDzABUACQEXABAADABlAAgADQAOAA8AEAARAAoBawBsABMACwFuAPMAFQAJARcAEAAMAGUACwANAA4ADwAQACEAOAARAAwBJgA6ADsAPABrAGwAEwANAW4A8wAVAA4BFwAQAAwAZQALAA0ADgAPABAAIQA4ABEADwEm'
..'ADoAOwA8AGsAbAATABABbgDzABUAEQEXABAADABlAAgADQAOAA8AEAARABIBawBsABMAEwFuAPMAFQAUARcAEAAMAGUACAANAA4ADwAQABEAFQFrAGwAEwAWAW4A8wAVABQBFwAQAAwAZQAIAA0ADgAPABAAEQAXAWsAbAATABgBbgDzABUAGQEXABAAGgFAAgAMACIB'
..'IwFsAAAMACQBJQFsAGUACgANAA4AIQAbAREAHAEmAB0BOwAeAWsAbAATAB8BbgDzABUAIAEhAQ4AGgFAAgAMACkBKgFsAAAMACsBLAFsAGUACgANAA4AIQAbAREAJgEmAB0BOwAeAWsAbAATACcBbgDzABUAKAEhAQ4ADABlAAsADQAOAA8AEAAhADgAEQAtASYAOgA7'
..'ADwAawBsABMALgFuAPMAFQAvARcAEAAMAGUACwANAA4ADwAQACEAOAARADABJgA6ADsAPABrAGwAEwAxAW4A8wAVADIBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEAMwEmADoAOwA8AGsAbAATADQBbgDzABUANQEXABAADABlAAsADQAOAA8AEAAhADgAEQA2ASYAOgA7'
..'ADwAawBsABMANwFuAPMAFQA4ARcAEAAMAGUACAANAA4ADwAQABEAOQFrAGwAEwA6AW4A8wAVADsBFwAQABoBQAMADAA/AUABbAAADABBAUIBbAAADABDAUQBbABlAAoADQAOACEAZwARADwBJgBpADsAagBrAGwAEwA9AW4A8wAVAD4BIQEOAAwAZQAIAA0ADgAPABAA'
..'EQBFAWsAbAATAEYBbgDzABUARwEXABAADABlAAgADQAOAA8AEAARAEgBawBsABMASQFuAPMAFQBKARcAEAAMAGUACAANAA4ADwAQABEASwFrAGwAEwBMAW4A8wAVAE0BFwAQAAwAZQAIAA0ADgAPABAAEQBOAWsAbAATAE8BbgDzABUASgEXABAAAQBlAAEAAgBQAQEA'
..'gQABAAIAUQEMAIIADAANAA4ADwAQACEAUgERAFMBJgBUATsAVQFrAGwAEwBWAW4AbwAVAFcBFwAQAFgBWQEMAIIACwANAA4ADwAQACEAUgERAFoBJgBUATsAVQFrAFsBEwBcAW4AXQEVAF4BFwAQAAwAggAMAA0ADgAPABAAIQBSAREAXwEmAFQBOwBVAWsAbAATAGAB'
..'bgBvABUAVwEXABAAWAFZAQwAggAMAA0ADgAPABAAIQBhAREAYgEmAGMBOwBkAWsAbAATAGUBbgBvABUAZgEXABAAWAFZAWcBhgACACYAYwFoARAADACCAAsADQAOAA8AEAAhAGEBEQBpASYAYwE7AGQBawBbARMAagFuAF0BFQBrARcAEABnAYgAAgAmAGMBaAEQAAwA'
..'ggAMAA0ADgAPABAAIQBhAREAUwEmAGMBOwBkAWsAbAATAFYBbgBvABUAZgEXABAAWAFZAWcBigACACYAYwFoARAADACBAAYADQAOAA8AEAARAGwBEwBtARUAbgEXABAADACBAAYADQAOAA8AEAARAG8BEwBwARUAcQEXABAADACBAAYADQAOAA8AEAARAHIBEwBzARUA'
..'bgEXABAAAQCBAAEAAgB0AQwAjwAKAA0ADgAPABAAIQBSAREAdQEmAFQBOwBVARMAdgEVAFcBFwAQAFgBWQEMAI8ACwANAA4ADwAQACEAUgERAHcBJgBUATsAVQFrAHgBEwB5AW4AeAEVAF4BFwAQAAwAjwAKAA0ADgAPABAAIQBSAREAegEmAFQBOwBVARMAewEVAFcB'
..'FwAQAFgBWQEMAI8ACgANAA4ADwAQACEAYQERAHwBJgBjATsAZAETAH0BFQBmARcAEABYAVkBZwGTAAIAJgBjAWgBEAAMAI8ACwANAA4ADwAQACEAYQERAH4BJgBjATsAZAFrAHgBEwB/AW4AeAEVAGsBFwAQAGcBlQACACYAYwFoARAADACPAAoADQAOAA8AEAAhAGEB'
..'EQB1ASYAYwE7AGQBEwB2ARUAZgEXABAAWAFZAWcBlwACACYAYwFoARAAAQBlAAIACACAAQIAgQEBAJkAAQACAIIBDACaAAwADQAOAA8AEAAhAFIBEQCDASYAVAE7AFUBawBsABMAhAFuAG8AFQBXARcAEABYAVkBDACaAAsADQAOAA8AEAAhAFIBEQCFASYAVAE7AFUB'
..'awBbARMAhgFuAF0BFQBeARcAEAAMAJoADAANAA4ADwAQACEAUgERAIcBJgBUATsAVQFrAGwAEwCIAW4AbwAVAFcBFwAQAFgBWQEMAJoADAANAA4ADwAQACEAYQERAIkBJgBjATsAZAFrAGwAEwCKAW4AbwAVAGYBFwAQAFgBWQFnAZ4AAgAmAGMBaAEQAAwAmgALAA0A'
..'DgAPABAAIQBhAREAiwEmAGMBOwBkAWsAWwETAIwBbgBdARUAawEXABAAZwGgAAIAJgBjAWgBEAAMAJoADAANAA4ADwAQACEAYQERAIMBJgBjATsAZAFrAGwAEwCEAW4AbwAVAGYBFwAQAFgBWQFnAaIAAgAmAGMBaAEQAAwAmQAGAA0ADgAPABAAEQCNARMAjgEVAG4B'
..'FwAQAAwAmQAGAA0ADgAPABAAEQCPARMAkAEVAHEBFwAQAAwAmQAGAA0ADgAPABAAEQCRARMAkgEVAG4BFwAQAAEAmQABAAIAkwEMAKcACgANAA4ADwAQACEAUgERAJQBJgBUATsAVQETAJUBFQBXARcAEABYAVkBDACnAAsADQAOAA8AEAAhAFIBEQCWASYAVAE7AFUB'
..'awB4ARMAlwFuAHgBFQBeARcAEAAMAKcACgANAA4ADwAQACEAUgERAJgBJgBUATsAVQETAJkBFQBXARcAEABYAVkBDACnAAoADQAOAA8AEAAhAGEBEQCaASYAYwE7AGQBEwCbARUAZgEXABAAWAFZAWcBqwACACYAYwFoARAADACnAAsADQAOAA8AEAAhAGEBEQCcASYA'
..'YwE7AGQBawB4ARMAnQFuAHgBFQBrARcAEABnAa0AAgAmAGMBaAEQAAwApwAKAA0ADgAPABAAIQBhAREAlAEmAGMBOwBkARMAlQEVAGYBFwAQAFgBWQFnAa8AAgAmAGMBaAEQAAwAmQAHAAgAngENAA4ADwAQABEAnwETAKABFQChARcAEACiAbEABQCjASsApAEOAKUB'
..'KwCmAacBqAErAKkBsgADAKoBqwGsASsAFQCtAa4BswAGAKoBqwGsASsAFQCtAa8BsAGxAbIBswGnAQEAZQABAAIAtAEBALUAAQACALUBDAC2AAwADQAOAA8AEAAhAFIBEQC2ASYAVAE7AFUBawBsABMAtwFuAG8AFQBXARcAEABYAVkBDAC2AAsADQAOAA8AEAAhAFIB'
..'EQC4ASYAVAE7AFUBawBbARMAuQFuAF0BFQBeARcAEAAMALYADAANAA4ADwAQACEAUgERALoBJgBUATsAVQFrAGwAEwC7AW4AbwAVAFcBFwAQAFgBWQEMALYADAANAA4ADwAQACEAYQERALwBJgBjATsAZAFrAGwAEwC9AW4AbwAVAGYBFwAQAFgBWQFnAboAAgAmAGMB'
..'aAEQAAwAtgALAA0ADgAPABAAIQBhAREAvgEmAGMBOwBkAWsAWwETAL8BbgBdARUAawEXABAAZwG8AAIAJgBjAWgBEAAMALYADAANAA4ADwAQACEAYQERALYBJgBjATsAZAFrAGwAEwC3AW4AbwAVAGYBFwAQAFgBWQFnAb4AAgAmAGMBaAEQAAwAtQAGAA0ADgAPABAA'
..'EQDAARMAwQEVAG4BFwAQAAwAtQAGAA0ADgAPABAAEQDCARMAwwEVAHEBFwAQAAwAtQAGAA0ADgAPABAAEQDEARMAxQEVAG4BFwAQAAEAtQABAAIAxgEMAMMACgANAA4ADwAQACEAUgERAMcBJgBUATsAVQETAMgBFQBXARcAEABYAVkBDADDAAsADQAOAA8AEAAhAFIB'
..'EQDJASYAVAE7AFUBawB4ARMAygFuAHgBFQBeARcAEAAMAMMACgANAA4ADwAQACEAUgERAMsBJgBUATsAVQETAMwBFQBXARcAEABYAVkBDADDAAoADQAOAA8AEAAhAGEBEQDNASYAYwE7AGQBEwDOARUAZgEXABAAWAFZAWcBxwACACYAYwFoARAADADDAAsADQAOAA8A'
..'EAAhAGEBEQDPASYAYwE7AGQBawB4ARMA0AFuAHgBFQBrARcAEABnAckAAgAmAGMBaAEQAAwAwwAKAA0ADgAPABAAIQBhAREAxwEmAGMBOwBkARMAyAEVAGYBFwAQAFgBWQFnAcsAAgAmAGMBaAEQAAEAZQABAAIA0QEBAM0AAQACANIBDADOAAwADQAOAA8AEAAhAFIB'
..'EQDTASYAVAE7AFUBawBsABMA1AFuAG8AFQBXARcAEABYAVkBDADOAAsADQAOAA8AEAAhAFIBEQDVASYAVAE7AFUBawBbARMA1gFuAF0BFQBeARcAEAAMAM4ADAANAA4ADwAQACEAUgERANcBJgBUATsAVQFrAGwAEwDYAW4AbwAVAFcBFwAQAFgBWQEMAM4ADAANAA4A'
..'DwAQACEAYQERANkBJgBjATsAZAFrAGwAEwDaAW4AbwAVAGYBFwAQAFgBWQFnAdIAAgAmAGMBaAEQAAwAzgALAA0ADgAPABAAIQBhAREA2wEmAGMBOwBkAWsAWwETANwBbgBdARUAawEXABAAZwHUAAIAJgBjAWgBEAAMAM4ADAANAA4ADwAQACEAYQERANMBJgBjATsA'
..'ZAFrAGwAEwDUAW4AbwAVAGYBFwAQAFgBWQFnAdYAAgAmAGMBaAEQAAwAzQAGAA0ADgAPABAAEQDdARMA3gEVAG4BFwAQAAwAzQAGAA0ADgAPABAAEQDfARMA4AEVAHEBFwAQAAwAzQAGAA0ADgAPABAAEQDhARMA4gEVAG4BFwAQAAEAzQABAAIA4wEMANsACgANAA4A'
..'DwAQACEAUgERAOQBJgBUATsAVQETAOUBFQBXARcAEABYAVkBDADbAAsADQAOAA8AEAAhAFIBEQDmASYAVAE7AFUBawB4ARMA5wFuAHgBFQBeARcAEAAMANsACgANAA4ADwAQACEAUgERAOgBJgBUATsAVQETAOkBFQBXARcAEABYAVkBDADbAAoADQAOAA8AEAAhAGEB'
..'EQDqASYAYwE7AGQBEwDrARUAZgEXABAAWAFZAWcB3wACACYAYwFoARAADADbAAsADQAOAA8AEAAhAGEBEQDsASYAYwE7AGQBawB4ARMA7QFuAHgBFQBrARcAEABnAeEAAgAmAGMBaAEQAAwA2wAKAA0ADgAPABAAIQBhAREA5AEmAGMBOwBkARMA5QEVAGYBFwAQAFgB'
..'WQFnAeMAAgAmAGMBaAEQAAEAZQABAAIA7gEBAOUAAQACAO8BDADmAAwADQAOAA8AEAAhAFIBEQDwASYAVAE7AFUBawBsABMA8QFuAG8AFQBXARcAEABYAVkBDADmAAsADQAOAA8AEAAhAFIBEQDyASYAVAE7AFUBawBbARMA8wFuAF0BFQBeARcAEAAMAOYADAANAA4A'
..'DwAQACEAUgERAPQBJgBUATsAVQFrAGwAEwD1AW4AbwAVAFcBFwAQAFgBWQEMAOYADAANAA4ADwAQACEAYQERAPYBJgBjATsAZAFrAGwAEwD3AW4AbwAVAGYBFwAQAFgBWQFnAeoAAgAmAGMBaAEQAAwA5gALAA0ADgAPABAAIQBhAREA+AEmAGMBOwBkAWsAWwETAPkB'
..'bgBdARUAawEXABAAZwHsAAIAJgBjAWgBEAAMAOYADAANAA4ADwAQACEAYQERAPABJgBjATsAZAFrAGwAEwDxAW4AbwAVAGYBFwAQAFgBWQFnAe4AAgAmAGMBaAEQAAwA5QAGAA0ADgAPABAAEQD6ARMA+wEVAG4BFwAQAAwA5QAGAA0ADgAPABAAEQD8ARMA/QEVAHEB'
..'FwAQAAwA5QAGAA0ADgAPABAAEQD+ARMA/wEVAG4BFwAQAAEA5QABAAIAAAIMAPMACgANAA4ADwAQACEAUgERAAECJgBUATsAVQETAAICFQBXARcAEABYAVkBDADzAAsADQAOAA8AEAAhAFIBEQADAiYAVAE7AFUBawB4ARMABAJuAHgBFQBeARcAEAAMAPMACgANAA4A'
..'DwAQACEAUgERAAUCJgBUATsAVQETAAYCFQBXARcAEABYAVkBDADzAAoADQAOAA8AEAAhAGEBEQAHAiYAYwE7AGQBEwAIAhUAZgEXABAAWAFZAWcB9wACACYAYwFoARAADADzAAsADQAOAA8AEAAhAGEBEQAJAiYAYwE7AGQBawB4ARMACgJuAHgBFQBrARcAEABnAfkA'
..'AgAmAGMBaAEQAAwA8wAKAA0ADgAPABAAIQBhAREAAQImAGMBOwBkARMAAgIVAGYBFwAQAFgBWQFnAfsAAgAmAGMBaAEQAAEAZQABAAIACwIBAP0AAQACAAwCDAD+AAwADQAOAA8AEAAhAFIBEQANAiYAVAE7AFUBawBsABMADgJuAG8AFQBXARcAEABYAVkBDAD+AAsA'
..'DQAOAA8AEAAhAFIBEQAPAiYAVAE7AFUBawBbARMAEAJuAF0BFQBeARcAEAAMAP4ADAANAA4ADwAQACEAUgERABECJgBUATsAVQFrAGwAEwASAm4AbwAVAFcBFwAQAFgBWQEMAP4ADAANAA4ADwAQACEAYQERABMCJgBjATsAZAFrAGwAEwAUAm4AbwAVAGYBFwAQAFgB'
..'WQFnAQIBAgAmAGMBaAEQAAwA/gALAA0ADgAPABAAIQBhAREAFQImAGMBOwBkAWsAWwETABYCbgBdARUAawEXABAAZwEEAQIAJgBjAWgBEAAMAP4ADAANAA4ADwAQACEAYQERAA0CJgBjATsAZAFrAGwAEwAOAm4AbwAVAGYBFwAQAFgBWQFnAQYBAgAmAGMBaAEQAAwA'
..'/QAGAA0ADgAPABAAEQAXAhMAGAIVAG4BFwAQAAwA/QAGAA0ADgAPABAAEQAZAhMAGgIVAHEBFwAQAAwA/QAGAA0ADgAPABAAEQAbAhMAHAIVAG4BFwAQAAEA/QABAAIAHQIMAAsBCgANAA4ADwAQACEAUgERAB4CJgBUATsAVQETAB8CFQBXARcAEABYAVkBDAALAQsA'
..'DQAOAA8AEAAhAFIBEQAgAiYAVAE7AFUBawB4ARMAIQJuAHgBFQBeARcAEAAMAAsBCgANAA4ADwAQACEAUgERACICJgBUATsAVQETACMCFQBXARcAEABYAVkBDAALAQoADQAOAA8AEAAhAGEBEQAkAiYAYwE7AGQBEwAlAhUAZgEXABAAWAFZAWcBDwECACYAYwFoARAA'
..'DAALAQsADQAOAA8AEAAhAGEBEQAmAiYAYwE7AGQBawB4ARMAJwJuAHgBFQBrARcAEABnAREBAgAmAGMBaAEQAAwACwEKAA0ADgAPABAAIQBhAREAHgImAGMBOwBkARMAHwIVAGYBFwAQAFgBWQFnARMBAgAmAGMBaAEQAAEAZQACAAgAKAICACkCDAAVAQoACAAqAg0A'
..'DgAPABAAIQBhAREAKwImAGMBOwAeARMALAIVAC0CFwAQAC4CBQAAAAEABQACAAgALwICADACDAAYAQoACAAvAg0ADgAPABAAIQAxAhEAMgImADMCOwA8ABMANAIVADUCFwAQAKIBGQEFAKMBKwCkAQ4AaAFZAaUBKwCoASsAqQEaAQQAqgGrAawBKwATADYCFQA3Aq4B'
..'GwEIAKoBqwGsASsAFQCtAa8BsAE4AqsBOQI6ArEBqwGzATsCDAAYAQwACAA8Ag0ADgAPABAAIQA9AhEAPgIkACUAJgA/AjsAHgETAEACFQBBAhcAEAAqACsALgIdAQAADAAYAQgADQAOAA8AEAAhACIAEQBCAiYAJwATAEMCFQBEAhcAEAAMABgBCAANAA4ADwAQACEA'
..'IgARAEUCJgAnABMARgIVAEcCFwAQAAwAGAEIAA0ADgAPABAAIQAiABEASAImACcAEwBJAhUASgIXABAADAAYAQkACABLAg0ADgAPABAAIQAiABEATAImACcAEwBNAhUATgIXABAATwIiAQEAUAJRAlICGAEBAAgAUwIuAgQAAQAIAFQCAQAEAAIACABVAgIAVgIMACYB'
..'CgAIAC8CDQAOAA8AEAAhADECEQBXAiYAMwI7ADwAEwBYAhUANQIXABAAogEnAQUAowErAKQBDgBoAVkBpQErAKgBKwCpASgBBACqAasBrAErABMANgIVADcCrgEpAQgAqgGrAawBKwAVAK0BrwGwATgCqwE5AjoCsQGrAbMBOwIMACYBDAAIADwCDQAOAA8AEAAhAD0C'
..'EQBZAiQAJQAmAD8COwAeARMAWgIVAEECFwAQACoAKwAuAisBAABSAiwBAQAIAFMCDAAmAQgADQAOAA8AEAAhACIAEQBbAiYAJwATAFwCFQBEAhcAEAAMACYBCAANAA4ADwAQACEAIgARAF0CJgAnABMAXgIVAEcCFwAQAAwAJgEIAA0ADgAPABAAIQAiABEAXwImACcA'
..'EwBgAhUASgIXABAADAAmAQkACABLAg0ADgAPABAAIQAiABEAYQImACcAEwBiAhUATgIXABAATwIxAQEAUAJRAgcAAwABAAgAYwJkAjMBAQAIAGUCZAIzAQEACABmAgwAAQAJAA0ADgAPABAAIQBnABEAZwImAGkAOwAeARMAaAIVAGkCFwAQAAwAAQAKAA0ADgAPABAA'
..'IQBnABEAagIkACUAJgBpADsAHgETAGsCFQBsAhcAEABtAjcBAgBuAm8CcAIlAC4CNwEAAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
