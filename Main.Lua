-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 29552 characters

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
local WFIRT = false
local height = 0
local door = 1
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
			WFIRT = true
			cinst.INTERACT.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChildOfClass("Humanoid") == nil then return end
				print("Clicked")
				spawn(function()
					for i = 3,(cinst.MDOOR.Size.z / 0.15)  do
						cinst.MDOOR.CFrame = cinst.MDOOR.CFrame + (cinst.MDOOR.CFrame.lookVector * 0.15)
						wait()
					end
				end)
				WFIRT = false
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
			if WFIRT == true then
			else
				script.Parent.Parent.Events.LoadNextRoom:Fire(currdoor.DID.Value)
			end
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


local Objects = Decode('AFCIAyEFTW9kZWwhCldvcmxkUGl2b3QEMgMzAzQDBDUDMwM0AwQ2AzMDNAMENwMzAzQDIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQEOAMzAzQDIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUADMDNAMhCFBv'
..'c2l0aW9uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQAzAzQDCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHAAzAzQDCsXOr0OPM/VC98CLxAQeADMDNAMKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNr'
..'Q29sb3IH6gMEKAAzAzQDIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AMwM0AwoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyADMDNAMKAAAAAAAA'
..'AACPwuNAIQJVcAQ5AzMDNAMENgAzAzQDCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQA6AzQDBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAADoDNAMKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDADoDNAMK'
..'lWaQQw6v/UJhXo3EBEUAOgM0AwqVZpBDDq//QseEjcQERwAzAzQDCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgAzAzQDCm2gjkM2LwBDOruMxARMADMDNAMKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPADMDNAMK1WCQQ0ovAENkv4zEBFEAMwM0AwoAOjS9'
..'AACsQKRwZ8EEUwAzAzQDCgAAVTw3ibXAMLJjQQRVADoDNAMKlWaQQw6v90Iu64zEBFcAOgM0AwqVZpBDDq/5QpQRjcQEWQA6AzQDCpVmkEMOr/FC+neMxARbADoDNAMKlWaQQw+v80JhnozEBF0AOgM0AwqVZpBDDq/1QsfEjMQEXwAzAzQDCi9lkEOzPexCOruMxArG'
..'QeZAQLbiPoid6EEEYgA7AzQDCpVmkEMOr+1CLiuMxARkADoDNAMKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBDwDPQM0AwdrAARtAD4DPwMGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAA'
..'AAAANEMKPibWQUC24j6InehBBHIAPgM/Awr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBHUAPgM/AwoLXqZDHSn5QvW5jsQEdwA+Az8DCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegA+Az8DCr+un0NU/AJD9bmOxAR8AD4DPwMKf/ejQx0p+ULDhpDECvy/HUEY'
..'mVJBEqmNPgR/AD4DPwMKMXObQx0p+ULDhpDEBIEAPgM/AwrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BIQAPgM/Awoxc5tDHSn5QhvrjMQEhgA+Az8DCteBnUOGJgFDG+uMxASIAD4DPwMKf/ejQx0p+UIb64zEBIoAPgM/AwoFtp9D+yj5QvW5jsQEjQBAAzQDCgAA'
..'AACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkAAzAzQDCgDAVDzByvG/FK5pwSEERG93bgRBAzMDNAMElAA+Az8DCjPBikN+XwpDb7aMxASWAD4DPwMKM7qKQ/cUAUMfYYvEBJgAPgM/AwozuopD7in8Qtk9jMQEmgA+Az8DCjO6ikPuKf5CcheMxAScAD4DPwMKM7qK'
..'Q/cUAEMM8YvEBJ4APgM/Awpp/ohDpmwAQ5m6jMQEoAA+Az8DClmAjEOmbABDmbqMxASiAD4DPwMKM8GKQ13sBEO+ho7EBKQAPgM/Awrzv4pDumwAQ2+2jMQEpgA+Az8DCjO6ikPuKfhCpYqMxASoAD4DPwMKM7qKQ+4p+kI/ZIzEBKoAPgM/AwozuopD7inyQtn9jMQE'
..'rAA+Az8DCjO6ikPvKfRCcteMxASuAD4DPwMKM7qKQ+4p9kIMsYzEBLAAPgM/AwqZu4pDk7jsQpm6jMQEsgA+Az8DCjO6ikPuKe5CpUqNxAS0AD4DPwMKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBEIDMwM0AwS4AD4DPwMKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3o'
..'QQS7AD4DPwMKIqI/Q1Fc+ULgG5HEBL0APgM/AwpVEIRDUVz5QuAbkcQEvwA+Az8DChLCekMXpOxCwU2PxATBAD4DPwMKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEAD4DPwMKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHAD4DPwMK0o1EQ1Fc+UKv6JLEBMkA'
..'PgM/Awoeq0hDIEABQ6/oksQEywA+Az8DChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgA+Az8DCkJodkMgQAFDBk2PxATQAD4DPwMKyamBQ1Fc+UIGTY/EBNIAPgM/AwpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEQwMzAzQDBNYAPgM/AwoycWRD9qvsQtY0jMQE'
..'2AA+Az8DCro/QEMwZPlC1jSMxATaAD4DPwMKH1+EQzBk+ULWNIzEBNwAPgM/AwqqX3tD9qvsQrdmisQE3gA+Az8DCs5mZEPcGQND1jSMxATgAD4DPwMK4olkQ9Jv+ULQM4zEBEQDRQM0AwTjAD4DPwMKfwyCQ2Bk+UKjAY7EBOUAPgM/AwqKMFxDYGT5QqMBjsQE5wA+'
..'Az8DCq4td0MoRAFDowGOxARGA0UDNAME6gA+Az8DChLubENsavlC/WWKxATsAD4DPwMKyiBJQy1HAUP9ZYrEBO4APgM/Awp6A0VDbGr5Qv1lisQhA0xJQgRHA0gDNAME8gBJA0oDCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYASwM0Awp5'
..'k6RDfj8DQ17PfMQE+AAzAzQDCgAAAAAGgeW/4vqvQgT6ADMDNAMKAAAAAPp+8sBf5a/CBPwASQNKAwq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BP8ASQNKAwp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBSQNKAwp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+'
..'BAUBPgM/AwrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBSQNKAwrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBSQNKAwp3k4dDfj8DQyLLfMQEDQFJA0oDCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAFJA0oDCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDv'
..'fz8EEwFJA0oDCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgFJA0oDCk03mkPnUPZCnm9wxAQYAUkDSgMKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEHwFJA0oDBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HA'
..'d5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBSQNKAwq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQND'
..'oO9vxAQuAUkDSgMKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAUkDSgMKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AUkDSgMKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3AUkDSgMKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AUkDSgMKtZ2LQ+dQ'
..'9kKi72/ECmZmdkEAAABBwO9/PwQ9AUkDSgMKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQAAwEBwURBCCsXLi0PoUPRCFE1rxARGAUkDSgMKQ4CkQ5JtC0PayWbE'
..'CpmZEUFwPTJBAOjWPgRJAUkDSgMKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAUkDSgMKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAUkDSgMK5xCVQ34/A0PayWbEBEwDMwM0AwRqAUgDNAMHxwAEVgE+Az8DBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QK'
..'ANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAU0DTgMKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABPgM/Awp+SqpDKITwQos2h8QHagAEZQE+Az8DBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAA'
..'gD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagFNA04DCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQEzAzQDCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAEzAzQDCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEcwEzAzQDCsdLnkM9ngNDizaHxAR/ATMD'
..'NAMEdgEzAzQDCg/NnkPWy/5CizaHxAR5AU8DUAMKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7ATMDNAMKD82eQyiE8EKLNofEBH0BMwM0AwoPzZ5DZY7wQos2h8QEfwFPA1ADCg7NnkP/p/dCizaHxCEEQXJjaARRAzMDNAMEjAFIAzQDBIQBPgM/Awp+SqpD1sv+'
..'Qou2hMQEhgFNA04DCn5KqkP/p/dCi7aExASIAT4DPwMKfkqqQyiE8EKLtoTEBIoBPgM/Awp+SqpDZY7wQou2hMQEjAFNA04DCn9KqkP/p/dCi7aExASOATMDNAMKx8uqQz2eA0OLtoTEBJABMwM0AwrHi6RDeqgGQ4u2hMQEkgEzAzQDCsdLnkM9ngNDi7aExASdATMD'
..'NAMElQEzAzQDCg/NnkPWy/5Ci7aExASXAU8DUAMKD82eQ/+n90KLtoTEBJkBMwM0AwoPzZ5DKITwQou2hMQEmwEzAzQDCg/NnkNljvBCi7aExASdAU8DUAMKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABMwM0AwrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABAIQpTdXJm'
..'YWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAIA/'
..'AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQRSAzMDNAMEvwFIAzQDBLcBPgM/Awp+SqpD1sv+Qos2gsQEuQFNA04DCn5KqkP/p/dCizaCxAS7AT4DPwMKfkqqQyiE8EKLNoLEBL0BPgM/Awp+SqpDZY7wQos2'
..'gsQEvwFNA04DCn9KqkP/p/dCizaCxATBATMDNAMKx8uqQz2eA0OLNoLEBMMBMwM0AwrHi6RDeqgGQ4s2gsQExQEzAzQDCsdLnkM9ngNDizaCxATQATMDNAMEyAEzAzQDCg/NnkPWy/5CizaCxATKAU8DUAMKD82eQ/+n90KLNoLEBMwBMwM0AwoPzZ5DKITwQos2gsQE'
..'zgEzAzQDCg/NnkNljvBCizaCxATQAU8DUAMKDs2eQ/+n90KLNoLEBFMDMwM0AwTcAUgDNAME1AE+Az8DCn5KqkPWy/5CFm1/xATWAU0DTgMKfkqqQ/+n90IWbX/EBNgBPgM/Awp+SqpDKITwQhZtf8QE2gE+Az8DCn5KqkNljvBCFm1/xATcAU0DTgMKf0qqQ/+n90IW'
..'bX/EBN4BMwM0AwrHy6pDPZ4DQxZtf8QE4AEzAzQDCseLpEN6qAZDFm1/xATiATMDNAMKx0ueQz2eA0MWbX/EBO0BMwM0AwTlATMDNAMKD82eQ9bL/kIWbX/EBOcBTwNQAwoPzZ5D/6f3QhZtf8QE6QEzAzQDCg/NnkMohPBCFm1/xATrATMDNAMKD82eQ2WO8EIWbX/E'
..'BO0BTwNQAwoOzZ5D/6f3QhZtf8QEVAMzAzQDBPkBSAM0AwTxAT4DPwMKfkqqQ9bL/kIWbXrEBPMBTQNOAwp+SqpD/6f3QhZtesQE9QE+Az8DCn5KqkMohPBCFm16xAT3AT4DPwMKfkqqQ2WO8EIWbXrEBPkBTQNOAwp/SqpD/6f3QhZtesQE+wEzAzQDCsfLqkM9ngND'
..'Fm16xAT9ATMDNAMKx4ukQ3qoBkMWbXrEBP8BMwM0AwrHS55DPZ4DQxZtesQECgIzAzQDBAICMwM0AwoPzZ5D1sv+QhZtesQEBAJPA1ADCg/NnkP/p/dCFm16xAQGAjMDNAMKD82eQyiE8EIWbXrEBAgCMwM0AwoPzZ5DZY7wQhZtesQECgJPA1ADCg7NnkP/p/dCFm16'
..'xARVAzMDNAMEFgJIAzQDBA4CPgM/Awp+SqpD1sv+QhZtdcQEEAJNA04DCn5KqkP/p/dCFm11xAQSAj4DPwMKfkqqQyiE8EIWbXXEBBQCPgM/Awp+SqpDZY7wQhZtdcQEFgJNA04DCn9KqkP/p/dCFm11xAQYAjMDNAMKx8uqQz2eA0MWbXXEBBoCMwM0AwrHi6RDeqgG'
..'QxZtdcQEHAIzAzQDCsdLnkM9ngNDFm11xAQnAjMDNAMEHwIzAzQDCg/NnkPWy/5CFm11xAQhAk8DUAMKD82eQ/+n90IWbXXEBCMCMwM0AwoPzZ5DKITwQhZtdcQEJQIzAzQDCg/NnkNljvBCFm11xAQnAk8DUAMKDs2eQ/+n90IWbXXEIQZTY3JpcHQhBERvb3IEVgMz'
..'AzQDB2kBBC4CMwM0AwZWQjYKx+kUQxdY9UKUFJDECtpFx0Dt1gNBGIUjPwwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIRFQbGFjZWhvbGRlckNvbG9yMyEEVGV4dCEBMAMAAAAAAABEQCEQRG9vckhpdERldGVjdGlvbgdMAQQ6AjMDNAMGdQAACsfpFEMXWPVCtxGQ'
..'xAp2Md9AUrgKQVyPQj8EPQIzAzQDCpQ6GENkMPVCbheQxArg++M+O+cNQQCjLT8EQAIzAzQDCub9FEMH8f1CbheQxApqa91AIP3ePgCjLT8EQwIzAzQDCpaMEUMXWPVCbheQxApAIhY/a2IQQQCjLT8hAlNQBEcCMwM0AwqM2hRDTMPsQm4XkMQKxkHmQEC24j4Aoy0/'
..'IQVTb3VuZCEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzE1NzE2NzIwMyELTnVtYmVyVmFsdWUhA0RJRCEDSU5UBFcDRQM0AwRRAjMDNAMKrUHNQ8gZAkOmeJHECiNa5kBvgMJAENbePgRUAjMDNAMKnbjCQ+Jr9UJI6YnECgOrq0HwXg5BwF7KPgRXAjMDNAMKnbjCQ+Jr'
..'9UIp5I3EBFkCMwM0AwqUc71D4mv1QoXri8QKH8vBPvBeDkFme/9BBFwCMwM0AwpCG8hDdiECQ7gujcQKHxOjPjxNv0AAKhJBBF8CMwM0AwpkoNBDUSn7QqZ4kcQKajvhQA/kcUEH2t4+BGICMwM0AwpayclDUSn7QqZ4kcQEZAIzAzQDCq1BzUN2IQJDhkuJxAojWuZA'
..'9GvEQB9sXD4EZwIzAzQDCjKt0EOuOPtChkuJxAqdbtRA0dlyQR9sXD4EagIzAzQDCqLKyUNxLvtChkuJxApB3+FA+jVyQR9sXD4EbQIzAzQDCp5Bw0NhQuxC9+2LxArMH8RBQLbiPu8wBEIEcAIzAzQDCkIbyENm1/pCxY2PxArNEqM+VsVsQQzs+EEEcwIzAzQDCvqe'
..'x0OmG/tC7GGNxAR1AjMDNAMKQjLNQ2FC7ELYYI3ECqTDpEFAtuI+8KeDQgR4AjMDNAMKxU7SQ1Ep+0L2YI3ECgBG1j4P5HFBShyDQgR7AjMDNAMKGR/IQzMk+0J7BIvECh/LwT4jknFBuTPeQQR+AjMDNAMKBCjNQzrwBEMpZI3ECqTDpEFAtuI+ShyDQgSCAjMDNAMD'
..'AAAAAACAmEAKQ2HQQy1x+0IAgIrECszM7EAK12tBCtejPQMAAAAAAADQPwSGAjMDNAMKwpXOQy1x+0IAgIrECrAehT4K12tBpHC9PwSJAjMDNAMKvlXNQyY7AUMAgIrECuF6pEA9CvdACtejPSEFTURPT1IHZwAEkQJYA1kDBsrItgMAAAAAAACRQAoAALRCAAC0QgAA'
..'AAAKz1PNQ1eo80LIforECgAAtEIAAAAAAAC0wgrdx8U+lKCQQKwB2UAhBFdlbGQhAkMwBFoDSANbAyECQzEEXANdA14DIQVQYXJ0MQRfA0gDNAMEYANhA2IDIQxBY2Nlc3NEZW5pZWQhElJvbGxPZmZNYXhEaXN0YW5jZSEWcmJ4YXNzZXRpZDovLzIwMDg4ODUxMCEN'
..'QWNjZXNzR3JhbnRlZCEWcmJ4YXNzZXRpZDovLzIwMDg4ODQ2OCEJRG9vckNsb3NlIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1lAwAAAAAAAAhAIQhEb29yT3BlbiENUGxheWJhY2tTcGVlZAMAAABgZmbyPwSpAjMDNAMKTljNQ9y4+kIAgIrECj0Kp0Dg'
..'UTg+pHC9PwSsAjMDNAMKFA7MQyMa+0IAgIrECrAehT5mZmZBpHC9PwSvAjMDNAMKlRnKQy1x+0IAgIrECj0K90AK12tBCtejPQSzAjQDWwMKAAAAAAAAtEIAALRCCp8YxkODnfRC//qKxAqjhZI/SUocPjaYuT8EtgIzAzQDCpk5xkPcOPNCCneLxAquR/FA16PQQDMz'
..'80AhBkJ1dHRvbgfsAwS8AjQDWwMG/wAACp8YxkODnfRCHfaKxCELUmVmbGVjdGFuY2UDAAAAAAAA4D8KkdMvP0lKHD6khZI/BMECMwM0AwpSeMJDlFf+Qmfui8QK4Xq0QQrXoz0ehQVCBMUCYwM0AwoAAAAAAAC0QgAAAAAK4A7IQ+/I7EKDLo3EBMcCYwM0AwrgDshD'
..'Bjb1QoSajcQEyQJjAzQDCuAOyEOp9v1C7jKNxATLAmMDNAMK4A7IQ7ld9ULExIzEBGQDZQNmAyELQmFja1N1cmZhY2UDAAAAAAAAJEAE0wJnA2gDIQxGcm9udFN1cmZhY2UhC0xlZnRTdXJmYWNlCgAAAAAAAAAAAAC0wgrcUs1DKIr6QnB+isQhDFJpZ2h0U3VyZmFj'
..'ZQp9PzU+46WPQAAAgD8E2AJlA2YDCgAAAAAAADTDAAAAAAr8T81Dw8HsQpN+isQKx0uXQH0/NT4AAIA/BGkDSANbAwRqA2sDbAME3QJtA24DCl0lzENeffNCmX6KxAoZBJY+th7dQAAAgD8EbwNjAzQDBHADcQNyAyEFUGFydDAEcwMzAzQDBHQDdQN2AwR3A3gDeQME'
..'5gJtA24DCvV+zkNBePNCmn6KxAoZBJY+3XrcQAAAgD8EegNxA3IDBHsDeAN5AyEJV2VkZ2VQYXJ0BO0CfAN9AwqamQ9CAAC0QgAAtMIKb3rOQ09g+kKGjorECgAAtEJmZlhCAAA0wwrNzEw+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8h'
..'CE1lc2hUeXBlBPYCfgN/AwqamQ/C9qixwrieskIKbnrOQ1dg+kKaborECo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4zj0AAIA/BPwCgAOBAwoAAAAAAAAAAJoZEEMKb3rOQ1Jg+kKGforECt3Rmz7NzEw+xrV+PwQAA4IDgwMKSOH8QQAAtMIfBbRCCs0p'
..'zENKY/pChI6KxArh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwQGA4QDhQMKCtcjPHH9M0NSOPPCCswpzENUY/pChG6KxApx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/lMbSPQQMA4YDhwMKAAAAAAAAAADXYxTDCs0pzENPY/pC'
..'hH6KxApzypo+zcxMPhirfj8hCElOVEVSQUNUBBADNANbAwqfGMZDbO/xQh32isQKDJSvQM8cfj+eD1ZAIQVNYWlucyEFU0Rvb3IEiAMzAzQDBBYDMwM0Awqau2dCF1j1QpQUkMQhATEEGQMzAzQDCpq7Z0IXWPVCtxGQxCEFVmFsdWUEHAMzAzQDCs7+dEJkMPVCbheQ'
..'xAQeAzMDNAMKFAxoQgfx/UJuF5DEBCADMwM0AwrWRlpCF1j1Qm4XkMQEIgMzAzQDCq5+Z0JMw+xCbheQxCEHQXNzZXRJZCEGRXZlbnRzIQ1CaW5kYWJsZUV2ZW50IQxMb2FkTmV4dFJvb20hCUFzc2V0UGF0aAQpAzMDNAMKEJtmQiWF7EKZmovECjAzsUKPwvU9KVyP'
..'QgQsAzMDNAMKAAAAAK5HkUAAAAAACgAAgD8AAIA/AACAPyEPUHJveGltaXR5UHJvbXB0IQpPYmplY3RUZXh0IT1Hb2xkM25GMXIzJ3MgRG9vcnMgRW5naW5lLgoKSW50ZXJhY3Qgd2l0aCBtZSB0byBwbGF5ICJkb29ycyIuIRNSZXF1aXJlc0xpbmVPZlNpZ2h0Cj/1'
..'v0O8CZVCH80SxAoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACgKKZkK6LA5DJ3WHxAqufmdCO1n1Qo4Uh8QKuhuGQvBe9UKWgYnECgMFrkOJFvVCpr2LxArTYJBDLC8AQ2S/jMQK/f9/PwAAAAAAAAAACv//fz8AAAAAAAAAAAoFtp9DHSn5QvW5jsQKAACAvwAAAAAu'
..'vbuzCgAAgL8uvbuz7a0JKAouvbuzAACAPy69u7MKAACAPwAAAAAuvTu0CvW/ikOcbABDb7aMxApK7GND+Gf5QtoakcQK4olkQ9Zv+ULQM4zECtKiZENgZPlCowGOxAoAAIC/AAAAAC69uzMK4npkQ21q+UL9ZYrECneTpEN+PwNDXs98xAoAAIC/AAAAAAAAAAAKAACA'
..'vy69uzPtrQkoCi69uzMAAIA/Lr27MwoAAIA/AAAAAC69u7MKx4ukQz2eA0OLNofECi69O7MAAIA/Lr27swoAAIA/Lr07M+2tiacKLr07swAAgD8AAAAACgAAgL8uvTuzAAAAAArHi6RDPZ4DQ4u2hMQKx4ukQz2eA0OLNoLECseLpEM9ngNDFm1/xArHi6RDPZ4DQxZt'
..'esQKx4ukQz2eA0MWbXXECozaFEM8WfVC6xOQxAoEn8dDqRv7QuxhjcQKLr07swAAAAAAAIC/CgAAgD8uvTuzLr07swqnTRfAdK21PTRexT4KAAAAAAAAAAAAAIA/CgA8w77oaFjAYGQVwAp8eEy5RxmwNwAAgL8K/v9/v/DpDzqTe0w5CnBixj7qQGLAACsWvgoAfsk+'
..'m8ljwMDWDUAKAACAv2AAAC4AAICtCmAAAC4AAIA/mP8JLAoAAAAAAAAAAAAAgL8KK0XNQwSm80J1e4rECgAAgL9ACxGt/v9vrwpACxEtAACAP/7/b64Kd9OSNQAAgL+2F5k4CgAAgD9JhpI1/AYCuAoAAIDDAAAgQQAAgEMKLrn2wuHQCD6t98zDCpmFTDm/8Q86/v9/'
..'vwoAAIC/bDOvt7CITLkKAACAv0zvei/+/2+vCoyjiC8AAIA//B/YMQp9P7U946UPwAAAAD8KAFDjvT7wW0AAVQG/CsQGAjh3Gpm4CwCAPwoAAIC/cIOSNdgGAjgKAPGnvlaWWcBQxA5ACgBMB74A8lLAAKesPgp6eEw5nOoPOgoAgL8Kwxiwt/L/fz9X6g86CrJj+8Kc'
..'5k7AyPfMwwqZhUw5LPIPOv7/f78KAACAv+gyr7eviEy5CvDYkkARlFxAgFMBvwpQ/fHCy0JOwMj3zMMKByEWv5xbT7/bUWG4CvsJEDia4y04/P9/vwoHIRY/nFtPP0uxYTgKn/lavNagHzwG93+/CuFbT7+pIBY/nXeBtwqpIBa/4FtPv0TXpTgKHTAGv0sDWj9tIT65'
..'CiuDEDioBUm5/P9/vwobMAY/SgNav8QoPDkKSwNavxwwBr/MTfi4Cl8DWr/9Lwa/vduMOAr+LwY/XgNav/ymOjgKrn5nQjxZ9ULrE5DEdwEBAAAAAQACAAMAAQABAAEAAgAEAAEAAgABAAIABQABAAMAAQACAAYABwAEAAEACAAJAAEABQACAAgACgACAAsADAAGAAYA'
..'DQAOAA8AEAARABIAEwAUABUAFgAXABAADAAGAAYADQAOAA8AEAARABgAEwAZABUAGgAXABAADAAGAAYADQAOAA8AEAARABsAEwAcABUAGgAXABAADAAGAAYADQAOAA8AEAARAB0AEwAeABUAHwAXABAADAAGAAsACAAgAA0ADgAPABAAIQAiABEAIwAkACUAJgAnABMA'
..'KAAVACkAFwAQACoAKwAsAAsAAwAIAC0AEQAuABMALwAsAAsAAwAIADAAEQAxABMAMgABAAUAAgAIADMAAgA0AAwADgAGAA0ADgAPABAAEQA1ABMANgAVADcAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAOQAmADoAOwA8ABMAPQAVAD4AFwAQAAwADgAJAA0ADgAPABAA'
..'IQA4ABEAPwAmADoAOwA8ABMAQAAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAQgAmADoAOwA8ABMAQwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEARAAmADoAOwA8ABMARQAVAEEAFwAQAAwADgAGAA0ADgAPABAAEQBGABMARwAVAEgAFwAQAAwADgAGAA0A'
..'DgAPABAAEQBJABMASgAVAEgAFwAQAAwADgAGAA0ADgAPABAAEQBLABMATAAVAE0AFwAQAAwADgALAAgAIAANAA4ADwAQACEAIgARAE4AJAAlACYAJwATAE8AFQApABcAEAAqACsALAAXAAMACAAtABEAUAATAFEALAAXAAMACAAwABEAUgATAFMADAAOAAkADQAOAA8A'
..'EAAhADgAEQBUACYAOgA7ADwAEwBVABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBWACYAOgA7ADwAEwBXABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBYACYAOgA7ADwAEwBZABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBaACYAOgA7ADwAEwBbABUA'
..'QQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBcACYAOgA7ADwAEwBdABUAQQAXABAADAAOAAYADQAOAA8AEAARAF4AEwBfABUAYAAXABAADAAOAAkADQAOAA8AEAAhADgAEQBhACYAOgA7ADwAEwBiABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBjACYAOgA7ADwA'
..'EwBkABUAQQAXABAAAQAFAAIACABlAAIAZgAMACIACwANAA4ADwAQACEAZwARAGgAJgBpADsAagBrAGwAEwBtAG4AbwAVAHAAFwAQAAwAIgAIAA0ADgAPABAAEQBxAGsAbAATAHIAbgBvABUAcwAXABAADAAiAAgADQAOAA8AEAARAHQAawBsABMAdQBuAG8AFQBzABcA'
..'EAAMACIACAANAA4ADwAQABEAdgBrAGwAEwB3AG4AbwAVAHgAFwAQAAwAIgAIAA0ADgAPABAAEQB5AGsAbAATAHoAbgBvABUAcAAXABAADAAiAAgADQAOAA8AEAARAHsAawBsABMAfABuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAfgBrAGwAEwB/AG4AbwAVAH0A'
..'FwAQAAwAIgAIAA0ADgAPABAAEQCAAGsAbAATAIEAbgBvABUAggAXABAADAAiAAgADQAOAA8AEAARAIMAawBsABMAhABuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAhQBrAGwAEwCGAG4AbwAVAIIAFwAQAAwAIgAIAA0ADgAPABAAEQCHAGsAbAATAIgAbgBvABUA'
..'fQAXABAADAAiAA0ACAAgAA0ADgAPABAAIQAiABEAiQAkACUAJgAnAGsAbAATAIoAbgBvABUAKQAXABAAKgArACwALgAEAAgALQARAIsAawCMABMAjQAsAC4AAwAIAI4AEQCPABMAkAABAAUAAgAIAJEAAgCSAAwAMQAIAA0ADgAPABAAEQCTAGsAbAATAJQAbgBvABUA'
..'NwAXABAADAAxAAsADQAOAA8AEAAhADgAEQCVACYAOgA7ADwAawBsABMAlgBuAG8AFQA+ABcAEAAMADEACwANAA4ADwAQACEAOAARAJcAJgA6ADsAPABrAGwAEwCYAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAmQAmADoAOwA8AGsAbAATAJoAbgBvABUA'
..'QQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCbACYAOgA7ADwAawBsABMAnABuAG8AFQBBABcAEAAMADEACAANAA4ADwAQABEAnQBrAGwAEwCeAG4AbwAVAEgAFwAQAAwAMQAIAA0ADgAPABAAEQCfAGsAbAATAKAAbgBvABUASAAXABAADAAxAAgADQAOAA8AEAARAKEA'
..'awBsABMAogBuAG8AFQBNABcAEAAMADEADQAIACAADQAOAA8AEAAhACIAEQCjACQAJQAmACcAawBsABMApABuAG8AFQApABcAEAAqACsALAA6AAMACAAtABEAUAATAFEALAA6AAMACAAwABEAUgATAFMADAAxAAsADQAOAA8AEAAhADgAEQClACYAOgA7ADwAawBsABMA'
..'pgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKcAJgA6ADsAPABrAGwAEwCoAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAqQAmADoAOwA8AGsAbAATAKoAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCrACYAOgA7ADwAawBsABMA'
..'rABuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAK0AJgA6ADsAPABrAGwAEwCuAG4AbwAVAEEAFwAQAAwAMQAIAA0ADgAPABAAEQCvAGsAbAATALAAbgBvABUAYAAXABAADAAxAAsADQAOAA8AEAAhADgAEQCxACYAOgA7ADwAawBsABMAsgBuAG8AFQBBABcA'
..'EAAMADEACwANAA4ADwAQACEAOAARALMAJgA6ADsAPABrAGwAEwC0AG4AbwAVAEEAFwAQAAEABQACAAgAtQACALYADABFAAsADQAOAA8AEAAhAGcAEQC3ACYAaQA7AGoAawBsABMAuABuAG8AFQC5ABcAEAAMAEUACAANAA4ADwAQABEAugBrAGwAEwC7AG4AbwAVAHMA'
..'FwAQAAwARQAIAA0ADgAPABAAEQC8AGsAbAATAL0AbgBvABUAcwAXABAADABFAAgADQAOAA8AEAARAL4AawBsABMAvwBuAG8AFQB4ABcAEAAMAEUACAANAA4ADwAQABEAwABrAGwAEwDBAG4AbwAVAMIAFwAQAAwARQAIAA0ADgAPABAAEQDDAGsAbAATAMQAbgBvABUA'
..'xQAXABAADABFAAgADQAOAA8AEAARAMYAawBsABMAxwBuAG8AFQB9ABcAEAAMAEUACAANAA4ADwAQABEAyABrAGwAEwDJAG4AbwAVAIIAFwAQAAwARQAIAA0ADgAPABAAEQDKAGsAbAATAMsAbgBvABUAzAAXABAADABFAAgADQAOAA8AEAARAM0AawBsABMAzgBuAG8A'
..'FQCCABcAEAAMAEUACAANAA4ADwAQABEAzwBrAGwAEwDQAG4AbwAVAH0AFwAQAAwARQANAAgAIAANAA4ADwAQACEAIgARANEAJAAlACYAJwBrAGwAEwDSAG4AbwAVACkAFwAQACoAKwAsAFEABAAIAC0AEQCLAGsAjAATAI0ALABRAAMACACOABEAjwATAJAAAQAFAAIA'
..'CADTAAIA1AAMAFQACwANAA4ADwAQACEAZwARANUAJgBpADsAagBrAGwAEwDWAG4AbwAVALkAFwAQAAwAVAAIAA0ADgAPABAAEQDXAGsAbAATANgAbgBvABUAcwAXABAADABUAAgADQAOAA8AEAARANkAawBsABMA2gBuAG8AFQBzABcAEAAMAFQACAANAA4ADwAQABEA'
..'2wBrAGwAEwDcAG4AbwAVAHgAFwAQAAwAVAAIAA0ADgAPABAAEQDdAGsAbAATAN4AbgBvABUAwgAXABAADABUAA0ACAAgAA0ADgAPABAAIQAiABEA3wAkACUAJgAnAGsAbAATAOAAbgBvABUAKQAXABAAKgArACwAWgAEAAgALQARAIsAawCMABMAjQAsAFoAAwAIAI4A'
..'EQCPABMAkAABAFQAAQACAOEADABdAAgADQAOAA8AEAARAOIAawBsABMA4wBuAG8AFQB9ABcAEAAMAF0ACAANAA4ADwAQABEA5ABrAGwAEwDlAG4AbwAVAMwAFwAQAAwAXQAIAA0ADgAPABAAEQDmAGsAbAATAOcAbgBvABUAggAXABAAAQBUAAEAAgDoAAwAYQAIAA0A'
..'DgAPABAAEQDpAGsAbAATAOoAbgBvABUAxQAXABAADABhAAgADQAOAA8AEAARAOsAawBsABMA7ABuAG8AFQCCABcAEAAMAGEACAANAA4ADwAQABEA7QBrAGwAEwDuAG4AbwAVAH0AFwAQAAEABQACAAgA7wACAPAADABlAAgADQAOAA8AEAARAPEAawBsABMA8gBuAPMA'
..'FQD0ABcAEAAMAGUACwAIACAADQAOAA8AEAAhACIAEQD1ACQAJQAmACcAEwD2ABUAKQAXABAAKgArACwAZwADAAgALQARAPcAEwD4ACwAZwADAAgAjgARAPkAEwD6AAwAZQAIAA0ADgAPABAAEQD7AGsAbAATAPwAbgDzABUA/QAXABAADABlAAgADQAOAA8AEAARAP4A'
..'awBsABMA/wBuAPMAFQAAARcAEAAMAGUACAANAA4ADwAQABEAAQFrAGwAEwACAW4A8wAVAAMBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEABAEmADoAOwA8AGsAbAATAAUBbgBvABUABgEXABAADABlAAgADQAOAA8AEAARAAcBawBsABMACAFuAPMAFQAJARcAEAAMAGUA'
..'CAANAA4ADwAQABEACgFrAGwAEwALAW4A8wAVAAkBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEADAEmADoAOwA8AGsAbAATAA0BbgDzABUADgEXABAADABlAAsADQAOAA8AEAAhADgAEQAPASYAOgA7ADwAawBsABMAEAFuAPMAFQARARcAEAAMAGUACAANAA4ADwAQABEA'
..'EgFrAGwAEwATAW4A8wAVABQBFwAQAAwAZQAIAA0ADgAPABAAEQAVAWsAbAATABYBbgDzABUAFAEXABAADABlAAgADQAOAA8AEAARABcBawBsABMAGAFuAPMAFQAZARcAEAAaAUACAAwAIgEjAWwAAAwAJAElAWwAZQAKAA0ADgAhABsBEQAcASYAHQE7AB4BawBsABMA'
..'HwFuAPMAFQAgASEBDgAaAUACAAwAKQEqAWwAAAwAKwEsAWwAZQAKAA0ADgAhABsBEQAmASYAHQE7AB4BawBsABMAJwFuAPMAFQAoASEBDgAMAGUACwANAA4ADwAQACEAOAARAC0BJgA6ADsAPABrAGwAEwAuAW4A8wAVAC8BFwAQAAwAZQALAA0ADgAPABAAIQA4ABEA'
..'MAEmADoAOwA8AGsAbAATADEBbgDzABUAMgEXABAADABlAAsADQAOAA8AEAAhADgAEQAzASYAOgA7ADwAawBsABMANAFuAPMAFQA1ARcAEAAMAGUACwANAA4ADwAQACEAOAARADYBJgA6ADsAPABrAGwAEwA3AW4A8wAVADgBFwAQAAwAZQAIAA0ADgAPABAAEQA5AWsA'
..'bAATADoBbgDzABUAOwEXABAAGgFAAwAMAD8BQAFsAAAMAEEBQgFsAAAMAEMBRAFsAGUACgANAA4AIQBnABEAPAEmAGkAOwBqAGsAbAATAD0BbgDzABUAPgEhAQ4ADABlAAgADQAOAA8AEAARAEUBawBsABMARgFuAPMAFQBHARcAEAAMAGUACAANAA4ADwAQABEASAFr'
..'AGwAEwBJAW4A8wAVAEoBFwAQAAwAZQAIAA0ADgAPABAAEQBLAWsAbAATAEwBbgDzABUATQEXABAADABlAAgADQAOAA8AEAARAE4BawBsABMATwFuAPMAFQBKARcAEAABAGUAAQACAFABAQCBAAEAAgBRAQwAggAMAA0ADgAPABAAIQBSAREAUwEmAFQBOwBVAWsAbAAT'
..'AFYBbgBvABUAVwEXABAAWAFZAQwAggALAA0ADgAPABAAIQBSAREAWgEmAFQBOwBVAWsAWwETAFwBbgBdARUAXgEXABAADACCAAwADQAOAA8AEAAhAFIBEQBfASYAVAE7AFUBawBsABMAYAFuAG8AFQBXARcAEABYAVkBDACCAAwADQAOAA8AEAAhAGEBEQBiASYAYwE7'
..'AGQBawBsABMAZQFuAG8AFQBmARcAEABYAVkBZwGGAAIAJgBjAWgBEAAMAIIACwANAA4ADwAQACEAYQERAGkBJgBjATsAZAFrAFsBEwBqAW4AXQEVAGsBFwAQAGcBiAACACYAYwFoARAADACCAAwADQAOAA8AEAAhAGEBEQBTASYAYwE7AGQBawBsABMAVgFuAG8AFQBm'
..'ARcAEABYAVkBZwGKAAIAJgBjAWgBEAAMAIEABgANAA4ADwAQABEAbAETAG0BFQBuARcAEAAMAIEABgANAA4ADwAQABEAbwETAHABFQBxARcAEAAMAIEABgANAA4ADwAQABEAcgETAHMBFQBuARcAEAABAIEAAQACAHQBDACPAAoADQAOAA8AEAAhAFIBEQB1ASYAVAE7'
..'AFUBEwB2ARUAVwEXABAAWAFZAQwAjwALAA0ADgAPABAAIQBSAREAdwEmAFQBOwBVAWsAeAETAHkBbgB4ARUAXgEXABAADACPAAoADQAOAA8AEAAhAFIBEQB6ASYAVAE7AFUBEwB7ARUAVwEXABAAWAFZAQwAjwAKAA0ADgAPABAAIQBhAREAfAEmAGMBOwBkARMAfQEV'
..'AGYBFwAQAFgBWQFnAZMAAgAmAGMBaAEQAAwAjwALAA0ADgAPABAAIQBhAREAfgEmAGMBOwBkAWsAeAETAH8BbgB4ARUAawEXABAAZwGVAAIAJgBjAWgBEAAMAI8ACgANAA4ADwAQACEAYQERAHUBJgBjATsAZAETAHYBFQBmARcAEABYAVkBZwGXAAIAJgBjAWgBEAAB'
..'AGUAAgAIAIABAgCBAQEAmQABAAIAggEMAJoADAANAA4ADwAQACEAUgERAIMBJgBUATsAVQFrAGwAEwCEAW4AbwAVAFcBFwAQAFgBWQEMAJoACwANAA4ADwAQACEAUgERAIUBJgBUATsAVQFrAFsBEwCGAW4AXQEVAF4BFwAQAAwAmgAMAA0ADgAPABAAIQBSAREAhwEm'
..'AFQBOwBVAWsAbAATAIgBbgBvABUAVwEXABAAWAFZAQwAmgAMAA0ADgAPABAAIQBhAREAiQEmAGMBOwBkAWsAbAATAIoBbgBvABUAZgEXABAAWAFZAWcBngACACYAYwFoARAADACaAAsADQAOAA8AEAAhAGEBEQCLASYAYwE7AGQBawBbARMAjAFuAF0BFQBrARcAEABn'
..'AaAAAgAmAGMBaAEQAAwAmgAMAA0ADgAPABAAIQBhAREAgwEmAGMBOwBkAWsAbAATAIQBbgBvABUAZgEXABAAWAFZAWcBogACACYAYwFoARAADACZAAYADQAOAA8AEAARAI0BEwCOARUAbgEXABAADACZAAYADQAOAA8AEAARAI8BEwCQARUAcQEXABAADACZAAYADQAO'
..'AA8AEAARAJEBEwCSARUAbgEXABAAAQCZAAEAAgCTAQwApwAKAA0ADgAPABAAIQBSAREAlAEmAFQBOwBVARMAlQEVAFcBFwAQAFgBWQEMAKcACwANAA4ADwAQACEAUgERAJYBJgBUATsAVQFrAHgBEwCXAW4AeAEVAF4BFwAQAAwApwAKAA0ADgAPABAAIQBSAREAmAEm'
..'AFQBOwBVARMAmQEVAFcBFwAQAFgBWQEMAKcACgANAA4ADwAQACEAYQERAJoBJgBjATsAZAETAJsBFQBmARcAEABYAVkBZwGrAAIAJgBjAWgBEAAMAKcACwANAA4ADwAQACEAYQERAJwBJgBjATsAZAFrAHgBEwCdAW4AeAEVAGsBFwAQAGcBrQACACYAYwFoARAADACn'
..'AAoADQAOAA8AEAAhAGEBEQCUASYAYwE7AGQBEwCVARUAZgEXABAAWAFZAWcBrwACACYAYwFoARAADACZAAcACACeAQ0ADgAPABAAEQCfARMAoAEVAKEBFwAQAKIBsQAFAKMBKwCkAQ4ApQErAKYBpwGoASsAqQGyAAMAqgGrAawBKwAVAK0BrgGzAAYAqgGrAawBKwAV'
..'AK0BrwGwAbEBsgGzAacBAQBlAAEAAgC0AQEAtQABAAIAtQEMALYADAANAA4ADwAQACEAUgERALYBJgBUATsAVQFrAGwAEwC3AW4AbwAVAFcBFwAQAFgBWQEMALYACwANAA4ADwAQACEAUgERALgBJgBUATsAVQFrAFsBEwC5AW4AXQEVAF4BFwAQAAwAtgAMAA0ADgAP'
..'ABAAIQBSAREAugEmAFQBOwBVAWsAbAATALsBbgBvABUAVwEXABAAWAFZAQwAtgAMAA0ADgAPABAAIQBhAREAvAEmAGMBOwBkAWsAbAATAL0BbgBvABUAZgEXABAAWAFZAWcBugACACYAYwFoARAADAC2AAsADQAOAA8AEAAhAGEBEQC+ASYAYwE7AGQBawBbARMAvwFu'
..'AF0BFQBrARcAEABnAbwAAgAmAGMBaAEQAAwAtgAMAA0ADgAPABAAIQBhAREAtgEmAGMBOwBkAWsAbAATALcBbgBvABUAZgEXABAAWAFZAWcBvgACACYAYwFoARAADAC1AAYADQAOAA8AEAARAMABEwDBARUAbgEXABAADAC1AAYADQAOAA8AEAARAMIBEwDDARUAcQEX'
..'ABAADAC1AAYADQAOAA8AEAARAMQBEwDFARUAbgEXABAAAQC1AAEAAgDGAQwAwwAKAA0ADgAPABAAIQBSAREAxwEmAFQBOwBVARMAyAEVAFcBFwAQAFgBWQEMAMMACwANAA4ADwAQACEAUgERAMkBJgBUATsAVQFrAHgBEwDKAW4AeAEVAF4BFwAQAAwAwwAKAA0ADgAP'
..'ABAAIQBSAREAywEmAFQBOwBVARMAzAEVAFcBFwAQAFgBWQEMAMMACgANAA4ADwAQACEAYQERAM0BJgBjATsAZAETAM4BFQBmARcAEABYAVkBZwHHAAIAJgBjAWgBEAAMAMMACwANAA4ADwAQACEAYQERAM8BJgBjATsAZAFrAHgBEwDQAW4AeAEVAGsBFwAQAGcByQAC'
..'ACYAYwFoARAADADDAAoADQAOAA8AEAAhAGEBEQDHASYAYwE7AGQBEwDIARUAZgEXABAAWAFZAWcBywACACYAYwFoARAAAQBlAAEAAgDRAQEAzQABAAIA0gEMAM4ADAANAA4ADwAQACEAUgERANMBJgBUATsAVQFrAGwAEwDUAW4AbwAVAFcBFwAQAFgBWQEMAM4ACwAN'
..'AA4ADwAQACEAUgERANUBJgBUATsAVQFrAFsBEwDWAW4AXQEVAF4BFwAQAAwAzgAMAA0ADgAPABAAIQBSAREA1wEmAFQBOwBVAWsAbAATANgBbgBvABUAVwEXABAAWAFZAQwAzgAMAA0ADgAPABAAIQBhAREA2QEmAGMBOwBkAWsAbAATANoBbgBvABUAZgEXABAAWAFZ'
..'AWcB0gACACYAYwFoARAADADOAAsADQAOAA8AEAAhAGEBEQDbASYAYwE7AGQBawBbARMA3AFuAF0BFQBrARcAEABnAdQAAgAmAGMBaAEQAAwAzgAMAA0ADgAPABAAIQBhAREA0wEmAGMBOwBkAWsAbAATANQBbgBvABUAZgEXABAAWAFZAWcB1gACACYAYwFoARAADADN'
..'AAYADQAOAA8AEAARAN0BEwDeARUAbgEXABAADADNAAYADQAOAA8AEAARAN8BEwDgARUAcQEXABAADADNAAYADQAOAA8AEAARAOEBEwDiARUAbgEXABAAAQDNAAEAAgDjAQwA2wAKAA0ADgAPABAAIQBSAREA5AEmAFQBOwBVARMA5QEVAFcBFwAQAFgBWQEMANsACwAN'
..'AA4ADwAQACEAUgERAOYBJgBUATsAVQFrAHgBEwDnAW4AeAEVAF4BFwAQAAwA2wAKAA0ADgAPABAAIQBSAREA6AEmAFQBOwBVARMA6QEVAFcBFwAQAFgBWQEMANsACgANAA4ADwAQACEAYQERAOoBJgBjATsAZAETAOsBFQBmARcAEABYAVkBZwHfAAIAJgBjAWgBEAAM'
..'ANsACwANAA4ADwAQACEAYQERAOwBJgBjATsAZAFrAHgBEwDtAW4AeAEVAGsBFwAQAGcB4QACACYAYwFoARAADADbAAoADQAOAA8AEAAhAGEBEQDkASYAYwE7AGQBEwDlARUAZgEXABAAWAFZAWcB4wACACYAYwFoARAAAQBlAAEAAgDuAQEA5QABAAIA7wEMAOYADAAN'
..'AA4ADwAQACEAUgERAPABJgBUATsAVQFrAGwAEwDxAW4AbwAVAFcBFwAQAFgBWQEMAOYACwANAA4ADwAQACEAUgERAPIBJgBUATsAVQFrAFsBEwDzAW4AXQEVAF4BFwAQAAwA5gAMAA0ADgAPABAAIQBSAREA9AEmAFQBOwBVAWsAbAATAPUBbgBvABUAVwEXABAAWAFZ'
..'AQwA5gAMAA0ADgAPABAAIQBhAREA9gEmAGMBOwBkAWsAbAATAPcBbgBvABUAZgEXABAAWAFZAWcB6gACACYAYwFoARAADADmAAsADQAOAA8AEAAhAGEBEQD4ASYAYwE7AGQBawBbARMA+QFuAF0BFQBrARcAEABnAewAAgAmAGMBaAEQAAwA5gAMAA0ADgAPABAAIQBh'
..'AREA8AEmAGMBOwBkAWsAbAATAPEBbgBvABUAZgEXABAAWAFZAWcB7gACACYAYwFoARAADADlAAYADQAOAA8AEAARAPoBEwD7ARUAbgEXABAADADlAAYADQAOAA8AEAARAPwBEwD9ARUAcQEXABAADADlAAYADQAOAA8AEAARAP4BEwD/ARUAbgEXABAAAQDlAAEAAgAA'
..'AgwA8wAKAA0ADgAPABAAIQBSAREAAQImAFQBOwBVARMAAgIVAFcBFwAQAFgBWQEMAPMACwANAA4ADwAQACEAUgERAAMCJgBUATsAVQFrAHgBEwAEAm4AeAEVAF4BFwAQAAwA8wAKAA0ADgAPABAAIQBSAREABQImAFQBOwBVARMABgIVAFcBFwAQAFgBWQEMAPMACgAN'
..'AA4ADwAQACEAYQERAAcCJgBjATsAZAETAAgCFQBmARcAEABYAVkBZwH3AAIAJgBjAWgBEAAMAPMACwANAA4ADwAQACEAYQERAAkCJgBjATsAZAFrAHgBEwAKAm4AeAEVAGsBFwAQAGcB+QACACYAYwFoARAADADzAAoADQAOAA8AEAAhAGEBEQABAiYAYwE7AGQBEwAC'
..'AhUAZgEXABAAWAFZAWcB+wACACYAYwFoARAAAQBlAAEAAgALAgEA/QABAAIADAIMAP4ADAANAA4ADwAQACEAUgERAA0CJgBUATsAVQFrAGwAEwAOAm4AbwAVAFcBFwAQAFgBWQEMAP4ACwANAA4ADwAQACEAUgERAA8CJgBUATsAVQFrAFsBEwAQAm4AXQEVAF4BFwAQ'
..'AAwA/gAMAA0ADgAPABAAIQBSAREAEQImAFQBOwBVAWsAbAATABICbgBvABUAVwEXABAAWAFZAQwA/gAMAA0ADgAPABAAIQBhAREAEwImAGMBOwBkAWsAbAATABQCbgBvABUAZgEXABAAWAFZAWcBAgECACYAYwFoARAADAD+AAsADQAOAA8AEAAhAGEBEQAVAiYAYwE7'
..'AGQBawBbARMAFgJuAF0BFQBrARcAEABnAQQBAgAmAGMBaAEQAAwA/gAMAA0ADgAPABAAIQBhAREADQImAGMBOwBkAWsAbAATAA4CbgBvABUAZgEXABAAWAFZAWcBBgECACYAYwFoARAADAD9AAYADQAOAA8AEAARABcCEwAYAhUAbgEXABAADAD9AAYADQAOAA8AEAAR'
..'ABkCEwAaAhUAcQEXABAADAD9AAYADQAOAA8AEAARABsCEwAcAhUAbgEXABAAAQD9AAEAAgAdAgwACwEKAA0ADgAPABAAIQBSAREAHgImAFQBOwBVARMAHwIVAFcBFwAQAFgBWQEMAAsBCwANAA4ADwAQACEAUgERACACJgBUATsAVQFrAHgBEwAhAm4AeAEVAF4BFwAQ'
..'AAwACwEKAA0ADgAPABAAIQBSAREAIgImAFQBOwBVARMAIwIVAFcBFwAQAFgBWQEMAAsBCgANAA4ADwAQACEAYQERACQCJgBjATsAZAETACUCFQBmARcAEABYAVkBZwEPAQIAJgBjAWgBEAAMAAsBCwANAA4ADwAQACEAYQERACYCJgBjATsAZAFrAHgBEwAnAm4AeAEV'
..'AGsBFwAQAGcBEQECACYAYwFoARAADAALAQoADQAOAA8AEAAhAGEBEQAeAiYAYwE7AGQBEwAfAhUAZgEXABAAWAFZAWcBEwECACYAYwFoARAAKAIFAAAAAQAFAAIACAApAgIAKgIMABYBCgAIACkCDQAOAA8AEAAhACsCEQAsAiYALQI7ADwAEwAuAhUALwIXABAAogEX'
..'AQUAowErAKQBDgBoAVkBpQErAKgBKwCpARgBBACqAasBrAErABMAMAIVADECrgEZAQgAqgGrAawBKwAVAK0BrwGwATICqwEzAjQCsQGrAbMBNQIMABYBDAAIADYCDQAOAA8AEAAhADcCEQA4AiQAJQAmADkCOwAeARMAOgIVADsCFwAQACoAKwAMABYBCAANAA4ADwAQ'
..'ACEAIgARADwCJgAnABMAPQIVAD4CFwAQAAwAFgEIAA0ADgAPABAAIQAiABEAPwImACcAEwBAAhUAQQIXABAADAAWAQgADQAOAA8AEAAhACIAEQBCAiYAJwATAEMCFQBEAhcAEAAMABYBCQAIAEUCDQAOAA8AEAAhACIAEQBGAiYAJwATAEcCFQBIAhcAEABJAh8BAQBK'
..'AksCTAIWAQEACABNAgEABQACAAgATgICAE8CDAAiAQYADQAOAA8AEAARAFACEwBRAhUAUgIXABAADAAiAQYADQAOAA8AEAARAFMCEwBUAhUAVQIXABAADAAiAQYADQAOAA8AEAARAFYCEwBXAhUAVQIXABAADAAiAQYADQAOAA8AEAARAFgCEwBZAhUAWgIXABAADAAi'
..'AQYADQAOAA8AEAARAFsCEwBcAhUAXQIXABAADAAiAQYADQAOAA8AEAARAF4CEwBfAhUAYAIXABAADAAiAQYADQAOAA8AEAARAGECEwBiAhUAYAIXABAADAAiAQYADQAOAA8AEAARAGMCEwBkAhUAZQIXABAADAAiAQYADQAOAA8AEAARAGYCEwBnAhUAaAIXABAADAAi'
..'AQYADQAOAA8AEAARAGkCEwBqAhUAawIXABAADAAiAQYADQAOAA8AEAARAGwCEwBtAhUAbgIXABAADAAiAQYADQAOAA8AEAARAG8CEwBwAhUAcQIXABAADAAiAQsACAAgAA0ADgAPABAAIQAiABEAcgIkACUAJgAnABMAcwIVACkAFwAQACoAKwAsAC8BAwAIAC0AEQAu'
..'ABMALwAsAC8BAwAIADAAEQAxABMAMgAMACIBBgANAA4ADwAQABEAdAITAHUCFQB2AhcAEAAMACIBBgANAA4ADwAQABEAdwITAHgCFQB5AhcAEAAMACIBBgANAA4ADwAQABEAegITAHsCFQB8AhcAEAAMACIBBgANAA4ADwAQABEAfQITAH4CFQB/AhcAEAAMACIBCAAN'
..'AA4ADwAQABEAgAI7AIECEwCCAhUAgwIXABAAKgCEAgwAIgEGAA0ADgAPABAAEQCFAhMAhgIVAIcCFwAQAAwAIgEIAA0ADgAPABAAEQCIAjsAgQITAIkCFQCKAhcAEAAqAIQCDAAiAQoACACLAg0ADgAhAIwCEQCNAiYAjgI7AI8CawCQAhMAkQJuAJICFQCTApQCOQEC'
..'AJUClgKXApgClAI5AQIAlQKaApcCmwJJAjkBAwAIAJwCnQKnAUoCngJJAjkBAwAIAJ8CnQKnAUoCoAJJAjkBBAAIAKECnQKnAUoCogKjAqQCSQI5AQUACAClAqYCpwKdAqcBSgKiAqMCpAIMACIBBgANAA4ADwAQABEAqAITAKkCFQCqAhcAEAAMACIBBQAPABAAEQCr'
..'AhMArAIVAK0CFwAQAAwAIgEIAA0ADgAPABAAEQCuAjsAgQITAK8CFQCwAhcAEAAqAIQCDAAiAQcADQAOABEAsQI7AFUBawCyAhMAswJuAJACFQC0AgwAIgEFAA8AEAARALUCEwC2AhUAtwIXABAADAAiAQ0ACAC4Ag0ADgAPAFkBIQC5AhEAugImALsCOwBVAWsAsgIT'
..'ALwCvQK+Am4AkAIVAL8CFwBZAQwAIgEFAA8AEAARAMACEwDBAhUAwgIXABAADAAiAQsACABFAg0ADgAPABAAIQAiABEAwwImACcAawDEAhMAxQJuAMQCFQBIAhcAEABJAkcBAQBKAksCDAAiAQoADQAOAA8AEAAhACIAEQDGAiYAJwBrAMQCEwDHAm4AxAIVAD4CFwAQ'
..'AAwAIgEKAA0ADgAPABAAIQAiABEAyAImACcAawDEAhMAyQJuAMQCFQBBAhcAEAAMACIBCgANAA4ADwAQACEAIgARAMoCJgAnAGsAxAITAMsCbgDEAhUARAIXABAAAQAiAQIACACpAQIAzAIMAEwBDQANAA4AzQLOAg8AEAARAM8C0ALOAtECzgI7AI8CawDSAhMA0wLU'
..'As4CbgDSAhUA1QIXABAADABMAQ0ADQAOAM0CzgIPABAAEQDWAtACzgLRAs4COwCPAmsA1wITANgC1ALOAm4A8wAVANkCFwDOApQCTgECAJUC2gKXAtsCDABMAQ0ADQAOAM0CzgIPABAAEQDcAtACzgLRAs4COwCPAmsA1wITAN0C1ALOAm4A8wAVAN4CFwDOApQCUAEC'
..'AJUC3wKXAuAClAJQAQIAlQLiApcC4wKUAlABAgCVAtoClwLkAgwATAENAA0ADgDNAs4CDwAQABEA5QLQAs4C0QLOAjsAjwJrANcCEwDmAtQCzgJuAPMAFQDnAhcAzgKUAlQBAgCVAt8ClwLoApQCVAECAJUC2gKXAukC6gJMAQ0ADQAOAM0CzgIPAM4CEQDrAtACzgLR'
..'As4COwCPAmsA7AITAO0C1ALOAm4A7gIVAO8CFwDOAvACVwECAPEC8gLzAlkB6gJMAQ0ADQAOAM0CzgIPAM4CEQD0AtACzgLRAs4COwCPAmsA9QITAPYC1ALOAm4A9wIVAPgCFwDOAvACWQECAPEC+QLzAlkBDABMAQkADQAOAA8AEAARAPoCOwCPAmsA+wITAPwCbgD7'
..'AhUA/QIXABAA6gJMAQ0ADQAOAM0CzgIPAM4CEQD+AtACzgLRAs4COwCPAmsA/wITAAAD1ALOAm4AAQMVAAIDFwDOAvACXAECAPECAwPzAlkB6gJMAQ0ADQAOAM0CzgIPAM4CEQAEA9ACzgLRAs4COwCPAmsABQMTAAYD1ALOAm4ABwMVAAgDFwDOAvACXgECAPECCQPz'
..'AlkBDABMAQkADQAOAA8AEAARAAoDOwCPAmsACwMTAAwDbgALAxUADQMXABAADAAiAQ4ACAAOAw0ADgAPAFkBIQC5AhEADwMkACUAJgC7AjsAHgFrALICEwAQA70CvgJuAJACFQARAxcAWQEoAgQAAQAIABIDAQAEAAIACAATAwIAFAMMAGMBCgAIACkCDQAOAA8AEAAh'
..'ACsCEQAVAyYALQI7ADwAEwAWAxUALwIXABAAogFkAQUAowErAKQBDgBoAVkBpQErAKgBKwCpAWUBBACqAasBrAErABMAMAIVADECrgFmAQgAqgGrAawBKwAVAK0BrwGwATICqwEzAhcDsQGrAbMBNQIMAGMBDAAIADYCDQAOAA8AEAAhADcCEQAYAyQAJQAmADkCOwAe'
..'ARMAGQMVADsCFwAQACoAKwAoAmgBAABMAmkBAgAIAE0CGgMrAAwAYwEIAA0ADgAPABAAIQAiABEAGwMmACcAEwAcAxUAPgIXABAADABjAQgADQAOAA8AEAAhACIAEQAdAyYAJwATAB4DFQBBAhcAEAAMAGMBCAANAA4ADwAQACEAIgARAB8DJgAnABMAIAMVAEQCFwAQ'
..'AAwAYwEJAAgARQINAA4ADwAQACEAIgARACEDJgAnABMAIgMVAEgCFwAQAEkCbgEBAEoCSwJMAgQAAQAIACMDBwADAAEACAAkAyUDcQEBAAgAJgMlA3EBAQAIACcDDAABAAkADQAOAA8AEAAhAGcAEQAoAyYAaQA7AB4BEwApAxUAKgMXABAADAABAAoADQAOAA8AEAAh'
..'AGcAEQArAyQAJQAmAGkAOwAeARMALAMVAC0DFwAQAC4DdQECAC8DMAMxAyUAKAJ1AQAACjoBmQI5ATsBmQI5AU8BmQJOAVEB4QJNAVEBmQJQAVIBmQJQAVMBmQJQAVUB4QJNAVUBmQJUAVYBmQJUAQ==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
