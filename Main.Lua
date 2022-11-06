-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 12748 characters

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
script.Parent.Door.Door.SurfaceGui.Frame.TextBox.Text="0"
local doormodel = nil
local ran = 0
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
		i.SP.Sound:Play()
		doormodel:PivotTo(CFrame.new(doormodel.Door.Position+Vector3.new(-(corr.roomdiagonalincrease),corr.up,-corr.Length)))
		script.Parent.Door.Door.SurfaceGui.Frame.TextBox.Text=door
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


local Objects = Decode('AECnASEFTW9kZWwhCldvcmxkUGl2b3QEjQGOAY8BBJABjgGPAQSRAY4BjwEEkgGOAY8BIQROYW1lIQREb29yBJMBjgGPASEEUGFydCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yB2kBIQZDRnJhbWUEGACOAY8BIQVDb2xvcgZW'
..'QjYhCE1hdGVyaWFsAwAAAAAAAIBAIQhQb3NpdGlvbgqau2dCF1j1QpQUkMQhBFNpemUK2kXHQO3WA0EYhSM/IQpUb3BTdXJmYWNlIQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEQQ2xpcHNEZXNjZW5kYW50cyEERmFjZQMAAAAAAAAAQCEOTGln'
..'aHRJbmZsdWVuY2UhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIQdUZXh0Qm94DAAAgD8AAAAAgD8AACEERm9udAMAAAAAAAAQQCERUGxhY2Vob2xk'
..'ZXJDb2xvcjMhClRleHRDb2xvcjMhCFRleHRTaXplAwAAAAAAAERAIRBEb29ySGl0RGV0ZWN0aW9uB0wBBDkAjgGPASEKQ2FuQ29sbGlkZQIGdQAAAwAAAAAAwJhACpq7Z0IXWPVCtxGQxAp2Md9AUrgKQVyPQj8hDFRyYW5zcGFyZW5jeSEGU2NyaXB0B+oDBEAAjgGP'
..'AQbNzc0Kzv50QmQw9UJuF5DECuD74z475w1BAKMtPwRDAI4BjwEKFAxoQgfx/UJuF5DECmpr3UAg/d4+AKMtPwRGAI4BjwEK1kZaQhdY9UJuF5DECkAiFj9rYhBBAKMtPyECU1AESgCOAY8BCq5+Z0JMw+xCbheQxArGQeZAQLbiPgCjLT8hBVNvdW5kIQdTb3VuZElk'
..'IRZyYnhhc3NldGlkOi8vMTU3MTY3MjAzIQ1CaW5kYWJsZUV2ZW50IQZBc3NldHMElAGOAY8BIQhTdHJhaWdodASVAY4BjwEEVQCOAY8BCg//rUOx6v1C98CLxArGQeZAQLbiPp3DY0EEWACOAY8BCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEWwCOAY8BCsXOr0OP'
..'M/VC98CLxARdAI4BjwEKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQEYQCOAY8BCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhCkF0dGFjaG1lbnQhA0VuZARmAI4BjwEKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcEaQCOAY8BCgAAAAAAAAAAj8LjQCEC'
..'VXAElgGOAY8BBG0AjgGPAQqVX5BDDiIKQ2S/jMQKNhPpQGA5LD+osupBB20BBHIAlwGPAQZqOQkKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QAR1AJcBjwEKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwR4AJcBjwEKlWaQQw6v/UJhXo3EBHoAlwGPAQqVZpBDDq//'
..'QseEjcQEfACOAY8BCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEEfwCOAY8BCm2gjkM2LwBDOruMxASBAI4BjwEKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgSEAI4BjwEK1WCQQ0ovAENkv4zEBIYAjgGPAQoAOjS9AACsQKRwZ8EEiACOAY8BCgAAVTw3ibXAMLJj'
..'QQSKAJcBjwEKlWaQQw6v90Iu64zEBIwAlwGPAQqVZpBDDq/5QpQRjcQEjgCXAY8BCpVmkEMOr/FC+neMxASQAJcBjwEKlWaQQw+v80JhnozEBJIAlwGPAQqVZpBDDq/1QsfEjMQElACOAY8BCi9lkEOzPexCOruMxArGQeZAQLbiPoid6EEElwCYAY8BCpVmkEMOr+1C'
..'LiuMxASZAJcBjwEKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBJkBmgGPAQdrAASiAJsBnAEGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADRDAAAAAAAANEMKPibWQUC24j6InehBBKcAmwGcAQr/'
..'DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBKoAmwGcAQoLXqZDHSn5QvW5jsQErACbAZwBCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4ErwCbAZwBCr+un0NU/AJD9bmOxASxAJsBnAEKf/ejQx0p+ULDhpDECvy/HUEYmVJBEqmNPgS0AJsBnAEKMXObQx0p+ULDhpDE'
..'BLYAmwGcAQrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BLkAmwGcAQoxc5tDHSn5QhvrjMQEuwCbAZwBCteBnUOGJgFDG+uMxAS9AJsBnAEKf/ejQx0p+UIb64zEBL8AmwGcAQoFtp9D+yj5QvW5jsQEwgCdAY8BCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQE'
..'xQCOAY8BCgDAVDzByvG/FK5pwSEERG93bgSeAY4BjwEEyQCfAZwBCjPBikN+XwpDb7aMxATLAJ8BnAEKM7qKQ/cUAUMfYYvEBM0AnwGcAQozuopD7in8Qtk9jMQEzwCfAZwBCjO6ikPuKf5CcheMxATRAJ8BnAEKM7qKQ/cUAEMM8YvEBNMAnwGcAQpp/ohDpmwAQ5m6'
..'jMQE1QCfAZwBClmAjEOmbABDmbqMxATXAJ8BnAEKM8GKQ13sBEO+ho7EBNkAnwGcAQrzv4pDumwAQ2+2jMQE2wCfAZwBCjO6ikPuKfhCpYqMxATdAJ8BnAEKM7qKQ+4p+kI/ZIzEBN8AnwGcAQozuopD7inyQtn9jMQE4QCfAZwBCjO6ikPvKfRCcteMxATjAJ8BnAEK'
..'M7qKQ+4p9kIMsYzEBOUAnwGcAQqZu4pDk7jsQpm6jMQE5wCfAZwBCjO6ikPuKe5CpUqNxATpAJ8BnAEKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBKABjgGPAQTtAJ8BnAEKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3oQQTwAJ8BnAEKIqI/Q1Fc+ULgG5HEBPIAnwGc'
..'AQpVEIRDUVz5QuAbkcQE9ACfAZwBChLCekMXpOxCwU2PxAT2AJ8BnAEKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQT5AJ8BnAEKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgT8AJ8BnAEK0o1EQ1Fc+UKv6JLEBP4AnwGcAQoeq0hDIEABQ6/oksQEAAGfAZwBChpr'
..'W0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EAwGfAZwBCkJodkMgQAFDBk2PxAQFAZ8BnAEKyamBQ1Fc+UIGTY/EBAcBnwGcAQpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEoQGOAY8BBAsBnwGcAQoycWRD9qvsQtY0jMQEDQGfAZwBCro/QEMwZPlC1jSMxAQPAZ8BnAEK'
..'H1+EQzBk+ULWNIzEBBEBnwGcAQqqX3tD9qvsQrdmisQEEwGfAZwBCs5mZEPcGQND1jSMxAQVAZ8BnAEK4olkQ9Jv+ULQM4zEBKIBowGPAQQYAZ8BnAEKfwyCQ2Bk+UKjAY7EBBoBnwGcAQqKMFxDYGT5QqMBjsQEHAGfAZwBCq4td0MoRAFDowGOxASkAaMBjwEEHwGb'
..'AZwBChLubENsavlC/WWKxAQhAZsBnAEKyiBJQy1HAUP9ZYrEBCMBmwGcAQp6A0VDbGr5Qv1lisQhA0xJQgSlAaYBjwEEJwGmAY8BCr/Us0N+PwND412JxAoAADTDAAAAAAAANMMKehRYQv//20EOA2E+BCsBpwGPAQp5k6RDfj8DQ17PfMQELQGOAY8BCgAAAAAGgeW/'
..'4vqvQgQvAY4BjwEKAAAAAPp+8sBf5a/CBDEBpgGPAQq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BDQBpgGPAQp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBDcBpgGPAQp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+BDoBpgGPAQrLi6RD9FDtQojKfMQKAEDmQgAA'
..'gD8AADBDBD0BpgGPAQrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBEABpgGPAQp3k4dDfj8DQyLLfMQEQgGmAY8BCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8ERQGmAY8BCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDvfz8ESAGmAY8BCk23j0PnUPZCnm9wxAoAAIA/'
..'AAAAQfj9n0AESwGmAY8BCk03mkPnUPZCnm9wxARNAaYBjwEKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEUwGmAY8BBqOipQr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HAd5RACq5H4T49CsNBpkWRQApPN5pDGFkDQzh5cMQKuB6dQj0K'
..'w0EuJ+E+Cvu+rUMYWQNDoe9vxARaAaYBjwEKv7SLQxhZA0MGdnDECuJ6hEE8CsNBwHeUQAptvI9DGFkDQzh5cMQK61GEQT0Kw0EuJ+E+Cnezi0MYWQNDoe9vxARgAaYBjwEKgwOVQ+dQ8UKWb3DECmDDpEEAAEBAwO9/PwRjAaYBjwEKgwOVQ+dQ8kKaL3DECmDDpEEA'
..'AIBAwO9/PwRmAaYBjwEKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwRpAaYBjwEKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQARsAaYBjwEKtZ2LQ+dQ9kKi72/ECmZmdkEAAABBwO9/PwRvAaYBjwEKxYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAgBxCAADAQHBR'
..'BEIKxYuRQ+hQ9EIU7WrECgAAgUEAAMBAcFEQQgrFy4tD6FD0QhRNa8QKAECcQgAAwEBwURBCCsXLrUPoUPRCFE1rxAR4AaYBjwEKQ4CkQ5JtC0PayWbECpmZEUFwPTJBAOjWPgR7AaYBjwEKWQ60Q34/A0PayWbECgrXW0IAANxBAOjWPgR+AaYBjwEKWY6kQ/x+8kLa'
..'yWbECihcD0EAAPBAAOjWPgSBAaYBjwEK5xCVQ34/A0PayWbEBIMBjgGPAQq1y8NDJYXsQpmai8QKuB49RI/C9T0pXI9CBIYBpgGPAQoKVyNDWDjrQh6tjMQKAACAQEfhuj8AAGhBIQRUZXh0ISVBc3NldCBHYWxsZXJ5IChSb29tcy9Eb29ycyBhdmFsaWFibGUpBIsB'
..'jgGPAQoAAAAArkeRQAAAAAAhD1Byb3hpbWl0eVByb21wdAo29b9DvAmVQhzNEsQKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAoCimZCuiwOQyd1h8QKrn5nQjtZ9UKOFIfECrobhkLwXvVCloGJxAqufmdCPFn1QusTkMQKYbfVQwjVpEE2gIbECgMFrkOJFvVCpr2L'
..'xArTYJBDLC8AQ2S/jMQK/f9/PwAAAAAAAAAACv//fz8AAAAAAAAAAAoFtp9DHSn5QvW5jsQKAACAvwAAAAAuvbuzCgAAgL8uvbuzAAAAKAouvbuzAACAPy69u7MKAACAPwAAAAAuvTu0CvW/ikOcbABDb7aMxAoAAIC/Lr27s+2tCSgKSuxjQ/hn+ULaGpHECuKJZEPW'
..'b/lC0DOMxArSomRDYGT5QqMBjsQKAACAvwAAAAAuvbszCuJ6ZENtavlC/WWKxAp3k6RDfj8DQ17PfMQKAACAvwAAAAAAAAAACgAAgD8AAAAALr27s5YBAAABAAIAAwABAAEBAAIABAABAAIBAAIABQABAAMBAAIABgABAAQCAAcACAACAAkACgAFCgAHAAgACwAMAA0A'
..'DgAPABAAEQASABMAFAAVABYAFwAYABkAGgAbAA4AHAAGBQAdAB4AHwAMACAAIQAiAB4AIwAeACQABwQAJQAmACcAHgAXACgAGQApACoACAcAJQAmACcAHgAZACsALAAtAC4AJgAvACYAMAAxAAoABQwABwAyAAsADAANAA4ADwAzABEANAA1ADYAEwA3ABUAOAAXADkA'
..'GQA6ABsADgA7AB4APAAKAAAKAAUIAAsADAANAA4ADwA9ABEAPgATAD8AFwBAABkAQQAbAA4ACgAFCAALAAwADQAOAA8APQARAEIAEwA/ABcAQwAZAEQAGwAOAAoABQgACwAMAA0ADgAPAD0AEQBFABMAPwAXAEYAGQBHABsADgAKAAUJAAcASAALAAwADQAOAA8APQAR'
..'AEkAEwA/ABcASgAZAEsAGwAOAEwADwEATQBOADwABAAATwADAAABAAMCAAcAUAACAFEAAQATAgAHAFIAAgBTAAoAFAYACwAMAA0ADgARAFQAFwBVABkAVgAbAA4ACgAUBgALAAwADQAOABEAVwAXAFgAGQBZABsADgAKABQGAAsADAANAA4AEQBaABcAWwAZAFkAGwAO'
..'AAoAFAYACwAMAA0ADgARAFwAFwBdABkAXgAbAA4ACgAUCwAHAF8ACwAMAA0ADgAPAD0AEQBgADUANgATAD8AFwBhABkAYgAbAA4AOwAeAGMAGQMABwBkABEAZQAXAGYAYwAZAwAHAGcAEQBoABcAaQABABMCAAcAagACAGsACgAcBgALAAwADQAOABEAbAAXAG0AGQBu'
..'ABsADgAKABwJAAsADAANAA4ADwBvABEAcAATAHEAFQAWABcAcgAZAHMAGwAOAAoAHAkACwAMAA0ADgAPAG8AEQB0ABMAcQAVABYAFwB1ABkAdgAbAA4ACgAcCQALAAwADQAOAA8AbwARAHcAEwBxABUAFgAXAHgAGQB2ABsADgAKABwJAAsADAANAA4ADwBvABEAeQAT'
..'AHEAFQAWABcAegAZAHYAGwAOAAoAHAYACwAMAA0ADgARAHsAFwB8ABkAfQAbAA4ACgAcBgALAAwADQAOABEAfgAXAH8AGQB9ABsADgAKABwGAAsADAANAA4AEQCAABcAgQAZAIIAGwAOAAoAHAsABwBfAAsADAANAA4ADwA9ABEAgwA1ADYAEwA/ABcAhAAZAGIAGwAO'
..'ADsAHgBjACUDAAcAZAARAIUAFwCGAGMAJQMABwBnABEAhwAXAIgACgAcCQALAAwADQAOAA8AbwARAIkAEwBxABUAFgAXAIoAGQB2ABsADgAKABwJAAsADAANAA4ADwBvABEAiwATAHEAFQAWABcAjAAZAHYAGwAOAAoAHAkACwAMAA0ADgAPAG8AEQCNABMAcQAVABYA'
..'FwCOABkAdgAbAA4ACgAcCQALAAwADQAOAA8AbwARAI8AEwBxABUAFgAXAJAAGQB2ABsADgAKABwJAAsADAANAA4ADwBvABEAkQATAHEAFQAWABcAkgAZAHYAGwAOAAoAHAYACwAMAA0ADgARAJMAFwCUABkAlQAbAA4ACgAcCQALAAwADQAOAA8AbwARAJYAEwBxABUA'
..'FgAXAJcAGQB2ABsADgAKABwJAAsADAANAA4ADwBvABEAmAATAHEAFQAWABcAmQAZAHYAGwAOAAEAEwIABwCaAAIAmwAKADALAAsADAANAA4ADwCcABEAnQATAJ4AFQCfAKAAoQAXAKIAowCkABkApQAbAA4ACgAwCAALAAwADQAOABEApgCgAKEAFwCnAKMApAAZAKgA'
..'GwAOAAoAMAgACwAMAA0ADgARAKkAoAChABcAqgCjAKQAGQCoABsADgAKADAIAAsADAANAA4AEQCrAKAAoQAXAKwAowCkABkArQAbAA4ACgAwCAALAAwADQAOABEArgCgAKEAFwCvAKMApAAZAKUAGwAOAAoAMAgACwAMAA0ADgARALAAoAChABcAsQCjAKQAGQCyABsA'
..'DgAKADAIAAsADAANAA4AEQCzAKAAoQAXALQAowCkABkAsgAbAA4ACgAwCAALAAwADQAOABEAtQCgAKEAFwC2AKMApAAZALcAGwAOAAoAMAgACwAMAA0ADgARALgAoAChABcAuQCjAKQAGQCyABsADgAKADAIAAsADAANAA4AEQC6AKAAoQAXALsAowCkABkAtwAbAA4A'
..'CgAwCAALAAwADQAOABEAvACgAKEAFwC9AKMApAAZALIAGwAOAAoAMA0ABwBfAAsADAANAA4ADwA9ABEAvgA1ADYAEwA/AKAAoQAXAL8AowCkABkAYgAbAA4AOwAeAGMAPAQABwBkABEAwACgAMEAFwDCAGMAPAMABwDDABEAxAAXAMUAAQATAgAHAMYAAgDHAAoAPwgA'
..'CwAMAA0ADgARAMgAoAChABcAyQCjAKQAGQBuABsADgAKAD8LAAsADAANAA4ADwBvABEAygATAHEAFQAWAKAAoQAXAMsAowCkABkAcwAbAA4ACgA/CwALAAwADQAOAA8AbwARAMwAEwBxABUAFgCgAKEAFwDNAKMApAAZAHYAGwAOAAoAPwsACwAMAA0ADgAPAG8AEQDO'
..'ABMAcQAVABYAoAChABcAzwCjAKQAGQB2ABsADgAKAD8LAAsADAANAA4ADwBvABEA0AATAHEAFQAWAKAAoQAXANEAowCkABkAdgAbAA4ACgA/CAALAAwADQAOABEA0gCgAKEAFwDTAKMApAAZAH0AGwAOAAoAPwgACwAMAA0ADgARANQAoAChABcA1QCjAKQAGQB9ABsA'
..'DgAKAD8IAAsADAANAA4AEQDWAKAAoQAXANcAowCkABkAggAbAA4ACgA/DQAHAF8ACwAMAA0ADgAPAD0AEQDYADUANgATAD8AoAChABcA2QCjAKQAGQBiABsADgA7AB4AYwBIAwAHAGQAEQCFABcAhgBjAEgDAAcAZwARAIcAFwCIAAoAPwsACwAMAA0ADgAPAG8AEQDa'
..'ABMAcQAVABYAoAChABcA2wCjAKQAGQB2ABsADgAKAD8LAAsADAANAA4ADwBvABEA3AATAHEAFQAWAKAAoQAXAN0AowCkABkAdgAbAA4ACgA/CwALAAwADQAOAA8AbwARAN4AEwBxABUAFgCgAKEAFwDfAKMApAAZAHYAGwAOAAoAPwsACwAMAA0ADgAPAG8AEQDgABMA'
..'cQAVABYAoAChABcA4QCjAKQAGQB2ABsADgAKAD8LAAsADAANAA4ADwBvABEA4gATAHEAFQAWAKAAoQAXAOMAowCkABkAdgAbAA4ACgA/CAALAAwADQAOABEA5ACgAKEAFwDlAKMApAAZAJUAGwAOAAoAPwsACwAMAA0ADgAPAG8AEQDmABMAcQAVABYAoAChABcA5wCj'
..'AKQAGQB2ABsADgAKAD8LAAsADAANAA4ADwBvABEA6AATAHEAFQAWAKAAoQAXAOkAowCkABkAdgAbAA4AAQATAgAHAOoAAgDrAAoAUwsACwAMAA0ADgAPAJwAEQDsABMAngAVAJ8AoAChABcA7QCjAKQAGQDuABsADgAKAFMIAAsADAANAA4AEQDvAKAAoQAXAPAAowCk'
..'ABkAqAAbAA4ACgBTCAALAAwADQAOABEA8QCgAKEAFwDyAKMApAAZAKgAGwAOAAoAUwgACwAMAA0ADgARAPMAoAChABcA9ACjAKQAGQCtABsADgAKAFMIAAsADAANAA4AEQD1AKAAoQAXAPYAowCkABkA9wAbAA4ACgBTCAALAAwADQAOABEA+ACgAKEAFwD5AKMApAAZ'
..'APoAGwAOAAoAUwgACwAMAA0ADgARAPsAoAChABcA/ACjAKQAGQCyABsADgAKAFMIAAsADAANAA4AEQD9AKAAoQAXAP4AowCkABkAtwAbAA4ACgBTCAALAAwADQAOABEA/wCgAKEAFwAAAaMApAAZAAEBGwAOAAoAUwgACwAMAA0ADgARAAIBoAChABcAAwGjAKQAGQC3'
..'ABsADgAKAFMIAAsADAANAA4AEQAEAaAAoQAXAAUBowCkABkAsgAbAA4ACgBTDQAHAF8ACwAMAA0ADgAPAD0AEQAGATUANgATAD8AoAChABcABwGjAKQAGQBiABsADgA7AB4AYwBfBAAHAGQAEQDAAKAAwQAXAMIAYwBfAwAHAMMAEQDEABcAxQABABMCAAcACAECAAkB'
..'CgBiCwALAAwADQAOAA8AnAARAAoBEwCeABUAnwCgAKEAFwALAaMApAAZAO4AGwAOAAoAYggACwAMAA0ADgARAAwBoAChABcADQGjAKQAGQCoABsADgAKAGIIAAsADAANAA4AEQAOAaAAoQAXAA8BowCkABkAqAAbAA4ACgBiCAALAAwADQAOABEAEAGgAKEAFwARAaMA'
..'pAAZAK0AGwAOAAoAYggACwAMAA0ADgARABIBoAChABcAEwGjAKQAGQD3ABsADgAKAGINAAcAXwALAAwADQAOAA8APQARABQBNQA2ABMAPwCgAKEAFwAVAaMApAAZAGIAGwAOADsAHgBjAGgEAAcAZAARAMAAoADBABcAwgBjAGgDAAcAwwARAMQAFwDFAAEAYgEAAgAW'
..'AQoAawgACwAMAA0ADgARABcBoAChABcAGAGjAKQAGQCyABsADgAKAGsIAAsADAANAA4AEQAZAaAAoQAXABoBowCkABkAAQEbAA4ACgBrCAALAAwADQAOABEAGwGgAKEAFwAcAaMApAAZALcAGwAOAAEAYgEAAgAdAQoAbwgACwAMAA0ADgARAB4BoAChABcAHwGjAKQA'
..'GQD6ABsADgAKAG8IAAsADAANAA4AEQAgAaAAoQAXACEBowCkABkAtwAbAA4ACgBvCAALAAwADQAOABEAIgGgAKEAFwAjAaMApAAZALIAGwAOAAEAEwIABwAkAQIAJQEKAHMIAAsADAANAA4AEQAmAaAAoQAXACcBowAoARkAKQEbAA4ACgBzCwAHAF8ACwAMAA0ADgAP'
..'AD0AEQAqATUANgATAD8AFwArARkAYgAbAA4AOwAeAGMAdQMABwBkABEALAEXAC0BYwB1AwAHAMMAEQAuARcALwEKAHMIAAsADAANAA4AEQAwAaAAoQAXADEBowAoARkAMgEbAA4ACgBzCAALAAwADQAOABEAMwGgAKEAFwA0AaMAKAEZADUBGwAOAAoAcwgACwAMAA0A'
..'DgARADYBoAChABcANwGjACgBGQA4ARsADgAKAHMLAAsADAANAA4ADwBvABEAOQETAHEAFQAWAKAAoQAXADoBowAoARkAOwEbAA4ACgBzCAALAAwADQAOABEAPAGgAKEAFwA9AaMAKAEZAD4BGwAOAAoAcwgACwAMAA0ADgARAD8BoAChABcAQAGjACgBGQA+ARsADgAK'
..'AHMLAAsADAANAA4ADwBvABEAQQETAHEAFQAWAKAAoQAXAEIBowAoARkAQwEbAA4ACgBzCwALAAwADQAOAA8AbwARAEQBEwBxABUAFgCgAKEAFwBFAaMAKAEZAEYBGwAOAAoAcwgACwAMAA0ADgARAEcBoAChABcASAGjACgBGQBJARsADgAKAHMIAAsADAANAA4AEQBK'
..'AaAAoQAXAEsBowAoARkASQEbAA4ACgBzCAALAAwADQAOABEATAGgAKEAFwBNAaMAKAEZAE4BGwAOAE8BQAIACgBVAVYBoQAACgBXAVgBoQBzCQALAAwADwBQAREAUQETAFIBFQA4AKAAoQAXAFMBowAoARkAVAFPAUACAAoAVQFcAaEAAAoAXQFeAaEAcwkACwAMAA8A'
..'UAERAFkBEwBSARUAOACgAKEAFwBaAaMAKAEZAFsBCgBzCwALAAwADQAOAA8AbwARAF8BEwBxABUAFgCgAKEAFwBgAaMAKAEZAGEBGwAOAAoAcwsACwAMAA0ADgAPAG8AEQBiARMAcQAVABYAoAChABcAYwGjACgBGQBkARsADgAKAHMLAAsADAANAA4ADwBvABEAZQET'
..'AHEAFQAWAKAAoQAXAGYBowAoARkAZwEbAA4ACgBzCwALAAwADQAOAA8AbwARAGgBEwBxABUAFgCgAKEAFwBpAaMAKAEZAGoBGwAOAAoAcwgACwAMAA0ADgARAGsBoAChABcAbAGjACgBGQBtARsADgBPAUADAAoAcQFyAaEAAAoAcwF0AaEAAAoAdQF2AaEAcwkACwAM'
..'AA8AnAARAG4BEwCeABUAnwCgAKEAFwBvAaMAKAEZAHABCgBzCAALAAwADQAOABEAdwGgAKEAFwB4AaMAKAEZAHkBGwAOAAoAcwgACwAMAA0ADgARAHoBoAChABcAewGjACgBGQB8ARsADgAKAHMIAAsADAANAA4AEQB9AaAAoQAXAH4BowAoARkAfwEbAA4ACgBzCAAL'
..'AAwADQAOABEAgAGgAKEAFwCBAaMAKAEZAHwBGwAOAAoAAQkACwAMAA0ADgAPAJwAEQCCARMAngAVADgAFwCDARkAhAEbAA4ACgABCwALAAwADQAOAA8AnAARAIUBEwCeAKAAoQAXAIYBowAoARkAhwEbAA4AOwAeABwAkAUAHQAeAB8ADAAgAB4AIgAeACMAHgAkAJEE'
..'ACUAJgAnAB4AFwAoABkAKQAqAJIIACUAJgAnAB4AGQArACwALQAuACYAiAGJAS8AJgAwADEACgABCgALAAwADQAOAA8AnAARAIoBNQA2ABMAngAXAIsBGQBiABsADgA7AB4APACUAACMAZQAAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
