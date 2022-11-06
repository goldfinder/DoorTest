-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 12672 characters

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


local Objects = Decode('AECjASEFTW9kZWwhCldvcmxkUGl2b3QEiQGKAYsBBIwBigGLAQSNAYoBiwEEjgGKAYsBIQROYW1lIQREb29yBI8BigGLASEEUGFydCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yB2kBIQZDRnJhbWUEGACKAYsBIQVDb2xvcgZW'
..'QjYhCE1hdGVyaWFsAwAAAAAAAIBAIQhQb3NpdGlvbgqau2dCF1j1QpQUkMQhBFNpemUK2kXHQO3WA0EYhSM/IQpUb3BTdXJmYWNlIQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEQQ2xpcHNEZXNjZW5kYW50cyEERmFjZQMAAAAAAAAAQCEOTGln'
..'aHRJbmZsdWVuY2UhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIQdUZXh0Qm94DAAAgD8AAAAAgD8AACEERm9udAMAAAAAAAAQQCERUGxhY2Vob2xk'
..'ZXJDb2xvcjMhClRleHRDb2xvcjMhCFRleHRTaXplAwAAAAAAAERAIRBEb29ySGl0RGV0ZWN0aW9uB0wBBDkAigGLASEKQ2FuQ29sbGlkZQIGdQAAAwAAAAAAwJhACpq7Z0IXWPVCtxGQxAp2Md9AUrgKQVyPQj8hDFRyYW5zcGFyZW5jeSEGU2NyaXB0B+oDBEAAigGL'
..'AQbNzc0Kzv50QmQw9UJuF5DECuD74z475w1BAKMtPwRDAIoBiwEKFAxoQgfx/UJuF5DECmpr3UAg/d4+AKMtPwRGAIoBiwEK1kZaQhdY9UJuF5DECkAiFj9rYhBBAKMtPwRJAIoBiwEKrn5nQkzD7EJuF5DECsZB5kBAtuI+AKMtPyENQmluZGFibGVFdmVudCEGQXNz'
..'ZXRzBJABigGLASEIU3RyYWlnaHQEkQGKAYsBBFEAigGLAQoP/61Dser9QvfAi8QKxkHmQEC24j6dw2NBBFQAigGLAQpBO6xDjzP1QvfAi8QKAEbWPuaHEkGdw2NBBFcAigGLAQrFzq9DjzP1QvfAi8QEWQCKAYsBCg//rUNhQuxCKsGLxArGQeZAQLbiPuj2Y0EhBVJD'
..'RU5UBF0AigGLAQoNBa5Dpxb1Qqm9i8QKAACAQAAAgD8AAABAIQpBdHRhY2htZW50IQNFbmQEYgCKAYsBCgAAAAAAAAAAj8LjwCEJQmVnaW5uaW5nBGUAigGLAQoAAAAAAAAAAI/C40AhAlVwBJIBigGLAQRpAIoBiwEKlV+QQw4iCkNkv4zECjYT6UBgOSw/qLLqQQdt'
..'AQRuAJMBiwEGajkJCpVmkEOH1wBDtBSOxAr/0OZAAACAPzZz+UAEcQCTAYsBCpVmkEMOr/tC+jeNxAr/0OZAAACAP5mZmT8EdACTAYsBCpVmkEMOr/1CYV6NxAR2AJMBiwEKlWaQQw6v/0LHhI3EBHgAigGLAQpfIpJDNi8AQzq7jMQKwLx1PlyPpEGInehBBHsAigGL'
..'AQptoI5DNi8AQzq7jMQEfQCKAYsBCpVfkEPtrgRDFe+KxAo2E+lAzic5QQC0oj4EgACKAYsBCtVgkENKLwBDZL+MxASCAIoBiwEKADo0vQAArECkcGfBBIQAigGLAQoAAFU8N4m1wDCyY0EEhgCTAYsBCpVmkEMOr/dCLuuMxASIAJMBiwEKlWaQQw6v+UKUEY3EBIoA'
..'kwGLAQqVZpBDDq/xQvp3jMQEjACTAYsBCpVmkEMPr/NCYZ6MxASOAJMBiwEKlWaQQw6v9ULHxIzEBJAAigGLAQovZZBDsz3sQjq7jMQKxkHmQEC24j6InehBBJMAlAGLAQqVZpBDDq/tQi4rjMQElQCTAYsBCpVmkEMOr+9ClFGMxCEKU3RyYWlnaHQtMQSVAZYBiwEH'
..'awAEngCXAZgBBgCPnAMAAAAAAICUQCELT3JpZW50YXRpb24KAAAAAAAANEMAAAAACr+un0PlcOxC9bmOxCEIUm90YXRpb24KAAA0QwAAAAAAADRDCj4m1kFAtuI+iJ3oQQSjAJcBmAEK/w2ZQx0p+UL1uY7ECoCOgz4YmVJBiJ3oQQSmAJcBmAEKC16mQx0p+UL1uY7E'
..'BKgAlwGYAQq/rp9D5XDsQtbrjMQKPibWQUC24j4A+UY+BKsAlwGYAQq/rp9DVPwCQ/W5jsQErQCXAZgBCn/3o0MdKflCw4aQxAr8vx1BGJlSQRKpjT4EsACXAZgBCjFzm0MdKflCw4aQxASyAJcBmAEK14GdQ4YmAUPDhpDECqq0kEFwtIBAEqmNPgS1AJcBmAEKMXOb'
..'Qx0p+UIb64zEBLcAlwGYAQrXgZ1DhiYBQxvrjMQEuQCXAZgBCn/3o0MdKflCG+uMxAS7AJcBmAEKBbafQ/so+UL1uY7EBL4AmQGLAQoAAAAAmhIoNwAAAAAKAEA0vcDK8b/w0mVBIQFkBMEAigGLAQoAwFQ8wcrxvxSuacEhBERvd24EmgGKAYsBBMUAmwGYAQozwYpD'
..'fl8KQ2+2jMQExwCbAZgBCjO6ikP3FAFDH2GLxATJAJsBmAEKM7qKQ+4p/ELZPYzEBMsAmwGYAQozuopD7in+QnIXjMQEzQCbAZgBCjO6ikP3FABDDPGLxATPAJsBmAEKaf6IQ6ZsAEOZuozEBNEAmwGYAQpZgIxDpmwAQ5m6jMQE0wCbAZgBCjPBikNd7ARDvoaOxATV'
..'AJsBmAEK87+KQ7psAENvtozEBNcAmwGYAQozuopD7in4QqWKjMQE2QCbAZgBCjO6ikPuKfpCP2SMxATbAJsBmAEKM7qKQ+4p8kLZ/YzEBN0AmwGYAQozuopD7yn0QnLXjMQE3wCbAZgBCjO6ikPuKfZCDLGMxAThAJsBmAEKmbuKQ5O47EKZuozEBOMAmwGYAQozuopD'
..'7inuQqVKjcQE5QCbAZgBCjO6ikPuKfBCPySNxCEKRGlhZ29uYWwtMQScAYoBiwEE6QCbAZgBCprTY0MXpOxC4BuRxApkQ5FCQLbiPoid6EEE7ACbAZgBCiKiP0NRXPlC4BuRxATuAJsBmAEKVRCEQ1Fc+ULgG5HEBPAAmwGYAQoSwnpDF6TsQsFNj8QE8gCbAZgBCjrJ'
..'Y0PtFQND4BuRxAoAbZFCQLbiPoid6EEE9QCbAZgBCmp4bENRXPlCr+iSxAq1kV9CGJlSQRKpjT4E+ACbAZgBCtKNRENRXPlCr+iSxAT6AJsBmAEKHqtIQyBAAUOv6JLEBPwAmwGYAQoaa1tDUVz5QgZNj8QKN49fQhiZUkESqY0+BP8AmwGYAQpCaHZDIEABQwZNj8QE'
..'AQGbAZgBCsmpgUNRXPlCBk2PxAQDAZsBmAEKSuxjQ/Zn+ULaGpHEIQpEaWFnb25hbC0yBJ0BigGLAQQHAZsBmAEKMnFkQ/ar7ELWNIzEBAkBmwGYAQq6P0BDMGT5QtY0jMQECwGbAZgBCh9fhEMwZPlC1jSMxAQNAZsBmAEKql97Q/ar7EK3ZorEBA8BmwGYAQrOZmRD'
..'3BkDQ9Y0jMQEEQGbAZgBCuKJZEPSb/lC0DOMxASeAZ8BiwEEFAGbAZgBCn8MgkNgZPlCowGOxAQWAZsBmAEKijBcQ2Bk+UKjAY7EBBgBmwGYAQquLXdDKEQBQ6MBjsQEoAGfAYsBBBsBlwGYAQoS7mxDbGr5Qv1lisQEHQGXAZgBCsogSUMtRwFD/WWKxAQfAZcBmAEK'
..'egNFQ2xq+UL9ZYrEIQNMSUIEoQGiAYsBBCMBogGLAQq/1LNDfj8DQ+NdicQKAAA0wwAAAAAAADTDCnoUWEL//9tBDgNhPgQnAaMBiwEKeZOkQ34/A0Nez3zEBCkBigGLAQoAAAAABoHlv+L6r0IEKwGKAYsBCgAAAAD6fvLAX+WvwgQtAaIBiwEKv1SkQyyHCEPjXYnE'
..'Cj0K6EIehYdBDgNhPgQwAaIBiwEKd5OkQ34/EEMiy3zECgAA6kIAAMA/Sw8wQwQzAaIBiwEKdxOVQ34/A0PjXYnECgAAXEIAANxBDgNhPgQ2AaIBiwEKy4ukQ/RQ7UKIynzECgBA5kIAAIA/AAAwQwQ5AaIBiwEKyYvBQ34/A0Miy3zECgAAgD8AANxBSw8wQwQ8AaIB'
..'iwEKd5OHQ34/A0Miy3zEBD4BogGLAQqDA5VD51DvQo7vcMQKYMOkQQAAgD/A738/BEEBogGLAQqDA5VD51DwQpKvcMQKYMOkQQAAAEDA738/BEQBogGLAQpNt49D51D2Qp5vcMQKAACAPwAAAEH4/Z9ABEcBogGLAQpNN5pD51D2Qp5vcMQESQGiAYsBCq2lrUPnUPZC'
..'ou9vxAr+cp1CAAAAQcDvfz8hDlVuaW9uT3BlcmF0aW9uB8IABE8BogGLAQajoqUK+76tQxhZA0MGdnDECrgenUI/CsNBwHeUQAquR+E+PQrDQaZFkUAKTzeaQxhZA0M4eXDECrgenUI9CsNBLifhPgr7vq1DGFkDQ6Hvb8QEVgGiAYsBCr+0i0MYWQNDBnZwxArieoRB'
..'PArDQcB3lEAKbbyPQxhZA0M4eXDECutRhEE9CsNBLifhPgp3s4tDGFkDQ6Hvb8QEXAGiAYsBCoMDlUPnUPFClm9wxApgw6RBAABAQMDvfz8EXwGiAYsBCoMDlUPnUPJCmi9wxApgw6RBAACAQMDvfz8EYgGiAYsBCoMDlUPnUPNCnu9vxApgw6RBAACgQMDvfz8EZQGi'
..'AYsBCsULlUPJS/RCFG1vxAoAAKlBKVy/QAAXRUAEaAGiAYsBCrWdi0PnUPZCou9vxApmZnZBAAAAQcDvfz8EawGiAYsBCsWLpEPoUPRCFE1rxAoCQOZCCADAQHFREEIKAIAcQgAAwEBwUQRCCsWLkUPoUPRCFO1qxAoAAIFBAADAQHBREEIKxcuLQ+hQ9EIUTWvECgBA'
..'nEIAAMBAcFEQQgrFy61D6FD0QhRNa8QEdAGiAYsBCkOApEOSbQtD2slmxAqZmRFBcD0yQQDo1j4EdwGiAYsBClkOtEN+PwND2slmxAoK11tCAADcQQDo1j4EegGiAYsBClmOpEP8fvJC2slmxAooXA9BAADwQADo1j4EfQGiAYsBCucQlUN+PwND2slmxAR/AYoBiwEK'
..'tcvDQyWF7EKZmovECrgePUSPwvU9KVyPQgSCAaIBiwEKClcjQ1g460IerYzECgAAgEBH4bo/AABoQSEEVGV4dCElQXNzZXQgR2FsbGVyeSAoUm9vbXMvRG9vcnMgYXZhbGlhYmxlKQSHAYoBiwEKAAAAAK5HkUAAAAAAIQ9Qcm94aW1pdHlQcm9tcHQKNvW/Q7wJlUIc'
..'zRLECgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKAopmQrosDkMndYfECq5+Z0I7WfVCjhSHxAq6G4ZC8F71QpaBicQKrn5nQjxZ9ULrE5DECmG31UMI1aRBNoCGxAoDBa5DiRb1Qqa9i8QK02CQQywvAENkv4zECv3/fz8AAAAAAAAAAAr//38/AAAAAAAAAAAKBbaf'
..'Qx0p+UL1uY7ECgAAgL8AAAAALr27swoAAIC/Lr27swAAACgKLr27swAAgD8uvbuzCgAAgD8AAAAALr07tAr1v4pDnGwAQ2+2jMQKAACAvy69u7PtrQkoCkrsY0P4Z/lC2hqRxAriiWRD1m/5QtAzjMQK0qJkQ2Bk+UKjAY7ECgAAgL8AAAAALr27MwriemRDbWr5Qv1l'
..'isQKd5OkQ34/A0Nez3zECgAAgL8AAAAAAAAAAAoAAIA/AAAAAC69u7OVAQAAAQACAAMAAQABAQACAAQAAQACAQACAAUAAQADAQACAAYAAQAEAgAHAAgAAgAJAAoABQoABwAIAAsADAANAA4ADwAQABEAEgATABQAFQAWABcAGAAZABoAGwAOABwABgUAHQAeAB8ADAAg'
..'ACEAIgAeACMAHgAkAAcEACUAJgAnAB4AFwAoABkAKQAqAAgHACUAJgAnAB4AGQArACwALQAuACYALwAmADAAMQAKAAUMAAcAMgALAAwADQAOAA8AMwARADQANQA2ABMANwAVADgAFwA5ABkAOgAbAA4AOwAeADwACgAACgAFCAALAAwADQAOAA8APQARAD4AEwA/ABcA'
..'QAAZAEEAGwAOAAoABQgACwAMAA0ADgAPAD0AEQBCABMAPwAXAEMAGQBEABsADgAKAAUIAAsADAANAA4ADwA9ABEARQATAD8AFwBGABkARwAbAA4ACgAFCAALAAwADQAOAA8APQARAEgAEwA/ABcASQAZAEoAGwAOADwABAAASwADAAABAAMCAAcATAACAE0AAQASAgAH'
..'AE4AAgBPAAoAEwYACwAMAA0ADgARAFAAFwBRABkAUgAbAA4ACgATBgALAAwADQAOABEAUwAXAFQAGQBVABsADgAKABMGAAsADAANAA4AEQBWABcAVwAZAFUAGwAOAAoAEwYACwAMAA0ADgARAFgAFwBZABkAWgAbAA4ACgATCwAHAFsACwAMAA0ADgAPAD0AEQBcADUA'
..'NgATAD8AFwBdABkAXgAbAA4AOwAeAF8AGAMABwBgABEAYQAXAGIAXwAYAwAHAGMAEQBkABcAZQABABICAAcAZgACAGcACgAbBgALAAwADQAOABEAaAAXAGkAGQBqABsADgAKABsJAAsADAANAA4ADwBrABEAbAATAG0AFQAWABcAbgAZAG8AGwAOAAoAGwkACwAMAA0A'
..'DgAPAGsAEQBwABMAbQAVABYAFwBxABkAcgAbAA4ACgAbCQALAAwADQAOAA8AawARAHMAEwBtABUAFgAXAHQAGQByABsADgAKABsJAAsADAANAA4ADwBrABEAdQATAG0AFQAWABcAdgAZAHIAGwAOAAoAGwYACwAMAA0ADgARAHcAFwB4ABkAeQAbAA4ACgAbBgALAAwA'
..'DQAOABEAegAXAHsAGQB5ABsADgAKABsGAAsADAANAA4AEQB8ABcAfQAZAH4AGwAOAAoAGwsABwBbAAsADAANAA4ADwA9ABEAfwA1ADYAEwA/ABcAgAAZAF4AGwAOADsAHgBfACQDAAcAYAARAIEAFwCCAF8AJAMABwBjABEAgwAXAIQACgAbCQALAAwADQAOAA8AawAR'
..'AIUAEwBtABUAFgAXAIYAGQByABsADgAKABsJAAsADAANAA4ADwBrABEAhwATAG0AFQAWABcAiAAZAHIAGwAOAAoAGwkACwAMAA0ADgAPAGsAEQCJABMAbQAVABYAFwCKABkAcgAbAA4ACgAbCQALAAwADQAOAA8AawARAIsAEwBtABUAFgAXAIwAGQByABsADgAKABsJ'
..'AAsADAANAA4ADwBrABEAjQATAG0AFQAWABcAjgAZAHIAGwAOAAoAGwYACwAMAA0ADgARAI8AFwCQABkAkQAbAA4ACgAbCQALAAwADQAOAA8AawARAJIAEwBtABUAFgAXAJMAGQByABsADgAKABsJAAsADAANAA4ADwBrABEAlAATAG0AFQAWABcAlQAZAHIAGwAOAAEA'
..'EgIABwCWAAIAlwAKAC8LAAsADAANAA4ADwCYABEAmQATAJoAFQCbAJwAnQAXAJ4AnwCgABkAoQAbAA4ACgAvCAALAAwADQAOABEAogCcAJ0AFwCjAJ8AoAAZAKQAGwAOAAoALwgACwAMAA0ADgARAKUAnACdABcApgCfAKAAGQCkABsADgAKAC8IAAsADAANAA4AEQCn'
..'AJwAnQAXAKgAnwCgABkAqQAbAA4ACgAvCAALAAwADQAOABEAqgCcAJ0AFwCrAJ8AoAAZAKEAGwAOAAoALwgACwAMAA0ADgARAKwAnACdABcArQCfAKAAGQCuABsADgAKAC8IAAsADAANAA4AEQCvAJwAnQAXALAAnwCgABkArgAbAA4ACgAvCAALAAwADQAOABEAsQCc'
..'AJ0AFwCyAJ8AoAAZALMAGwAOAAoALwgACwAMAA0ADgARALQAnACdABcAtQCfAKAAGQCuABsADgAKAC8IAAsADAANAA4AEQC2AJwAnQAXALcAnwCgABkAswAbAA4ACgAvCAALAAwADQAOABEAuACcAJ0AFwC5AJ8AoAAZAK4AGwAOAAoALw0ABwBbAAsADAANAA4ADwA9'
..'ABEAugA1ADYAEwA/AJwAnQAXALsAnwCgABkAXgAbAA4AOwAeAF8AOwQABwBgABEAvACcAL0AFwC+AF8AOwMABwC/ABEAwAAXAMEAAQASAgAHAMIAAgDDAAoAPggACwAMAA0ADgARAMQAnACdABcAxQCfAKAAGQBqABsADgAKAD4LAAsADAANAA4ADwBrABEAxgATAG0A'
..'FQAWAJwAnQAXAMcAnwCgABkAbwAbAA4ACgA+CwALAAwADQAOAA8AawARAMgAEwBtABUAFgCcAJ0AFwDJAJ8AoAAZAHIAGwAOAAoAPgsACwAMAA0ADgAPAGsAEQDKABMAbQAVABYAnACdABcAywCfAKAAGQByABsADgAKAD4LAAsADAANAA4ADwBrABEAzAATAG0AFQAW'
..'AJwAnQAXAM0AnwCgABkAcgAbAA4ACgA+CAALAAwADQAOABEAzgCcAJ0AFwDPAJ8AoAAZAHkAGwAOAAoAPggACwAMAA0ADgARANAAnACdABcA0QCfAKAAGQB5ABsADgAKAD4IAAsADAANAA4AEQDSAJwAnQAXANMAnwCgABkAfgAbAA4ACgA+DQAHAFsACwAMAA0ADgAP'
..'AD0AEQDUADUANgATAD8AnACdABcA1QCfAKAAGQBeABsADgA7AB4AXwBHAwAHAGAAEQCBABcAggBfAEcDAAcAYwARAIMAFwCEAAoAPgsACwAMAA0ADgAPAGsAEQDWABMAbQAVABYAnACdABcA1wCfAKAAGQByABsADgAKAD4LAAsADAANAA4ADwBrABEA2AATAG0AFQAW'
..'AJwAnQAXANkAnwCgABkAcgAbAA4ACgA+CwALAAwADQAOAA8AawARANoAEwBtABUAFgCcAJ0AFwDbAJ8AoAAZAHIAGwAOAAoAPgsACwAMAA0ADgAPAGsAEQDcABMAbQAVABYAnACdABcA3QCfAKAAGQByABsADgAKAD4LAAsADAANAA4ADwBrABEA3gATAG0AFQAWAJwA'
..'nQAXAN8AnwCgABkAcgAbAA4ACgA+CAALAAwADQAOABEA4ACcAJ0AFwDhAJ8AoAAZAJEAGwAOAAoAPgsACwAMAA0ADgAPAGsAEQDiABMAbQAVABYAnACdABcA4wCfAKAAGQByABsADgAKAD4LAAsADAANAA4ADwBrABEA5AATAG0AFQAWAJwAnQAXAOUAnwCgABkAcgAb'
..'AA4AAQASAgAHAOYAAgDnAAoAUgsACwAMAA0ADgAPAJgAEQDoABMAmgAVAJsAnACdABcA6QCfAKAAGQDqABsADgAKAFIIAAsADAANAA4AEQDrAJwAnQAXAOwAnwCgABkApAAbAA4ACgBSCAALAAwADQAOABEA7QCcAJ0AFwDuAJ8AoAAZAKQAGwAOAAoAUggACwAMAA0A'
..'DgARAO8AnACdABcA8ACfAKAAGQCpABsADgAKAFIIAAsADAANAA4AEQDxAJwAnQAXAPIAnwCgABkA8wAbAA4ACgBSCAALAAwADQAOABEA9ACcAJ0AFwD1AJ8AoAAZAPYAGwAOAAoAUggACwAMAA0ADgARAPcAnACdABcA+ACfAKAAGQCuABsADgAKAFIIAAsADAANAA4A'
..'EQD5AJwAnQAXAPoAnwCgABkAswAbAA4ACgBSCAALAAwADQAOABEA+wCcAJ0AFwD8AJ8AoAAZAP0AGwAOAAoAUggACwAMAA0ADgARAP4AnACdABcA/wCfAKAAGQCzABsADgAKAFIIAAsADAANAA4AEQAAAZwAnQAXAAEBnwCgABkArgAbAA4ACgBSDQAHAFsACwAMAA0A'
..'DgAPAD0AEQACATUANgATAD8AnACdABcAAwGfAKAAGQBeABsADgA7AB4AXwBeBAAHAGAAEQC8AJwAvQAXAL4AXwBeAwAHAL8AEQDAABcAwQABABICAAcABAECAAUBCgBhCwALAAwADQAOAA8AmAARAAYBEwCaABUAmwCcAJ0AFwAHAZ8AoAAZAOoAGwAOAAoAYQgACwAM'
..'AA0ADgARAAgBnACdABcACQGfAKAAGQCkABsADgAKAGEIAAsADAANAA4AEQAKAZwAnQAXAAsBnwCgABkApAAbAA4ACgBhCAALAAwADQAOABEADAGcAJ0AFwANAZ8AoAAZAKkAGwAOAAoAYQgACwAMAA0ADgARAA4BnACdABcADwGfAKAAGQDzABsADgAKAGENAAcAWwAL'
..'AAwADQAOAA8APQARABABNQA2ABMAPwCcAJ0AFwARAZ8AoAAZAF4AGwAOADsAHgBfAGcEAAcAYAARALwAnAC9ABcAvgBfAGcDAAcAvwARAMAAFwDBAAEAYQEAAgASAQoAaggACwAMAA0ADgARABMBnACdABcAFAGfAKAAGQCuABsADgAKAGoIAAsADAANAA4AEQAVAZwA'
..'nQAXABYBnwCgABkA/QAbAA4ACgBqCAALAAwADQAOABEAFwGcAJ0AFwAYAZ8AoAAZALMAGwAOAAEAYQEAAgAZAQoAbggACwAMAA0ADgARABoBnACdABcAGwGfAKAAGQD2ABsADgAKAG4IAAsADAANAA4AEQAcAZwAnQAXAB0BnwCgABkAswAbAA4ACgBuCAALAAwADQAO'
..'ABEAHgGcAJ0AFwAfAZ8AoAAZAK4AGwAOAAEAEgIABwAgAQIAIQEKAHIIAAsADAANAA4AEQAiAZwAnQAXACMBnwAkARkAJQEbAA4ACgByCwAHAFsACwAMAA0ADgAPAD0AEQAmATUANgATAD8AFwAnARkAXgAbAA4AOwAeAF8AdAMABwBgABEAKAEXACkBXwB0AwAHAL8A'
..'EQAqARcAKwEKAHIIAAsADAANAA4AEQAsAZwAnQAXAC0BnwAkARkALgEbAA4ACgByCAALAAwADQAOABEALwGcAJ0AFwAwAZ8AJAEZADEBGwAOAAoAcggACwAMAA0ADgARADIBnACdABcAMwGfACQBGQA0ARsADgAKAHILAAsADAANAA4ADwBrABEANQETAG0AFQAWAJwA'
..'nQAXADYBnwAkARkANwEbAA4ACgByCAALAAwADQAOABEAOAGcAJ0AFwA5AZ8AJAEZADoBGwAOAAoAcggACwAMAA0ADgARADsBnACdABcAPAGfACQBGQA6ARsADgAKAHILAAsADAANAA4ADwBrABEAPQETAG0AFQAWAJwAnQAXAD4BnwAkARkAPwEbAA4ACgByCwALAAwA'
..'DQAOAA8AawARAEABEwBtABUAFgCcAJ0AFwBBAZ8AJAEZAEIBGwAOAAoAcggACwAMAA0ADgARAEMBnACdABcARAGfACQBGQBFARsADgAKAHIIAAsADAANAA4AEQBGAZwAnQAXAEcBnwAkARkARQEbAA4ACgByCAALAAwADQAOABEASAGcAJ0AFwBJAZ8AJAEZAEoBGwAO'
..'AEsBQAIACgBRAVIBnQAACgBTAVQBnQByCQALAAwADwBMAREATQETAE4BFQA4AJwAnQAXAE8BnwAkARkAUAFLAUACAAoAUQFYAZ0AAAoAWQFaAZ0AcgkACwAMAA8ATAERAFUBEwBOARUAOACcAJ0AFwBWAZ8AJAEZAFcBCgByCwALAAwADQAOAA8AawARAFsBEwBtABUA'
..'FgCcAJ0AFwBcAZ8AJAEZAF0BGwAOAAoAcgsACwAMAA0ADgAPAGsAEQBeARMAbQAVABYAnACdABcAXwGfACQBGQBgARsADgAKAHILAAsADAANAA4ADwBrABEAYQETAG0AFQAWAJwAnQAXAGIBnwAkARkAYwEbAA4ACgByCwALAAwADQAOAA8AawARAGQBEwBtABUAFgCc'
..'AJ0AFwBlAZ8AJAEZAGYBGwAOAAoAcggACwAMAA0ADgARAGcBnACdABcAaAGfACQBGQBpARsADgBLAUADAAoAbQFuAZ0AAAoAbwFwAZ0AAAoAcQFyAZ0AcgkACwAMAA8AmAARAGoBEwCaABUAmwCcAJ0AFwBrAZ8AJAEZAGwBCgByCAALAAwADQAOABEAcwGcAJ0AFwB0'
..'AZ8AJAEZAHUBGwAOAAoAcggACwAMAA0ADgARAHYBnACdABcAdwGfACQBGQB4ARsADgAKAHIIAAsADAANAA4AEQB5AZwAnQAXAHoBnwAkARkAewEbAA4ACgByCAALAAwADQAOABEAfAGcAJ0AFwB9AZ8AJAEZAHgBGwAOAAoAAQkACwAMAA0ADgAPAJgAEQB+ARMAmgAV'
..'ADgAFwB/ARkAgAEbAA4ACgABCwALAAwADQAOAA8AmAARAIEBEwCaAJwAnQAXAIIBnwAkARkAgwEbAA4AOwAeABwAjwUAHQAeAB8ADAAgAB4AIgAeACMAHgAkAJAEACUAJgAnAB4AFwAoABkAKQAqAJEIACUAJgAnAB4AGQArACwALQAuACYAhAGFAS8AJgAwADEACgAB'
..'CgALAAwADQAOAA8AmAARAIYBNQA2ABMAmgAXAIcBGQBeABsADgA7AB4APACTAACIAZMAAAA=')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
