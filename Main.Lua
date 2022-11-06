-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 11888 characters

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
..'ZW5jZSEKU2l6aW5nTW9kZSEFRnJhbWUhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5DAAAAAAAAM3MzD0AAAwAAIA/AAAAAAAAZAAhB1RleHRCb3gMAACAPwAAAACAPwAAIQRGb250AwAAAAAAABBAIRFQbGFjZWhvbGRlckNvbG9y'
..'MyEKVGV4dENvbG9yMyEIVGV4dFNpemUDAAAAAAAAREAhEERvb3JIaXREZXRlY3Rpb24HTAEEOACAAYEBIQpDYW5Db2xsaWRlAgZ1AAADAAAAAADAmEAKmrtnQrBikEB7sQzBCnYx30BSuApBXI9CPyEMVHJhbnNwYXJlbmN5IQZTY3JpcHQH6gMEPwCAAYEBBs3NzQrO'
..'/nRCfeeNQEOND8EK4PvjPjvnDUEAoy0/BEIAgAGBAQoUDGhC2fgMQUOND8EKamvdQCD93j4Aoy0/BEUAgAGBAQrWRlpCsGKQQEOND8EKQCIWP2tiEEEAoy0/BEgAgAGBAQqufmdCpcBiPkOND8EKxkHmQEC24j4Aoy0/IQ1CaW5kYWJsZUV2ZW50IQZBc3NldHMEhQGA'
..'AYEBIQhTdHJhaWdodASGAYABgQEEUACAAYEBCpBbOsG9rxfC/P84wgrGQeZAQLbiPp3DY0EEUwCAAYEBCljVcsEBHinC/P84wgoARtY+5ocSQZ3DY0EEVgCAAYEBCtBkAMEBHinC/P84wgRYAIABgQEKkFs6wV0AO8JmBjnCCsZB5kBAtuI+6PZjQSEFUkNFTlQEXACA'
..'AYEBCvCbOcHPVynCVpY4wgoAAIBAAACAPwAAAEAhCkF0dGFjaG1lbnQhA0VuZARhAIABgQEKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcEZACAAYEBCgAAAAAAAAAAj8LjQCECVXAEhwGAAYEBBGgAgAGBAQpeAxHCg5YOwrTNWMIKNhPpQGA5LD+osupBB20BBG0AiAGB'
..'AQZqOQkKVssQwp/AM8LTu4HCCv/Q5kAAAIA/NnP5QARwAIgBgQEKVssQwp/AP8J04GfCCv/Q5kAAAIA/mZmZPwRzAIgBgQEKVssQwp/AO8JArWzCBHUAiAGBAQpWyxDCn8A3wg56ccIEdwCAAYEBCgbtAsLlYTbCbEhYwgrAvHU+XI+kQYid6EEEegCAAYEBCpL8HsLl'
..'YTbCbEhYwgR8AIABgQEKXgMRwgdjJMK+wx7CCjYT6UDOJzlBALSiPgR/AIABgQEKVvkQwpNhNsKizVjCBIEAgAGBAQoAOjS9AACsQKRwZ8EEgwCAAYEBCgAAVTw3ibXAMLJjQQSFAIgBgQEKVssQwp/AR8LaRl7CBIcAiAGBAQpWyxDCn8BDwqYTY8IEiQCIAYEBClbL'
..'EMKfwFPCdOBPwgSLAIgBgQEKVssQwp3AT8JArVTCBI0AiAGBAQpWyxDCn8BLwg56WcIEjwCAAYEBCoTWEMJVo17CbEhYwgrGQeZAQLbiPoid6EEEkgCJAYEBClbLEMKfwFvC2kZGwgSUAIgBgQEKVssQwp/AV8KmE0vCIQpTdHJhaWdodC0xBIoBiwGBAQdrAASdAIwB'
..'jQEGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKFEbNwJOtUcLkD4zCIQhSb3RhdGlvbgoAADRDAAAAAAAANEMKPibWQUC24j6InehBBKIAjAGNAQqJXZ3BHz04wuUPjMIKgI6DPhiZUkGInehBBKUAjAGNAQqajN5AHz04wuQPjMIEpwCMAY0B'
..'CiVGzcCTrVHC41tewgo+JtZBQLbiPgD5Rj4EqgCMAY0BChRGzcANnh7C5A+MwgSsAIwBjQEKWNMJQB89OMLK3KjCCvy/HUEYmVJBEqmNPgSvAIwBjQEK0hRuwR89OMLK3KjCBLEAjAGNAQoiQCzBQ/UlwsrcqMIKqrSQQXC0gEASqY0+BLQAjAGNAQrSFG7BHz04wnlE'
..'XsIEtgCMAY0BCiJALMFD9SXCeURewgS4AIwBjQEKWNMJQB89OMJ5RF7CBLoAjAGNAQrEdMvAZT04wt8PjMIEvQCOAYEBCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEwACAAYEBCgDAVDzByvG/FK5pwSEERG93bgSPAYABgQEExACQAY0BCjqYm0HgJRHC/K5X'
..'wgTGAJABjQEKKiibQfxPNsIKBS3CBMgAkAGNAQoqKJtB/E9CwjycSMIEygCQAY0BCioom0H8Tz7CcM9DwgTMAJABjQEKKiibQfxPOsKiAj/CBM4AkAGNAQoU135BQvE4wkQ0WMIE0ACQAY0BCqKKt0FC8TjCRDRYwgTSAJABjQEKOpibQWTyJsJ53IjCBNQAkAGNAQoq'
..'hJtB8PA4wg6vV8IE1gCQAY0BCioom0H8T0rC1jVSwgTYAJABjQEKKiibQfxPRsIKaU3CBNoAkAGNAQoqKJtB/E9WwjycYMIE3ACQAY0BCioom0H6T1LCcM9bwgTeAJABjQEKKiibQfxPTsKiAlfCBOAAkAGNAQqGPptBsjJhwkQ0WMIE4gCQAY0BCioom0H8T17C1DVq'
..'wgTkAJABjQEKKiibQfxPWsIKaWXCIQpEaWFnb25hbC0xBJEBgAGBAQToAJABjQEKO9ADwyJwN8I8LUDBCmRDkUJAtuI+iJ3oQQTrAJABjQEKtgEow67/HcI4LUDBBO0AkAGNAQpgBr/Crv8dwjgtQMEE7wCQAY0BCozD2cIicDfCeIkbQATxAJABjQEKoNoDw5xgBMI8'
..'LUDBCgBtkUJAtuI+iJ3oQQT0AJABjQEK4Fb2wq7/HcI0StPBCrWRX0IYmVJBEqmNPgT3AJABjQEKBBYjw67/HcI0StPBBPkAkAGNAQq5+B7D0rcLwjZK08EE+wCQAY0BCrs4DMOu/x3CCAAdQAo3j19CGJlSQRKpjT4E/gCQAY0BCi534sLStwvCGAAdQAQAAZABjQEK'
..'jqDIwq7/HcIQAB1ABAIBkAGNAQqOtwPDZOgdwvypP8EhCkRpYWdvbmFsLTIEkgGAAYEBBAYBkAGNAQqlMgPDcTctwvN7R8IECAGQAY0BCiBkJ8P9xhPC8ntHwgQKAZABjQEKNMu9wv3GE8Lye0fCBAwBkAGNAQpgiNjCcTctwgy4DcIEDgGQAY0BCgo9A8PaT/TB83tH'
..'wgQQAZABjQEK+BkDw7mvE8IjW0fCBJMBlAGBAQQTAZABjQEKshXHwp3GE8LBioDCBBUBkAGNAQpNcwvDncYTwsCKgMIEFwGQAY0BClLs4MK/fgHCwIqAwgSVAZQBgQEEGgGMAY0BCo5r9cKFuhPCxaANwgQcAYwBjQEKEIMew6lyAcLGoA3CBB4BjAGNAQpboCLDhboT'
..'wsSgDcIhA0xJQgSWAYABgQEEIgGAAYEBCuL9c8LhpT3C3jsUQwp6FFhC///bQQ4DYT4EJgGUAYEBCgAAAAAAADTDAAAAAAps5/PB4aU9wvgockIKAAA0wwAAAAAAADTDBCkBgAGBAQoAAAAABoHlv+L6r0IEKwGAAYEBCgAAAAD6fvLAX+WvwgQtAYABgQEKwPvvwSmH'
..'KMLeOxRDCj0K6EIehYdBDgNhPgQwAYABgQEKROfzweGlCcI85XFCCgAA6kIAAMA/Sw8wQwQzAYABgQEKgBcDP+GlPcLeOxRDCgAAXEIAANxBDgNhPgQ2AYABgQEKjGzzwfEBcMKg23FCCgBA5kIAAIA/AAAwQwQ5AYABgQEKF9uwwuGlPcI85XFCCgAAgD8AANxBSw8w'
..'QwQ8AYABgQEKuhjcQeGlPcI85XFCBD4BgAGBAQqA/SI/CwJswrSvUEEKYMOkQQAAgD/A738/BEEBgAGBAQqA/SI/CwJqwrywQEEKYMOkQQAAAEDA738/BEQBgAGBAQqUtjNBCwJewsSzMEEKAACAPwAAAEH4/Z9ABEcBgAGBAQpoSRzBCwJewsSzMEEESQGAAYEBCliF'
..'QsILAl7CyLQQQQr+cp1CAAAAQcDvfz8hDlVuaW9uT3BlcmF0aW9uB8IABE8BgAGBAQajoqUKzE9Dwns/PcIcTjJBCrgenUI/CsNBwHeUQAquR+E+PQrDQaZFkUAKuEkcwXo/PcKkGjNBCgAAAAAAAAAAAAAAAAq4Hp1CPQrDQS4n4T4Ky09Dwns/PcLItBBBBFcBgAGB'
..'AQpABJpBez89whxOMkEK4nqEQTwKw0HAd5RACr0SM0F6Pz3CpBozQQrrUYRBPQrDQS4n4T4KvBiaQXs/PcLItBBBBF0BgAGBAQqA/SI/CwJowsSxMEEKYMOkQQAAQEDA738/BGABgAGBAQqA/SI/CwJmwsSyIEEKYMOkQQAAgEDA738/BGMBgAGBAQqA/SI/CwJkwsiz'
..'EEEKYMOkQQAAoEDA738/BGYBgAGBAQoAexI/Rwxiwsgi4EAKAACpQSlcv0AAF0VABGkBgAGBAQrkdJtBCwJewsi0EEEKZmZ2QQAAAEHA738/BGwBgAGBAQoobPPBCQJiwpzuF8EKAkDmQggAwEBxURBCCgCAHEIAAMBAcFEEQgpgT/JACgJiwpzuL8EKAACBQQAAwEBw'
..'URBCCtiTmEEKAmLCnO4XwQoAQJxCAADAQHBREEIKFLZDwgoCYsKc7hfBBHUBgAGBAQoUtPLBj+0cwnpe3MEKmZkRQXA9MkEA6NY+BHgBgAGBAQquynXC4aU9wnpe3MEKCtdbQgAA3EEA6NY+BHsBgAGBAQpclfPB4aVlwnpe3MEKKFwPQQAA8EAA6NY+BH4BgAGBAQoA'
..'Ngg/4aU9wnpe3MEKAopmQiEewEEYGD7BCgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKrn5nQvl0kECwyw3BCrobhkJM0JBArifiwQqufmdCBnWQQKzLDcEK1ZWHQqocw8IAP4fAChidOcENWCnC9JU4wgps+RDCC2I2wrTNWMIK/f9/PwAAAAAAAAAACv//fz8AAAAA'
..'AAAAAArEdMvAIT04wuQPjMIKAACAvwAAAAAuvbuzCgAAgL8uvbuzAAAAKAouvbuzAACAPy69u7MKAACAPwAAAAAuvTu0ClaEm0Fo8TjC/K5XwgoAAIC/Lr27s+2tCSgKjrcDw2DoHcI0qj/BCvgZA8OxrxPCMVtHwgoGAQPDncYTwsCKgMIKAACAvwAAAAAuvbszCvYo'
..'A8ODuhPCxaANwgpE5/PB4aU9wvwockKMAQAAAQACAAMAAQABAQACAAQAAQACAQACAAUAAQADAgAGAAcAAgAIAAkABAoABgAHAAoACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgANABsABQUAHAAdAB4ACwAfACAAIQAdACIAHQAjAAYEACQAJQAmAB0AFgAn'
..'ABgAKAApAAcHACQAJQAmAB0AGAAqACsALAAtACUALgAlAC8AMAAJAAQMAAYAMQAKAAsADAANAA4AMgAQADMANAA1ABIANgAUADcAFgA4ABgAOQAaAA0AOgAdADsACQAACQAECAAKAAsADAANAA4APAAQAD0AEgA+ABYAPwAYAEAAGgANAAkABAgACgALAAwADQAOADwA'
..'EABBABIAPgAWAEIAGABDABoADQAJAAQIAAoACwAMAA0ADgA8ABAARAASAD4AFgBFABgARgAaAA0ACQAECAAKAAsADAANAA4APAAQAEcAEgA+ABYASAAYAEkAGgANADsAAwAASgACAAABAAICAAYASwACAEwAAQARAgAGAE0AAgBOAAkAEgYACgALAAwADQAQAE8AFgBQ'
..'ABgAUQAaAA0ACQASBgAKAAsADAANABAAUgAWAFMAGABUABoADQAJABIGAAoACwAMAA0AEABVABYAVgAYAFQAGgANAAkAEgYACgALAAwADQAQAFcAFgBYABgAWQAaAA0ACQASCwAGAFoACgALAAwADQAOADwAEABbADQANQASAD4AFgBcABgAXQAaAA0AOgAdAF4AFwMA'
..'BgBfABAAYAAWAGEAXgAXAwAGAGIAEABjABYAZAABABECAAYAZQACAGYACQAaBgAKAAsADAANABAAZwAWAGgAGABpABoADQAJABoJAAoACwAMAA0ADgBqABAAawASAGwAFAAVABYAbQAYAG4AGgANAAkAGgkACgALAAwADQAOAGoAEABvABIAbAAUABUAFgBwABgAcQAa'
..'AA0ACQAaCQAKAAsADAANAA4AagAQAHIAEgBsABQAFQAWAHMAGABxABoADQAJABoJAAoACwAMAA0ADgBqABAAdAASAGwAFAAVABYAdQAYAHEAGgANAAkAGgYACgALAAwADQAQAHYAFgB3ABgAeAAaAA0ACQAaBgAKAAsADAANABAAeQAWAHoAGAB4ABoADQAJABoGAAoA'
..'CwAMAA0AEAB7ABYAfAAYAH0AGgANAAkAGgsABgBaAAoACwAMAA0ADgA8ABAAfgA0ADUAEgA+ABYAfwAYAF0AGgANADoAHQBeACMDAAYAXwAQAIAAFgCBAF4AIwMABgBiABAAggAWAIMACQAaCQAKAAsADAANAA4AagAQAIQAEgBsABQAFQAWAIUAGABxABoADQAJABoJ'
..'AAoACwAMAA0ADgBqABAAhgASAGwAFAAVABYAhwAYAHEAGgANAAkAGgkACgALAAwADQAOAGoAEACIABIAbAAUABUAFgCJABgAcQAaAA0ACQAaCQAKAAsADAANAA4AagAQAIoAEgBsABQAFQAWAIsAGABxABoADQAJABoJAAoACwAMAA0ADgBqABAAjAASAGwAFAAVABYA'
..'jQAYAHEAGgANAAkAGgYACgALAAwADQAQAI4AFgCPABgAkAAaAA0ACQAaCQAKAAsADAANAA4AagAQAJEAEgBsABQAFQAWAJIAGABxABoADQAJABoJAAoACwAMAA0ADgBqABAAkwASAGwAFAAVABYAlAAYAHEAGgANAAEAEQIABgCVAAIAlgAJAC4LAAoACwAMAA0ADgCX'
..'ABAAmAASAJkAFACaAJsAnAAWAJ0AngCfABgAoAAaAA0ACQAuCAAKAAsADAANABAAoQCbAJwAFgCiAJ4AnwAYAKMAGgANAAkALggACgALAAwADQAQAKQAmwCcABYApQCeAJ8AGACjABoADQAJAC4IAAoACwAMAA0AEACmAJsAnAAWAKcAngCfABgAqAAaAA0ACQAuCAAK'
..'AAsADAANABAAqQCbAJwAFgCqAJ4AnwAYAKAAGgANAAkALggACgALAAwADQAQAKsAmwCcABYArACeAJ8AGACtABoADQAJAC4IAAoACwAMAA0AEACuAJsAnAAWAK8AngCfABgArQAaAA0ACQAuCAAKAAsADAANABAAsACbAJwAFgCxAJ4AnwAYALIAGgANAAkALggACgAL'
..'AAwADQAQALMAmwCcABYAtACeAJ8AGACtABoADQAJAC4IAAoACwAMAA0AEAC1AJsAnAAWALYAngCfABgAsgAaAA0ACQAuCAAKAAsADAANABAAtwCbAJwAFgC4AJ4AnwAYAK0AGgANAAkALg0ABgBaAAoACwAMAA0ADgA8ABAAuQA0ADUAEgA+AJsAnAAWALoAngCfABgA'
..'XQAaAA0AOgAdAF4AOgQABgBfABAAuwCbALwAFgC9AF4AOgMABgC+ABAAvwAWAMAAAQARAgAGAMEAAgDCAAkAPQgACgALAAwADQAQAMMAmwCcABYAxACeAJ8AGABpABoADQAJAD0LAAoACwAMAA0ADgBqABAAxQASAGwAFAAVAJsAnAAWAMYAngCfABgAbgAaAA0ACQA9'
..'CwAKAAsADAANAA4AagAQAMcAEgBsABQAFQCbAJwAFgDIAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADJABIAbAAUABUAmwCcABYAygCeAJ8AGABxABoADQAJAD0LAAoACwAMAA0ADgBqABAAywASAGwAFAAVAJsAnAAWAMwAngCfABgAcQAaAA0ACQA9CAAK'
..'AAsADAANABAAzQCbAJwAFgDOAJ4AnwAYAHgAGgANAAkAPQgACgALAAwADQAQAM8AmwCcABYA0ACeAJ8AGAB4ABoADQAJAD0IAAoACwAMAA0AEADRAJsAnAAWANIAngCfABgAfQAaAA0ACQA9DQAGAFoACgALAAwADQAOADwAEADTADQANQASAD4AmwCcABYA1ACeAJ8A'
..'GABdABoADQA6AB0AXgBGAwAGAF8AEACAABYAgQBeAEYDAAYAYgAQAIIAFgCDAAkAPQsACgALAAwADQAOAGoAEADVABIAbAAUABUAmwCcABYA1gCeAJ8AGABxABoADQAJAD0LAAoACwAMAA0ADgBqABAA1wASAGwAFAAVAJsAnAAWANgAngCfABgAcQAaAA0ACQA9CwAK'
..'AAsADAANAA4AagAQANkAEgBsABQAFQCbAJwAFgDaAJ4AnwAYAHEAGgANAAkAPQsACgALAAwADQAOAGoAEADbABIAbAAUABUAmwCcABYA3ACeAJ8AGABxABoADQAJAD0LAAoACwAMAA0ADgBqABAA3QASAGwAFAAVAJsAnAAWAN4AngCfABgAcQAaAA0ACQA9CAAKAAsA'
..'DAANABAA3wCbAJwAFgDgAJ4AnwAYAJAAGgANAAkAPQsACgALAAwADQAOAGoAEADhABIAbAAUABUAmwCcABYA4gCeAJ8AGABxABoADQAJAD0LAAoACwAMAA0ADgBqABAA4wASAGwAFAAVAJsAnAAWAOQAngCfABgAcQAaAA0AAQARAgAGAOUAAgDmAAkAUQsACgALAAwA'
..'DQAOAJcAEADnABIAmQAUAJoAmwCcABYA6ACeAJ8AGADpABoADQAJAFEIAAoACwAMAA0AEADqAJsAnAAWAOsAngCfABgAowAaAA0ACQBRCAAKAAsADAANABAA7ACbAJwAFgDtAJ4AnwAYAKMAGgANAAkAUQgACgALAAwADQAQAO4AmwCcABYA7wCeAJ8AGACoABoADQAJ'
..'AFEIAAoACwAMAA0AEADwAJsAnAAWAPEAngCfABgA8gAaAA0ACQBRCAAKAAsADAANABAA8wCbAJwAFgD0AJ4AnwAYAPUAGgANAAkAUQgACgALAAwADQAQAPYAmwCcABYA9wCeAJ8AGACtABoADQAJAFEIAAoACwAMAA0AEAD4AJsAnAAWAPkAngCfABgAsgAaAA0ACQBR'
..'CAAKAAsADAANABAA+gCbAJwAFgD7AJ4AnwAYAPwAGgANAAkAUQgACgALAAwADQAQAP0AmwCcABYA/gCeAJ8AGACyABoADQAJAFEIAAoACwAMAA0AEAD/AJsAnAAWAAABngCfABgArQAaAA0ACQBRDQAGAFoACgALAAwADQAOADwAEAABATQANQASAD4AmwCcABYAAgGe'
..'AJ8AGABdABoADQA6AB0AXgBdBAAGAF8AEAC7AJsAvAAWAL0AXgBdAwAGAL4AEAC/ABYAwAABABECAAYAAwECAAQBCQBgCwAKAAsADAANAA4AlwAQAAUBEgCZABQAmgCbAJwAFgAGAZ4AnwAYAOkAGgANAAkAYAgACgALAAwADQAQAAcBmwCcABYACAGeAJ8AGACjABoA'
..'DQAJAGAIAAoACwAMAA0AEAAJAZsAnAAWAAoBngCfABgAowAaAA0ACQBgCAAKAAsADAANABAACwGbAJwAFgAMAZ4AnwAYAKgAGgANAAkAYAgACgALAAwADQAQAA0BmwCcABYADgGeAJ8AGADyABoADQAJAGANAAYAWgAKAAsADAANAA4APAAQAA8BNAA1ABIAPgCbAJwA'
..'FgAQAZ4AnwAYAF0AGgANADoAHQBeAGYEAAYAXwAQALsAmwC8ABYAvQBeAGYDAAYAvgAQAL8AFgDAAAEAYAEAAgARAQkAaQgACgALAAwADQAQABIBmwCcABYAEwGeAJ8AGACtABoADQAJAGkIAAoACwAMAA0AEAAUAZsAnAAWABUBngCfABgA/AAaAA0ACQBpCAAKAAsA'
..'DAANABAAFgGbAJwAFgAXAZ4AnwAYALIAGgANAAEAYAEAAgAYAQkAbQgACgALAAwADQAQABkBmwCcABYAGgGeAJ8AGAD1ABoADQAJAG0IAAoACwAMAA0AEAAbAZsAnAAWABwBngCfABgAsgAaAA0ACQBtCAAKAAsADAANABAAHQGbAJwAFgAeAZ4AnwAYAK0AGgANAAEA'
..'EQIABgAfAQIAIAEJAHEGAAoACwAMAA0AEAAhARYAIgEYACMBGgANAAkAcQ0ABgBaAAoACwAMAA0ADgA8ABAAJAE0ADUAEgA+AJsAJQEWACYBngAnARgAXQAaAA0AOgAdAF4AcwMABgBfABAAKAEWACkBXgBzAwAGAL4AEAAqARYAKwEJAHEGAAoACwAMAA0AEAAsARYA'
..'LQEYAC4BGgANAAkAcQYACgALAAwADQAQAC8BFgAwARgAMQEaAA0ACQBxBgAKAAsADAANABAAMgEWADMBGAA0ARoADQAJAHEJAAoACwAMAA0ADgBqABAANQESAGwAFAAVABYANgEYADcBGgANAAkAcQYACgALAAwADQAQADgBFgA5ARgAOgEaAA0ACQBxBgAKAAsADAAN'
..'ABAAOwEWADwBGAA6ARoADQAJAHEJAAoACwAMAA0ADgBqABAAPQESAGwAFAAVABYAPgEYAD8BGgANAAkAcQkACgALAAwADQAOAGoAEABAARIAbAAUABUAFgBBARgAQgEaAA0ACQBxBgAKAAsADAANABAAQwEWAEQBGABFARoADQAJAHEGAAoACwAMAA0AEABGARYARwEY'
..'AEUBGgANAAkAcQYACgALAAwADQAQAEgBFgBJARgASgEaAA0ASwFAAgAJAFEBUgFTAQAJAFQBVQFTAXEHAAoACwAOAEwBEABNARIATgEUADcAFgBPARgAUAFLAUACAAkAUQFZAVMBAAkAWgFbAVMBcQcACgALAA4ATAEQAFYBEgBOARQANwAWAFcBGABYAQkAcQkACgAL'
..'AAwADQAOAGoAEABcARIAbAAUABUAFgBdARgAXgEaAA0ACQBxCQAKAAsADAANAA4AagAQAF8BEgBsABQAFQAWAGABGABhARoADQAJAHEJAAoACwAMAA0ADgBqABAAYgESAGwAFAAVABYAYwEYAGQBGgANAAkAcQkACgALAAwADQAOAGoAEABlARIAbAAUABUAFgBmARgA'
..'ZwEaAA0ACQBxBgAKAAsADAANABAAaAEWAGkBGABqARoADQBLAUADAAkAbgFvAVMBAAkAcAFxAVMBAAkAcgFzAVMBcQcACgALAA4AlwAQAGsBEgCZABQAmgAWAGwBGABtAQkAcQYACgALAAwADQAQAHQBFgB1ARgAdgEaAA0ACQBxBgAKAAsADAANABAAdwEWAHgBGAB5'
..'ARoADQAJAHEGAAoACwAMAA0AEAB6ARYAewEYAHwBGgANAAkAcQYACgALAAwADQAQAH0BFgB+ARgAeQEaAA0AAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
