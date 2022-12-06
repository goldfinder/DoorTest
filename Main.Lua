-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 31120 characters

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
	plr.Character:PivotTo(CFrame.new(69.061, 121.517, -1094.013))
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


local Objects = Decode('AFC4AyEFTW9kZWwhCldvcmxkUGl2b3QEYQNiA2MDBGQDYgNjAwRlA2IDYwMEZgNiA2MDIQZGb2xkZXIhBE5hbWUhBkFzc2V0cyEIU3RyYWlnaHQEZwNiA2MDIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQUAGIDYwMhCFBvc2l0aW9'
..'uCg//rUOx6v1C98CLxCEEU2l6ZQrGQeZAQLbiPp3DY0EhClRvcFN1cmZhY2UEGQBiA2MDCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEHABiA2MDCsXOr0OPM/VC98CLxAQeAGIDYwMKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQhCkJyaWNrQ29sb3IH6gMEKA'
..'BiA2MDIQpDYW5Db2xsaWRlAiEFQ29sb3IGzc3NCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhDFRyYW5zcGFyZW5jeQMAAAAAAADwPyEKQXR0YWNobWVudCEDRW5kBC8AYgNjAwoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwQyAGIDYwMKAAAAAAAAAACPwuNAIQJVcARoA2IDY'
..'wMENgBiA2MDCpVfkEMOIgpDZL+MxAo2E+lAYDksP6iy6kEHbQEEPQBpA2MDBmo5CSEITWF0ZXJpYWwDAAAAAAAAgEAKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QARAAGkDYwMKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwRDAGkDYwMKlWaQQw6v/UJhXo3EBEUAaQNjAwqV'
..'ZpBDDq//QseEjcQERwBiA2MDCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEESgBiA2MDCm2gjkM2LwBDOruMxARMAGIDYwMKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgRPAGIDYwMK1WCQQ0ovAENkv4zEBFEAYgNjAwoAOjS9AACsQKRwZ8EEUwBiA2MDCgAAVTw3ibXAMLJ'
..'jQQRVAGkDYwMKlWaQQw6v90Iu64zEBFcAaQNjAwqVZpBDDq/5QpQRjcQEWQBpA2MDCpVmkEMOr/FC+neMxARbAGkDYwMKlWaQQw+v80JhnozEBF0AaQNjAwqVZpBDDq/1QsfEjMQEXwBiA2MDCi9lkEOzPexCOruMxArGQeZAQLbiPoid6EEEYgBqA2MDCpVmkEMOr+1CLiuMxA'
..'RkAGkDYwMKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBGsDbANjAwdrAARtAG0DbgMGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAAAAAANEMKPibWQUC24j6InehBBHIAbQNuAwr/DZlDHSn5QvW5j'
..'sQKgI6DPhiZUkGInehBBHUAbQNuAwoLXqZDHSn5QvW5jsQEdwBtA24DCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EegBtA24DCr+un0NU/AJD9bmOxAR8AG0DbgMKf/ejQx0p+ULDhpDECvy/HUEYmVJBEqmNPgR/AG0DbgMKMXObQx0p+ULDhpDEBIEAbQNuAwrXgZ1DhiYB'
..'Q8OGkMQKqrSQQXC0gEASqY0+BIQAbQNuAwoxc5tDHSn5QhvrjMQEhgBtA24DCteBnUOGJgFDG+uMxASIAG0DbgMKf/ejQx0p+UIb64zEBIoAbQNuAwoFtp9D+yj5QvW5jsQEjQBvA2MDCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEkABiA2MDCgDAVDzByvG/FK5pwSE'
..'ERG93bgRwA2IDYwMElABtA24DCjPBikN+XwpDb7aMxASWAG0DbgMKM7qKQ/cUAUMfYYvEBJgAbQNuAwozuopD7in8Qtk9jMQEmgBtA24DCjO6ikPuKf5CcheMxAScAG0DbgMKM7qKQ/cUAEMM8YvEBJ4AbQNuAwpp/ohDpmwAQ5m6jMQEoABtA24DClmAjEOmbABDmbqMxASiAG'
..'0DbgMKM8GKQ13sBEO+ho7EBKQAbQNuAwrzv4pDumwAQ2+2jMQEpgBtA24DCjO6ikPuKfhCpYqMxASoAG0DbgMKM7qKQ+4p+kI/ZIzEBKoAbQNuAwozuopD7inyQtn9jMQErABtA24DCjO6ikPvKfRCcteMxASuAG0DbgMKM7qKQ+4p9kIMsYzEBLAAbQNuAwqZu4pDk7jsQpm6j'
..'MQEsgBtA24DCjO6ikPuKe5CpUqNxAS0AG0DbgMKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBHEDYgNjAwS4AG0DbgMKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3oQQS7AG0DbgMKIqI/Q1Fc+ULgG5HEBL0AbQNuAwpVEIRDUVz5QuAbkcQEvwBtA24DChLCekMXpOxCwU2PxATB'
..'AG0DbgMKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQTEAG0DbgMKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgTHAG0DbgMK0o1EQ1Fc+UKv6JLEBMkAbQNuAwoeq0hDIEABQ6/oksQEywBtA24DChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EzgBtA24DCkJodkMgQAFDBk2'
..'PxATQAG0DbgMKyamBQ1Fc+UIGTY/EBNIAbQNuAwpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEcgNiA2MDBNYAbQNuAwoycWRD9qvsQtY0jMQE2ABtA24DCro/QEMwZPlC1jSMxATaAG0DbgMKH1+EQzBk+ULWNIzEBNwAbQNuAwqqX3tD9qvsQrdmisQE3gBtA24DCs5mZEPcGQ'
..'ND1jSMxATgAG0DbgMK4olkQ9Jv+ULQM4zEBHMDdANjAwTjAG0DbgMKfwyCQ2Bk+UKjAY7EBOUAbQNuAwqKMFxDYGT5QqMBjsQE5wBtA24DCq4td0MoRAFDowGOxAR1A3QDYwME6gBtA24DChLubENsavlC/WWKxATsAG0DbgMKyiBJQy1HAUP9ZYrEBO4AbQNuAwp6A0VDbGr5Q'
..'v1lisQhA0xJQgR2A3cDYwME8gB4A3kDCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BPYAegNjAwp5k6RDfj8DQ17PfMQE+ABiA2MDCgAAAAAGgeW/4vqvQgT6AGIDYwMKAAAAAPp+8sBf5a/CBPwAeAN5Awq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+'
..'BP8AeAN5Awp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBAIBeAN5Awp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+BAUBbQNuAwrHi6RD5VDtQojKfMQKAEDmQgAAgD8AADBDBAgBeAN5AwrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBAsBeAN5Awp3k4dDfj8DQyLLfMQEDQF'
..'4A3kDCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8EEAF4A3kDCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDvfz8EEwF4A3kDCk23j0PnUPZCnm9wxAoAAIA/AAAAQfj9n0AEFgF4A3kDCk03mkPnUPZCnm9wxAQYAXgDeQMKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb2'
..'5PcGVyYXRpb24HwgAEHwF4A3kDBqOipQMAAAAAAMCYQAr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HAd5RAIQxVc2VQYXJ0Q29sb3IKrkfhPj0Kw0GmRZFACk83mkMYWQNDOXlwxAq4Hp1CPQrDQS4n4T4K+76tQxhZA0Oi72/EBCcBeAN5Awq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd'
..'5RACq5H4T49CsNBYkaRQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQNDoO9vxAQuAXgDeQMKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwQxAXgDeQMKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwQ0AXgDeQMKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwQ3'
..'AXgDeQMKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQAQ6AXgDeQMKtZ2LQ+dQ9kKi72/ECmZmdkEAAABBwO9/PwQ9AXgDeQMKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAQJxCAADAQHBREEIKxcutQ+hQ9EIUTWvECgCAHEIAAMBAcFEEQgrFi5FD6FD0QhTtasQKAACBQQA'
..'AwEBwURBCCsXLi0PoUPRCFE1rxARGAXgDeQMKQ4CkQ5JtC0PayWbECpmZEUFwPTJBAOjWPgRJAXgDeQMKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgRMAXgDeQMKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgRPAXgDeQMK5xCVQ34/A0PayWbEBHsDYgNjAwRqAXcDYwMHxw'
..'AEVgFtA24DBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QKANejPAAAgD+ZmRk/IQVTaGFwZQMAAAAAAAAAQARcAXwDfQMKAAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADRDAAAAAAAAtMIK4XrkQArXozyZmRk/BGABbQNuAwp+SqpDKITwQos2h8QHagAEZQFtA24DBtqFQ'
..'QMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAAgD+4HgU/IQxTdXJmYWNlTGlnaHQhBEZhY2UEagF8A30DCn9KqkP/p/dCizaHxArheuRAj8J1PbgeBT8EbQFiA2MDCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEcAFiA2MDCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAE'
..'cwFiA2MDCsdLnkM9ngNDizaHxAR/AWIDYwMEdgFiA2MDCg/NnkPWy/5CizaHxAR5AX4DfwMKAAAAAAAAAAAAALRCCg/NnkP/p/dCizaHxAR7AWIDYwMKD82eQyiE8EKLNofEBH0BYgNjAwoPzZ5DZY7wQos2h8QEfwF+A38DCg7NnkP/p/dCizaHxCEEQXJjaASAA2IDYwMEjAF'
..'3A2MDBIQBbQNuAwp+SqpD1sv+Qou2hMQEhgF8A30DCn5KqkP/p/dCi7aExASIAW0DbgMKfkqqQyiE8EKLtoTEBIoBbQNuAwp+SqpDZY7wQou2hMQEjAF8A30DCn9KqkP/p/dCi7aExASOAWIDYwMKx8uqQz2eA0OLtoTEBJABYgNjAwrHi6RDeqgGQ4u2hMQEkgFiA2MDCsdLnk'
..'M9ngNDi7aExASdAWIDYwMElQFiA2MDCg/NnkPWy/5Ci7aExASXAX4DfwMKD82eQ/+n90KLtoTEBJkBYgNjAwoPzZ5DKITwQou2hMQEmwFiA2MDCg/NnkNljvBCi7aExASdAX4DfwMKDs2eQ/+n90KLtoTEIQdUZXh0Ym94BKABYgNjAwrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AA'
..'ABAIQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvciEQQ2xpcHNEZXNjZW5kYW50cyEOTGlnaHRJbmZsdWVuY2UhDVBpeGVsc1BlclN0dWQDAAAAAAAAWUAhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwA'
..'AIA/AAAAAIA/AAAhB1RleHRCb3ghBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMGAAAAIQhUZXh0U2l6ZQSBA2IDYwMEvwF3A2MDBLcBbQNuAwp+SqpD1sv+Qos2gsQEuQF8A30DCn5KqkP/p/dCizaCxAS7AW0DbgMKfkqqQyiE8EKLNoLEBL0BbQNuAwp+SqpDZY7wQos2gsQ'
..'EvwF8A30DCn9KqkP/p/dCizaCxATBAWIDYwMKx8uqQz2eA0OLNoLEBMMBYgNjAwrHi6RDeqgGQ4s2gsQExQFiA2MDCsdLnkM9ngNDizaCxATQAWIDYwMEyAFiA2MDCg/NnkPWy/5CizaCxATKAX4DfwMKD82eQ/+n90KLNoLEBMwBYgNjAwoPzZ5DKITwQos2gsQEzgFiA2MDCg'
..'/NnkNljvBCizaCxATQAX4DfwMKDs2eQ/+n90KLNoLEBIIDYgNjAwTcAXcDYwME1AFtA24DCn5KqkPWy/5CFm1/xATWAXwDfQMKfkqqQ/+n90IWbX/EBNgBbQNuAwp+SqpDKITwQhZtf8QE2gFtA24DCn5KqkNljvBCFm1/xATcAXwDfQMKf0qqQ/+n90IWbX/EBN4BYgNjAwrHy'
..'6pDPZ4DQxZtf8QE4AFiA2MDCseLpEN6qAZDFm1/xATiAWIDYwMKx0ueQz2eA0MWbX/EBO0BYgNjAwTlAWIDYwMKD82eQ9bL/kIWbX/EBOcBfgN/AwoPzZ5D/6f3QhZtf8QE6QFiA2MDCg/NnkMohPBCFm1/xATrAWIDYwMKD82eQ2WO8EIWbX/EBO0BfgN/AwoOzZ5D/6f3QhZt'
..'f8QEgwNiA2MDBPkBdwNjAwTxAW0DbgMKfkqqQ9bL/kIWbXrEBPMBfAN9Awp+SqpD/6f3QhZtesQE9QFtA24DCn5KqkMohPBCFm16xAT3AW0DbgMKfkqqQ2WO8EIWbXrEBPkBfAN9Awp/SqpD/6f3QhZtesQE+wFiA2MDCsfLqkM9ngNDFm16xAT9AWIDYwMKx4ukQ3qoBkMWbXr'
..'EBP8BYgNjAwrHS55DPZ4DQxZtesQECgJiA2MDBAICYgNjAwoPzZ5D1sv+QhZtesQEBAJ+A38DCg/NnkP/p/dCFm16xAQGAmIDYwMKD82eQyiE8EIWbXrEBAgCYgNjAwoPzZ5DZY7wQhZtesQECgJ+A38DCg7NnkP/p/dCFm16xASEA2IDYwMEFgJ3A2MDBA4CbQNuAwp+SqpD1s'
..'v+QhZtdcQEEAJ8A30DCn5KqkP/p/dCFm11xAQSAm0DbgMKfkqqQyiE8EIWbXXEBBQCbQNuAwp+SqpDZY7wQhZtdcQEFgJ8A30DCn9KqkP/p/dCFm11xAQYAmIDYwMKx8uqQz2eA0MWbXXEBBoCYgNjAwrHi6RDeqgGQxZtdcQEHAJiA2MDCsdLnkM9ngNDFm11xAQnAmIDYwMEH'
..'wJiA2MDCg/NnkPWy/5CFm11xAQhAn4DfwMKD82eQ/+n90IWbXXEBCMCYgNjAwoPzZ5DKITwQhZtdcQEJQJiA2MDCg/NnkNljvBCFm11xAQnAn4DfwMKDs2eQ/+n90IWbXXEIQZTY3JpcHQhBERvb3IEhQNiA2MDB2kBBC4CYgNjAwZWQjYKx+kUQxdY9UKUFJDECtpFx0Dt1gNB'
..'GIUjPwwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIRFQbGFjZWhvbGRlckNvbG9yMyEEVGV4dCEBMAMAAAAAAABEQCEQRG9vckhpdERldGVjdGlvbgdMAQQ6AmIDYwMGdQAACsfpFEMXWPVCtxGQxAp2Md9AUrgKQVyPQj8EPQJiA2MDCpQ6GENkMPVCbheQxArg++M+O+cNQQC'
..'jLT8EQAJiA2MDCub9FEMH8f1CbheQxApqa91AIP3ePgCjLT8EQwJiA2MDCpaMEUMXWPVCbheQxApAIhY/a2IQQQCjLT8hAlNQBEcCYgNjAwqM2hRDTMPsQm4XkMQKxkHmQEC24j4Aoy0/IQVTb3VuZCEHU291bmRJZCEWcmJ4YXNzZXRpZDovLzE1NzE2NzIwMyELTnVtYmVyVm'
..'FsdWUhA0RJRCEDSU5UBIYDdANjAwRRAmIDYwMKrUHNQ8gZAkOmeJHECiNa5kBvgMJAENbePgRUAmIDYwMKnbjCQ+Jr9UJI6YnECgOrq0HwXg5BwF7KPgRXAmIDYwMKnbjCQ+Jr9UIp5I3EBFkCYgNjAwqUc71D4mv1QoXri8QKH8vBPvBeDkFme/9BBFwCYgNjAwoZH8hDdiECQ'
..'7gujcQKH8vBPjxNv0AAKhJBBF8CYgNjAwpkoNBDUSn7QqZ4kcQKajvhQA/kcUEH2t4+BGICYgNjAwpayclDUSn7QqZ4kcQEZAJiA2MDCq1BzUN2IQJDhkuJxAojWuZA9GvEQB9sXD4EZwJiA2MDCjKt0EOuOPtChkuJxAqdbtRA0dlyQR9sXD4EagJiA2MDCqLKyUNxLvtChkuJ'
..'xApB3+FA+jVyQR9sXD4EbQJiA2MDCp5Bw0NhQuxC9+2LxArMH8RBQLbiPu8wBEIEcAJiA2MDCkIbyENm1/pCxY2PxArNEqM+VsVsQQzs+EEEcwJiA2MDCvqex0OmG/tC7GGNxAR1AmIDYwMKQjLNQ2FC7ELYYI3ECqTDpEFAtuI+8KeDQgR4AmIDYwMKxU7SQ1Ep+0L2YI3ECgB'
..'G1j4P5HFBShyDQgR7AmIDYwMKGR/IQzMk+0J7BIvECh/LwT4jknFBuTPeQQR+AmIDYwMKBCjNQzrwBEMpZI3ECqTDpEFAtuI+ShyDQgSCAmIDYwMDAAAAAACAmEAKQ2HQQy1x+0IAgIrECszM7EAK12tBCtejPQMAAAAAAADQPwSGAmIDYwMKwpXOQy1x+0IAgIrECrAehT4K12'
..'tBpHC9PwSJAmIDYwMKvlXNQyY7AUMAgIrECuF6pEA9CvdACtejPSEFTURPT1IHZwAEkQKHA4gDBsrItgMAAAAAAACRQAoAALRCAAC0QgAAAAAKz1PNQ1eo80LIforECgAAtEIAAAAAAAC0wgrdx8U+lKCQQKwB2UAhBFdlbGQhAkMwBIkDdwOKAyECQzEEiwOMA40DIQVQYXJ0M'
..'QSOA3cDYwMEjwOQA5EDIQxBY2Nlc3NEZW5pZWQhElJvbGxPZmZNYXhEaXN0YW5jZSEWcmJ4YXNzZXRpZDovLzIwMDg4ODUxMCENQWNjZXNzR3JhbnRlZCEWcmJ4YXNzZXRpZDovLzIwMDg4ODQ2OCEJRG9vckNsb3NlIRdyYnhhc3NldGlkOi8vNTA5Njk4NjE0NSEGVm9sdW1l'
..'AwAAAAAAAAhAIQhEb29yT3BlbiENUGxheWJhY2tTcGVlZAMAAABgZmbyPwSpAmIDYwMKTljNQ9y4+kIAgIrECj0Kp0DgUTg+pHC9PwSsAmIDYwMKFA7MQyMa+0IAgIrECrAehT5mZmZBpHC9PwSvAmIDYwMKlRnKQy1x+0IAgIrECj0K90AK12tBCtejPQSzAmMDigMKAAAAAAA'
..'AtEIAALRCCp8YxkODnfRC//qKxAqjhZI/SUocPjaYuT8EtgJiA2MDCpk5xkPcOPNCCneLxAquR/FA16PQQDMz80AhBkJ1dHRvbgfsAwS8AmMDigMG/wAACp8YxkODnfRCHfaKxCELUmVmbGVjdGFuY2UDAAAAAAAA4D8KkdMvP0lKHD6khZI/BMECYgNjAwpSeMJDlFf+Qmfui8'
..'QK4Xq0QQrXoz0ehQVCBMUCkgNjAwoAAAAAAAC0QgAAAAAK4A7IQ+/I7EKDLo3EBMcCkgNjAwrgDshDBjb1QoSajcQEyQKSA2MDCuAOyEOp9v1C7jKNxATLApIDYwMK4A7IQ7ld9ULExIzEBJMDlAOVAyELQmFja1N1cmZhY2UDAAAAAAAAJEAE0wKWA5cDIQxGcm9udFN1cmZhY'
..'2UhC0xlZnRTdXJmYWNlCgAAAAAAAAAAAAC0wgrcUs1DKIr6QnB+isQhDFJpZ2h0U3VyZmFjZQp9PzU+46WPQAAAgD8E2AKUA5UDCgAAAAAAADTDAAAAAAr8T81Dw8HsQpN+isQKx0uXQH0/NT4AAIA/BJgDdwOKAwSZA5oDmwME3QKcA50DCl0lzENeffNCmX6KxAoZBJY+th7d'
..'QAAAgD8EngOSA2MDBJ8DoAOhAyEFUGFydDAEogNiA2MDBKMDpAOlAwSmA6cDqAME5gKcA50DCvV+zkNBePNCmn6KxAoZBJY+3XrcQAAAgD8EqQOgA6EDBKoDpwOoAyEJV2VkZ2VQYXJ0BO0CqwOsAwqamQ9CAAC0QgAAtMIKb3rOQ09g+kKGjorECgAAtEJmZlhCAAA0wwrNzEw'
..'+zcxMPf/Rmz4hC1NwZWNpYWxNZXNoIQVTY2FsZQoAAIA/AUDOPQAAgD8hCE1lc2hUeXBlBPYCrQOuAwqamQ/C9qixwrieskIKbnrOQ1dg+kKaborECo/CsMLsUVjCFK6nPwrNzEw+zcxMPWjMmz4KAACAP5w4zj0AAIA/BPwCrwOwAwoAAAAAAAAAAJoZEEMKb3rOQ1Jg+kKGfo'
..'rECt3Rmz7NzEw+xrV+PwQAA7EDsgMKSOH8QQAAtMIfBbRCCs0pzENKY/pChI6KxArh+rNCXI9pwgAANMMKzcxMPs3MTD1Sypo+CgAAgD8BINU9AACAPwQGA7MDtAMKCtcjPHH9M0NSOPPCCswpzENUY/pChG6KxApx/TNDCtcjPFyPaUIKzcxMPnPKmj7NzEw9CgAAgD8AAIA/l'
..'MbSPQQMA7UDtgMKAAAAAAAAAADXYxTDCs0pzENPY/pChH6KxApzypo+zcxMPhirfj8hCElOVEVSQUNUBBADYwOKAwqfGMZDbO/xQh32isQKDJSvQM8cfj+eD1ZAIQVNYWlucyEFU0Rvb3IEtwNiA2MDBBYDYgNjAwqau2dCF1j1QpQUkMQhATEEGQNiA2MDCpq7Z0IXWPVCtxGQ'
..'xCEFVmFsdWUEHANiA2MDCs7+dEJkMPVCbheQxAQeA2IDYwMKFAxoQgfx/UJuF5DEBCADYgNjAwrWRlpCF1j1Qm4XkMQEIgNiA2MDCq5+Z0JMw+xCbheQxCEHQXNzZXRJZCEGRXZlbnRzIQ1CaW5kYWJsZUV2ZW50IQxMb2FkTmV4dFJvb20hCUFzc2V0UGF0aAQpA2IDYwMKAAA'
..'AAK5HkUAAAAAACgAAgD8AAIA/AACAPyEPUHJveGltaXR5UHJvbXB0IQpPYmplY3RUZXh0IT1Hb2xkM25GMXIzJ3MgRG9vcnMgRW5naW5lLgoKSW50ZXJhY3Qgd2l0aCBtZSB0byBwbGF5ICJkb29ycyIuIRNSZXF1aXJlc0xpbmVPZlNpZ2h0BDADYgO4AwrGXFtCA+rrQtSujM'
..'QKj8JpQgAAgD+F61dCBDMDYgO4AwoQdoRC0rbzQslvicQKIFwPPs3MDEFwwfU9BDYDYgO4AwpNAIJC0rbzQoFuicQKUbgeQM3MDEFuwfU9BDkDYgO4Awp3XIpCK8b7QslvicQKrkfBQMzMjD9wwfU9BDwDYgO4AwpPpH9CnwP1QnvaiMQKoB6FPpmZIUGNwhVBBD8DYgO4AwqVY'
..'YpCbND9QoFuicQKj8ItQR6Fqz9uwfU9BzcBBEUDYgO4AwafoawDAAAAAAAAiUAKd1yKQl/560Kr2ojECvQoLEEUroc/jcIVQQRIA2IDuAMKd1yKQpwD7ELJb4nEBEoDYgO4AwpY149CsTH/QqvaiMQK+tajP1qPQj+A69FABE0DYgO4AwrdQpBC0rbzQslvicQETwNiA7gDChrN'
..'kkLStvNCgW6JxARRA2IDuAMKBR+VQp8D9UKE2ojECgDXIz6ZmSFBjcIVQQRUA2IDuAMKwWuKQp8D9UL0R4jECo/CLUGZmSFBQMxMPgRXA2IDuAMKd1yKQjad/0Kr2ojEBFkDYgO4AwpthYVCsTH/QqvaiMQHXAEEXQNiA7gDBu3q6gpthYVCkiz/QqvaiMQKqB6FPxKuRz9hZsZ'
..'ABGADYgO4AwpY149Ckiz/QqvaiMQKP/W/Q7wJlUIfzRLECgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKAopmQrosDkMndYfECq5+Z0I7WfVCjhSHxAq6G4ZC8F71QpaBicQKAwWuQ4kW9UKmvYvECtNgkEMsLwBDZL+MxAr9/38/AAAAAAAAAAAK//9/PwAAAAAAAAAACgW2n0'
..'MdKflC9bmOxAoAAIC/AAAAAC69u7MKAACAvy69u7PtrQkoCi69u7MAAIA/Lr27swoAAIA/AAAAAC69O7QK9b+KQ5xsAENvtozECkrsY0P4Z/lC2hqRxAriiWRD1m/5QtAzjMQK0qJkQ2Bk+UKjAY7ECgAAgL8AAAAALr27MwriemRDbWr5Qv1lisQKd5OkQ34/A0Nez3zECgAAg'
..'L8AAAAAAAAAAAoAAIC/Lr27M+2tCSgKLr27MwAAgD8uvbszCgAAgD8AAAAALr27swrHi6RDPZ4DQ4s2h8QKLr07swAAgD8uvbuzCgAAgD8uvTsz7a2JpwouvTuzAACAPwAAAAAKAACAvy69O7MAAAAACseLpEM9ngNDi7aExArHi6RDPZ4DQ4s2gsQKx4ukQz2eA0MWbX/ECseL'
..'pEM9ngNDFm16xArHi6RDPZ4DQxZtdcQKjNoUQzxZ9ULrE5DECgSfx0OpG/tC7GGNxAouvTuzAAAAAAAAgL8KAACAPy69O7MuvTuzCqdNF8B0rbU9NF7FPgoAAAAAAAAAAAAAgD8KADzDvuhoWMBgZBXACnx4TLlHGbA3AACAvwr+/3+/8OkPOpN7TDkKcGLGPupAYsAAKxa+CgB'
..'+yT6byWPAwNYNQAoAAIC/YAAALgAAgK0KYAAALgAAgD+Y/wksCgAAAAAAAAAAAACAvworRc1DBKbzQnV7isQKAACAv0ALEa3+/2+vCkALES0AAIA//v9vrgp305I1AACAv7YXmTgKAACAP0mGkjX8BgK4CgAAgMMAACBBAACAQwouufbC4dAIPq33zMMKmYVMOb/xDzr+/3+/Cg'
..'AAgL9sM6+3sIhMuQoAAIC/TO96L/7/b68KjKOILwAAgD/8H9gxCn0/tT3jpQ/AAAAAPwoAUOO9PvBbQABVAb8KxAYCOHcambgLAIA/CgAAgL9wg5I12AYCOAoA8ae+VpZZwFDEDkAKAEwHvgDyUsAAp6w+Cnp4TDmc6g86CgCAvwrDGLC38v9/P1fqDzoKsmP7wpzmTsDI98zDC'
..'pmFTDks8g86/v9/vwoAAIC/6DKvt6+ITLkK8NiSQBGUXECAUwG/ClD98cLLQk7AyPfMwwoHIRa/nFtPv9tRYbgK+wkQOJrjLTj8/3+/CgchFj+cW08/S7FhOAqf+Vq81qAfPAb3f78K4VtPv6kgFj+dd4G3CqkgFr/gW0+/RNelOAodMAa/SwNaP20hPrkKK4MQOKgFSbn8/3+/'
..'ChswBj9KA1q/xCg8OQpLA1q/HDAGv8xN+LgKXwNav/0vBr+924w4Cv4vBj9eA1q//KY6OAqufmdCPFn1QusTkMQKAAAAAP//fz8AAAAAiQEBAAAAAQACAAMAAQABAAEAAgAEAAEAAgABAAIABQABAAMAAQACAAYABwAEAAEACAAJAAEABQACAAgACgACAAsADAAGAAYADQAOAA8'
..'AEAARABIAEwAUABUAFgAXABAADAAGAAYADQAOAA8AEAARABgAEwAZABUAGgAXABAADAAGAAYADQAOAA8AEAARABsAEwAcABUAGgAXABAADAAGAAYADQAOAA8AEAARAB0AEwAeABUAHwAXABAADAAGAAsACAAgAA0ADgAPABAAIQAiABEAIwAkACUAJgAnABMAKAAVACkAFwAQAC'
..'oAKwAsAAsAAwAIAC0AEQAuABMALwAsAAsAAwAIADAAEQAxABMAMgABAAUAAgAIADMAAgA0AAwADgAGAA0ADgAPABAAEQA1ABMANgAVADcAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAOQAmADoAOwA8ABMAPQAVAD4AFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAPwAmADoAOwA8A'
..'BMAQAAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEAQgAmADoAOwA8ABMAQwAVAEEAFwAQAAwADgAJAA0ADgAPABAAIQA4ABEARAAmADoAOwA8ABMARQAVAEEAFwAQAAwADgAGAA0ADgAPABAAEQBGABMARwAVAEgAFwAQAAwADgAGAA0ADgAPABAAEQBJABMASgAVAEgAFwAQ'
..'AAwADgAGAA0ADgAPABAAEQBLABMATAAVAE0AFwAQAAwADgALAAgAIAANAA4ADwAQACEAIgARAE4AJAAlACYAJwATAE8AFQApABcAEAAqACsALAAXAAMACAAtABEAUAATAFEALAAXAAMACAAwABEAUgATAFMADAAOAAkADQAOAA8AEAAhADgAEQBUACYAOgA7ADwAEwBVABUAQQA'
..'XABAADAAOAAkADQAOAA8AEAAhADgAEQBWACYAOgA7ADwAEwBXABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBYACYAOgA7ADwAEwBZABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBaACYAOgA7ADwAEwBbABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBcACYAOg'
..'A7ADwAEwBdABUAQQAXABAADAAOAAYADQAOAA8AEAARAF4AEwBfABUAYAAXABAADAAOAAkADQAOAA8AEAAhADgAEQBhACYAOgA7ADwAEwBiABUAQQAXABAADAAOAAkADQAOAA8AEAAhADgAEQBjACYAOgA7ADwAEwBkABUAQQAXABAAAQAFAAIACABlAAIAZgAMACIACwANAA4AD'
..'wAQACEAZwARAGgAJgBpADsAagBrAGwAEwBtAG4AbwAVAHAAFwAQAAwAIgAIAA0ADgAPABAAEQBxAGsAbAATAHIAbgBvABUAcwAXABAADAAiAAgADQAOAA8AEAARAHQAawBsABMAdQBuAG8AFQBzABcAEAAMACIACAANAA4ADwAQABEAdgBrAGwAEwB3AG4AbwAVAHgAFwAQAAwA'
..'IgAIAA0ADgAPABAAEQB5AGsAbAATAHoAbgBvABUAcAAXABAADAAiAAgADQAOAA8AEAARAHsAawBsABMAfABuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAfgBrAGwAEwB/AG4AbwAVAH0AFwAQAAwAIgAIAA0ADgAPABAAEQCAAGsAbAATAIEAbgBvABUAggAXABAADAAiAAg'
..'ADQAOAA8AEAARAIMAawBsABMAhABuAG8AFQB9ABcAEAAMACIACAANAA4ADwAQABEAhQBrAGwAEwCGAG4AbwAVAIIAFwAQAAwAIgAIAA0ADgAPABAAEQCHAGsAbAATAIgAbgBvABUAfQAXABAADAAiAA0ACAAgAA0ADgAPABAAIQAiABEAiQAkACUAJgAnAGsAbAATAIoAbgBvAB'
..'UAKQAXABAAKgArACwALgAEAAgALQARAIsAawCMABMAjQAsAC4AAwAIAI4AEQCPABMAkAABAAUAAgAIAJEAAgCSAAwAMQAIAA0ADgAPABAAEQCTAGsAbAATAJQAbgBvABUANwAXABAADAAxAAsADQAOAA8AEAAhADgAEQCVACYAOgA7ADwAawBsABMAlgBuAG8AFQA+ABcAEAAMA'
..'DEACwANAA4ADwAQACEAOAARAJcAJgA6ADsAPABrAGwAEwCYAG4AbwAVAEEAFwAQAAwAMQALAA0ADgAPABAAIQA4ABEAmQAmADoAOwA8AGsAbAATAJoAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCbACYAOgA7ADwAawBsABMAnABuAG8AFQBBABcAEAAMADEACAAN'
..'AA4ADwAQABEAnQBrAGwAEwCeAG4AbwAVAEgAFwAQAAwAMQAIAA0ADgAPABAAEQCfAGsAbAATAKAAbgBvABUASAAXABAADAAxAAgADQAOAA8AEAARAKEAawBsABMAogBuAG8AFQBNABcAEAAMADEADQAIACAADQAOAA8AEAAhACIAEQCjACQAJQAmACcAawBsABMApABuAG8AFQA'
..'pABcAEAAqACsALAA6AAMACAAtABEAUAATAFEALAA6AAMACAAwABEAUgATAFMADAAxAAsADQAOAA8AEAAhADgAEQClACYAOgA7ADwAawBsABMApgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAKcAJgA6ADsAPABrAGwAEwCoAG4AbwAVAEEAFwAQAAwAMQALAA0ADg'
..'APABAAIQA4ABEAqQAmADoAOwA8AGsAbAATAKoAbgBvABUAQQAXABAADAAxAAsADQAOAA8AEAAhADgAEQCrACYAOgA7ADwAawBsABMArABuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARAK0AJgA6ADsAPABrAGwAEwCuAG4AbwAVAEEAFwAQAAwAMQAIAA0ADgAPABAAE'
..'QCvAGsAbAATALAAbgBvABUAYAAXABAADAAxAAsADQAOAA8AEAAhADgAEQCxACYAOgA7ADwAawBsABMAsgBuAG8AFQBBABcAEAAMADEACwANAA4ADwAQACEAOAARALMAJgA6ADsAPABrAGwAEwC0AG4AbwAVAEEAFwAQAAEABQACAAgAtQACALYADABFAAsADQAOAA8AEAAhAGcA'
..'EQC3ACYAaQA7AGoAawBsABMAuABuAG8AFQC5ABcAEAAMAEUACAANAA4ADwAQABEAugBrAGwAEwC7AG4AbwAVAHMAFwAQAAwARQAIAA0ADgAPABAAEQC8AGsAbAATAL0AbgBvABUAcwAXABAADABFAAgADQAOAA8AEAARAL4AawBsABMAvwBuAG8AFQB4ABcAEAAMAEUACAANAA4'
..'ADwAQABEAwABrAGwAEwDBAG4AbwAVAMIAFwAQAAwARQAIAA0ADgAPABAAEQDDAGsAbAATAMQAbgBvABUAxQAXABAADABFAAgADQAOAA8AEAARAMYAawBsABMAxwBuAG8AFQB9ABcAEAAMAEUACAANAA4ADwAQABEAyABrAGwAEwDJAG4AbwAVAIIAFwAQAAwARQAIAA0ADgAPAB'
..'AAEQDKAGsAbAATAMsAbgBvABUAzAAXABAADABFAAgADQAOAA8AEAARAM0AawBsABMAzgBuAG8AFQCCABcAEAAMAEUACAANAA4ADwAQABEAzwBrAGwAEwDQAG4AbwAVAH0AFwAQAAwARQANAAgAIAANAA4ADwAQACEAIgARANEAJAAlACYAJwBrAGwAEwDSAG4AbwAVACkAFwAQA'
..'CoAKwAsAFEABAAIAC0AEQCLAGsAjAATAI0ALABRAAMACACOABEAjwATAJAAAQAFAAIACADTAAIA1AAMAFQACwANAA4ADwAQACEAZwARANUAJgBpADsAagBrAGwAEwDWAG4AbwAVALkAFwAQAAwAVAAIAA0ADgAPABAAEQDXAGsAbAATANgAbgBvABUAcwAXABAADABUAAgADQAO'
..'AA8AEAARANkAawBsABMA2gBuAG8AFQBzABcAEAAMAFQACAANAA4ADwAQABEA2wBrAGwAEwDcAG4AbwAVAHgAFwAQAAwAVAAIAA0ADgAPABAAEQDdAGsAbAATAN4AbgBvABUAwgAXABAADABUAA0ACAAgAA0ADgAPABAAIQAiABEA3wAkACUAJgAnAGsAbAATAOAAbgBvABUAKQA'
..'XABAAKgArACwAWgAEAAgALQARAIsAawCMABMAjQAsAFoAAwAIAI4AEQCPABMAkAABAFQAAQACAOEADABdAAgADQAOAA8AEAARAOIAawBsABMA4wBuAG8AFQB9ABcAEAAMAF0ACAANAA4ADwAQABEA5ABrAGwAEwDlAG4AbwAVAMwAFwAQAAwAXQAIAA0ADgAPABAAEQDmAGsAbA'
..'ATAOcAbgBvABUAggAXABAAAQBUAAEAAgDoAAwAYQAIAA0ADgAPABAAEQDpAGsAbAATAOoAbgBvABUAxQAXABAADABhAAgADQAOAA8AEAARAOsAawBsABMA7ABuAG8AFQCCABcAEAAMAGEACAANAA4ADwAQABEA7QBrAGwAEwDuAG4AbwAVAH0AFwAQAAEABQACAAgA7wACAPAAD'
..'ABlAAgADQAOAA8AEAARAPEAawBsABMA8gBuAPMAFQD0ABcAEAAMAGUACwAIACAADQAOAA8AEAAhACIAEQD1ACQAJQAmACcAEwD2ABUAKQAXABAAKgArACwAZwADAAgALQARAPcAEwD4ACwAZwADAAgAjgARAPkAEwD6AAwAZQAIAA0ADgAPABAAEQD7AGsAbAATAPwAbgDzABUA'
..'/QAXABAADABlAAgADQAOAA8AEAARAP4AawBsABMA/wBuAPMAFQAAARcAEAAMAGUACAANAA4ADwAQABEAAQFrAGwAEwACAW4A8wAVAAMBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEABAEmADoAOwA8AGsAbAATAAUBbgBvABUABgEXABAADABlAAgADQAOAA8AEAARAAcBawBsABM'
..'ACAFuAPMAFQAJARcAEAAMAGUACAANAA4ADwAQABEACgFrAGwAEwALAW4A8wAVAAkBFwAQAAwAZQALAA0ADgAPABAAIQA4ABEADAEmADoAOwA8AGsAbAATAA0BbgDzABUADgEXABAADABlAAsADQAOAA8AEAAhADgAEQAPASYAOgA7ADwAawBsABMAEAFuAPMAFQARARcAEAAMAG'
..'UACAANAA4ADwAQABEAEgFrAGwAEwATAW4A8wAVABQBFwAQAAwAZQAIAA0ADgAPABAAEQAVAWsAbAATABYBbgDzABUAFAEXABAADABlAAgADQAOAA8AEAARABcBawBsABMAGAFuAPMAFQAZARcAEAAaAUACAAwAIgEjAWwAAAwAJAElAWwAZQAKAA0ADgAhABsBEQAcASYAHQE7A'
..'B4BawBsABMAHwFuAPMAFQAgASEBDgAaAUACAAwAKQEqAWwAAAwAKwEsAWwAZQAKAA0ADgAhABsBEQAmASYAHQE7AB4BawBsABMAJwFuAPMAFQAoASEBDgAMAGUACwANAA4ADwAQACEAOAARAC0BJgA6ADsAPABrAGwAEwAuAW4A8wAVAC8BFwAQAAwAZQALAA0ADgAPABAAIQA4'
..'ABEAMAEmADoAOwA8AGsAbAATADEBbgDzABUAMgEXABAADABlAAsADQAOAA8AEAAhADgAEQAzASYAOgA7ADwAawBsABMANAFuAPMAFQA1ARcAEAAMAGUACwANAA4ADwAQACEAOAARADYBJgA6ADsAPABrAGwAEwA3AW4A8wAVADgBFwAQAAwAZQAIAA0ADgAPABAAEQA5AWsAbAA'
..'TADoBbgDzABUAOwEXABAAGgFAAwAMAD8BQAFsAAAMAEEBQgFsAAAMAEMBRAFsAGUACgANAA4AIQBnABEAPAEmAGkAOwBqAGsAbAATAD0BbgDzABUAPgEhAQ4ADABlAAgADQAOAA8AEAARAEUBawBsABMARgFuAPMAFQBHARcAEAAMAGUACAANAA4ADwAQABEASAFrAGwAEwBJAW'
..'4A8wAVAEoBFwAQAAwAZQAIAA0ADgAPABAAEQBLAWsAbAATAEwBbgDzABUATQEXABAADABlAAgADQAOAA8AEAARAE4BawBsABMATwFuAPMAFQBKARcAEAABAGUAAQACAFABAQCBAAEAAgBRAQwAggAMAA0ADgAPABAAIQBSAREAUwEmAFQBOwBVAWsAbAATAFYBbgBvABUAVwEXA'
..'BAAWAFZAQwAggALAA0ADgAPABAAIQBSAREAWgEmAFQBOwBVAWsAWwETAFwBbgBdARUAXgEXABAADACCAAwADQAOAA8AEAAhAFIBEQBfASYAVAE7AFUBawBsABMAYAFuAG8AFQBXARcAEABYAVkBDACCAAwADQAOAA8AEAAhAGEBEQBiASYAYwE7AGQBawBsABMAZQFuAG8AFQBm'
..'ARcAEABYAVkBZwGGAAIAJgBjAWgBEAAMAIIACwANAA4ADwAQACEAYQERAGkBJgBjATsAZAFrAFsBEwBqAW4AXQEVAGsBFwAQAGcBiAACACYAYwFoARAADACCAAwADQAOAA8AEAAhAGEBEQBTASYAYwE7AGQBawBsABMAVgFuAG8AFQBmARcAEABYAVkBZwGKAAIAJgBjAWgBEAA'
..'MAIEABgANAA4ADwAQABEAbAETAG0BFQBuARcAEAAMAIEABgANAA4ADwAQABEAbwETAHABFQBxARcAEAAMAIEABgANAA4ADwAQABEAcgETAHMBFQBuARcAEAABAIEAAQACAHQBDACPAAoADQAOAA8AEAAhAFIBEQB1ASYAVAE7AFUBEwB2ARUAVwEXABAAWAFZAQwAjwALAA0ADg'
..'APABAAIQBSAREAdwEmAFQBOwBVAWsAeAETAHkBbgB4ARUAXgEXABAADACPAAoADQAOAA8AEAAhAFIBEQB6ASYAVAE7AFUBEwB7ARUAVwEXABAAWAFZAQwAjwAKAA0ADgAPABAAIQBhAREAfAEmAGMBOwBkARMAfQEVAGYBFwAQAFgBWQFnAZMAAgAmAGMBaAEQAAwAjwALAA0AD'
..'gAPABAAIQBhAREAfgEmAGMBOwBkAWsAeAETAH8BbgB4ARUAawEXABAAZwGVAAIAJgBjAWgBEAAMAI8ACgANAA4ADwAQACEAYQERAHUBJgBjATsAZAETAHYBFQBmARcAEABYAVkBZwGXAAIAJgBjAWgBEAABAGUAAgAIAIABAgCBAQEAmQABAAIAggEMAJoADAANAA4ADwAQACEA'
..'UgERAIMBJgBUATsAVQFrAGwAEwCEAW4AbwAVAFcBFwAQAFgBWQEMAJoACwANAA4ADwAQACEAUgERAIUBJgBUATsAVQFrAFsBEwCGAW4AXQEVAF4BFwAQAAwAmgAMAA0ADgAPABAAIQBSAREAhwEmAFQBOwBVAWsAbAATAIgBbgBvABUAVwEXABAAWAFZAQwAmgAMAA0ADgAPABA'
..'AIQBhAREAiQEmAGMBOwBkAWsAbAATAIoBbgBvABUAZgEXABAAWAFZAWcBngACACYAYwFoARAADACaAAsADQAOAA8AEAAhAGEBEQCLASYAYwE7AGQBawBbARMAjAFuAF0BFQBrARcAEABnAaAAAgAmAGMBaAEQAAwAmgAMAA0ADgAPABAAIQBhAREAgwEmAGMBOwBkAWsAbAATAI'
..'QBbgBvABUAZgEXABAAWAFZAWcBogACACYAYwFoARAADACZAAYADQAOAA8AEAARAI0BEwCOARUAbgEXABAADACZAAYADQAOAA8AEAARAI8BEwCQARUAcQEXABAADACZAAYADQAOAA8AEAARAJEBEwCSARUAbgEXABAAAQCZAAEAAgCTAQwApwAKAA0ADgAPABAAIQBSAREAlAEmA'
..'FQBOwBVARMAlQEVAFcBFwAQAFgBWQEMAKcACwANAA4ADwAQACEAUgERAJYBJgBUATsAVQFrAHgBEwCXAW4AeAEVAF4BFwAQAAwApwAKAA0ADgAPABAAIQBSAREAmAEmAFQBOwBVARMAmQEVAFcBFwAQAFgBWQEMAKcACgANAA4ADwAQACEAYQERAJoBJgBjATsAZAETAJsBFQBm'
..'ARcAEABYAVkBZwGrAAIAJgBjAWgBEAAMAKcACwANAA4ADwAQACEAYQERAJwBJgBjATsAZAFrAHgBEwCdAW4AeAEVAGsBFwAQAGcBrQACACYAYwFoARAADACnAAoADQAOAA8AEAAhAGEBEQCUASYAYwE7AGQBEwCVARUAZgEXABAAWAFZAWcBrwACACYAYwFoARAADACZAAcACAC'
..'eAQ0ADgAPABAAEQCfARMAoAEVAKEBFwAQAKIBsQAFAKMBKwCkAQ4ApQErAKYBpwGoASsAqQGyAAMAqgGrAawBKwAVAK0BrgGzAAYAqgGrAawBKwAVAK0BrwGwAbEBsgGzAacBAQBlAAEAAgC0AQEAtQABAAIAtQEMALYADAANAA4ADwAQACEAUgERALYBJgBUATsAVQFrAGwAEw'
..'C3AW4AbwAVAFcBFwAQAFgBWQEMALYACwANAA4ADwAQACEAUgERALgBJgBUATsAVQFrAFsBEwC5AW4AXQEVAF4BFwAQAAwAtgAMAA0ADgAPABAAIQBSAREAugEmAFQBOwBVAWsAbAATALsBbgBvABUAVwEXABAAWAFZAQwAtgAMAA0ADgAPABAAIQBhAREAvAEmAGMBOwBkAWsAb'
..'AATAL0BbgBvABUAZgEXABAAWAFZAWcBugACACYAYwFoARAADAC2AAsADQAOAA8AEAAhAGEBEQC+ASYAYwE7AGQBawBbARMAvwFuAF0BFQBrARcAEABnAbwAAgAmAGMBaAEQAAwAtgAMAA0ADgAPABAAIQBhAREAtgEmAGMBOwBkAWsAbAATALcBbgBvABUAZgEXABAAWAFZAWcB'
..'vgACACYAYwFoARAADAC1AAYADQAOAA8AEAARAMABEwDBARUAbgEXABAADAC1AAYADQAOAA8AEAARAMIBEwDDARUAcQEXABAADAC1AAYADQAOAA8AEAARAMQBEwDFARUAbgEXABAAAQC1AAEAAgDGAQwAwwAKAA0ADgAPABAAIQBSAREAxwEmAFQBOwBVARMAyAEVAFcBFwAQAFg'
..'BWQEMAMMACwANAA4ADwAQACEAUgERAMkBJgBUATsAVQFrAHgBEwDKAW4AeAEVAF4BFwAQAAwAwwAKAA0ADgAPABAAIQBSAREAywEmAFQBOwBVARMAzAEVAFcBFwAQAFgBWQEMAMMACgANAA4ADwAQACEAYQERAM0BJgBjATsAZAETAM4BFQBmARcAEABYAVkBZwHHAAIAJgBjAW'
..'gBEAAMAMMACwANAA4ADwAQACEAYQERAM8BJgBjATsAZAFrAHgBEwDQAW4AeAEVAGsBFwAQAGcByQACACYAYwFoARAADADDAAoADQAOAA8AEAAhAGEBEQDHASYAYwE7AGQBEwDIARUAZgEXABAAWAFZAWcBywACACYAYwFoARAAAQBlAAEAAgDRAQEAzQABAAIA0gEMAM4ADAANA'
..'A4ADwAQACEAUgERANMBJgBUATsAVQFrAGwAEwDUAW4AbwAVAFcBFwAQAFgBWQEMAM4ACwANAA4ADwAQACEAUgERANUBJgBUATsAVQFrAFsBEwDWAW4AXQEVAF4BFwAQAAwAzgAMAA0ADgAPABAAIQBSAREA1wEmAFQBOwBVAWsAbAATANgBbgBvABUAVwEXABAAWAFZAQwAzgAM'
..'AA0ADgAPABAAIQBhAREA2QEmAGMBOwBkAWsAbAATANoBbgBvABUAZgEXABAAWAFZAWcB0gACACYAYwFoARAADADOAAsADQAOAA8AEAAhAGEBEQDbASYAYwE7AGQBawBbARMA3AFuAF0BFQBrARcAEABnAdQAAgAmAGMBaAEQAAwAzgAMAA0ADgAPABAAIQBhAREA0wEmAGMBOwB'
..'kAWsAbAATANQBbgBvABUAZgEXABAAWAFZAWcB1gACACYAYwFoARAADADNAAYADQAOAA8AEAARAN0BEwDeARUAbgEXABAADADNAAYADQAOAA8AEAARAN8BEwDgARUAcQEXABAADADNAAYADQAOAA8AEAARAOEBEwDiARUAbgEXABAAAQDNAAEAAgDjAQwA2wAKAA0ADgAPABAAIQ'
..'BSAREA5AEmAFQBOwBVARMA5QEVAFcBFwAQAFgBWQEMANsACwANAA4ADwAQACEAUgERAOYBJgBUATsAVQFrAHgBEwDnAW4AeAEVAF4BFwAQAAwA2wAKAA0ADgAPABAAIQBSAREA6AEmAFQBOwBVARMA6QEVAFcBFwAQAFgBWQEMANsACgANAA4ADwAQACEAYQERAOoBJgBjATsAZ'
..'AETAOsBFQBmARcAEABYAVkBZwHfAAIAJgBjAWgBEAAMANsACwANAA4ADwAQACEAYQERAOwBJgBjATsAZAFrAHgBEwDtAW4AeAEVAGsBFwAQAGcB4QACACYAYwFoARAADADbAAoADQAOAA8AEAAhAGEBEQDkASYAYwE7AGQBEwDlARUAZgEXABAAWAFZAWcB4wACACYAYwFoARAA'
..'AQBlAAEAAgDuAQEA5QABAAIA7wEMAOYADAANAA4ADwAQACEAUgERAPABJgBUATsAVQFrAGwAEwDxAW4AbwAVAFcBFwAQAFgBWQEMAOYACwANAA4ADwAQACEAUgERAPIBJgBUATsAVQFrAFsBEwDzAW4AXQEVAF4BFwAQAAwA5gAMAA0ADgAPABAAIQBSAREA9AEmAFQBOwBVAWs'
..'AbAATAPUBbgBvABUAVwEXABAAWAFZAQwA5gAMAA0ADgAPABAAIQBhAREA9gEmAGMBOwBkAWsAbAATAPcBbgBvABUAZgEXABAAWAFZAWcB6gACACYAYwFoARAADADmAAsADQAOAA8AEAAhAGEBEQD4ASYAYwE7AGQBawBbARMA+QFuAF0BFQBrARcAEABnAewAAgAmAGMBaAEQAA'
..'wA5gAMAA0ADgAPABAAIQBhAREA8AEmAGMBOwBkAWsAbAATAPEBbgBvABUAZgEXABAAWAFZAWcB7gACACYAYwFoARAADADlAAYADQAOAA8AEAARAPoBEwD7ARUAbgEXABAADADlAAYADQAOAA8AEAARAPwBEwD9ARUAcQEXABAADADlAAYADQAOAA8AEAARAP4BEwD/ARUAbgEXA'
..'BAAAQDlAAEAAgAAAgwA8wAKAA0ADgAPABAAIQBSAREAAQImAFQBOwBVARMAAgIVAFcBFwAQAFgBWQEMAPMACwANAA4ADwAQACEAUgERAAMCJgBUATsAVQFrAHgBEwAEAm4AeAEVAF4BFwAQAAwA8wAKAA0ADgAPABAAIQBSAREABQImAFQBOwBVARMABgIVAFcBFwAQAFgBWQEM'
..'APMACgANAA4ADwAQACEAYQERAAcCJgBjATsAZAETAAgCFQBmARcAEABYAVkBZwH3AAIAJgBjAWgBEAAMAPMACwANAA4ADwAQACEAYQERAAkCJgBjATsAZAFrAHgBEwAKAm4AeAEVAGsBFwAQAGcB+QACACYAYwFoARAADADzAAoADQAOAA8AEAAhAGEBEQABAiYAYwE7AGQBEwA'
..'CAhUAZgEXABAAWAFZAWcB+wACACYAYwFoARAAAQBlAAEAAgALAgEA/QABAAIADAIMAP4ADAANAA4ADwAQACEAUgERAA0CJgBUATsAVQFrAGwAEwAOAm4AbwAVAFcBFwAQAFgBWQEMAP4ACwANAA4ADwAQACEAUgERAA8CJgBUATsAVQFrAFsBEwAQAm4AXQEVAF4BFwAQAAwA/g'
..'AMAA0ADgAPABAAIQBSAREAEQImAFQBOwBVAWsAbAATABICbgBvABUAVwEXABAAWAFZAQwA/gAMAA0ADgAPABAAIQBhAREAEwImAGMBOwBkAWsAbAATABQCbgBvABUAZgEXABAAWAFZAWcBAgECACYAYwFoARAADAD+AAsADQAOAA8AEAAhAGEBEQAVAiYAYwE7AGQBawBbARMAF'
..'gJuAF0BFQBrARcAEABnAQQBAgAmAGMBaAEQAAwA/gAMAA0ADgAPABAAIQBhAREADQImAGMBOwBkAWsAbAATAA4CbgBvABUAZgEXABAAWAFZAWcBBgECACYAYwFoARAADAD9AAYADQAOAA8AEAARABcCEwAYAhUAbgEXABAADAD9AAYADQAOAA8AEAARABkCEwAaAhUAcQEXABAA'
..'DAD9AAYADQAOAA8AEAARABsCEwAcAhUAbgEXABAAAQD9AAEAAgAdAgwACwEKAA0ADgAPABAAIQBSAREAHgImAFQBOwBVARMAHwIVAFcBFwAQAFgBWQEMAAsBCwANAA4ADwAQACEAUgERACACJgBUATsAVQFrAHgBEwAhAm4AeAEVAF4BFwAQAAwACwEKAA0ADgAPABAAIQBSARE'
..'AIgImAFQBOwBVARMAIwIVAFcBFwAQAFgBWQEMAAsBCgANAA4ADwAQACEAYQERACQCJgBjATsAZAETACUCFQBmARcAEABYAVkBZwEPAQIAJgBjAWgBEAAMAAsBCwANAA4ADwAQACEAYQERACYCJgBjATsAZAFrAHgBEwAnAm4AeAEVAGsBFwAQAGcBEQECACYAYwFoARAADAALAQ'
..'oADQAOAA8AEAAhAGEBEQAeAiYAYwE7AGQBEwAfAhUAZgEXABAAWAFZAWcBEwECACYAYwFoARAAKAIFAAAAAQAFAAIACAApAgIAKgIMABYBCgAIACkCDQAOAA8AEAAhACsCEQAsAiYALQI7ADwAEwAuAhUALwIXABAAogEXAQUAowErAKQBDgBoAVkBpQErAKgBKwCpARgBBACqA'
..'asBrAErABMAMAIVADECrgEZAQgAqgGrAawBKwAVAK0BrwGwATICqwEzAjQCsQGrAbMBNQIMABYBDAAIADYCDQAOAA8AEAAhADcCEQA4AiQAJQAmADkCOwAeARMAOgIVADsCFwAQACoAKwAMABYBCAANAA4ADwAQACEAIgARADwCJgAnABMAPQIVAD4CFwAQAAwAFgEIAA0ADgAP'
..'ABAAIQAiABEAPwImACcAEwBAAhUAQQIXABAADAAWAQgADQAOAA8AEAAhACIAEQBCAiYAJwATAEMCFQBEAhcAEAAMABYBCQAIAEUCDQAOAA8AEAAhACIAEQBGAiYAJwATAEcCFQBIAhcAEABJAh8BAQBKAksCTAIWAQEACABNAgEABQACAAgATgICAE8CDAAiAQYADQAOAA8AEAA'
..'RAFACEwBRAhUAUgIXABAADAAiAQYADQAOAA8AEAARAFMCEwBUAhUAVQIXABAADAAiAQYADQAOAA8AEAARAFYCEwBXAhUAVQIXABAADAAiAQYADQAOAA8AEAARAFgCEwBZAhUAWgIXABAADAAiAQYADQAOAA8AEAARAFsCEwBcAhUAXQIXABAADAAiAQYADQAOAA8AEAARAF4CEw'
..'BfAhUAYAIXABAADAAiAQYADQAOAA8AEAARAGECEwBiAhUAYAIXABAADAAiAQYADQAOAA8AEAARAGMCEwBkAhUAZQIXABAADAAiAQYADQAOAA8AEAARAGYCEwBnAhUAaAIXABAADAAiAQYADQAOAA8AEAARAGkCEwBqAhUAawIXABAADAAiAQYADQAOAA8AEAARAGwCEwBtAhUAb'
..'gIXABAADAAiAQYADQAOAA8AEAARAG8CEwBwAhUAcQIXABAADAAiAQsACAAgAA0ADgAPABAAIQAiABEAcgIkACUAJgAnABMAcwIVACkAFwAQACoAKwAsAC8BAwAIAC0AEQAuABMALwAsAC8BAwAIADAAEQAxABMAMgAMACIBBgANAA4ADwAQABEAdAITAHUCFQB2AhcAEAAMACIB'
..'BgANAA4ADwAQABEAdwITAHgCFQB5AhcAEAAMACIBBgANAA4ADwAQABEAegITAHsCFQB8AhcAEAAMACIBBgANAA4ADwAQABEAfQITAH4CFQB/AhcAEAAMACIBCAANAA4ADwAQABEAgAI7AIECEwCCAhUAgwIXABAAKgCEAgwAIgEGAA0ADgAPABAAEQCFAhMAhgIVAIcCFwAQAAw'
..'AIgEIAA0ADgAPABAAEQCIAjsAgQITAIkCFQCKAhcAEAAqAIQCDAAiAQoACACLAg0ADgAhAIwCEQCNAiYAjgI7AI8CawCQAhMAkQJuAJICFQCTApQCOQECAJUClgKXApgClAI5AQIAlQKaApcCmwJJAjkBAwAIAJwCnQKnAUoCngJJAjkBAwAIAJ8CnQKnAUoCoAJJAjkBBAAIAK'
..'ECnQKnAUoCogKjAqQCSQI5AQUACAClAqYCpwKdAqcBSgKiAqMCpAIMACIBBgANAA4ADwAQABEAqAITAKkCFQCqAhcAEAAMACIBBgANAA4ADwAQABEAqwITAKwCFQCtAhcAEAAMACIBCAANAA4ADwAQABEArgI7AIECEwCvAhUAsAIXABAAKgCEAgwAIgEHAA0ADgARALECOwBVA'
..'WsAsgITALMCbgCQAhUAtAIMACIBBgANAA4ADwAQABEAtQITALYCFQC3AhcAEAAMACIBDQAIALgCDQAOAA8AWQEhALkCEQC6AiYAuwI7AFUBawCyAhMAvAK9Ar4CbgCQAhUAvwIXAFkBDAAiAQYADQAOAA8AEAARAMACEwDBAhUAwgIXABAADAAiAQsACABFAg0ADgAPABAAIQAi'
..'ABEAwwImACcAawDEAhMAxQJuAMQCFQBIAhcAEABJAkcBAQBKAksCDAAiAQoADQAOAA8AEAAhACIAEQDGAiYAJwBrAMQCEwDHAm4AxAIVAD4CFwAQAAwAIgEKAA0ADgAPABAAIQAiABEAyAImACcAawDEAhMAyQJuAMQCFQBBAhcAEAAMACIBCgANAA4ADwAQACEAIgARAMoCJgA'
..'nAGsAxAITAMsCbgDEAhUARAIXABAAAQAiAQIACACpAQIAzAIMAEwBDQANAA4AzQLOAg8AEAARAM8C0ALOAtECzgI7AI8CawDSAhMA0wLUAs4CbgDSAhUA1QIXABAADABMAQ0ADQAOAM0CzgIPABAAEQDWAtACzgLRAs4COwCPAmsA1wITANgC1ALOAm4A8wAVANkCFwDOApQCTg'
..'ECAJUC2gKXAtsCDABMAQ0ADQAOAM0CzgIPABAAEQDcAtACzgLRAs4COwCPAmsA1wITAN0C1ALOAm4A8wAVAN4CFwDOApQCUAECAJUC3wKXAuAClAJQAQIAlQLiApcC4wKUAlABAgCVAtoClwLkAgwATAENAA0ADgDNAs4CDwAQABEA5QLQAs4C0QLOAjsAjwJrANcCEwDmAtQCz'
..'gJuAPMAFQDnAhcAzgKUAlQBAgCVAt8ClwLoApQCVAECAJUC2gKXAukC6gJMAQ0ADQAOAM0CzgIPAM4CEQDrAtACzgLRAs4COwCPAmsA7AITAO0C1ALOAm4A7gIVAO8CFwDOAvACVwECAPEC8gLzAlkB6gJMAQ0ADQAOAM0CzgIPAM4CEQD0AtACzgLRAs4COwCPAmsA9QITAPYC'
..'1ALOAm4A9wIVAPgCFwDOAvACWQECAPEC+QLzAlkBDABMAQkADQAOAA8AEAARAPoCOwCPAmsA+wITAPwCbgD7AhUA/QIXABAA6gJMAQ0ADQAOAM0CzgIPAM4CEQD+AtACzgLRAs4COwCPAmsA/wITAAAD1ALOAm4AAQMVAAIDFwDOAvACXAECAPECAwPzAlkB6gJMAQ0ADQAOAM0'
..'CzgIPAM4CEQAEA9ACzgLRAs4COwCPAmsABQMTAAYD1ALOAm4ABwMVAAgDFwDOAvACXgECAPECCQPzAlkBDABMAQkADQAOAA8AEAARAAoDOwCPAmsACwMTAAwDbgALAxUADQMXABAADAAiAQ4ACAAOAw0ADgAPAFkBIQC5AhEADwMkACUAJgC7AjsAHgFrALICEwAQA70CvgJuAJ'
..'ACFQARAxcAWQEoAgQAAQAIABIDAQAEAAIACAATAwIAFAMMAGMBCgAIACkCDQAOAA8AEAAhACsCEQAVAyYALQI7ADwAEwAWAxUALwIXABAAogFkAQUAowErAKQBDgBoAVkBpQErAKgBKwCpAWUBBACqAasBrAErABMAMAIVADECrgFmAQgAqgGrAawBKwAVAK0BrwGwATICqwEzA'
..'hcDsQGrAbMBNQIMAGMBDAAIADYCDQAOAA8AEAAhADcCEQAYAyQAJQAmADkCOwAeARMAGQMVADsCFwAQACoAKwAoAmgBAABMAmkBAgAIAE0CGgMrAAwAYwEIAA0ADgAPABAAIQAiABEAGwMmACcAEwAcAxUAPgIXABAADABjAQgADQAOAA8AEAAhACIAEQAdAyYAJwATAB4DFQBB'
..'AhcAEAAMAGMBCAANAA4ADwAQACEAIgARAB8DJgAnABMAIAMVAEQCFwAQAAwAYwEJAAgARQINAA4ADwAQACEAIgARACEDJgAnABMAIgMVAEgCFwAQAEkCbgEBAEoCSwJMAgQAAQAIACMDBwADAAEACAAkAyUDcQEBAAgAJgMlA3EBAQAIACcDDAABAAoADQAOAA8AEAAhAGcAEQA'
..'oAyQAJQAmAGkAOwAeARMAKQMVACoDFwAQACsDdAECACwDLQMuAyUAKAJ0AQAADAABAAYADQAOAA8AEAARAC8DEwAwAxUAMQMXABAADAABAAkADQAOAA8AEAAhAFIBEQAyAyYAVAE7AFUBEwAzAxUANAMXABAADAABAAkADQAOAA8AEAAhAFIBEQA1AyYAVAE7ADwAEwA2AxUANw'
..'MXABAADAABAAkADQAOAA8AEAAhAFIBEQA4AyYAVAE7AFUBEwA5AxUAOgMXABAADAABAAkADQAOAA8AEAAhAFIBEQA7AyYAVAE7ADwAEwA8AxUAPQMXABAADAABAAkADQAOAA8AEAAhAFIBEQA+AyYAVAE7ADwAEwA/AxUAQAMXABAADAABAAkADQAOAA8AEAAhAEEDEQBCAyYAQ'
..'wM7AEQDEwBFAxUARgMXABAADAABAAkADQAOAA8AEAAhAFIBEQBHAyYAVAE7AFUBEwBIAxUAOgMXABAADAABAAkADQAOAA8AEAAhAEEDEQBJAyYAQwM7AI8CEwBKAxUASwMXABAADAABAAkADQAOAA8AEAAhAFIBEQBMAyYAVAE7AFUBEwBNAxUANAMXABAADAABAAkADQAOAA8A'
..'EAAhAFIBEQBOAyYAVAE7ADwAEwBPAxUANwMXABAADAABAAkADQAOAA8AEAAhAFIBEQBQAyYAVAE7ADwAEwBRAxUAUgMXABAADAABAAkADQAOAA8AEAAhAFIBEQBTAyYAVAE7ADwAEwBUAxUAVQMXABAADAABAAkADQAOAA8AEAAhAEEDEQBWAyYAQwM7AEQDEwBXAxUARgMXABA'
..'ADAABAAkADQAOAA8AEAAhAEEDEQBYAyYAQwM7AI8CEwBZAxUASwMXABAADAABAAkADQAOAA8AEAAhAFoDEQBbAyYAXAM7AGQBEwBdAxUAXgMXABAAZwGGAQEAaAGwAQwAAQAJAA0ADgAPABAAIQBaAxEAXwMmAFwDOwBkARMAYAMVAF4DFwAQAGcBiAEBAGgBsAEKOgGZAjkBOw'
..'GZAjkBTwGZAk4BUQHhAk0BUQGZAlABUgGZAlABUwGZAlABVQHhAk0BVQGZAlQBVgGZAlQB')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
