-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 22440 characters

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
	if 7 == c then
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
		if door == 1000 and door ~= "No more doors :(" then
			local cinst = game.ReplicatedStorage:FindFirstChild("Assets")[corr.Instance]
			cinst = cinst:Clone()
			if cinst.Name=="LIB" then
				cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
				if door~=1000 then
					cinst["20"]:Destroy()
				end
			end
			cinst.Parent=script
			cinst:PivotTo(CFrame.new(doormodel.Door.Position+Vector3.new(-(corr.roomdiagonalincrease/2),(corr.up/2)+corr.uproomheight,-(corr.Length/2))))
			debounce=true
			wait(.06)
			local i = doormodel:Clone()
			i.Door:Destroy()
			i.DoorHitDetection:Destroy()
			i.SP.Sound:Play()
			doormodel:PivotTo(CFrame.new(doormodel.Door.Position+Vector3.new(-(corr.roomdiagonalincrease),corr.up,-corr.Length)))
			door = "No more doors :("
			script.Parent.Door.Door.SurfaceGui.Frame.TextBox.Text=door
			i.Parent=script
			wait(.06)
			debounce=false
		else
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


local Objects = Decode('AFCFAiEFTW9kZWwhCldvcmxkUGl2b3QEXQJeAl8CBGACXgJfAgRhAl4CXwIEYgJeAl8CIQROYW1lIQREb29yBGMCXgJfAiEEUGFydCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yB2kBIQZDRnJhbWUEGABeAl8CIQVDb2xvcgZW'
..'QjYhCE1hdGVyaWFsAwAAAAAAAIBAIQhQb3NpdGlvbgqau2dCF1j1QpQUkMQhBFNpemUK2kXHQO3WA0EYhSM/IQpUb3BTdXJmYWNlIQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEQQ2xpcHNEZXNjZW5kYW50cyEERmFjZQMAAAAAAAAAQCEOTGln'
..'aHRJbmZsdWVuY2UhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIQdUZXh0Qm94DAAAgD8AAAAAgD8AACEERm9udAMAAAAAAAAQQCERUGxhY2Vob2xk'
..'ZXJDb2xvcjMhBFRleHQhATAhClRleHRDb2xvcjMhCFRleHRTaXplAwAAAAAAAERAIRBEb29ySGl0RGV0ZWN0aW9uB0wBBDsAXgJfAiEKQ2FuQ29sbGlkZQIGdQAAAwAAAAAAwJhACpq7Z0IXWPVCtxGQxAp2Md9AUrgKQVyPQj8hDFRyYW5zcGFyZW5jeSEGU2NyaXB0'
..'B+oDBEIAXgJfAgbNzc0Kzv50QmQw9UJuF5DECuD74z475w1BAKMtPwRFAF4CXwIKFAxoQgfx/UJuF5DECmpr3UAg/d4+AKMtPwRIAF4CXwIK1kZaQhdY9UJuF5DECkAiFj9rYhBBAKMtPyECU1AETABeAl8CCq5+Z0JMw+xCbheQxArGQeZAQLbiPgCjLT8hBVNvdW5k'
..'IQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMTU3MTY3MjAzIQZGb2xkZXIhBkFzc2V0cyEIU3RyYWlnaHQEZAJeAl8CBFYAXgJfAgoP/61Dser9QvfAi8QKxkHmQEC24j6dw2NBBFkAXgJfAgpBO6xDjzP1QvfAi8QKAEbWPuaHEkGdw2NBBFwAXgJfAgrFzq9DjzP1QvfA'
..'i8QEXgBeAl8CCg//rUNhQuxCKsGLxArGQeZAQLbiPuj2Y0EhBVJDRU5UBGIAXgJfAgoNBa5Dpxb1Qqm9i8QKAACAQAAAgD8AAABAIQpBdHRhY2htZW50IQNFbmQEZwBeAl8CCgAAAAAAAAAAj8LjwCEJQmVnaW5uaW5nBGoAXgJfAgoAAAAAAAAAAI/C40AhAlVwBGUC'
..'XgJfAgRuAF4CXwIKlV+QQw4iCkNkv4zECjYT6UBgOSw/qLLqQQdtAQRzAGYCXwIGajkJCpVmkEOH1wBDtBSOxAr/0OZAAACAPzZz+UAEdgBmAl8CCpVmkEMOr/tC+jeNxAr/0OZAAACAP5mZmT8EeQBmAl8CCpVmkEMOr/1CYV6NxAR7AGYCXwIKlWaQQw6v/0LHhI3E'
..'BH0AXgJfAgpfIpJDNi8AQzq7jMQKwLx1PlyPpEGInehBBIAAXgJfAgptoI5DNi8AQzq7jMQEggBeAl8CCpVfkEPtrgRDFe+KxAo2E+lAzic5QQC0oj4EhQBeAl8CCtVgkENKLwBDZL+MxASHAF4CXwIKADo0vQAArECkcGfBBIkAXgJfAgoAAFU8N4m1wDCyY0EEiwBm'
..'Al8CCpVmkEMOr/dCLuuMxASNAGYCXwIKlWaQQw6v+UKUEY3EBI8AZgJfAgqVZpBDDq/xQvp3jMQEkQBmAl8CCpVmkEMPr/NCYZ6MxASTAGYCXwIKlWaQQw6v9ULHxIzEBJUAXgJfAgovZZBDsz3sQjq7jMQKxkHmQEC24j6InehBBJgAZwJfAgqVZpBDDq/tQi4rjMQE'
..'mgBmAl8CCpVmkEMOr+9ClFGMxCEKU3RyYWlnaHQtMQRoAmkCXwIHawAEowBqAmsCBgCPnAMAAAAAAICUQCELT3JpZW50YXRpb24KAAAAAAAANEMAAAAACr+un0PlcOxC9bmOxCEIUm90YXRpb24KAAA0QwAAAAAAADRDCj4m1kFAtuI+iJ3oQQSoAGoCawIK/w2ZQx0p'
..'+UL1uY7ECoCOgz4YmVJBiJ3oQQSrAGoCawIKC16mQx0p+UL1uY7EBK0AagJrAgq/rp9D5XDsQtbrjMQKPibWQUC24j4A+UY+BLAAagJrAgq/rp9DVPwCQ/W5jsQEsgBqAmsCCn/3o0MdKflCw4aQxAr8vx1BGJlSQRKpjT4EtQBqAmsCCjFzm0MdKflCw4aQxAS3AGoC'
..'awIK14GdQ4YmAUPDhpDECqq0kEFwtIBAEqmNPgS6AGoCawIKMXObQx0p+UIb64zEBLwAagJrAgrXgZ1DhiYBQxvrjMQEvgBqAmsCCn/3o0MdKflCG+uMxATAAGoCawIKBbafQ/so+UL1uY7EBMMAbAJfAgoAAAAAmhIoNwAAAAAKAEA0vcDK8b/w0mVBIQFkBMYAXgJf'
..'AgoAwFQ8wcrxvxSuacEhBERvd24EbQJeAl8CBMoAagJrAgozwYpDfl8KQ2+2jMQEzABqAmsCCjO6ikP3FAFDH2GLxATOAGoCawIKM7qKQ+4p/ELZPYzEBNAAagJrAgozuopD7in+QnIXjMQE0gBqAmsCCjO6ikP3FABDDPGLxATUAGoCawIKaf6IQ6ZsAEOZuozEBNYA'
..'agJrAgpZgIxDpmwAQ5m6jMQE2ABqAmsCCjPBikNd7ARDvoaOxATaAGoCawIK87+KQ7psAENvtozEBNwAagJrAgozuopD7in4QqWKjMQE3gBqAmsCCjO6ikPuKfpCP2SMxATgAGoCawIKM7qKQ+4p8kLZ/YzEBOIAagJrAgozuopD7yn0QnLXjMQE5ABqAmsCCjO6ikPu'
..'KfZCDLGMxATmAGoCawIKmbuKQ5O47EKZuozEBOgAagJrAgozuopD7inuQqVKjcQE6gBqAmsCCjO6ikPuKfBCPySNxCEKRGlhZ29uYWwtMQRuAl4CXwIE7gBqAmsCCprTY0MXpOxC4BuRxApkQ5FCQLbiPoid6EEE8QBqAmsCCiKiP0NRXPlC4BuRxATzAGoCawIKVRCE'
..'Q1Fc+ULgG5HEBPUAagJrAgoSwnpDF6TsQsFNj8QE9wBqAmsCCjrJY0PtFQND4BuRxAoAbZFCQLbiPoid6EEE+gBqAmsCCmp4bENRXPlCr+iSxAq1kV9CGJlSQRKpjT4E/QBqAmsCCtKNRENRXPlCr+iSxAT/AGoCawIKHqtIQyBAAUOv6JLEBAEBagJrAgoaa1tDUVz5'
..'QgZNj8QKN49fQhiZUkESqY0+BAQBagJrAgpCaHZDIEABQwZNj8QEBgFqAmsCCsmpgUNRXPlCBk2PxAQIAWoCawIKSuxjQ/Zn+ULaGpHEIQpEaWFnb25hbC0yBG8CXgJfAgQMAWoCawIKMnFkQ/ar7ELWNIzEBA4BagJrAgq6P0BDMGT5QtY0jMQEEAFqAmsCCh9fhEMw'
..'ZPlC1jSMxAQSAWoCawIKql97Q/ar7EK3ZorEBBQBagJrAgrOZmRD3BkDQ9Y0jMQEFgFqAmsCCuKJZEPSb/lC0DOMxARwAnECXwIEGQFqAmsCCn8MgkNgZPlCowGOxAQbAWoCawIKijBcQ2Bk+UKjAY7EBB0BagJrAgquLXdDKEQBQ6MBjsQEcgJxAl8CBCABagJrAgoS'
..'7mxDbGr5Qv1lisQEIgFqAmsCCsogSUMtRwFD/WWKxAQkAWoCawIKegNFQ2xq+UL9ZYrEIQNMSUIEcwJ0Al8CBCgBdQJ2Agq/1LNDfj8DQ+NdicQKAAA0wwAAAAAAADTDCnoUWEL//9tBDgNhPgQsAXcCXwIKeZOkQ34/A0Nez3zEBC4BXgJfAgoAAAAABoHlv+L6r0IE'
..'MAFeAl8CCgAAAAD6fvLAX+WvwgQyAXUCdgIKv1SkQyyHCEPjXYnECj0K6EIehYdBDgNhPgQ1AXUCdgIKd5OkQ34/EEMiy3zECgAA6kIAAMA/Sw8wQwQ4AXUCdgIKdxOVQ34/A0PjXYnECgAAXEIAANxBDgNhPgQ7AWoCawIKx4ukQ+VQ7UKIynzECgBA5kIAAIA/AAAw'
..'QwQ+AXUCdgIKyYvBQ34/A0Miy3zECgAAgD8AANxBSw8wQwRBAXUCdgIKd5OHQ34/A0Miy3zEBEMBdQJ2AgqDA5VD51DvQo7vcMQKYMOkQQAAgD/A738/BEYBdQJ2AgqDA5VD51DwQpKvcMQKYMOkQQAAAEDA738/BEkBdQJ2AgpNt49D51D2Qp5vcMQKAACAPwAAAEH4'
..'/Z9ABEwBdQJ2AgpNN5pD51D2Qp5vcMQETgF1AnYCCq2lrUPnUPZCou9vxAr+cp1CAAAAQcDvfz8hDlVuaW9uT3BlcmF0aW9uB8IABFQBdQJ2AgajoqUK+76tQxhZA0MGdnDECrgenUI/CsNBwHeUQCEMVXNlUGFydENvbG9yCq5H4T49CsNBpkWRQApPN5pDGFkDQzl5'
..'cMQKuB6dQj0Kw0EuJ+E+Cvu+rUMYWQNDou9vxARcAXUCdgIKv7SLQxhZA0MGdnDECuJ6hEE8CsNBwHeUQAquR+E+PQrDQWJGkUAKbbyPQxhZA0M4eXDECutRhEE9CsNBLifhPgp3s4tDGFkDQ6Dvb8QEYwF1AnYCCoMDlUPnUPFClm9wxApgw6RBAABAQMDvfz8EZgF1'
..'AnYCCoMDlUPnUPJCmi9wxApgw6RBAACAQMDvfz8EaQF1AnYCCoMDlUPnUPNCnu9vxApgw6RBAACgQMDvfz8EbAF1AnYCCsULlUPJS/RCFG1vxAoAAKlBKVy/QAAXRUAEbwF1AnYCCrWdi0PnUPZCou9vxApmZnZBAAAAQcDvfz8EcgF1AnYCCsWLpEPoUPRCFE1rxAoC'
..'QOZCCADAQHFREEIKAECcQgAAwEBwURBCCsXLrUPoUPRCFE1rxAoAgBxCAADAQHBRBEIKxYuRQ+hQ9EIU7WrECgAAgUEAAMBAcFEQQgrFy4tD6FD0QhRNa8QEewF1AnYCCkOApEOSbQtD2slmxAqZmRFBcD0yQQDo1j4EfgF1AnYCClkOtEN+PwND2slmxAoK11tCAADc'
..'QQDo1j4EgQF1AnYCClmOpEP8fvJC2slmxAooXA9BAADwQADo1j4EhAF1AnYCCucQlUN+PwND2slmxAR4Al4CXwIEnQF0Al8CB8cABIsBagJrAgZjX2IDAAAAAACAkEAKfkqqQ9bL/kKLNofECgDXozwAAIA/mZkZPyEFU2hhcGUEkAF5AnoCCgAAAAAAADRDAAC0Qgp+'
..'SqpD/6f3Qos2h8QKAAA0QwAAAAAAALTCCuF65EAK16M8mZkZPwSUAWoCawIKfkqqQyiE8EKLNofEB2oABJkBagJrAgbahUEDAAAAAAAAckAKfkqqQ2WO8EKLNofECorCdT0AAIA/uB4FPyEMU3VyZmFjZUxpZ2h0BJ0BeQJ6Agp/SqpD/6f3Qos2h8QK4XrkQI/CdT24'
..'HgU/BKABXgJfAgrHy6pDPZ4DQ4s2h8QKAAAAQI/C1UEAAABABKMBXgJfAgrHi6RDeqgGQ4s2h8QKAAC4QQAAgD8AAABABKYBXgJfAgrHS55DPZ4DQ4s2h8QEsgFeAl8CBKkBXgJfAgoPzZ5D1sv+Qos2h8QErAF7AnwCCgAAAAAAAAAAAAC0QgoPzZ5D/6f3Qos2h8QE'
..'rgFeAl8CCg/NnkMohPBCizaHxASwAV4CXwIKD82eQ2WO8EKLNofEBLIBewJ8AgoOzZ5D/6f3Qos2h8QhBEFyY2gEfQJeAl8CBL8BdAJfAgS3AWoCawIKfkqqQ9bL/kKLtoTEBLkBeQJ6Agp+SqpD/6f3Qou2hMQEuwFqAmsCCn5KqkMohPBCi7aExAS9AWoCawIKfkqq'
..'Q2WO8EKLtoTEBL8BeQJ6Agp/SqpD/6f3Qou2hMQEwQFeAl8CCsfLqkM9ngNDi7aExATDAV4CXwIKx4ukQ3qoBkOLtoTEBMUBXgJfAgrHS55DPZ4DQ4u2hMQE0AFeAl8CBMgBXgJfAgoPzZ5D1sv+Qou2hMQEygF7AnwCCg/NnkP/p/dCi7aExATMAV4CXwIKD82eQyiE'
..'8EKLtoTEBM4BXgJfAgoPzZ5DZY7wQou2hMQE0AF7AnwCCg7NnkP/p/dCi7aExCEHVGV4dGJveATTAV4CXwIKx4ukQ3OoBkOLtoTECsL1iEDrUbg/AAAAQCENUGl4ZWxzUGVyU3R1ZAMAAAAAAABZQAYAAAAEfgJeAl8CBOMBdAJfAgTbAWoCawIKfkqqQ9bL/kKLNoLE'
..'BN0BeQJ6Agp+SqpD/6f3Qos2gsQE3wFqAmsCCn5KqkMohPBCizaCxAThAWoCawIKfkqqQ2WO8EKLNoLEBOMBeQJ6Agp/SqpD/6f3Qos2gsQE5QFeAl8CCsfLqkM9ngNDizaCxATnAV4CXwIKx4ukQ3qoBkOLNoLEBOkBXgJfAgrHS55DPZ4DQ4s2gsQE9AFeAl8CBOwB'
..'XgJfAgoPzZ5D1sv+Qos2gsQE7gF7AnwCCg/NnkP/p/dCizaCxATwAV4CXwIKD82eQyiE8EKLNoLEBPIBXgJfAgoPzZ5DZY7wQos2gsQE9AF7AnwCCg7NnkP/p/dCizaCxAR/Al4CXwIEAAJ0Al8CBPgBagJrAgp+SqpD1sv+QhZtf8QE+gF5AnoCCn5KqkP/p/dCFm1/'
..'xAT8AWoCawIKfkqqQyiE8EIWbX/EBP4BagJrAgp+SqpDZY7wQhZtf8QEAAJ5AnoCCn9KqkP/p/dCFm1/xAQCAl4CXwIKx8uqQz2eA0MWbX/EBAQCXgJfAgrHi6RDeqgGQxZtf8QEBgJeAl8CCsdLnkM9ngNDFm1/xAQRAl4CXwIECQJeAl8CCg/NnkPWy/5CFm1/xAQL'
..'AnsCfAIKD82eQ/+n90IWbX/EBA0CXgJfAgoPzZ5DKITwQhZtf8QEDwJeAl8CCg/NnkNljvBCFm1/xAQRAnsCfAIKDs2eQ/+n90IWbX/EBIACXgJfAgQdAnQCXwIEFQJqAmsCCn5KqkPWy/5CFm16xAQXAnkCegIKfkqqQ/+n90IWbXrEBBkCagJrAgp+SqpDKITwQhZt'
..'esQEGwJqAmsCCn5KqkNljvBCFm16xAQdAnkCegIKf0qqQ/+n90IWbXrEBB8CXgJfAgrHy6pDPZ4DQxZtesQEIQJeAl8CCseLpEN6qAZDFm16xAQjAl4CXwIKx0ueQz2eA0MWbXrEBC4CXgJfAgQmAl4CXwIKD82eQ9bL/kIWbXrEBCgCewJ8AgoPzZ5D/6f3QhZtesQE'
..'KgJeAl8CCg/NnkMohPBCFm16xAQsAl4CXwIKD82eQ2WO8EIWbXrEBC4CewJ8AgoOzZ5D/6f3QhZtesQEgQJeAl8CBDoCdAJfAgQyAmoCawIKfkqqQ9bL/kIWbXXEBDQCeQJ6Agp+SqpD/6f3QhZtdcQENgJqAmsCCn5KqkMohPBCFm11xAQ4AmoCawIKfkqqQ2WO8EIW'
..'bXXEBDoCeQJ6Agp/SqpD/6f3QhZtdcQEPAJeAl8CCsfLqkM9ngNDFm11xAQ+Al4CXwIKx4ukQ3qoBkMWbXXEBEACXgJfAgrHS55DPZ4DQxZtdcQESwJeAl8CBEMCXgJfAgoPzZ5D1sv+QhZtdcQERQJ7AnwCCg/NnkP/p/dCFm11xARHAl4CXwIKD82eQyiE8EIWbXXE'
..'BEkCXgJfAgoPzZ5DZY7wQhZtdcQESwJ7AnwCCg7NnkP/p/dCFm11xCECMjAEggKDAoQCIQMtLS0EUAKFAmsCCrGFpEMtBwJDiIpnxAqPwl1BexQ2QQrXw0AhDUJpbmRhYmxlRXZlbnQEVAJeAl8CChCbZkIlhexCmZqLxAowM7FCj8L1PSlcj0IEVwJeAl8CCgAAAACu'
..'R5FAAAAAAAoAAIA/AACAPwAAgD8hD1Byb3hpbWl0eVByb21wdCEKT2JqZWN0VGV4dCE9R29sZDNuRjFyMydzIERvb3JzIEVuZ2luZS4KCkludGVyYWN0IHdpdGggbWUgdG8gcGxheSAiZG9vcnMiLiETUmVxdWlyZXNMaW5lT2ZTaWdodAo/9b9DvAmVQh/NEsQKAACA'
..'PwAAAAAAAAAACgAAAAAAAIA/AAAAAAoCimZCuiwOQyd1h8QKrn5nQjtZ9UKOFIfECrobhkLwXvVCloGJxAqufmdCPFn1QusTkMQKAwWuQ4kW9UKmvYvECtNgkEMsLwBDZL+MxAr9/38/AAAAAAAAAAAK//9/PwAAAAAAAAAACgW2n0MdKflC9bmOxAoAAIC/AAAAAC69'
..'u7MKAACAvy69u7PtrQkoCi69u7MAAIA/Lr27swoAAIA/AAAAAC69O7QK9b+KQ5xsAENvtozECkrsY0P4Z/lC2hqRxAriiWRD1m/5QtAzjMQK0qJkQ2Bk+UKjAY7ECgAAgL8AAAAALr27MwriemRDbWr5Qv1lisQKd5OkQ34/A0Nez3zECgAAgL8AAAAAAAAAAAoAAIC/'
..'Lr27M+2tCSgKLr27MwAAgD8uvbszCgAAgD8AAAAALr27swrHi6RDPZ4DQ4s2h8QKLr07swAAgD8uvbuzCgAAgD8uvTsz7a2JpwouvTuzAACAPwAAAAAKAACAvy69O7MAAAAACseLpEM9ngNDi7aExArHi6RDPZ4DQ4s2gsQKx4ukQz2eA0MWbX/ECseLpEM9ngNDFm16'
..'xArHi6RDPZ4DQxZtdcQKO5WkQ/cgBkMvz4TECgAAgD8uvTsz7a0JpwouvTuzAACAPy69O7MKAACAPy69uzNaHI4nKQEBAAAAAQACAAMAAQABAAEAAgAEAAEAAgABAAIABQABAAMAAQACAAYAAQAEAAIABwAIAAIACQAKAAUACgAHAAgACwAMAA0ADgAPABAAEQASABMA'
..'FAAVABYAFwAYABkAGgAbAA4AHAAGAAUAHQAeAB8ADAAgACEAIgAeACMAHgAkAAcABAAlACYAJwAeABcAKAAZACkAKgAIAAgAJQAmACcAHgAZACsALAAtAC4AJgAvADAAMQAmADIAMwAKAAUADAAHADQACwAMAA0ADgAPADUAEQA2ADcAOAATADkAFQA6ABcAOwAZADwA'
..'GwAOAD0AHgA+AAoAAAAKAAUACAALAAwADQAOAA8APwARAEAAEwBBABcAQgAZAEMAGwAOAAoABQAIAAsADAANAA4ADwA/ABEARAATAEEAFwBFABkARgAbAA4ACgAFAAgACwAMAA0ADgAPAD8AEQBHABMAQQAXAEgAGQBJABsADgAKAAUACQAHAEoACwAMAA0ADgAPAD8A'
..'EQBLABMAQQAXAEwAGQBNABsADgBOAA8AAQBPAFAAUQAEAAEABwBSAAEAEQACAAcAUwACAFQACgASAAYACwAMAA0ADgARAFUAFwBWABkAVwAbAA4ACgASAAYACwAMAA0ADgARAFgAFwBZABkAWgAbAA4ACgASAAYACwAMAA0ADgARAFsAFwBcABkAWgAbAA4ACgASAAYA'
..'CwAMAA0ADgARAF0AFwBeABkAXwAbAA4ACgASAAsABwBgAAsADAANAA4ADwA/ABEAYQA3ADgAEwBBABcAYgAZAGMAGwAOAD0AHgBkABcAAwAHAGUAEQBmABcAZwBkABcAAwAHAGgAEQBpABcAagABABEAAgAHAGsAAgBsAAoAGgAGAAsADAANAA4AEQBtABcAbgAZAG8A'
..'GwAOAAoAGgAJAAsADAANAA4ADwBwABEAcQATAHIAFQAWABcAcwAZAHQAGwAOAAoAGgAJAAsADAANAA4ADwBwABEAdQATAHIAFQAWABcAdgAZAHcAGwAOAAoAGgAJAAsADAANAA4ADwBwABEAeAATAHIAFQAWABcAeQAZAHcAGwAOAAoAGgAJAAsADAANAA4ADwBwABEA'
..'egATAHIAFQAWABcAewAZAHcAGwAOAAoAGgAGAAsADAANAA4AEQB8ABcAfQAZAH4AGwAOAAoAGgAGAAsADAANAA4AEQB/ABcAgAAZAH4AGwAOAAoAGgAGAAsADAANAA4AEQCBABcAggAZAIMAGwAOAAoAGgALAAcAYAALAAwADQAOAA8APwARAIQANwA4ABMAQQAXAIUA'
..'GQBjABsADgA9AB4AZAAjAAMABwBlABEAhgAXAIcAZAAjAAMABwBoABEAiAAXAIkACgAaAAkACwAMAA0ADgAPAHAAEQCKABMAcgAVABYAFwCLABkAdwAbAA4ACgAaAAkACwAMAA0ADgAPAHAAEQCMABMAcgAVABYAFwCNABkAdwAbAA4ACgAaAAkACwAMAA0ADgAPAHAA'
..'EQCOABMAcgAVABYAFwCPABkAdwAbAA4ACgAaAAkACwAMAA0ADgAPAHAAEQCQABMAcgAVABYAFwCRABkAdwAbAA4ACgAaAAkACwAMAA0ADgAPAHAAEQCSABMAcgAVABYAFwCTABkAdwAbAA4ACgAaAAYACwAMAA0ADgARAJQAFwCVABkAlgAbAA4ACgAaAAkACwAMAA0A'
..'DgAPAHAAEQCXABMAcgAVABYAFwCYABkAdwAbAA4ACgAaAAkACwAMAA0ADgAPAHAAEQCZABMAcgAVABYAFwCaABkAdwAbAA4AAQARAAIABwCbAAIAnAAKAC4ACwALAAwADQAOAA8AnQARAJ4AEwCfABUAoAChAKIAFwCjAKQApQAZAKYAGwAOAAoALgAIAAsADAANAA4A'
..'EQCnAKEAogAXAKgApAClABkAqQAbAA4ACgAuAAgACwAMAA0ADgARAKoAoQCiABcAqwCkAKUAGQCpABsADgAKAC4ACAALAAwADQAOABEArAChAKIAFwCtAKQApQAZAK4AGwAOAAoALgAIAAsADAANAA4AEQCvAKEAogAXALAApAClABkApgAbAA4ACgAuAAgACwAMAA0A'
..'DgARALEAoQCiABcAsgCkAKUAGQCzABsADgAKAC4ACAALAAwADQAOABEAtAChAKIAFwC1AKQApQAZALMAGwAOAAoALgAIAAsADAANAA4AEQC2AKEAogAXALcApAClABkAuAAbAA4ACgAuAAgACwAMAA0ADgARALkAoQCiABcAugCkAKUAGQCzABsADgAKAC4ACAALAAwA'
..'DQAOABEAuwChAKIAFwC8AKQApQAZALgAGwAOAAoALgAIAAsADAANAA4AEQC9AKEAogAXAL4ApAClABkAswAbAA4ACgAuAA0ABwBgAAsADAANAA4ADwA/ABEAvwA3ADgAEwBBAKEAogAXAMAApAClABkAYwAbAA4APQAeAGQAOgAEAAcAZQARAMEAoQDCABcAwwBkADoA'
..'AwAHAMQAEQDFABcAxgABABEAAgAHAMcAAgDIAAoAPQAIAAsADAANAA4AEQDJAKEAogAXAMoApAClABkAbwAbAA4ACgA9AAsACwAMAA0ADgAPAHAAEQDLABMAcgAVABYAoQCiABcAzACkAKUAGQB0ABsADgAKAD0ACwALAAwADQAOAA8AcAARAM0AEwByABUAFgChAKIA'
..'FwDOAKQApQAZAHcAGwAOAAoAPQALAAsADAANAA4ADwBwABEAzwATAHIAFQAWAKEAogAXANAApAClABkAdwAbAA4ACgA9AAsACwAMAA0ADgAPAHAAEQDRABMAcgAVABYAoQCiABcA0gCkAKUAGQB3ABsADgAKAD0ACAALAAwADQAOABEA0wChAKIAFwDUAKQApQAZAH4A'
..'GwAOAAoAPQAIAAsADAANAA4AEQDVAKEAogAXANYApAClABkAfgAbAA4ACgA9AAgACwAMAA0ADgARANcAoQCiABcA2ACkAKUAGQCDABsADgAKAD0ADQAHAGAACwAMAA0ADgAPAD8AEQDZADcAOAATAEEAoQCiABcA2gCkAKUAGQBjABsADgA9AB4AZABGAAMABwBlABEA'
..'hgAXAIcAZABGAAMABwBoABEAiAAXAIkACgA9AAsACwAMAA0ADgAPAHAAEQDbABMAcgAVABYAoQCiABcA3ACkAKUAGQB3ABsADgAKAD0ACwALAAwADQAOAA8AcAARAN0AEwByABUAFgChAKIAFwDeAKQApQAZAHcAGwAOAAoAPQALAAsADAANAA4ADwBwABEA3wATAHIA'
..'FQAWAKEAogAXAOAApAClABkAdwAbAA4ACgA9AAsACwAMAA0ADgAPAHAAEQDhABMAcgAVABYAoQCiABcA4gCkAKUAGQB3ABsADgAKAD0ACwALAAwADQAOAA8AcAARAOMAEwByABUAFgChAKIAFwDkAKQApQAZAHcAGwAOAAoAPQAIAAsADAANAA4AEQDlAKEAogAXAOYA'
..'pAClABkAlgAbAA4ACgA9AAsACwAMAA0ADgAPAHAAEQDnABMAcgAVABYAoQCiABcA6ACkAKUAGQB3ABsADgAKAD0ACwALAAwADQAOAA8AcAARAOkAEwByABUAFgChAKIAFwDqAKQApQAZAHcAGwAOAAEAEQACAAcA6wACAOwACgBRAAsACwAMAA0ADgAPAJ0AEQDtABMA'
..'nwAVAKAAoQCiABcA7gCkAKUAGQDvABsADgAKAFEACAALAAwADQAOABEA8AChAKIAFwDxAKQApQAZAKkAGwAOAAoAUQAIAAsADAANAA4AEQDyAKEAogAXAPMApAClABkAqQAbAA4ACgBRAAgACwAMAA0ADgARAPQAoQCiABcA9QCkAKUAGQCuABsADgAKAFEACAALAAwA'
..'DQAOABEA9gChAKIAFwD3AKQApQAZAPgAGwAOAAoAUQAIAAsADAANAA4AEQD5AKEAogAXAPoApAClABkA+wAbAA4ACgBRAAgACwAMAA0ADgARAPwAoQCiABcA/QCkAKUAGQCzABsADgAKAFEACAALAAwADQAOABEA/gChAKIAFwD/AKQApQAZALgAGwAOAAoAUQAIAAsA'
..'DAANAA4AEQAAAaEAogAXAAEBpAClABkAAgEbAA4ACgBRAAgACwAMAA0ADgARAAMBoQCiABcABAGkAKUAGQC4ABsADgAKAFEACAALAAwADQAOABEABQGhAKIAFwAGAaQApQAZALMAGwAOAAoAUQANAAcAYAALAAwADQAOAA8APwARAAcBNwA4ABMAQQChAKIAFwAIAaQA'
..'pQAZAGMAGwAOAD0AHgBkAF0ABAAHAGUAEQDBAKEAwgAXAMMAZABdAAMABwDEABEAxQAXAMYAAQARAAIABwAJAQIACgEKAGAACwALAAwADQAOAA8AnQARAAsBEwCfABUAoAChAKIAFwAMAaQApQAZAO8AGwAOAAoAYAAIAAsADAANAA4AEQANAaEAogAXAA4BpAClABkA'
..'qQAbAA4ACgBgAAgACwAMAA0ADgARAA8BoQCiABcAEAGkAKUAGQCpABsADgAKAGAACAALAAwADQAOABEAEQGhAKIAFwASAaQApQAZAK4AGwAOAAoAYAAIAAsADAANAA4AEQATAaEAogAXABQBpAClABkA+AAbAA4ACgBgAA0ABwBgAAsADAANAA4ADwA/ABEAFQE3ADgA'
..'EwBBAKEAogAXABYBpAClABkAYwAbAA4APQAeAGQAZgAEAAcAZQARAMEAoQDCABcAwwBkAGYAAwAHAMQAEQDFABcAxgABAGAAAQACABcBCgBpAAgACwAMAA0ADgARABgBoQCiABcAGQGkAKUAGQCzABsADgAKAGkACAALAAwADQAOABEAGgGhAKIAFwAbAaQApQAZAAIB'
..'GwAOAAoAaQAIAAsADAANAA4AEQAcAaEAogAXAB0BpAClABkAuAAbAA4AAQBgAAEAAgAeAQoAbQAIAAsADAANAA4AEQAfAaEAogAXACABpAClABkA+wAbAA4ACgBtAAgACwAMAA0ADgARACEBoQCiABcAIgGkAKUAGQC4ABsADgAKAG0ACAALAAwADQAOABEAIwGhAKIA'
..'FwAkAaQApQAZALMAGwAOAAEAEQACAAcAJQECACYBCgBxAAgACwAMAA0ADgARACcBoQCiABcAKAGkACkBGQAqARsADgAKAHEACwAHAGAACwAMAA0ADgAPAD8AEQArATcAOAATAEEAFwAsARkAYwAbAA4APQAeAGQAcwADAAcAZQARAC0BFwAuAWQAcwADAAcAxAARAC8B'
..'FwAwAQoAcQAIAAsADAANAA4AEQAxAaEAogAXADIBpAApARkAMwEbAA4ACgBxAAgACwAMAA0ADgARADQBoQCiABcANQGkACkBGQA2ARsADgAKAHEACAALAAwADQAOABEANwGhAKIAFwA4AaQAKQEZADkBGwAOAAoAcQALAAsADAANAA4ADwBwABEAOgETAHIAFQAWAKEA'
..'ogAXADsBpAClABkAPAEbAA4ACgBxAAgACwAMAA0ADgARAD0BoQCiABcAPgGkACkBGQA/ARsADgAKAHEACAALAAwADQAOABEAQAGhAKIAFwBBAaQAKQEZAD8BGwAOAAoAcQALAAsADAANAA4ADwBwABEAQgETAHIAFQAWAKEAogAXAEMBpAApARkARAEbAA4ACgBxAAsA'
..'CwAMAA0ADgAPAHAAEQBFARMAcgAVABYAoQCiABcARgGkACkBGQBHARsADgAKAHEACAALAAwADQAOABEASAGhAKIAFwBJAaQAKQEZAEoBGwAOAAoAcQAIAAsADAANAA4AEQBLAaEAogAXAEwBpAApARkASgEbAA4ACgBxAAgACwAMAA0ADgARAE0BoQCiABcATgGkACkB'
..'GQBPARsADgBQAUACAAoAVwFYAaIAAAoAWQFaAaIAcQAKAAsADAAPAFEBEQBSARMAUwEVADoAoQCiABcAVAGkACkBGQBVAVYBDABQAUACAAoAXgFfAaIAAAoAYAFhAaIAcQAKAAsADAAPAFEBEQBbARMAUwEVADoAoQCiABcAXAGkACkBGQBdAVYBDAAKAHEACwALAAwA'
..'DQAOAA8AcAARAGIBEwByABUAFgChAKIAFwBjAaQAKQEZAGQBGwAOAAoAcQALAAsADAANAA4ADwBwABEAZQETAHIAFQAWAKEAogAXAGYBpAApARkAZwEbAA4ACgBxAAsACwAMAA0ADgAPAHAAEQBoARMAcgAVABYAoQCiABcAaQGkACkBGQBqARsADgAKAHEACwALAAwA'
..'DQAOAA8AcAARAGsBEwByABUAFgChAKIAFwBsAaQAKQEZAG0BGwAOAAoAcQAIAAsADAANAA4AEQBuAaEAogAXAG8BpAApARkAcAEbAA4AUAFAAwAKAHQBdQGiAAAKAHYBdwGiAAAKAHgBeQGiAHEACgALAAwADwCdABEAcQETAJ8AFQCgAKEAogAXAHIBpAApARkAcwFW'
..'AQwACgBxAAgACwAMAA0ADgARAHoBoQCiABcAewGkACkBGQB8ARsADgAKAHEACAALAAwADQAOABEAfQGhAKIAFwB+AaQAKQEZAH8BGwAOAAoAcQAIAAsADAANAA4AEQCAAaEAogAXAIEBpAApARkAggEbAA4ACgBxAAgACwAMAA0ADgARAIMBoQCiABcAhAGkACkBGQB/'
..'ARsADgABAHEAAQACAIUBAQCNAAEAAgCGAQoAjgAMAAsADAANAA4ADwCHAREAiAETAIkBFQCKAaEAogAXAIsBpAClABkAjAEbAA4AjQEhAAoAjgALAAsADAANAA4ADwCHAREAjgETAIkBFQCKAaEAjwEXAJABpACRARkAkgEbAA4ACgCOAAwACwAMAA0ADgAPAIcBEQCT'
..'ARMAiQEVAIoBoQCiABcAlAGkAKUAGQCMARsADgCNASEACgCOAAwACwAMAA0ADgAPAJUBEQCWARMAlwEVAJgBoQCiABcAmQGkAKUAGQCaARsADgCNASEAmwGSAAIAEwCXASAADgAKAI4ACwALAAwADQAOAA8AlQERAJwBEwCXARUAmAGhAI8BFwCdAaQAkQEZAJ4BGwAO'
..'AJsBlAACABMAlwEgAA4ACgCOAAwACwAMAA0ADgAPAJUBEQCIARMAlwEVAJgBoQCiABcAiwGkAKUAGQCaARsADgCNASEAmwGWAAIAEwCXASAADgAKAI0ABgALAAwADQAOABEAnwEXAKABGQChARsADgAKAI0ABgALAAwADQAOABEAogEXAKMBGQCkARsADgAKAI0ABgAL'
..'AAwADQAOABEApQEXAKYBGQChARsADgABAI0AAQACAKcBCgCbAAoACwAMAA0ADgAPAIcBEQCoARMAiQEVAIoBFwCpARkAjAEbAA4AjQEhAAoAmwALAAsADAANAA4ADwCHAREAqgETAIkBFQCKAaEAqwEXAKwBpACrARkAkgEbAA4ACgCbAAoACwAMAA0ADgAPAIcBEQCt'
..'ARMAiQEVAIoBFwCuARkAjAEbAA4AjQEhAAoAmwAKAAsADAANAA4ADwCVAREArwETAJcBFQCYARcAsAEZAJoBGwAOAI0BIQCbAZ8AAgATAJcBIAAOAAoAmwALAAsADAANAA4ADwCVAREAsQETAJcBFQCYAaEAqwEXALIBpACrARkAngEbAA4AmwGhAAIAEwCXASAADgAK'
..'AJsACgALAAwADQAOAA8AlQERAKgBEwCXARUAmAEXAKkBGQCaARsADgCNASEAmwGjAAIAEwCXASAADgABAHEAAgAHALMBAgC0AQEApQABAAIAtQEKAKYADAALAAwADQAOAA8AhwERALYBEwCJARUAigGhAKIAFwC3AaQApQAZAIwBGwAOAI0BIQAKAKYACwALAAwADQAO'
..'AA8AhwERALgBEwCJARUAigGhAI8BFwC5AaQAkQEZAJIBGwAOAAoApgAMAAsADAANAA4ADwCHAREAugETAIkBFQCKAaEAogAXALsBpAClABkAjAEbAA4AjQEhAAoApgAMAAsADAANAA4ADwCVAREAvAETAJcBFQCYAaEAogAXAL0BpAClABkAmgEbAA4AjQEhAJsBqgAC'
..'ABMAlwEgAA4ACgCmAAsACwAMAA0ADgAPAJUBEQC+ARMAlwEVAJgBoQCPARcAvwGkAJEBGQCeARsADgCbAawAAgATAJcBIAAOAAoApgAMAAsADAANAA4ADwCVAREAtgETAJcBFQCYAaEAogAXALcBpAClABkAmgEbAA4AjQEhAJsBrgACABMAlwEgAA4ACgClAAYACwAM'
..'AA0ADgARAMABFwDBARkAoQEbAA4ACgClAAYACwAMAA0ADgARAMIBFwDDARkApAEbAA4ACgClAAYACwAMAA0ADgARAMQBFwDFARkAoQEbAA4AAQClAAEAAgDGAQoAswAKAAsADAANAA4ADwCHAREAxwETAIkBFQCKARcAyAEZAIwBGwAOAI0BIQAKALMACwALAAwADQAO'
..'AA8AhwERAMkBEwCJARUAigGhAKsBFwDKAaQAqwEZAJIBGwAOAAoAswAKAAsADAANAA4ADwCHAREAywETAIkBFQCKARcAzAEZAIwBGwAOAI0BIQAKALMACgALAAwADQAOAA8AlQERAM0BEwCXARUAmAEXAM4BGQCaARsADgCNASEAmwG3AAIAEwCXASAADgAKALMACwAL'
..'AAwADQAOAA8AlQERAM8BEwCXARUAmAGhAKsBFwDQAaQAqwEZAJ4BGwAOAJsBuQACABMAlwEgAA4ACgCzAAoACwAMAA0ADgAPAJUBEQDHARMAlwEVAJgBFwDIARkAmgEbAA4AjQEhAJsBuwACABMAlwEgAA4ACgClAAcABwDRAQsADAANAA4AEQDSARcA0wEZANQBGwAO'
..'ABwAvQAFAB0AHgAfAAwAIgAeANUB1gEjAB4AJAC+AAMAJQAmACcAHgAZACsAKgC/AAYAJQAmACcAHgAZACsALAAtADEA1wEyANYBAQBxAAEAAgDYAQEAwQABAAIA2QEKAMIADAALAAwADQAOAA8AhwERANoBEwCJARUAigGhAKIAFwDbAaQApQAZAIwBGwAOAI0BIQAK'
..'AMIACwALAAwADQAOAA8AhwERANwBEwCJARUAigGhAI8BFwDdAaQAkQEZAJIBGwAOAAoAwgAMAAsADAANAA4ADwCHAREA3gETAIkBFQCKAaEAogAXAN8BpAClABkAjAEbAA4AjQEhAAoAwgAMAAsADAANAA4ADwCVAREA4AETAJcBFQCYAaEAogAXAOEBpAClABkAmgEb'
..'AA4AjQEhAJsBxgACABMAlwEgAA4ACgDCAAsACwAMAA0ADgAPAJUBEQDiARMAlwEVAJgBoQCPARcA4wGkAJEBGQCeARsADgCbAcgAAgATAJcBIAAOAAoAwgAMAAsADAANAA4ADwCVAREA2gETAJcBFQCYAaEAogAXANsBpAClABkAmgEbAA4AjQEhAJsBygACABMAlwEg'
..'AA4ACgDBAAYACwAMAA0ADgARAOQBFwDlARkAoQEbAA4ACgDBAAYACwAMAA0ADgARAOYBFwDnARkApAEbAA4ACgDBAAYACwAMAA0ADgARAOgBFwDpARkAoQEbAA4AAQDBAAEAAgDqAQoAzwAKAAsADAANAA4ADwCHAREA6wETAIkBFQCKARcA7AEZAIwBGwAOAI0BIQAK'
..'AM8ACwALAAwADQAOAA8AhwERAO0BEwCJARUAigGhAKsBFwDuAaQAqwEZAJIBGwAOAAoAzwAKAAsADAANAA4ADwCHAREA7wETAIkBFQCKARcA8AEZAIwBGwAOAI0BIQAKAM8ACgALAAwADQAOAA8AlQERAPEBEwCXARUAmAEXAPIBGQCaARsADgCNASEAmwHTAAIAEwCX'
..'ASAADgAKAM8ACwALAAwADQAOAA8AlQERAPMBEwCXARUAmAGhAKsBFwD0AaQAqwEZAJ4BGwAOAJsB1QACABMAlwEgAA4ACgDPAAoACwAMAA0ADgAPAJUBEQDrARMAlwEVAJgBFwDsARkAmgEbAA4AjQEhAJsB1wACABMAlwEgAA4AAQBxAAEAAgD1AQEA2QABAAIA9gEK'
..'ANoADAALAAwADQAOAA8AhwERAPcBEwCJARUAigGhAKIAFwD4AaQApQAZAIwBGwAOAI0BIQAKANoACwALAAwADQAOAA8AhwERAPkBEwCJARUAigGhAI8BFwD6AaQAkQEZAJIBGwAOAAoA2gAMAAsADAANAA4ADwCHAREA+wETAIkBFQCKAaEAogAXAPwBpAClABkAjAEb'
..'AA4AjQEhAAoA2gAMAAsADAANAA4ADwCVAREA/QETAJcBFQCYAaEAogAXAP4BpAClABkAmgEbAA4AjQEhAJsB3gACABMAlwEgAA4ACgDaAAsACwAMAA0ADgAPAJUBEQD/ARMAlwEVAJgBoQCPARcAAAKkAJEBGQCeARsADgCbAeAAAgATAJcBIAAOAAoA2gAMAAsADAAN'
..'AA4ADwCVAREA9wETAJcBFQCYAaEAogAXAPgBpAClABkAmgEbAA4AjQEhAJsB4gACABMAlwEgAA4ACgDZAAYACwAMAA0ADgARAAECFwACAhkAoQEbAA4ACgDZAAYACwAMAA0ADgARAAMCFwAEAhkApAEbAA4ACgDZAAYACwAMAA0ADgARAAUCFwAGAhkAoQEbAA4AAQDZ'
..'AAEAAgAHAgoA5wAKAAsADAANAA4ADwCHAREACAITAIkBFQCKARcACQIZAIwBGwAOAI0BIQAKAOcACwALAAwADQAOAA8AhwERAAoCEwCJARUAigGhAKsBFwALAqQAqwEZAJIBGwAOAAoA5wAKAAsADAANAA4ADwCHAREADAITAIkBFQCKARcADQIZAIwBGwAOAI0BIQAK'
..'AOcACgALAAwADQAOAA8AlQERAA4CEwCXARUAmAEXAA8CGQCaARsADgCNASEAmwHrAAIAEwCXASAADgAKAOcACwALAAwADQAOAA8AlQERABACEwCXARUAmAGhAKsBFwARAqQAqwEZAJ4BGwAOAJsB7QACABMAlwEgAA4ACgDnAAoACwAMAA0ADgAPAJUBEQAIAhMAlwEV'
..'AJgBFwAJAhkAmgEbAA4AjQEhAJsB7wACABMAlwEgAA4AAQBxAAEAAgASAgEA8QABAAIAEwIKAPIADAALAAwADQAOAA8AhwERABQCEwCJARUAigGhAKIAFwAVAqQApQAZAIwBGwAOAI0BIQAKAPIACwALAAwADQAOAA8AhwERABYCEwCJARUAigGhAI8BFwAXAqQAkQEZ'
..'AJIBGwAOAAoA8gAMAAsADAANAA4ADwCHAREAGAITAIkBFQCKAaEAogAXABkCpAClABkAjAEbAA4AjQEhAAoA8gAMAAsADAANAA4ADwCVAREAGgITAJcBFQCYAaEAogAXABsCpAClABkAmgEbAA4AjQEhAJsB9gACABMAlwEgAA4ACgDyAAsACwAMAA0ADgAPAJUBEQAc'
..'AhMAlwEVAJgBoQCPARcAHQKkAJEBGQCeARsADgCbAfgAAgATAJcBIAAOAAoA8gAMAAsADAANAA4ADwCVAREAFAITAJcBFQCYAaEAogAXABUCpAClABkAmgEbAA4AjQEhAJsB+gACABMAlwEgAA4ACgDxAAYACwAMAA0ADgARAB4CFwAfAhkAoQEbAA4ACgDxAAYACwAM'
..'AA0ADgARACACFwAhAhkApAEbAA4ACgDxAAYACwAMAA0ADgARACICFwAjAhkAoQEbAA4AAQDxAAEAAgAkAgoA/wAKAAsADAANAA4ADwCHAREAJQITAIkBFQCKARcAJgIZAIwBGwAOAI0BIQAKAP8ACwALAAwADQAOAA8AhwERACcCEwCJARUAigGhAKsBFwAoAqQAqwEZ'
..'AJIBGwAOAAoA/wAKAAsADAANAA4ADwCHAREAKQITAIkBFQCKARcAKgIZAIwBGwAOAI0BIQAKAP8ACgALAAwADQAOAA8AlQERACsCEwCXARUAmAEXACwCGQCaARsADgCNASEAmwEDAQIAEwCXASAADgAKAP8ACwALAAwADQAOAA8AlQERAC0CEwCXARUAmAGhAKsBFwAu'
..'AqQAqwEZAJ4BGwAOAJsBBQECABMAlwEgAA4ACgD/AAoACwAMAA0ADgAPAJUBEQAlAhMAlwEVAJgBFwAmAhkAmgEbAA4AjQEhAJsBBwECABMAlwEgAA4AAQBxAAEAAgAvAgEACQEBAAIAMAIKAAoBDAALAAwADQAOAA8AhwERADECEwCJARUAigGhAKIAFwAyAqQApQAZ'
..'AIwBGwAOAI0BIQAKAAoBCwALAAwADQAOAA8AhwERADMCEwCJARUAigGhAI8BFwA0AqQAkQEZAJIBGwAOAAoACgEMAAsADAANAA4ADwCHAREANQITAIkBFQCKAaEAogAXADYCpAClABkAjAEbAA4AjQEhAAoACgEMAAsADAANAA4ADwCVAREANwITAJcBFQCYAaEAogAX'
..'ADgCpAClABkAmgEbAA4AjQEhAJsBDgECABMAlwEgAA4ACgAKAQsACwAMAA0ADgAPAJUBEQA5AhMAlwEVAJgBoQCPARcAOgKkAJEBGQCeARsADgCbARABAgATAJcBIAAOAAoACgEMAAsADAANAA4ADwCVAREAMQITAJcBFQCYAaEAogAXADICpAClABkAmgEbAA4AjQEh'
..'AJsBEgECABMAlwEgAA4ACgAJAQYACwAMAA0ADgARADsCFwA8AhkAoQEbAA4ACgAJAQYACwAMAA0ADgARAD0CFwA+AhkApAEbAA4ACgAJAQYACwAMAA0ADgARAD8CFwBAAhkAoQEbAA4AAQAJAQEAAgBBAgoAFwEKAAsADAANAA4ADwCHAREAQgITAIkBFQCKARcAQwIZ'
..'AIwBGwAOAI0BIQAKABcBCwALAAwADQAOAA8AhwERAEQCEwCJARUAigGhAKsBFwBFAqQAqwEZAJIBGwAOAAoAFwEKAAsADAANAA4ADwCHAREARgITAIkBFQCKARcARwIZAIwBGwAOAI0BIQAKABcBCgALAAwADQAOAA8AlQERAEgCEwCXARUAmAEXAEkCGQCaARsADgCN'
..'ASEAmwEbAQIAEwCXASAADgAKABcBCwALAAwADQAOAA8AlQERAEoCEwCXARUAmAGhAKsBFwBLAqQAqwEZAJ4BGwAOAJsBHQECABMAlwEgAA4ACgAXAQoACwAMAA0ADgAPAJUBEQBCAhMAlwEVAJgBFwBDAhkAmgEbAA4AjQEhAJsBHwECABMAlwEgAA4AAQBxAAIABwBM'
..'AgIATQIKACEBCgAHAE4CCwAMAA0ADgAPAJUBEQBPAhMAlwEVADoAFwBQAhkAUQIbAA4APgARAAAAPgAEAAAAUgIDAAAACgABAAkACwAMAA0ADgAPAJ0AEQBTAhMAnwAVADoAFwBUAhkAVQIbAA4ACgABAAoACwAMAA0ADgAPAJ0AEQBWAjcAOAATAJ8AFQA6ABcAVwIZ'
..'AFgCGwAOAFkCJwECAFoCWwJcAjgAPgAnAQAAAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
