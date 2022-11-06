-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11880 characters

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
script.Parent.Door.Door.SurfaceGui.Frame.TextLabel.Text="0"
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
		script.Parent.Door.Door.SurfaceGui.Frame.TextLabel.Text=door
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


local Objects = Decode('AECWASEFTW9kZWwhCldvcmxkUGl2b3QEfwGAAYEBBIIBgAGBAQSDAYABgQEhBE5hbWUhBERvb3IEhAGAAYEBIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IHaQEhBkNGcmFtZQQXAIABgQEhBUNvbG9yBlZCNiEITWF0'
..'ZXJpYWwDAAAAAAAAgEAhCFBvc2l0aW9uCpq7Z0KwYpBAFCAOwSEEU2l6ZQraRcdA7dYDQRiFIz8hClRvcFN1cmZhY2UhClN1cmZhY2VHdWkhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IRBDbGlwc0Rlc2NlbmRhbnRzIQRGYWNlAwAAAAAAAABAIQ5MaWdodEluZmx1'
..'ZW5jZSEKU2l6aW5nTW9kZSEFRnJhbWUhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5DAAAAAAAAM3MzD0AAAwAAIA/AAAAAAAAZAAhCVRleHRMYWJlbAwAAIA/AAAAAIA/AAAhBEZvbnQDAAAAAAAAEEAhClRleHRDb2xvcjMhCFRl'
..'eHRTaXplAwAAAAAAAERAIQtUZXh0V3JhcHBlZCEQRG9vckhpdERldGVjdGlvbgdMAQQ4AIABgQEhCkNhbkNvbGxpZGUCBnUAAAMAAAAAAMCYQAqau2dCsGKQQHuxDMEKdjHfQFK4CkFcj0I/IQxUcmFuc3BhcmVuY3khBlNjcmlwdAfqAwQ/AIABgQEGzc3NCs7+dEJ9'
..'541AQ40PwQrg++M+O+cNQQCjLT8EQgCAAYEBChQMaELZ+AxBQ40PwQpqa91AIP3ePgCjLT8ERQCAAYEBCtZGWkKwYpBAQ40PwQpAIhY/a2IQQQCjLT8ESACAAYEBCq5+Z0KlwGI+Q40PwQrGQeZAQLbiPgCjLT8hDUJpbmRhYmxlRXZlbnQhBkFzc2V0cwSFAYABgQEh'
..'CFN0cmFpZ2h0BIYBgAGBAQRQAIABgQEK1ZWHQvCXEUI/j4rACsZB5kBAtuI+ncNjQQRTAIABgQEKnIaAQqopAEI/j4rACgBG1j7mhxJBncNjQQRWAIABgQEKrdSOQqopAEI/j4rABFgAgAGBAQrVlYdCno7cQY/CisAKxkHmQEC24j7o9mNBIQVSQ0VOVARcAIABgQEK'
..'ya2HQrnf/0EPQofACgAAgEAAAIA/AAAAQCEKQXR0YWNobWVudCEDRW5kBGEAgAGBAQoAAAAAAAAAAI/C48AhCUJlZ2lubmluZwRkAIABgQEKAAAAAAAAAACPwuNAIQJVcASHAYABgQEEaACAAYEBCpglPUKkxT5CGBg+wQo2E+lAYDksP6iy6kEHbQEEbQCIAYEBBmo5'
..'CQqgXT1Ch5sZQvBftMEK/9DmQAAAgD82c/lABHAAiAGBAQqgXT1Ch5sNQhdjesEK/9DmQAAAgD+ZmZk/BHMAiAGBAQqgXT1Ch5sRQiTLhsEEdQCIAYEBCqBdPUKHmxVCwGSQwQR3AIABgQEK8DtLQkH6FkL3AjzBCsC8dT5cj6RBiJ3oQQR6AIABgQEKZCwvQkH6FkL3'
..'AjzBBHwAgAGBAQqYJT1CH/koQv8+KEAKNhPpQM4nOUEAtKI+BH8AgAGBAQqgLz1Ck/oWQtAXPsEEgQCAAYEBCgA6NL0AAKxApHBnwQSDAIABgQEKAABVPDeJtcAwsmNBBIUAiAGBAQqgXT1CiJsFQq/8U8EEhwCIAYEBCqBdPUKHmwlC4C9nwQSJAIgBgQEKoF09Qg83'
..'80EXYxrBBIsAiAGBAQqgXT1CETf7QUiWLcEEjQCIAYEBCqBdPUKImwFCgMlAwQSPAIABgQEKclI9QqNx3UH3AjzBCsZB5kBAtuI+iJ3oQQSSAIkBgQEKoF09Qg8340Ff+efABJQAiAGBAQqgXT1CDzfrQeAvB8EhClN0cmFpZ2h0LTEEigGLAYEBB2sABJ0AjAGNAQYA'
..'j5wDAAAAAACAlEAhC09yaWVudGF0aW9uCgAAAAAAADRDAAAAAAqQ9hpBo3HdQTgtQMEhCFJvdGF0aW9uCgAANEMAAAAAAAA0Qwo+JtZBQLbiPoid6EEEogCMAY0BCuCFZMBFKQhCPC1AwQqAjoM+GJlSQYid6EEEpQCMAY0BCvRvuEFFKQhCOC1AwQSnAIwBjQEKiPYa'
..'QaNx3UFuiRtACj4m1kFAtuI+APlGPgSqAIwBjQEKkPYaQVfIIUI4LUDBBKwAjAGNAQo4B5JBRSkIQjZK08EK/L8dQRiZUkESqY0+BK8AjAGNAQo+Jpw/RSkIQjZK08EEsQCMAY0BCvCyqkAhcRpCNkrTwQqqtJBBcLSAQBKpjT4EtACMAY0BCj4mnD9FKQhCEQAdQAS2'
..'AIwBjQEK8LKqQCFxGkIRAB1ABLgAjAGNAQo4B5JBRSkIQhEAHUAEugCMAY0BCjffG0H/KAhCEC1AwQS9AI4BgQEKAAAAAJoSKDcAAAAACgBANL3AyvG/8NJlQSEBZATAAIABgQEKAMBUPMHK8b8UrmnBIQREb3duBI8BgAGBAQTEAIwBjQEK9G8UQqTFPkIYGD7BBMYA'
..'jAGNAQrsNxRCh5sZQoCCm78EyACMAY0BCuw3FEKHmw1CF80BwQTKAIwBjQEK7DcUQoebEULQM93ABMwAjAGNAQrsNxRCh5sVQmDNtsAEzgCMAY0BCpxZBkJB+hZCOC1AwQTQAIwBjQEKKGkiQkH6FkI4LUDBBNIAjAGNAQr0bxRCH/koQvgf08EE1ACMAY0BCuxlFEKT'
..'+hZCXxg+wQTWAIwBjQEK7DcUQoibBUJ/MyjBBNgAjAGNAQrsNxRCh5sJQlAAFcEE2gCMAY0BCuw3FEIPN/NBGM1hwQTcAIwBjQEK7DcUQhE3+0HnmU7BBN4AjAGNAQrsNxRCiJsBQrBmO8EE4ACMAY0BChpDFEKjcd1BOC1AwQTiAIwBjQEK7DcUQg8340G9GYTBBOQA'
..'jAGNAQrsNxRCDzfrQVAAdcEhCkRpYWdvbmFsLTEEkAGAAYEBBOgAjAGNAQoedFjCo3HdQTwtQMEKZEORQkC24j6InehBBOsAjAGNAQoFnbTCRSkIQjgtQMEE7QCMAY0BCuR/jsFFKQhCOC1AwQTvAIwBjQEKlHT5waNx3UF2iRtABPEAjAGNAQqynVjCV8ghQjwtQMEK'
..'AG2RQkC24j6InehBBPQAjAGNAQry4DXCRSkIQjRK08EKtZFfQhiZUkESqY0+BPcAjAGNAQqhxarCRSkIQjRK08EE+QCMAY0BCguLosIhcRpCNkrTwQT7AIwBjQEKHhZ6wkUpCEIIAB1ACjePX0IYmVJBEqmNPgT+AIwBjQEKjiEOwiFxGkIZAB1ABAABjAGNAQqc6LTB'
..'RSkIQhEAHUAEAgGMAY0BCmkRWMKOQAhC/Kk/wSEKRGlhZ29uYWwtMgSRAYABgQEEBgGMAY0BCgYIWcI6ECpCPC1AwQQIAYwBjQEK+ea0wq6AQ0I4LUDBBAoBjAGNAQq0p4/BroBDQjgtQMEEDAGMAY0BCmSc+sE6ECpCdokbQAQOAYwBjQEKmjFZwr4fXUI8LUDBBBAB'
..'jAGNAQpSpVjC9JdDQvypP8EEkgGTAYEBBBMBjAGNAQqs0bTBEIFDQrxJ08EEFQGMAY0BCqYKesIQgUNCuknTwQQXAYwBjQEKFhYOwu3IVUK6SdPBBJQBkwGBAQQaAZUBjQEKjhQ3wieNQ0Lw/RxABBwBlQGNAQrZJKPCA9VVQuf9HEAEHgGVAY0BCm9fq8InjUNCCv4c'
..'QCEDTElCBJYBgAGBAQQiAYABgQEK4f1zwolBpELeOxRDCnoUWEL//9tBDgNhPgQmAZMBgQEKAAAAAAAANMMAAAAACm3n88GJQaRC9yhyQgoAADTDAAAAAAAANMMEKQGAAYEBCgAAAAAGgeW/4vqvQgQrAYABgQEKAAAAAPp+8sBf5a/CBC0BgAGBAQrB++/B5dCuQt47'
..'FEMKPQroQh6Fh0EOA2E+BDABgAGBAQpG5/PBiUG+Qj3lcUIKAADqQgAAwD9LDzBDBDMBgAGBAQpAFwM/iUGkQt47FEMKAABcQgAA3EEOA2E+BDYBgAGBAQqLbPPBgROLQqHbcUIKAEDmQgAAgD8AADBDBDkBgAGBAQoY27DCiUGkQj3lcUIKAACAPwAA3EFLDzBDBDwB'
..'gAGBAQq6GNxBiUGkQj3lcUIEPgGAAYEBCkD9Ij90E41CtK9QQQpgw6RBAACAP8Dvfz8EQQGAAYEBCkD9Ij90E45CvLBAQQpgw6RBAAAAQMDvfz8ERAGAAYEBCpS2M0F0E5RCxLMwQQoAAIA/AAAAQfj9n0AERwGAAYEBCmxJHMF0E5RCxLMwQQRJAYABgQEKWIVCwnQT'
..'lELItBBBCv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAETwGAAYEBBqOipQrMT0PCvHSkQhxOMkEKuB6dQj8Kw0HAd5RACq5H4T49CsNBpkWRQAq4SRzBvHSkQqQaM0EKAAAAAAAAAAAAAAAACrgenUI9CsNBLifhPgrLT0PCvHSkQsi0EEEEVwGAAYEBCkAE'
..'mkG8dKRCHE4yQQrieoRBPArDQcB3lEAKvRIzQbx0pEKkGjNBCutRhEE9CsNBLifhPgq8GJpBvHSkQsi0EEEEXQGAAYEBCkD9Ij90E49CxLEwQQpgw6RBAABAQMDvfz8EYAGAAYEBCkD9Ij90E5BCxLIgQQpgw6RBAACAQMDvfz8EYwGAAYEBCkD9Ij90E5FCyLMQQQpg'
..'w6RBAACgQMDvfz8EZgGAAYEBCgB7Ej9WDpJCyCLgQAoAAKlBKVy/QAAXRUAEaQGAAYEBCuR0m0F0E5RCyLQQQQpmZnZBAAAAQcDvfz8EbAGAAYEBCils88F1E5JCnO4XwQoCQOZCCADAQHFREEIKAIAcQgAAwEBwUQRCClxP8kB1E5JCnO4vwQoAAIFBAADAQHBREEIK'
..'15OYQXUTkkKc7hfBCgBAnEIAAMBAcFEQQgoUtkPCdROSQpzuF8EEdQGAAYEBChK08sGynbRCel7cwQqZmRFBcD0yQQDo1j4EeAGAAYEBCq3KdcKJQaRCel7cwQoK11tCAADcQQDo1j4EewGAAYEBClqV88GJQZBCel7cwQooXA9BAADwQADo1j4EfgGAAYEBCgA2CD+J'
..'QaRCel7cwQoCimZCIR7AQRgYPsEKAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAqufmdC+XSQQLDLDcEKuhuGQkzQkECuJ+LBCq5+Z0IGdZBArMsNwQrVlYdCPt//QQA/h8AKpK2HQj7f/0EAP4fACoovPUIa+hZCGBg+wQr9/38/AAAAAAAAAAAK//9/PwAAAAAAAAAA'
..'CjjfG0FCKQhCOC1AwQoAAIC/AAAAAC69u7MKAACAvy69u7PtrQkoCi69u7MAAIA/Lr27swoAAIA/AAAAAC69O7QKAmYUQhr6FkIYGD7BCmoRWMKUQAhCNKo/wQpSpVjC/JdDQjSqP8EKikFYwhCBQ0K6SdPBCgAAgL8AAAAALr27MwpK4VjCKY1DQvD9HEAKAACAvy69'
..'u7MAAAAoCkbn88GJQaRC+yhyQowBAAABAAIAAwABAAEBAAIABAABAAIBAAIABQABAAMCAAYABwACAAgACQAECgAGAAcACgALAAwADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaAA0AGwAFBQAcAB0AHgALAB8AIAAhAB0AIgAdACMABgQAJAAlACYAHQAWACcAGAAo'
..'ACkABwcAJAAlACYAHQAYACoAKwAsAC0AJQAuAC8AMAALAAkABAwABgAxAAoACwAMAA0ADgAyABAAMwA0ADUAEgA2ABQANwAWADgAGAA5ABoADQA6AB0AOwAJAAAJAAQIAAoACwAMAA0ADgA8ABAAPQASAD4AFgA/ABgAQAAaAA0ACQAECAAKAAsADAANAA4APAAQAEEA'
..'EgA+ABYAQgAYAEMAGgANAAkABAgACgALAAwADQAOADwAEABEABIAPgAWAEUAGABGABoADQAJAAQIAAoACwAMAA0ADgA8ABAARwASAD4AFgBIABgASQAaAA0AOwADAABKAAIAAAEAAgIABgBLAAIATAABABECAAYATQACAE4ACQASBgAKAAsADAANABAATwAWAFAAGABR'
..'ABoADQAJABIGAAoACwAMAA0AEABSABYAUwAYAFQAGgANAAkAEgYACgALAAwADQAQAFUAFgBWABgAVAAaAA0ACQASBgAKAAsADAANABAAVwAWAFgAGABZABoADQAJABILAAYAWgAKAAsADAANAA4APAAQAFsANAA1ABIAPgAWAFwAGABdABoADQA6AB0AXgAXAwAGAF8A'
..'EABgABYAYQBeABcDAAYAYgAQAGMAFgBkAAEAEQIABgBlAAIAZgAJABoGAAoACwAMAA0AEABnABYAaAAYAGkAGgANAAkAGgkACgALAAwADQAOAGoAEABrABIAbAAUABUAFgBtABgAbgAaAA0ACQAaCQAKAAsADAANAA4AagAQAG8AEgBsABQAFQAWAHAAGABxABoADQAJ'
..'ABoJAAoACwAMAA0ADgBqABAAcgASAGwAFAAVABYAcwAYAHEAGgANAAkAGgkACgALAAwADQAOAGoAEAB0ABIAbAAUABUAFgB1ABgAcQAaAA0ACQAaBgAKAAsADAANABAAdgAWAHcAGAB4ABoADQAJABoGAAoACwAMAA0AEAB5ABYAegAYAHgAGgANAAkAGgYACgALAAwA'
..'DQAQAHsAFgB8ABgAfQAaAA0ACQAaCwAGAFoACgALAAwADQAOADwAEAB+ADQANQASAD4AFgB/ABgAXQAaAA0AOgAdAF4AIwMABgBfABAAgAAWAIEAXgAjAwAGAGIAEACCABYAgwAJABoJAAoACwAMAA0ADgBqABAAhAASAGwAFAAVABYAhQAYAHEAGgANAAkAGgkACgAL'
..'AAwADQAOAGoAEACGABIAbAAUABUAFgCHABgAcQAaAA0ACQAaCQAKAAsADAANAA4AagAQAIgAEgBsABQAFQAWAIkAGABxABoADQAJABoJAAoACwAMAA0ADgBqABAAigASAGwAFAAVABYAiwAYAHEAGgANAAkAGgkACgALAAwADQAOAGoAEACMABIAbAAUABUAFgCNABgA'
..'cQAaAA0ACQAaBgAKAAsADAANABAAjgAWAI8AGACQABoADQAJABoJAAoACwAMAA0ADgBqABAAkQASAGwAFAAVABYAkgAYAHEAGgANAAkAGgkACgALAAwADQAOAGoAEACTABIAbAAUABUAFgCUABgAcQAaAA0AAQARAgAGAJUAAgCWAAkALgsACgALAAwADQAOAJcAEACY'
..'ABIAmQAUAJoAmwCcABYAnQCeAJ8AGACgABoADQAJAC4IAAoACwAMAA0AEAChAJsAnAAWAKIAngCfABgAowAaAA0ACQAuCAAKAAsADAANABAApACbAJwAFgClAJ4AnwAYAKMAGgANAAkALggACgALAAwADQAQAKYAmwCcABYApwCeAJ8AGACoABoADQAJAC4IAAoACwAM'
..'AA0AEACpAJsAnAAWAKoAngCfABgAoAAaAA0ACQAuCAAKAAsADAANABAAqwCbAJwAFgCsAJ4AnwAYAK0AGgANAAkALggACgALAAwADQAQAK4AmwCcABYArwCeAJ8AGACtABoADQAJAC4IAAoACwAMAA0AEACwAJsAnAAWALEAngCfABgAsgAaAA0ACQAuCAAKAAsADAAN'
..'ABAAswCbAJwAFgC0AJ4AnwAYAK0AGgANAAkALggACgALAAwADQAQALUAmwCcABYAtgCeAJ8AGACyABoADQAJAC4IAAoACwAMAA0AEAC3AJsAnAAWALgAngCfABgArQAaAA0ACQAuDQAGAFoACgALAAwADQAOADwAEAC5ADQANQASAD4AmwCcABYAugCeAJ8AGABdABoA'
..'DQA6AB0AXgA6BAAGAF8AEAC7AJsAvAAWAL0AXgA6AwAGAL4AEAC/ABYAwAABABECAAYAwQACAMIACQA9CAAKAAsADAANABAAwwCbAJwAFgDEAJ4AnwAYAGkAGgANAAkAPQsACgALAAwADQAOAGoAEADFABIAbAAUABUAmwCcABYAxgCeAJ8AGABuABoADQAJAD0LAAoA'
..'CwAMAA0ADgBqABAAxwASAGwAFAAVAJsAnAAWAMgAngCfABgAcQAaAA0ACQA9CwAKAAsADAANAA4AagAQAMkAEgBsABQAFQCbAJwAFgDKAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADLABIAbAAUABUAmwCcABYAzACeAJ8AGABxABoADQAJAD0IAAoACwAM'
..'AA0AEADNAJsAnAAWAM4AngCfABgAeAAaAA0ACQA9CAAKAAsADAANABAAzwCbAJwAFgDQAJ4AnwAYAHgAGgANAAkAPQgACgALAAwADQAQANEAmwCcABYA0gCeAJ8AGAB9ABoADQAJAD0NAAYAWgAKAAsADAANAA4APAAQANMANAA1ABIAPgCbAJwAFgDUAJ4AnwAYAF0A'
..'GgANADoAHQBeAEYDAAYAXwAQAIAAFgCBAF4ARgMABgBiABAAggAWAIMACQA9CwAKAAsADAANAA4AagAQANUAEgBsABQAFQCbAJwAFgDWAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADXABIAbAAUABUAmwCcABYA2ACeAJ8AGABxABoADQAJAD0LAAoACwAM'
..'AA0ADgBqABAA2QASAGwAFAAVAJsAnAAWANoAngCfABgAcQAaAA0ACQA9CwAKAAsADAANAA4AagAQANsAEgBsABQAFQCbAJwAFgDcAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADdABIAbAAUABUAmwCcABYA3gCeAJ8AGABxABoADQAJAD0IAAoACwAMAA0A'
..'EADfAJsAnAAWAOAAngCfABgAkAAaAA0ACQA9CwAKAAsADAANAA4AagAQAOEAEgBsABQAFQCbAJwAFgDiAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADjABIAbAAUABUAmwCcABYA5ACeAJ8AGABxABoADQABABECAAYA5QACAOYACQBRCwAKAAsADAANAA4A'
..'lwAQAOcAEgCZABQAmgCbAJwAFgDoAJ4AnwAYAOkAGgANAAkAUQgACgALAAwADQAQAOoAmwCcABYA6wCeAJ8AGACjABoADQAJAFEIAAoACwAMAA0AEADsAJsAnAAWAO0AngCfABgAowAaAA0ACQBRCAAKAAsADAANABAA7gCbAJwAFgDvAJ4AnwAYAKgAGgANAAkAUQgA'
..'CgALAAwADQAQAPAAmwCcABYA8QCeAJ8AGADyABoADQAJAFEIAAoACwAMAA0AEADzAJsAnAAWAPQAngCfABgA9QAaAA0ACQBRCAAKAAsADAANABAA9gCbAJwAFgD3AJ4AnwAYAK0AGgANAAkAUQgACgALAAwADQAQAPgAmwCcABYA+QCeAJ8AGACyABoADQAJAFEIAAoA'
..'CwAMAA0AEAD6AJsAnAAWAPsAngCfABgA/AAaAA0ACQBRCAAKAAsADAANABAA/QCbAJwAFgD+AJ4AnwAYALIAGgANAAkAUQgACgALAAwADQAQAP8AmwCcABYAAAGeAJ8AGACtABoADQAJAFENAAYAWgAKAAsADAANAA4APAAQAAEBNAA1ABIAPgCbAJwAFgACAZ4AnwAY'
..'AF0AGgANADoAHQBeAF0EAAYAXwAQALsAmwC8ABYAvQBeAF0DAAYAvgAQAL8AFgDAAAEAEQIABgADAQIABAEJAGALAAoACwAMAA0ADgCXABAABQESAJkAFACaAJsAnAAWAAYBngCfABgA6QAaAA0ACQBgCAAKAAsADAANABAABwGbAJwAFgAIAZ4AnwAYAKMAGgANAAkA'
..'YAgACgALAAwADQAQAAkBmwCcABYACgGeAJ8AGACjABoADQAJAGAIAAoACwAMAA0AEAALAZsAnAAWAAwBngCfABgAqAAaAA0ACQBgCAAKAAsADAANABAADQGbAJwAFgAOAZ4AnwAYAPIAGgANAAkAYA0ABgBaAAoACwAMAA0ADgA8ABAADwE0ADUAEgA+AJsAnAAWABAB'
..'ngCfABgAXQAaAA0AOgAdAF4AZgQABgBfABAAuwCbALwAFgC9AF4AZgMABgC+ABAAvwAWAMAAAQBgAQACABEBCQBpCAAKAAsADAANABAAEgGbAJwAFgATAZ4AnwAYAK0AGgANAAkAaQgACgALAAwADQAQABQBmwCcABYAFQGeAJ8AGAD8ABoADQAJAGkIAAoACwAMAA0A'
..'EAAWAZsAnAAWABcBngCfABgAsgAaAA0AAQBgAQACABgBCQBtCAAKAAsADAANABAAGQGbAJwAFgAaAZ4AnwAYAPUAGgANAAkAbQgACgALAAwADQAQABsBmwCcABYAHAGeAJ8AGACyABoADQAJAG0IAAoACwAMAA0AEAAdAZsAnAAWAB4BngCfABgArQAaAA0AAQARAgAG'
..'AB8BAgAgAQkAcQYACgALAAwADQAQACEBFgAiARgAIwEaAA0ACQBxDQAGAFoACgALAAwADQAOADwAEAAkATQANQASAD4AmwAlARYAJgGeACcBGABdABoADQA6AB0AXgBzAwAGAF8AEAAoARYAKQFeAHMDAAYAvgAQACoBFgArAQkAcQYACgALAAwADQAQACwBFgAtARgA'
..'LgEaAA0ACQBxBgAKAAsADAANABAALwEWADABGAAxARoADQAJAHEGAAoACwAMAA0AEAAyARYAMwEYADQBGgANAAkAcQkACgALAAwADQAOAGoAEAA1ARIAbAAUABUAFgA2ARgANwEaAA0ACQBxBgAKAAsADAANABAAOAEWADkBGAA6ARoADQAJAHEGAAoACwAMAA0AEAA7'
..'ARYAPAEYADoBGgANAAkAcQkACgALAAwADQAOAGoAEAA9ARIAbAAUABUAFgA+ARgAPwEaAA0ACQBxCQAKAAsADAANAA4AagAQAEABEgBsABQAFQAWAEEBGABCARoADQAJAHEGAAoACwAMAA0AEABDARYARAEYAEUBGgANAAkAcQYACgALAAwADQAQAEYBFgBHARgARQEa'
..'AA0ACQBxBgAKAAsADAANABAASAEWAEkBGABKARoADQBLAUACAAkAUQFSAVMBAAkAVAFVAVMBcQcACgALAA4ATAEQAE0BEgBOARQANwAWAE8BGABQAUsBQAIACQBRAVkBUwEACQBaAVsBUwFxBwAKAAsADgBMARAAVgESAE4BFAA3ABYAVwEYAFgBCQBxCQAKAAsADAAN'
..'AA4AagAQAFwBEgBsABQAFQAWAF0BGABeARoADQAJAHEJAAoACwAMAA0ADgBqABAAXwESAGwAFAAVABYAYAEYAGEBGgANAAkAcQkACgALAAwADQAOAGoAEABiARIAbAAUABUAFgBjARgAZAEaAA0ACQBxCQAKAAsADAANAA4AagAQAGUBEgBsABQAFQAWAGYBGABnARoA'
..'DQAJAHEGAAoACwAMAA0AEABoARYAaQEYAGoBGgANAEsBQAMACQBuAW8BUwEACQBwAXEBUwEACQByAXMBUwFxBwAKAAsADgCXABAAawESAJkAFACaABYAbAEYAG0BCQBxBgAKAAsADAANABAAdAEWAHUBGAB2ARoADQAJAHEGAAoACwAMAA0AEAB3ARYAeAEYAHkBGgAN'
..'AAkAcQYACgALAAwADQAQAHoBFgB7ARgAfAEaAA0ACQBxBgAKAAsADAANABAAfQEWAH4BGAB5ARoADQAA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
