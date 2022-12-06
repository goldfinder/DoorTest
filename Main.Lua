-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 29532 characters

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
	if 9 == c then
		g = Instance.new("Folder")
		g.Parent=game.ReplicatedStorage
		id = 0
		while game.ReplicatedStorage:FindFirstChild("Assets"..id) ~= nil do
			id+=1
		end
		script.Parent.Parent.AssetId.Value=id
		g.Name = "Assets"..id
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
corridortype.Straight.roomdiagonalposition=0
corridortype.Up={}
corridortype.Up.Length=28.93
corridortype.Up.Instance="Up"
corridortype.Up.up=11.192
corridortype.Up.uproomheight=0
corridortype.Up.roomdiagonalincrease=0
corridortype.Up.roomdiagonalposition=0
corridortype.Down={}
corridortype.Down.Length=28.93
corridortype.Down.Instance="Down"
corridortype.Down.up=-11.192
corridortype.Down.uproomheight=0
corridortype.Down.roomdiagonalincrease=0
corridortype.Down.roomdiagonalposition=0
corridortype.StraightAlt1={}
corridortype.StraightAlt1.Instance="Straight-1"
corridortype.StraightAlt1.Length=29.21
corridortype.StraightAlt1.up=0
corridortype.StraightAlt1.uproomheight=1.889
corridortype.StraightAlt1.roomdiagonalincrease=0
corridortype.StraightAlt1.roomdiagonalposition=0
corridortype.Diag1={}
corridortype.Diag1.Instance="Diagonal-1"
corridortype.Diag1.Length=29.21
corridortype.Diag1.up=0
corridortype.Diag1.uproomheight=1.889
corridortype.Diag1.roomdiagonalincrease=46.04800
corridortype.Diag1.roomdiagonalposition=0
corridortype.Diag2={}
corridortype.Diag2.Instance="Diagonal-2"
corridortype.Diag2.Length=29.21
corridortype.Diag2.up=0
corridortype.Diag2.uproomheight=1.889
corridortype.Diag2.roomdiagonalincrease=-46.04800
corridortype.Diag2.roomdiagonalposition=0
corridortype.Library={}
corridortype.Library.Instance="LIB"
corridortype.Library.Length=175.5
corridortype.Library.up=5.785
corridortype.Library.uproomheight=4.753
corridortype.Library.roomdiagonalincrease=0
corridortype.Library.roomdiagonalposition=0
corridortype.Interactive={}
corridortype.Interactive.Instance="INT"
corridortype.Interactive.Length=65.52
corridortype.Interactive.up=0
corridortype.Interactive.uproomheight=2.869
corridortype.Interactive.roomdiagonalincrease=0
corridortype.Interactive.roomdiagonalposition=11.282

script.Parent.Parent.Events.LoadNextRoom.Event:Connect(function(doorid)
	print("Event Called")
	if doorid ~= door then print "Unable to use doorID" return end
	if doormodel == nil then
		doormodel = script.Parent:FindFirstChildOfClass("Model")
		if doormodel ~= nil then
			print("Door Model Created")
		end
	end
	local r = math.random(1,5)
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
		elseif r == 5 then
			corr = corridortype.Interactive
		end
	end
	if door == 1000 and door ~= "No more doors :(" then
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets"..script.Parent.AssetId.Value)["Door"]:Clone()
		if lastdoor ~= nil then
			lastdoor.DoorHitDetection:Destroy()
		end
		currdoor.DID.Value=door+1
		local cinst = game.ReplicatedStorage:FindFirstChild("Assets"..script.Parent.AssetId.Value)[corr.Instance]
		cinst = cinst:Clone()
		if cinst.Name=="LIB" then
			cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
		end
		if cinst.Name == "INT" then
			cinst.INTERACT.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChildOfClass("Humanoid") == nil then return end
				print("Clicked")
				spawn(function()
					for i = 3,(cinst.MDOOR.Size.z / 0.15)  do
						cinst.MDOOR.CFrame = cinst.MDOOR.CFrame + (cinst.MDOOR.CFrame.lookVector * 0.15)
						wait()
					end
				end)
				cinst.Button.Color = Color3.new(0,1,0)
				cinst.INTERACT:Destroy()
			end)
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
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets"..script.Parent.AssetId.Value)["Door"]:Clone()
		if lastdoor ~= nil then
			lastdoor.DoorHitDetection:Destroy()
		end
		currdoor.DID.Value=door+1
		local cinst = game.ReplicatedStorage:FindFirstChild("Assets"..script.Parent.AssetId.Value)[corr.Instance]
		cinst = cinst:Clone()
		if cinst.Name=="LIB" then
			cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
		end
		if cinst.Name == "INT" then
			cinst.INTERACT.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChildOfClass("Humanoid") == nil then return end
				print("Clicked")
				spawn(function()
					for i = 3,(cinst.MDOOR.Size.z / 0.15)  do
						cinst.MDOOR.CFrame = cinst.MDOOR.CFrame + (cinst.MDOOR.CFrame.lookVector * 0.15)
						wait()
					end
				end)
				cinst.Button.Color = Color3.new(0,1,0)
				cinst.INTERACT:Destroy()
			end)
		end
		local c = true
		door = door+1
		cinst.Parent=script
		cinst:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new(-(corr.roomdiagonalincrease/2)+corr.roomdiagonalposition,(corr.up/2)+corr.uproomheight,-(corr.Length/2))))
		debounce=true
		wait(.06)
		lastdoor.SP.Sound:Play()
		currdoor:PivotTo(CFrame.new(lastdoor.Door.Position+Vector3.new((-(corr.roomdiagonalincrease)),corr.up,-corr.Length)))
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


local Objects = Decode('AFCGAyEFTW9kZWwhCldvcmxkUGl2b3QEMAMxAzIDBDMDMQMyAwQ0AzEDMgMENQMxAzIDIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQENgMxAzIDIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUADEDMgMhCFBv'
..'c2l0aW9uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQAxAzIDCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHAAxAzIDCsXOr0OPM/VC98CLxAQeADEDMgMKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNr'
..'Q29sb3IH6gMEKAAxAzIDIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AMQMyAwoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyADEDMgMKAAAAAAAA'
..'AACPwuNAIQJVcAQ3AzEDMgMENgAxAzIDCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQA4AzIDBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAADgDMgMKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDADgDMgMK'
..'lWaQQw6v/UJhXo3EBEUAOAMyAwqVZpBDDq//QseEjcQERwAxAzIDCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgAxAzIDCm2gjkM2LwBDOruMxARMADEDMgMKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPADEDMgMK1WCQQ0ovAENkv4zEBFEAMQMyAwoAOjS9'
..'AACsQKRwZ8EEUwAxAzIDCgAAVTw3ibXAMLJjQQRVADgDMgMKlWaQQw6v90Iu64zEBFcAOAMyAwqVZpBDDq/5QpQRjcQEWQA4AzIDCpVmkEMOr/FC+neMxARbADgDMgMKlWaQQw+v80JhnozEBF0AOAMyAwqVZpBDDq/1QsfEjMQEXwAxAzIDCi9lkEOzPexCOruMxArG'
..'QeZAQLbiPoid6EEEYgA5AzIDCpVmkEMOr+1CLiuMxARkADgDMgMKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBDoDOwMyAwdrAARtADwDPQMGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAA'
..'AAAANEMKPibWQUC24j6InehBBHIAPAM9Awr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBHUAPAM9AwoLXqZDHSn5QvW5jsQEdwA8Az0DCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegA8Az0DCr+un0NU/AJD9bmOxAR8ADwDPQMKf/ejQx0p+ULDhpDECvy/HUEY'
..'mVJBEqmNPgR/ADwDPQMKMXObQx0p+ULDhpDEBIEAPAM9AwrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BIQAPAM9Awoxc5tDHSn5QhvrjMQEhgA8Az0DCteBnUOGJgFDG+uMxASIADwDPQMKf/ejQx0p+UIb64zEBIoAPAM9AwoFtp9D+yj5QvW5jsQEjQA+AzIDCgAA'
..'AACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkAAxAzIDCgDAVDzByvG/FK5pwSEERG93bgQ/AzEDMgMElAA8Az0DCjPBikN+XwpDb7aMxASWADwDPQMKM7qKQ/cUAUMfYYvEBJgAPAM9AwozuopD7in8Qtk9jMQEmgA8Az0DCjO6ikPuKf5CcheMxAScADwDPQMKM7qK'
..'Q/cUAEMM8YvEBJ4APAM9Awpp/ohDpmwAQ5m6jMQEoAA8Az0DClmAjEOmbABDmbqMxASiADwDPQMKM8GKQ13sBEO+ho7EBKQAPAM9Awrzv4pDumwAQ2+2jMQEpgA8Az0DCjO6ikPuKfhCpYqMxASoADwDPQMKM7qKQ+4p+kI/ZIzEBKoAPAM9AwozuopD7inyQtn9jMQE'
..'rAA8Az0DCjO6ikPvKfRCcteMxASuADwDPQMKM7qKQ+4p9kIMsYzEBLAAPAM9AwqZu4pDk7jsQpm6jMQEsgA8Az0DCjO6ikPuKe5CpUqNxAS0ADwDPQMKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBEADMQMyAwS4ADwDPQMKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3o'
..'QQS7ADwDPQMKIqI/Q1Fc+ULgG5HEBL0APAM9AwpVEIRDUVz5QuAbkcQEvwA8Az0DChLCekMXpOxCwU2PxATBADwDPQMKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEADwDPQMKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHADwDPQMK0o1EQ1Fc+UKv6JLEBMkA'
..'PAM9Awoeq0hDIEABQ6/oksQEywA8Az0DChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgA8Az0DCkJodkMgQAFDBk2PxATQADwDPQMKyamBQ1Fc+UIGTY/EBNIAPAM9AwpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEQQMxAzIDBNYAPAM9AwoycWRD9qvsQtY0jMQE'
..'2AA8Az0DCro/QEMwZPlC1jSMxATaADwDPQMKH1+EQzBk+ULWNIzEBNwAPAM9AwqqX3tD9qvsQrdmisQE3gA8Az0DCs5mZEPcGQND1jSMxATgADwDPQMK4olkQ9Jv+ULQM4zEBEIDQwMyAwTjADwDPQMKfwyCQ2Bk+UKjAY7EBOUAPAM9AwqKMFxDYGT5QqMBjsQE5wA8'
..'Az0DCq4td0MoRAFDowGOxAREA0MDMgME6gA8Az0DChLubENsavlC/WWKxATsADwDPQMKyiBJQy1HAUP9ZYrEBO4APAM9Awp6A0VDbGr5Qv1lisQhA0xJQgRFA0YDMgME8gBHA0gDCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYASQMyAwp5'
..'k6RDfj8DQ17PfMQE+AAxAzIDCgAAAAAGgeW/4vqvQgT6ADEDMgMKAAAAAPp+8sBf5a/CBPwARwNIAwq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BP8ARwNIAwp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBRwNIAwp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+'
..'BAUBPAM9AwrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBRwNIAwrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBRwNIAwp3k4dDfj8DQyLLfMQEDQFHA0gDCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAFHA0gDCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDv'
..'fz8EEwFHA0gDCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgFHA0gDCk03mkPnUPZCnm9wxAQYAUcDSAMKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEHwFHA0gDBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HA'
..'d5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBRwNIAwq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQND'
..'oO9vxAQuAUcDSAMKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAUcDSAMKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AUcDSAMKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3AUcDSAMKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AUcDSAMKtZ2LQ+dQ'
..'9kKi72/ECmZmdkEAAABBwO9/PwQ9AUcDSAMKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQAAwEBwURBCCsXLi0PoUPRCFE1rxARGAUcDSAMKQ4CkQ5JtC0PayWbE'
..'CpmZEUFwPTJBAOjWPgRJAUcDSAMKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAUcDSAMKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAUcDSAMK5xCVQ34/A0PayWbEBEoDMQMyAwRqAUYDMgMHxwAEVgE8Az0DBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QK'
..'ANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAUsDTAMKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABPAM9Awp+SqpDKITwQos2h8QHagAEZQE8Az0DBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAA'
..'gD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagFLA0wDCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQExAzIDCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAExAzIDCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEcwExAzIDCsdLnkM9ngNDizaHxAR/ATED'
..'MgMEdgExAzIDCg/NnkPWy/5CizaHxAR5AU0DTgMKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7ATEDMgMKD82eQyiE8EKLNofEBH0BMQMyAwoPzZ5DZY7wQos2h8QEfwFNA04DCg7NnkP/p/dCizaHxCEEQXJjaARPAzEDMgMEjAFGAzIDBIQBPAM9Awp+SqpD1sv+'
..'Qou2hMQEhgFLA0wDCn5KqkP/p/dCi7aExASIATwDPQMKfkqqQyiE8EKLtoTEBIoBPAM9Awp+SqpDZY7wQou2hMQEjAFLA0wDCn9KqkP/p/dCi7aExASOATEDMgMKx8uqQz2eA0OLtoTEBJABMQMyAwrHi6RDeqgGQ4u2hMQEkgExAzIDCsdLnkM9ngNDi7aExASdATED'
..'MgMElQExAzIDCg/NnkPWy/5Ci7aExASXAU0DTgMKD82eQ/+n90KLtoTEBJkBMQMyAwoPzZ5DKITwQou2hMQEmwExAzIDCg/NnkNljvBCi7aExASdAU0DTgMKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABMQMyAwrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABAIQpTdXJm'
..'YWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/'
..'AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQRQAzEDMgMEvwFGAzIDBLcBPAM9Awp+SqpD1sv+Qos2gsQEuQFLA0wDCn5KqkP/p/dCizaCxAS7ATwDPQMKfkqqQyiE8EKLNoLEBL0BPAM9Awp+SqpDZY7wQos2'
..'gsQEvwFLA0wDCn9KqkP/p/dCizaCxATBATEDMgMKx8uqQz2eA0OLNoLEBMMBMQMyAwrHi6RDeqgGQ4s2gsQExQExAzIDCsdLnkM9ngNDizaCxATQATEDMgMEyAExAzIDCg/NnkPWy/5CizaCxATKAU0DTgMKD82eQ/+n90KLNoLEBMwBMQMyAwoPzZ5DKITwQos2gsQE'
..'zgExAzIDCg/NnkNljvBCizaCxATQAU0DTgMKDs2eQ/+n90KLNoLEBFEDMQMyAwTcAUYDMgME1AE8Az0DCn5KqkPWy/5CFm1/xATWAUsDTAMKfkqqQ/+n90IWbX/EBNgBPAM9Awp+SqpDKITwQhZtf8QE2gE8Az0DCn5KqkNljvBCFm1/xATcAUsDTAMKf0qqQ/+n90IW'
..'bX/EBN4BMQMyAwrHy6pDPZ4DQxZtf8QE4AExAzIDCseLpEN6qAZDFm1/xATiATEDMgMKx0ueQz2eA0MWbX/EBO0BMQMyAwTlATEDMgMKD82eQ9bL/kIWbX/EBOcBTQNOAwoPzZ5D/6f3QhZtf8QE6QExAzIDCg/NnkMohPBCFm1/xATrATEDMgMKD82eQ2WO8EIWbX/E'
..'BO0BTQNOAwoOzZ5D/6f3QhZtf8QEUgMxAzIDBPkBRgMyAwTxATwDPQMKfkqqQ9bL/kIWbXrEBPMBSwNMAwp+SqpD/6f3QhZtesQE9QE8Az0DCn5KqkMohPBCFm16xAT3ATwDPQMKfkqqQ2WO8EIWbXrEBPkBSwNMAwp/SqpD/6f3QhZtesQE+wExAzIDCsfLqkM9ngND'
..'Fm16xAT9ATEDMgMKx4ukQ3qoBkMWbXrEBP8BMQMyAwrHS55DPZ4DQxZtesQECgIxAzIDBAICMQMyAwoPzZ5D1sv+QhZtesQEBAJNA04DCg/NnkP/p/dCFm16xAQGAjEDMgMKD82eQyiE8EIWbXrEBAgCMQMyAwoPzZ5DZY7wQhZtesQECgJNA04DCg7NnkP/p/dCFm16'
..'xARTAzEDMgMEFgJGAzIDBA4CPAM9Awp+SqpD1sv+QhZtdcQEEAJLA0wDCn5KqkP/p/dCFm11xAQSAjwDPQMKfkqqQyiE8EIWbXXEBBQCPAM9Awp+SqpDZY7wQhZtdcQEFgJLA0wDCn9KqkP/p/dCFm11xAQYAjEDMgMKx8uqQz2eA0MWbXXEBBoCMQMyAwrHi6RDeqgG'
..'QxZtdcQEHAIxAzIDCsdLnkM9ngNDFm11xAQnAjEDMgMEHwIxAzIDCg/NnkPWy/5CFm11xAQhAk0DTgMKD82eQ/+n90IWbXXEBCMCMQMyAwoPzZ5DKITwQhZtdcQEJQIxAzIDCg/NnkNljvBCFm11xAQnAk0DTgMKDs2eQ/+n90IWbXXEIQZTY3JpcHQhBERvb3IEVAMx'
..'AzIDB2kBBC4CMQMyAwZWQjYKx+kUQxdY9UKUFJDECtpFx0Dt1gNBGIUjPwwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIRFQbGFjZWhvbGRlckNvbG9yMyEEVGV4dCEBMAMAAAAAAABEQCEQRG9vckhpdERldGVjdGlvbgdMAQQ6AjEDMgMGdQAACsfpFEMXWPVCtxGQ'
..'xAp2Md9AUrgKQVyPQj8EPQIxAzIDCpQ6GENkMPVCbheQxArg++M+O+cNQQCjLT8EQAIxAzIDCub9FEMH8f1CbheQxApqa91AIP3ePgCjLT8EQwIxAzIDCpaMEUMXWPVCbheQxApAIhY/a2IQQQCjLT8hAlNQBEcCMQMyAwqM2hRDTMPsQm4XkMQKxkHmQEC24j4Aoy0/'
..'IQVTb3VuZCEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzE1NzE2NzIwMyELTnVtYmVyVmFsdWUhA0RJRCEDSU5UBFUDQwMyAwRRAjEDMgMKrUHNQ8gZAkOmeJHECiNa5kBvgMJAENbePgRUAjEDMgMKnbjCQ+Jr9UJI6YnECgOrq0HwXg5BwF7KPgRXAjEDMgMKnbjCQ+Jr'
..'9UIp5I3EBFkCMQMyAwqUc71D4mv1QoXri8QKH8vBPvBeDkFme/9BBFwCMQMyAwpCG8hDdiECQ7gujcQKHxOjPjxNv0AAKhJBBF8CMQMyAwpkoNBDUSn7QqZ4kcQKajvhQA/kcUEH2t4+BGICMQMyAwpayclDUSn7QqZ4kcQEZAIxAzIDCq1BzUN2IQJDhkuJxAojWuZA'
..'9GvEQB9sXD4EZwIxAzIDCjKt0EOuOPtChkuJxAqdbtRA0dlyQR9sXD4EagIxAzIDCqLKyUNxLvtChkuJxApB3+FA+jVyQR9sXD4EbQIxAzIDCp5Bw0NhQuxC9+2LxArMH8RBQLbiPu8wBEIEcAIxAzIDCkIbyENm1/pCxY2PxArNEqM+VsVsQQzs+EEEcwIxAzIDCvqe'
..'x0OmG/tC7GGNxAR1AjEDMgMKQjLNQ2FC7ELYYI3ECqTDpEFAtuI+8KeDQgR4AjEDMgMKxU7SQ1Ep+0L2YI3ECgBG1j4P5HFBShyDQgR7AjEDMgMKGR/IQzMk+0J7BIvECh/LwT4jknFBuTPeQQR+AjEDMgMKBCjNQzrwBEMpZI3ECqTDpEFAtuI+ShyDQgSCAjEDMgMD'
..'AAAAAACAmEAKQ2HQQy1x+0IAgIrECszM7EAK12tBCtejPQMAAAAAAADQPwSGAjEDMgMKwpXOQy1x+0IAgIrECrAehT4K12tBpHC9PwSJAjEDMgMKvlXNQyY7AUMAgIrECuF6pEA9CvdACtejPSEFTURPT1IHZwAEkQJWA1cDBsrItgMAAAAAAACRQAoAALRCAAC0QgAA'
..'AAAKz1PNQ1eo80LIforECgAAtEIAAAAAAAC0wgrdx8U+lKCQQKwB2UAhBFdlbGQhAkMwBFgDRgNZAyECQzEEWgNbA1wDIQVQYXJ0MQRdA0YDMgMEXgNfA2ADIQxBY2Nlc3NEZW5pZWQhElJvbGxPZmZNYXhEaXN0YW5jZSEWcmJ4YXNzZXRpZDovLzIwMDg4ODUxMCEN'
..'QWNjZXNzR3JhbnRlZCEWcmJ4YXNzZXRpZDovLzIwMDg4ODQ2OCEJRG9vckNsb3NlIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQhEb29yT3BlbiENUGxheWJhY2tTcGVlZAMAAABgZmbyPwSpAjEDMgMKTljNQ9y4+kIAgIrECj0Kp0Dg'
..'UTg+pHC9PwSsAjEDMgMKFA7MQyMa+0IAgIrECrAehT5mZmZBpHC9PwSvAjEDMgMKlRnKQy1x+0IAgIrECj0K90AK12tBCtejPQSzAjIDWQMKAAAAAAAAtEIAALRCCp8YxkODnfRC//qKxAqjhZI/SUocPjaYuT8EtgIxAzIDCpk5xkPcOPNCCneLxAquR/FA16PQQDMz'
..'80AhBkJ1dHRvbgfsAwS8AjIDWQMG/wAACp8YxkODnfRCHfaKxCELUmVmbGVjdGFuY2UDAAAAAAAA4D8KkdMvP0lKHD6khZI/BMECMQMyAwpSeMJDlFf+Qmfui8QK4Xq0QQrXoz0ehQVCBMUCYQMyAwoAAAAAAAC0QgAAAAAK4A7IQ+/I7EKDLo3EBMcCYQMyAwrgDshD'
..'Bjb1QoSajcQEyQJhAzIDCuAOyEOp9v1C7jKNxATLAmEDMgMK4A7IQ7ld9ULExIzEBGIDYwNkAyELQmFja1N1cmZhY2UDAAAAAAAAJEAE0wJlA2YDIQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlCgAAAAAAAAAAAAC0wgrcUs1DKIr6QnB+isQhDFJpZ2h0U3VyZmFj'
..'ZQp9PzU+46WPQAAAgD8E2AJjA2QDCgAAAAAAADTDAAAAAAr8T81Dw8HsQpN+isQKx0uXQH0/NT4AAIA/BGcDRgNZAwRoA2kDagME3QJrA2wDCl0lzENeffNCmX6KxAoZBJY+th7dQAAAgD8EbQNhAzIDBG4DbwNwAyEFUGFydDAEcQMxAzIDBHIDcwN0AwR1A3YDdwME'
..'5gJrA2wDCvV+zkNBePNCmn6KxAoZBJY+3XrcQAAAgD8EeANvA3ADBHkDdgN3AyEJV2VkZ2VQYXJ0BO0CegN7AwqamQ9CAAC0QgAAtMIKb3rOQ09g+kKGjorECgAAtEJmZlhCAAA0wwrNzEw+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8h'
..'CE1lc2hUeXBlBPYCfAN9AwqamQ/C9qixwrieskIKbnrOQ1dg+kKaborECo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4zj0AAIA/BPwCfgN/AwoAAAAAAAAAAJoZEEMKb3rOQ1Jg+kKGforECt3Rmz7NzEw+xrV+PwQAA4ADgQMKSOH8QQAAtMIfBbRCCs0p'
..'zENKY/pChI6KxArh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwQGA4IDgwMKCtcjPHH9M0NSOPPCCswpzENUY/pChG6KxApx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/lMbSPQQMA4QDhQMKAAAAAAAAAADXYxTDCs0pzENPY/pC'
..'hH6KxApzypo+zcxMPhirfj8hCElOVEVSQUNUBBADMgNZAwqfGMZDbO/xQh32isQKDJSvQM8cfj+eD1ZAIQVNYWlucyEFU0Rvb3IEhgMxAzIDBBYDMQMyAwqau2dCF1j1QpQUkMQEGAMxAzIDCpq7Z0IXWPVCtxGQxAQaAzEDMgMKzv50QmQw9UJuF5DEBBwDMQMyAwoU'
..'DGhCB/H9Qm4XkMQEHgMxAzIDCtZGWkIXWPVCbheQxAQgAzEDMgMKrn5nQkzD7EJuF5DEIQdBc3NldElkIQZFdmVudHMhDUJpbmRhYmxlRXZlbnQhDExvYWROZXh0Um9vbSEJQXNzZXRQYXRoBCcDMQMyAwoQm2ZCJYXsQpmai8QKMDOxQo/C9T0pXI9CBCoDMQMyAwoA'
..'AAAArkeRQAAAAAAKAACAPwAAgD8AAIA/IQ9Qcm94aW1pdHlQcm9tcHQhCk9iamVjdFRleHQhPUdvbGQzbkYxcjMncyBEb29ycyBFbmdpbmUuCgpJbnRlcmFjdCB3aXRoIG1lIHRvIHBsYXkgImRvb3JzIi4hE1JlcXVpcmVzTGluZU9mU2lnaHQKP/W/Q7wJlUIfzRLE'
..'CgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKAopmQrosDkMndYfECq5+Z0I7WfVCjhSHxAq6G4ZC8F71QpaBicQKAwWuQ4kW9UKmvYvECtNgkEMsLwBDZL+MxAr9/38/AAAAAAAAAAAK//9/PwAAAAAAAAAACgW2n0MdKflC9bmOxAoAAIC/AAAAAC69u7MKAACAvy69'
..'u7PtrQkoCi69u7MAAIA/Lr27swoAAIA/AAAAAC69O7QK9b+KQ5xsAENvtozECkrsY0P4Z/lC2hqRxAriiWRD1m/5QtAzjMQK0qJkQ2Bk+UKjAY7ECgAAgL8AAAAALr27MwriemRDbWr5Qv1lisQKd5OkQ34/A0Nez3zECgAAgL8AAAAAAAAAAAoAAIC/Lr27M+2tCSgK'
..'Lr27MwAAgD8uvbszCgAAgD8AAAAALr27swrHi6RDPZ4DQ4s2h8QKLr07swAAgD8uvbuzCgAAgD8uvTsz7a2JpwouvTuzAACAPwAAAAAKAACAvy69O7MAAAAACseLpEM9ngNDi7aExArHi6RDPZ4DQ4s2gsQKx4ukQz2eA0MWbX/ECseLpEM9ngNDFm16xArHi6RDPZ4D'
..'QxZtdcQKjNoUQzxZ9ULrE5DECgSfx0OpG/tC7GGNxAouvTuzAAAAAAAAgL8KAACAPy69O7MuvTuzCqdNF8B0rbU9NF7FPgoAAAAAAAAAAAAAgD8KADzDvuhoWMBgZBXACnx4TLlHGbA3AACAvwr+/3+/8OkPOpN7TDkKcGLGPupAYsAAKxa+CgB+yT6byWPAwNYNQAoA'
..'AIC/YAAALgAAgK0KYAAALgAAgD+Y/wksCgAAAAAAAAAAAACAvworRc1DBKbzQnV7isQKAACAv0ALEa3+/2+vCkALES0AAIA//v9vrgp305I1AACAv7YXmTgKAACAP0mGkjX8BgK4CgAAgMMAACBBAACAQwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/CgAAgL9sM6+3'
..'sIhMuQoAAIC/TO96L/7/b68KjKOILwAAgD/8H9gxCn0/tT3jpQ/AAAAAPwoAUOO9PvBbQABVAb8KxAYCOHcambgLAIA/CgAAgL9wg5I12AYCOAoA8ae+VpZZwFDEDkAKAEwHvgDyUsAAp6w+Cnp4TDmc6g86CgCAvwrDGLC38v9/P1fqDzoKsmP7wpzmTsDI98zDCpmF'
..'TDks8g86/v9/vwoAAIC/6DKvt6+ITLkK8NiSQBGUXECAUwG/ClD98cLLQk7AyPfMwwoHIRa/nFtPv9tRYbgK+wkQOJrjLTj8/3+/CgchFj+cW08/S7FhOAqf+Vq81qAfPAb3f78K4VtPv6kgFj+dd4G3CqkgFr/gW0+/RNelOAodMAa/SwNaP20hPrkKK4MQOKgFSbn8'
..'/3+/ChswBj9KA1q/xCg8OQpLA1q/HDAGv8xN+LgKXwNav/0vBr+924w4Cv4vBj9eA1q//KY6OAqufmdCPFn1QusTkMR3AQEAAAABAAIAAwABAAEAAQACAAQAAQACAAEAAgAFAAEAAwABAAIABgAHAAQAAQAIAAkAAQAFAAIACAAKAAIACwAMAAYABgANAA4ADwAQABEA'
..'EgATABQAFQAWABcAEAAMAAYABgANAA4ADwAQABEAGAATABkAFQAaABcAEAAMAAYABgANAA4ADwAQABEAGwATABwAFQAaABcAEAAMAAYABgANAA4ADwAQABEAHQATAB4AFQAfABcAEAAMAAYACwAIACAADQAOAA8AEAAhACIAEQAjACQAJQAmACcAEwAoABUAKQAXABAA'
..'KgArACwACwADAAgALQARAC4AEwAvACwACwADAAgAMAARADEAEwAyAAEABQACAAgAMwACADQADAAOAAYADQAOAA8AEAARADUAEwA2ABUANwAXABAADAAOAAkADQAOAA8AEAAhADgAEQA5ACYAOgA7ADwAEwA9ABUAPgAXABAADAAOAAkADQAOAA8AEAAhADgAEQA/ACYA'
..'OgA7ADwAEwBAABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBCACYAOgA7ADwAEwBDABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBEACYAOgA7ADwAEwBFABUAQQAXABAADAAOAAYADQAOAA8AEAARAEYAEwBHABUASAAXABAADAAOAAYADQAOAA8AEAARAEkA'
..'EwBKABUASAAXABAADAAOAAYADQAOAA8AEAARAEsAEwBMABUATQAXABAADAAOAAsACAAgAA0ADgAPABAAIQAiABEATgAkACUAJgAnABMATwAVACkAFwAQACoAKwAsABcAAwAIAC0AEQBQABMAUQAsABcAAwAIADAAEQBSABMAUwAMAA4ACQANAA4ADwAQACEAOAARAFQA'
..'JgA6ADsAPAATAFUAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFYAJgA6ADsAPAATAFcAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFgAJgA6ADsAPAATAFkAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAFoAJgA6ADsAPAATAFsAFQBBABcAEAAMAA4A'
..'CQANAA4ADwAQACEAOAARAFwAJgA6ADsAPAATAF0AFQBBABcAEAAMAA4ABgANAA4ADwAQABEAXgATAF8AFQBgABcAEAAMAA4ACQANAA4ADwAQACEAOAARAGEAJgA6ADsAPAATAGIAFQBBABcAEAAMAA4ACQANAA4ADwAQACEAOAARAGMAJgA6ADsAPAATAGQAFQBBABcA'
..'EAABAAUAAgAIAGUAAgBmAAwAIgALAA0ADgAPABAAIQBnABEAaAAmAGkAOwBqAGsAbAATAG0AbgBvABUAcAAXABAADAAiAAgADQAOAA8AEAARAHEAawBsABMAcgBuAG8AFQBzABcAEAAMACIACAANAA4ADwAQABEAdABrAGwAEwB1AG4AbwAVAHMAFwAQAAwAIgAIAA0A'
..'DgAPABAAEQB2AGsAbAATAHcAbgBvABUAeAAXABAADAAiAAgADQAOAA8AEAARAHkAawBsABMAegBuAG8AFQBwABcAEAAMACIACAANAA4ADwAQABEAewBrAGwAEwB8AG4AbwAVAH0AFwAQAAwAIgAIAA0ADgAPABAAEQB+AGsAbAATAH8AbgBvABUAfQAXABAADAAiAAgA'
..'DQAOAA8AEAARAIAAawBsABMAgQBuAG8AFQCCABcAEAAMACIACAANAA4ADwAQABEAgwBrAGwAEwCEAG4AbwAVAH0AFwAQAAwAIgAIAA0ADgAPABAAEQCFAGsAbAATAIYAbgBvABUAggAXABAADAAiAAgADQAOAA8AEAARAIcAawBsABMAiABuAG8AFQB9ABcAEAAMACIA'
..'DQAIACAADQAOAA8AEAAhACIAEQCJACQAJQAmACcAawBsABMAigBuAG8AFQApABcAEAAqACsALAAuAAQACAAtABEAiwBrAIwAEwCNACwALgADAAgAjgARAI8AEwCQAAEABQACAAgAkQACAJIADAAxAAgADQAOAA8AEAARAJMAawBsABMAlABuAG8AFQA3ABcAEAAMADEA'
..'CwANAA4ADwAQACEAOAARAJUAJgA6ADsAPABrAGwAEwCWAG4AbwAVAD4AFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAlwAmADoAOwA8AGsAbAATAJgAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCZACYAOgA7ADwAawBsABMAmgBuAG8AFQBBABcAEAAMADEA'
..'CwANAA4ADwAQACEAOAARAJsAJgA6ADsAPABrAGwAEwCcAG4AbwAVAEEAFwAQAAwAMQAIAA0ADgAPABAAEQCdAGsAbAATAJ4AbgBvABUASAAXABAADAAxAAgADQAOAA8AEAARAJ8AawBsABMAoABuAG8AFQBIABcAEAAMADEACAANAA4ADwAQABEAoQBrAGwAEwCiAG4A'
..'bwAVAE0AFwAQAAwAMQANAAgAIAANAA4ADwAQACEAIgARAKMAJAAlACYAJwBrAGwAEwCkAG4AbwAVACkAFwAQACoAKwAsADoAAwAIAC0AEQBQABMAUQAsADoAAwAIADAAEQBSABMAUwAMADEACwANAA4ADwAQACEAOAARAKUAJgA6ADsAPABrAGwAEwCmAG4AbwAVAEEA'
..'FwAQAAwAMQALAA0ADgAPABAAIQA4ABEApwAmADoAOwA8AGsAbAATAKgAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCpACYAOgA7ADwAawBsABMAqgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKsAJgA6ADsAPABrAGwAEwCsAG4AbwAVAEEA'
..'FwAQAAwAMQALAA0ADgAPABAAIQA4ABEArQAmADoAOwA8AGsAbAATAK4AbgBvABUAQQAXABAADAAxAAgADQAOAA8AEAARAK8AawBsABMAsABuAG8AFQBgABcAEAAMADEACwANAA4ADwAQACEAOAARALEAJgA6ADsAPABrAGwAEwCyAG4AbwAVAEEAFwAQAAwAMQALAA0A'
..'DgAPABAAIQA4ABEAswAmADoAOwA8AGsAbAATALQAbgBvABUAQQAXABAAAQAFAAIACAC1AAIAtgAMAEUACwANAA4ADwAQACEAZwARALcAJgBpADsAagBrAGwAEwC4AG4AbwAVALkAFwAQAAwARQAIAA0ADgAPABAAEQC6AGsAbAATALsAbgBvABUAcwAXABAADABFAAgA'
..'DQAOAA8AEAARALwAawBsABMAvQBuAG8AFQBzABcAEAAMAEUACAANAA4ADwAQABEAvgBrAGwAEwC/AG4AbwAVAHgAFwAQAAwARQAIAA0ADgAPABAAEQDAAGsAbAATAMEAbgBvABUAwgAXABAADABFAAgADQAOAA8AEAARAMMAawBsABMAxABuAG8AFQDFABcAEAAMAEUA'
..'CAANAA4ADwAQABEAxgBrAGwAEwDHAG4AbwAVAH0AFwAQAAwARQAIAA0ADgAPABAAEQDIAGsAbAATAMkAbgBvABUAggAXABAADABFAAgADQAOAA8AEAARAMoAawBsABMAywBuAG8AFQDMABcAEAAMAEUACAANAA4ADwAQABEAzQBrAGwAEwDOAG4AbwAVAIIAFwAQAAwA'
..'RQAIAA0ADgAPABAAEQDPAGsAbAATANAAbgBvABUAfQAXABAADABFAA0ACAAgAA0ADgAPABAAIQAiABEA0QAkACUAJgAnAGsAbAATANIAbgBvABUAKQAXABAAKgArACwAUQAEAAgALQARAIsAawCMABMAjQAsAFEAAwAIAI4AEQCPABMAkAABAAUAAgAIANMAAgDUAAwA'
..'VAALAA0ADgAPABAAIQBnABEA1QAmAGkAOwBqAGsAbAATANYAbgBvABUAuQAXABAADABUAAgADQAOAA8AEAARANcAawBsABMA2ABuAG8AFQBzABcAEAAMAFQACAANAA4ADwAQABEA2QBrAGwAEwDaAG4AbwAVAHMAFwAQAAwAVAAIAA0ADgAPABAAEQDbAGsAbAATANwA'
..'bgBvABUAeAAXABAADABUAAgADQAOAA8AEAARAN0AawBsABMA3gBuAG8AFQDCABcAEAAMAFQADQAIACAADQAOAA8AEAAhACIAEQDfACQAJQAmACcAawBsABMA4ABuAG8AFQApABcAEAAqACsALABaAAQACAAtABEAiwBrAIwAEwCNACwAWgADAAgAjgARAI8AEwCQAAEA'
..'VAABAAIA4QAMAF0ACAANAA4ADwAQABEA4gBrAGwAEwDjAG4AbwAVAH0AFwAQAAwAXQAIAA0ADgAPABAAEQDkAGsAbAATAOUAbgBvABUAzAAXABAADABdAAgADQAOAA8AEAARAOYAawBsABMA5wBuAG8AFQCCABcAEAABAFQAAQACAOgADABhAAgADQAOAA8AEAARAOkA'
..'awBsABMA6gBuAG8AFQDFABcAEAAMAGEACAANAA4ADwAQABEA6wBrAGwAEwDsAG4AbwAVAIIAFwAQAAwAYQAIAA0ADgAPABAAEQDtAGsAbAATAO4AbgBvABUAfQAXABAAAQAFAAIACADvAAIA8AAMAGUACAANAA4ADwAQABEA8QBrAGwAEwDyAG4A8wAVAPQAFwAQAAwA'
..'ZQALAAgAIAANAA4ADwAQACEAIgARAPUAJAAlACYAJwATAPYAFQApABcAEAAqACsALABnAAMACAAtABEA9wATAPgALABnAAMACACOABEA+QATAPoADABlAAgADQAOAA8AEAARAPsAawBsABMA/ABuAPMAFQD9ABcAEAAMAGUACAANAA4ADwAQABEA/gBrAGwAEwD/AG4A'
..'8wAVAAABFwAQAAwAZQAIAA0ADgAPABAAEQABAWsAbAATAAIBbgDzABUAAwEXABAADABlAAsADQAOAA8AEAAhADgAEQAEASYAOgA7ADwAawBsABMABQFuAG8AFQAGARcAEAAMAGUACAANAA4ADwAQABEABwFrAGwAEwAIAW4A8wAVAAkBFwAQAAwAZQAIAA0ADgAPABAA'
..'EQAKAWsAbAATAAsBbgDzABUACQEXABAADABlAAsADQAOAA8AEAAhADgAEQAMASYAOgA7ADwAawBsABMADQFuAPMAFQAOARcAEAAMAGUACwANAA4ADwAQACEAOAARAA8BJgA6ADsAPABrAGwAEwAQAW4A8wAVABEBFwAQAAwAZQAIAA0ADgAPABAAEQASAWsAbAATABMB'
..'bgDzABUAFAEXABAADABlAAgADQAOAA8AEAARABUBawBsABMAFgFuAPMAFQAUARcAEAAMAGUACAANAA4ADwAQABEAFwFrAGwAEwAYAW4A8wAVABkBFwAQABoBQAIADAAiASMBbAAADAAkASUBbABlAAoADQAOACEAGwERABwBJgAdATsAHgFrAGwAEwAfAW4A8wAVACAB'
..'IQEOABoBQAIADAApASoBbAAADAArASwBbABlAAoADQAOACEAGwERACYBJgAdATsAHgFrAGwAEwAnAW4A8wAVACgBIQEOAAwAZQALAA0ADgAPABAAIQA4ABEALQEmADoAOwA8AGsAbAATAC4BbgDzABUALwEXABAADABlAAsADQAOAA8AEAAhADgAEQAwASYAOgA7ADwA'
..'awBsABMAMQFuAPMAFQAyARcAEAAMAGUACwANAA4ADwAQACEAOAARADMBJgA6ADsAPABrAGwAEwA0AW4A8wAVADUBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEANgEmADoAOwA8AGsAbAATADcBbgDzABUAOAEXABAADABlAAgADQAOAA8AEAARADkBawBsABMAOgFuAPMA'
..'FQA7ARcAEAAaAUADAAwAPwFAAWwAAAwAQQFCAWwAAAwAQwFEAWwAZQAKAA0ADgAhAGcAEQA8ASYAaQA7AGoAawBsABMAPQFuAPMAFQA+ASEBDgAMAGUACAANAA4ADwAQABEARQFrAGwAEwBGAW4A8wAVAEcBFwAQAAwAZQAIAA0ADgAPABAAEQBIAWsAbAATAEkBbgDz'
..'ABUASgEXABAADABlAAgADQAOAA8AEAARAEsBawBsABMATAFuAPMAFQBNARcAEAAMAGUACAANAA4ADwAQABEATgFrAGwAEwBPAW4A8wAVAEoBFwAQAAEAZQABAAIAUAEBAIEAAQACAFEBDACCAAwADQAOAA8AEAAhAFIBEQBTASYAVAE7AFUBawBsABMAVgFuAG8AFQBX'
..'ARcAEABYAVkBDACCAAsADQAOAA8AEAAhAFIBEQBaASYAVAE7AFUBawBbARMAXAFuAF0BFQBeARcAEAAMAIIADAANAA4ADwAQACEAUgERAF8BJgBUATsAVQFrAGwAEwBgAW4AbwAVAFcBFwAQAFgBWQEMAIIADAANAA4ADwAQACEAYQERAGIBJgBjATsAZAFrAGwAEwBl'
..'AW4AbwAVAGYBFwAQAFgBWQFnAYYAAgAmAGMBaAEQAAwAggALAA0ADgAPABAAIQBhAREAaQEmAGMBOwBkAWsAWwETAGoBbgBdARUAawEXABAAZwGIAAIAJgBjAWgBEAAMAIIADAANAA4ADwAQACEAYQERAFMBJgBjATsAZAFrAGwAEwBWAW4AbwAVAGYBFwAQAFgBWQFn'
..'AYoAAgAmAGMBaAEQAAwAgQAGAA0ADgAPABAAEQBsARMAbQEVAG4BFwAQAAwAgQAGAA0ADgAPABAAEQBvARMAcAEVAHEBFwAQAAwAgQAGAA0ADgAPABAAEQByARMAcwEVAG4BFwAQAAEAgQABAAIAdAEMAI8ACgANAA4ADwAQACEAUgERAHUBJgBUATsAVQETAHYBFQBX'
..'ARcAEABYAVkBDACPAAsADQAOAA8AEAAhAFIBEQB3ASYAVAE7AFUBawB4ARMAeQFuAHgBFQBeARcAEAAMAI8ACgANAA4ADwAQACEAUgERAHoBJgBUATsAVQETAHsBFQBXARcAEABYAVkBDACPAAoADQAOAA8AEAAhAGEBEQB8ASYAYwE7AGQBEwB9ARUAZgEXABAAWAFZ'
..'AWcBkwACACYAYwFoARAADACPAAsADQAOAA8AEAAhAGEBEQB+ASYAYwE7AGQBawB4ARMAfwFuAHgBFQBrARcAEABnAZUAAgAmAGMBaAEQAAwAjwAKAA0ADgAPABAAIQBhAREAdQEmAGMBOwBkARMAdgEVAGYBFwAQAFgBWQFnAZcAAgAmAGMBaAEQAAEAZQACAAgAgAEC'
..'AIEBAQCZAAEAAgCCAQwAmgAMAA0ADgAPABAAIQBSAREAgwEmAFQBOwBVAWsAbAATAIQBbgBvABUAVwEXABAAWAFZAQwAmgALAA0ADgAPABAAIQBSAREAhQEmAFQBOwBVAWsAWwETAIYBbgBdARUAXgEXABAADACaAAwADQAOAA8AEAAhAFIBEQCHASYAVAE7AFUBawBs'
..'ABMAiAFuAG8AFQBXARcAEABYAVkBDACaAAwADQAOAA8AEAAhAGEBEQCJASYAYwE7AGQBawBsABMAigFuAG8AFQBmARcAEABYAVkBZwGeAAIAJgBjAWgBEAAMAJoACwANAA4ADwAQACEAYQERAIsBJgBjATsAZAFrAFsBEwCMAW4AXQEVAGsBFwAQAGcBoAACACYAYwFo'
..'ARAADACaAAwADQAOAA8AEAAhAGEBEQCDASYAYwE7AGQBawBsABMAhAFuAG8AFQBmARcAEABYAVkBZwGiAAIAJgBjAWgBEAAMAJkABgANAA4ADwAQABEAjQETAI4BFQBuARcAEAAMAJkABgANAA4ADwAQABEAjwETAJABFQBxARcAEAAMAJkABgANAA4ADwAQABEAkQET'
..'AJIBFQBuARcAEAABAJkAAQACAJMBDACnAAoADQAOAA8AEAAhAFIBEQCUASYAVAE7AFUBEwCVARUAVwEXABAAWAFZAQwApwALAA0ADgAPABAAIQBSAREAlgEmAFQBOwBVAWsAeAETAJcBbgB4ARUAXgEXABAADACnAAoADQAOAA8AEAAhAFIBEQCYASYAVAE7AFUBEwCZ'
..'ARUAVwEXABAAWAFZAQwApwAKAA0ADgAPABAAIQBhAREAmgEmAGMBOwBkARMAmwEVAGYBFwAQAFgBWQFnAasAAgAmAGMBaAEQAAwApwALAA0ADgAPABAAIQBhAREAnAEmAGMBOwBkAWsAeAETAJ0BbgB4ARUAawEXABAAZwGtAAIAJgBjAWgBEAAMAKcACgANAA4ADwAQ'
..'ACEAYQERAJQBJgBjATsAZAETAJUBFQBmARcAEABYAVkBZwGvAAIAJgBjAWgBEAAMAJkABwAIAJ4BDQAOAA8AEAARAJ8BEwCgARUAoQEXABAAogGxAAUAowErAKQBDgClASsApgGnAagBKwCpAbIAAwCqAasBrAErABUArQGuAbMABgCqAasBrAErABUArQGvAbABsQGy'
..'AbMBpwEBAGUAAQACALQBAQC1AAEAAgC1AQwAtgAMAA0ADgAPABAAIQBSAREAtgEmAFQBOwBVAWsAbAATALcBbgBvABUAVwEXABAAWAFZAQwAtgALAA0ADgAPABAAIQBSAREAuAEmAFQBOwBVAWsAWwETALkBbgBdARUAXgEXABAADAC2AAwADQAOAA8AEAAhAFIBEQC6'
..'ASYAVAE7AFUBawBsABMAuwFuAG8AFQBXARcAEABYAVkBDAC2AAwADQAOAA8AEAAhAGEBEQC8ASYAYwE7AGQBawBsABMAvQFuAG8AFQBmARcAEABYAVkBZwG6AAIAJgBjAWgBEAAMALYACwANAA4ADwAQACEAYQERAL4BJgBjATsAZAFrAFsBEwC/AW4AXQEVAGsBFwAQ'
..'AGcBvAACACYAYwFoARAADAC2AAwADQAOAA8AEAAhAGEBEQC2ASYAYwE7AGQBawBsABMAtwFuAG8AFQBmARcAEABYAVkBZwG+AAIAJgBjAWgBEAAMALUABgANAA4ADwAQABEAwAETAMEBFQBuARcAEAAMALUABgANAA4ADwAQABEAwgETAMMBFQBxARcAEAAMALUABgAN'
..'AA4ADwAQABEAxAETAMUBFQBuARcAEAABALUAAQACAMYBDADDAAoADQAOAA8AEAAhAFIBEQDHASYAVAE7AFUBEwDIARUAVwEXABAAWAFZAQwAwwALAA0ADgAPABAAIQBSAREAyQEmAFQBOwBVAWsAeAETAMoBbgB4ARUAXgEXABAADADDAAoADQAOAA8AEAAhAFIBEQDL'
..'ASYAVAE7AFUBEwDMARUAVwEXABAAWAFZAQwAwwAKAA0ADgAPABAAIQBhAREAzQEmAGMBOwBkARMAzgEVAGYBFwAQAFgBWQFnAccAAgAmAGMBaAEQAAwAwwALAA0ADgAPABAAIQBhAREAzwEmAGMBOwBkAWsAeAETANABbgB4ARUAawEXABAAZwHJAAIAJgBjAWgBEAAM'
..'AMMACgANAA4ADwAQACEAYQERAMcBJgBjATsAZAETAMgBFQBmARcAEABYAVkBZwHLAAIAJgBjAWgBEAABAGUAAQACANEBAQDNAAEAAgDSAQwAzgAMAA0ADgAPABAAIQBSAREA0wEmAFQBOwBVAWsAbAATANQBbgBvABUAVwEXABAAWAFZAQwAzgALAA0ADgAPABAAIQBS'
..'AREA1QEmAFQBOwBVAWsAWwETANYBbgBdARUAXgEXABAADADOAAwADQAOAA8AEAAhAFIBEQDXASYAVAE7AFUBawBsABMA2AFuAG8AFQBXARcAEABYAVkBDADOAAwADQAOAA8AEAAhAGEBEQDZASYAYwE7AGQBawBsABMA2gFuAG8AFQBmARcAEABYAVkBZwHSAAIAJgBj'
..'AWgBEAAMAM4ACwANAA4ADwAQACEAYQERANsBJgBjATsAZAFrAFsBEwDcAW4AXQEVAGsBFwAQAGcB1AACACYAYwFoARAADADOAAwADQAOAA8AEAAhAGEBEQDTASYAYwE7AGQBawBsABMA1AFuAG8AFQBmARcAEABYAVkBZwHWAAIAJgBjAWgBEAAMAM0ABgANAA4ADwAQ'
..'ABEA3QETAN4BFQBuARcAEAAMAM0ABgANAA4ADwAQABEA3wETAOABFQBxARcAEAAMAM0ABgANAA4ADwAQABEA4QETAOIBFQBuARcAEAABAM0AAQACAOMBDADbAAoADQAOAA8AEAAhAFIBEQDkASYAVAE7AFUBEwDlARUAVwEXABAAWAFZAQwA2wALAA0ADgAPABAAIQBS'
..'AREA5gEmAFQBOwBVAWsAeAETAOcBbgB4ARUAXgEXABAADADbAAoADQAOAA8AEAAhAFIBEQDoASYAVAE7AFUBEwDpARUAVwEXABAAWAFZAQwA2wAKAA0ADgAPABAAIQBhAREA6gEmAGMBOwBkARMA6wEVAGYBFwAQAFgBWQFnAd8AAgAmAGMBaAEQAAwA2wALAA0ADgAP'
..'ABAAIQBhAREA7AEmAGMBOwBkAWsAeAETAO0BbgB4ARUAawEXABAAZwHhAAIAJgBjAWgBEAAMANsACgANAA4ADwAQACEAYQERAOQBJgBjATsAZAETAOUBFQBmARcAEABYAVkBZwHjAAIAJgBjAWgBEAABAGUAAQACAO4BAQDlAAEAAgDvAQwA5gAMAA0ADgAPABAAIQBS'
..'AREA8AEmAFQBOwBVAWsAbAATAPEBbgBvABUAVwEXABAAWAFZAQwA5gALAA0ADgAPABAAIQBSAREA8gEmAFQBOwBVAWsAWwETAPMBbgBdARUAXgEXABAADADmAAwADQAOAA8AEAAhAFIBEQD0ASYAVAE7AFUBawBsABMA9QFuAG8AFQBXARcAEABYAVkBDADmAAwADQAO'
..'AA8AEAAhAGEBEQD2ASYAYwE7AGQBawBsABMA9wFuAG8AFQBmARcAEABYAVkBZwHqAAIAJgBjAWgBEAAMAOYACwANAA4ADwAQACEAYQERAPgBJgBjATsAZAFrAFsBEwD5AW4AXQEVAGsBFwAQAGcB7AACACYAYwFoARAADADmAAwADQAOAA8AEAAhAGEBEQDwASYAYwE7'
..'AGQBawBsABMA8QFuAG8AFQBmARcAEABYAVkBZwHuAAIAJgBjAWgBEAAMAOUABgANAA4ADwAQABEA+gETAPsBFQBuARcAEAAMAOUABgANAA4ADwAQABEA/AETAP0BFQBxARcAEAAMAOUABgANAA4ADwAQABEA/gETAP8BFQBuARcAEAABAOUAAQACAAACDADzAAoADQAO'
..'AA8AEAAhAFIBEQABAiYAVAE7AFUBEwACAhUAVwEXABAAWAFZAQwA8wALAA0ADgAPABAAIQBSAREAAwImAFQBOwBVAWsAeAETAAQCbgB4ARUAXgEXABAADADzAAoADQAOAA8AEAAhAFIBEQAFAiYAVAE7AFUBEwAGAhUAVwEXABAAWAFZAQwA8wAKAA0ADgAPABAAIQBh'
..'AREABwImAGMBOwBkARMACAIVAGYBFwAQAFgBWQFnAfcAAgAmAGMBaAEQAAwA8wALAA0ADgAPABAAIQBhAREACQImAGMBOwBkAWsAeAETAAoCbgB4ARUAawEXABAAZwH5AAIAJgBjAWgBEAAMAPMACgANAA4ADwAQACEAYQERAAECJgBjATsAZAETAAICFQBmARcAEABY'
..'AVkBZwH7AAIAJgBjAWgBEAABAGUAAQACAAsCAQD9AAEAAgAMAgwA/gAMAA0ADgAPABAAIQBSAREADQImAFQBOwBVAWsAbAATAA4CbgBvABUAVwEXABAAWAFZAQwA/gALAA0ADgAPABAAIQBSAREADwImAFQBOwBVAWsAWwETABACbgBdARUAXgEXABAADAD+AAwADQAO'
..'AA8AEAAhAFIBEQARAiYAVAE7AFUBawBsABMAEgJuAG8AFQBXARcAEABYAVkBDAD+AAwADQAOAA8AEAAhAGEBEQATAiYAYwE7AGQBawBsABMAFAJuAG8AFQBmARcAEABYAVkBZwECAQIAJgBjAWgBEAAMAP4ACwANAA4ADwAQACEAYQERABUCJgBjATsAZAFrAFsBEwAW'
..'Am4AXQEVAGsBFwAQAGcBBAECACYAYwFoARAADAD+AAwADQAOAA8AEAAhAGEBEQANAiYAYwE7AGQBawBsABMADgJuAG8AFQBmARcAEABYAVkBZwEGAQIAJgBjAWgBEAAMAP0ABgANAA4ADwAQABEAFwITABgCFQBuARcAEAAMAP0ABgANAA4ADwAQABEAGQITABoCFQBx'
..'ARcAEAAMAP0ABgANAA4ADwAQABEAGwITABwCFQBuARcAEAABAP0AAQACAB0CDAALAQoADQAOAA8AEAAhAFIBEQAeAiYAVAE7AFUBEwAfAhUAVwEXABAAWAFZAQwACwELAA0ADgAPABAAIQBSAREAIAImAFQBOwBVAWsAeAETACECbgB4ARUAXgEXABAADAALAQoADQAO'
..'AA8AEAAhAFIBEQAiAiYAVAE7AFUBEwAjAhUAVwEXABAAWAFZAQwACwEKAA0ADgAPABAAIQBhAREAJAImAGMBOwBkARMAJQIVAGYBFwAQAFgBWQFnAQ8BAgAmAGMBaAEQAAwACwELAA0ADgAPABAAIQBhAREAJgImAGMBOwBkAWsAeAETACcCbgB4ARUAawEXABAAZwER'
..'AQIAJgBjAWgBEAAMAAsBCgANAA4ADwAQACEAYQERAB4CJgBjATsAZAETAB8CFQBmARcAEABYAVkBZwETAQIAJgBjAWgBEAAoAgUAAAABAAUAAgAIACkCAgAqAgwAFgEKAAgAKQINAA4ADwAQACEAKwIRACwCJgAtAjsAPAATAC4CFQAvAhcAEACiARcBBQCjASsApAEO'
..'AGgBWQGlASsAqAErAKkBGAEEAKoBqwGsASsAEwAwAhUAMQKuARkBCACqAasBrAErABUArQGvAbABMgKrATMCNAKxAasBswE1AgwAFgEMAAgANgINAA4ADwAQACEANwIRADgCJAAlACYAOQI7AB4BEwA6AhUAOwIXABAAKgArAAwAFgEIAA0ADgAPABAAIQAiABEAPAIm'
..'ACcAEwA9AhUAPgIXABAADAAWAQgADQAOAA8AEAAhACIAEQA/AiYAJwATAEACFQBBAhcAEAAMABYBCAANAA4ADwAQACEAIgARAEICJgAnABMAQwIVAEQCFwAQAAwAFgEJAAgARQINAA4ADwAQACEAIgARAEYCJgAnABMARwIVAEgCFwAQAEkCHwEBAEoCSwJMAhYBAQAI'
..'AE0CAQAFAAIACABOAgIATwIMACIBBgANAA4ADwAQABEAUAITAFECFQBSAhcAEAAMACIBBgANAA4ADwAQABEAUwITAFQCFQBVAhcAEAAMACIBBgANAA4ADwAQABEAVgITAFcCFQBVAhcAEAAMACIBBgANAA4ADwAQABEAWAITAFkCFQBaAhcAEAAMACIBBgANAA4ADwAQ'
..'ABEAWwITAFwCFQBdAhcAEAAMACIBBgANAA4ADwAQABEAXgITAF8CFQBgAhcAEAAMACIBBgANAA4ADwAQABEAYQITAGICFQBgAhcAEAAMACIBBgANAA4ADwAQABEAYwITAGQCFQBlAhcAEAAMACIBBgANAA4ADwAQABEAZgITAGcCFQBoAhcAEAAMACIBBgANAA4ADwAQ'
..'ABEAaQITAGoCFQBrAhcAEAAMACIBBgANAA4ADwAQABEAbAITAG0CFQBuAhcAEAAMACIBBgANAA4ADwAQABEAbwITAHACFQBxAhcAEAAMACIBCwAIACAADQAOAA8AEAAhACIAEQByAiQAJQAmACcAEwBzAhUAKQAXABAAKgArACwALwEDAAgALQARAC4AEwAvACwALwED'
..'AAgAMAARADEAEwAyAAwAIgEGAA0ADgAPABAAEQB0AhMAdQIVAHYCFwAQAAwAIgEGAA0ADgAPABAAEQB3AhMAeAIVAHkCFwAQAAwAIgEGAA0ADgAPABAAEQB6AhMAewIVAHwCFwAQAAwAIgEGAA0ADgAPABAAEQB9AhMAfgIVAH8CFwAQAAwAIgEIAA0ADgAPABAAEQCA'
..'AjsAgQITAIICFQCDAhcAEAAqAIQCDAAiAQYADQAOAA8AEAARAIUCEwCGAhUAhwIXABAADAAiAQgADQAOAA8AEAARAIgCOwCBAhMAiQIVAIoCFwAQACoAhAIMACIBCgAIAIsCDQAOACEAjAIRAI0CJgCOAjsAjwJrAJACEwCRAm4AkgIVAJMClAI5AQIAlQKWApcCmAKU'
..'AjkBAgCVApoClwKbAkkCOQEDAAgAnAKdAqcBSgKeAkkCOQEDAAgAnwKdAqcBSgKgAkkCOQEEAAgAoQKdAqcBSgKiAqMCpAJJAjkBBQAIAKUCpgKnAp0CpwFKAqICowKkAgwAIgEGAA0ADgAPABAAEQCoAhMAqQIVAKoCFwAQAAwAIgEFAA8AEAARAKsCEwCsAhUArQIX'
..'ABAADAAiAQgADQAOAA8AEAARAK4COwCBAhMArwIVALACFwAQACoAhAIMACIBBwANAA4AEQCxAjsAVQFrALICEwCzAm4AkAIVALQCDAAiAQUADwAQABEAtQITALYCFQC3AhcAEAAMACIBDQAIALgCDQAOAA8AWQEhALkCEQC6AiYAuwI7AFUBawCyAhMAvAK9Ar4CbgCQ'
..'AhUAvwIXAFkBDAAiAQUADwAQABEAwAITAMECFQDCAhcAEAAMACIBCwAIAEUCDQAOAA8AEAAhACIAEQDDAiYAJwBrAMQCEwDFAm4AxAIVAEgCFwAQAEkCRwEBAEoCSwIMACIBCgANAA4ADwAQACEAIgARAMYCJgAnAGsAxAITAMcCbgDEAhUAPgIXABAADAAiAQoADQAO'
..'AA8AEAAhACIAEQDIAiYAJwBrAMQCEwDJAm4AxAIVAEECFwAQAAwAIgEKAA0ADgAPABAAIQAiABEAygImACcAawDEAhMAywJuAMQCFQBEAhcAEAABACIBAgAIAKkBAgDMAgwATAENAA0ADgDNAs4CDwAQABEAzwLQAs4C0QLOAjsAjwJrANICEwDTAtQCzgJuANICFQDV'
..'AhcAEAAMAEwBDQANAA4AzQLOAg8AEAARANYC0ALOAtECzgI7AI8CawDXAhMA2ALUAs4CbgDzABUA2QIXAM4ClAJOAQIAlQLaApcC2wIMAEwBDQANAA4AzQLOAg8AEAARANwC0ALOAtECzgI7AI8CawDXAhMA3QLUAs4CbgDzABUA3gIXAM4ClAJQAQIAlQLfApcC4AKU'
..'AlABAgCVAuIClwLjApQCUAECAJUC2gKXAuQCDABMAQ0ADQAOAM0CzgIPABAAEQDlAtACzgLRAs4COwCPAmsA1wITAOYC1ALOAm4A8wAVAOcCFwDOApQCVAECAJUC3wKXAugClAJUAQIAlQLaApcC6QLqAkwBDQANAA4AzQLOAg8AzgIRAOsC0ALOAtECzgI7AI8CawDs'
..'AhMA7QLUAs4CbgDuAhUA7wIXAM4C8AJXAQIA8QLyAvMCWQHqAkwBDQANAA4AzQLOAg8AzgIRAPQC0ALOAtECzgI7AI8CawD1AhMA9gLUAs4CbgD3AhUA+AIXAM4C8AJZAQIA8QL5AvMCWQEMAEwBCQANAA4ADwAQABEA+gI7AI8CawD7AhMA/AJuAPsCFQD9AhcAEADq'
..'AkwBDQANAA4AzQLOAg8AzgIRAP4C0ALOAtECzgI7AI8CawD/AhMAAAPUAs4CbgABAxUAAgMXAM4C8AJcAQIA8QIDA/MCWQHqAkwBDQANAA4AzQLOAg8AzgIRAAQD0ALOAtECzgI7AI8CawAFAxMABgPUAs4CbgAHAxUACAMXAM4C8AJeAQIA8QIJA/MCWQEMAEwBCQAN'
..'AA4ADwAQABEACgM7AI8CawALAxMADANuAAsDFQANAxcAEAAMACIBDgAIAA4DDQAOAA8AWQEhALkCEQAPAyQAJQAmALsCOwAeAWsAsgITABADvQK+Am4AkAIVABEDFwBZASgCBAABAAgAEgMBAAQAAgAIABMDAgAUAwwAYwEKAAgAKQINAA4ADwAQACEAKwIRABUDJgAt'
..'AjsAPAATABYDFQAvAhcAEACiAWQBBQCjASsApAEOAGgBWQGlASsAqAErAKkBZQEEAKoBqwGsASsAEwAwAhUAMQKuAWYBCACqAasBrAErABUArQGvAbABMgKrATMCNAKxAasBswE1AgwAYwEMAAgANgINAA4ADwAQACEANwIRABcDJAAlACYAOQI7AB4BEwAYAxUAOwIX'
..'ABAAKgArACgCaAEAAEwCaQEBAAgATQIMAGMBCAANAA4ADwAQACEAIgARABkDJgAnABMAGgMVAD4CFwAQAAwAYwEIAA0ADgAPABAAIQAiABEAGwMmACcAEwAcAxUAQQIXABAADABjAQgADQAOAA8AEAAhACIAEQAdAyYAJwATAB4DFQBEAhcAEAAMAGMBCQAIAEUCDQAO'
..'AA8AEAAhACIAEQAfAyYAJwATACADFQBIAhcAEABJAm4BAQBKAksCTAIEAAEACAAhAwcAAwABAAgAIgMjA3EBAQAIACQDIwNxAQEACAAlAwwAAQAJAA0ADgAPABAAIQBnABEAJgMmAGkAOwAeARMAJwMVACgDFwAQAAwAAQAKAA0ADgAPABAAIQBnABEAKQMkACUAJgBp'
..'ADsAHgETACoDFQArAxcAEAAsA3UBAgAtAy4DLwMlACgCdQEAAAo6AZkCOQE7AZkCOQFPAZkCTgFRAeECTQFRAZkCUAFSAZkCUAFTAZkCUAFVAeECTQFVAZkCVAFWAZkCVAE=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
