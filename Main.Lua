-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 12500 characters

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
debounce = false
script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChildOfClass("Humanoid") ~= nil and debounce == false then
		debounce = true
		script.Parent.Parent.Parent.Parent.Event:Fire()
		debounce = false
	end
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


local Objects = Decode('AECdASEFTW9kZWwhCldvcmxkUGl2b3QEhAGFAYYBBIcBhQGGAQSIAYUBhgEhBE5hbWUhBERvb3IEiQGFAYYBIQRQYXJ0IQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IHaQEhBkNGcmFtZQQXAIUBhgEhBUNvbG9yBlZCNiEITWF0'
..'ZXJpYWwDAAAAAAAAgEAhCFBvc2l0aW9uCpq7Z0KwYpBAFCAOwSEEU2l6ZQraRcdA7dYDQRiFIz8hClRvcFN1cmZhY2UhEERvb3JIaXREZXRlY3Rpb24HTAEEIgCFAYYBIQpDYW5Db2xsaWRlAgZ1AAADAAAAAADAmEAKmrtnQrBikEB7sQzBCnYx30BSuApBXI9CPyEG'
..'U2NyaXB0B+oDBCgAhQGGAQbNzc0Kzv50Qn3njUBDjQ/BCuD74z475w1BAKMtPwQrAIUBhgEKFAxoQtn4DEFDjQ/BCmpr3UAg/d4+AKMtPwQuAIUBhgEK1kZaQrBikEBDjQ/BCkAiFj9rYhBBAKMtPwQxAIUBhgEKrn5nQqXAYj5DjQ/BCsZB5kBAtuI+AKMtPyENQmlu'
..'ZGFibGVFdmVudCEGQXNzZXRzBIoBhQGGASEIU3RyYWlnaHQEiwGFAYYBBDkAhQGGAQrVlYdC8JcRQj+PisAKxkHmQEC24j6dw2NBBDwAhQGGAQqchoBCqikAQj+PisAKAEbWPuaHEkGdw2NBBD8AhQGGAQqt1I5CqikAQj+PisAEQQCFAYYBCtWVh0KejtxBj8KKwArG'
..'QeZAQLbiPuj2Y0EhBVJDRU5UBEUAhQGGAQrJrYdCud//QQ9Ch8AKAACAQAAAgD8AAABAIQxUcmFuc3BhcmVuY3kDAAAAAAAA8D8hCkF0dGFjaG1lbnQhA0VuZARMAIUBhgEKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcETwCFAYYBCgAAAAAAAAAAj8LjQCECVXAEjAGF'
..'AYYBBFMAhQGGAQqYJT1CpMU+QhgYPsEKNhPpQGA5LD+osupBB20BBFgAjQGGAQZqOQkKoF09QoebGULwX7TBCv/Q5kAAAIA/NnP5QARbAI0BhgEKoF09QoebDUIXY3rBCv/Q5kAAAIA/mZmZPwReAI0BhgEKoF09QoebEUIky4bBBGAAjQGGAQqgXT1Ch5sVQsBkkMEE'
..'YgCFAYYBCvA7S0JB+hZC9wI8wQrAvHU+XI+kQYid6EEEZQCFAYYBCmQsL0JB+hZC9wI8wQRnAIUBhgEKmCU9Qh/5KEL/PihACjYT6UDOJzlBALSiPgRqAIUBhgEKoC89QpP6FkLQFz7BBGwAhQGGAQoAOjS9AACsQKRwZ8EEbgCFAYYBCgAAVTw3ibXAMLJjQQRwAI0B'
..'hgEKoF09QoibBUKv/FPBBHIAjQGGAQqgXT1Ch5sJQuAvZ8EEdACNAYYBCqBdPUIPN/NBF2MawQR2AI0BhgEKoF09QhE3+0FIli3BBHgAjQGGAQqgXT1CiJsBQoDJQMEEegCFAYYBCnJSPUKjcd1B9wI8wQrGQeZAQLbiPoid6EEEfQCOAYYBCqBdPUIPN+NBX/nnwAR/'
..'AI0BhgEKoF09Qg8360HgLwfBIQpTdHJhaWdodC0xBI8BkAGGAQdrAASIAJEBkgEGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKkPYaQaNx3UE4LUDBIQhSb3RhdGlvbgoAADRDAAAAAAAANEMKPibWQUC24j6InehBBI0AkQGSAQrghWTARSkI'
..'QjwtQMEKgI6DPhiZUkGInehBBJAAkQGSAQr0b7hBRSkIQjgtQMEEkgCRAZIBCoj2GkGjcd1BbokbQAo+JtZBQLbiPgD5Rj4ElQCRAZIBCpD2GkFXyCFCOC1AwQSXAJEBkgEKOAeSQUUpCEI2StPBCvy/HUEYmVJBEqmNPgSaAJEBkgEKPiacP0UpCEI2StPBBJwAkQGS'
..'AQrwsqpAIXEaQjZK08EKqrSQQXC0gEASqY0+BJ8AkQGSAQo+Jpw/RSkIQhEAHUAEoQCRAZIBCvCyqkAhcRpCEQAdQASjAJEBkgEKOAeSQUUpCEIRAB1ABKUAkQGSAQo33xtB/ygIQhAtQMEEqACTAYYBCgAAAACaEig3AAAAAAoAQDS9wMrxv/DSZUEhAWQEqwCFAYYB'
..'CgDAVDzByvG/FK5pwSEERG93bgSUAYUBhgEErwCRAZIBCvRvFEKkxT5CGBg+wQSxAJEBkgEK7DcUQoebGUKAgpu/BLMAkQGSAQrsNxRCh5sNQhfNAcEEtQCRAZIBCuw3FEKHmxFC0DPdwAS3AJEBkgEK7DcUQoebFUJgzbbABLkAkQGSAQqcWQZCQfoWQjgtQMEEuwCR'
..'AZIBCihpIkJB+hZCOC1AwQS9AJEBkgEK9G8UQh/5KEL4H9PBBL8AkQGSAQrsZRRCk/oWQl8YPsEEwQCRAZIBCuw3FEKImwVCfzMowQTDAJEBkgEK7DcUQoebCUJQABXBBMUAkQGSAQrsNxRCDzfzQRjNYcEExwCRAZIBCuw3FEIRN/tB55lOwQTJAJEBkgEK7DcUQoib'
..'AUKwZjvBBMsAkQGSAQoaQxRCo3HdQTgtQMEEzQCRAZIBCuw3FEIPN+NBvRmEwQTPAJEBkgEK7DcUQg8360FQAHXBIQpEaWFnb25hbC0xBJUBhQGGAQTTAJEBkgEKHnRYwqNx3UE8LUDBCmRDkUJAtuI+iJ3oQQTWAJEBkgEKBZ20wkUpCEI4LUDBBNgAkQGSAQrkf47B'
..'RSkIQjgtQMEE2gCRAZIBCpR0+cGjcd1BdokbQATcAJEBkgEKsp1YwlfIIUI8LUDBCgBtkUJAtuI+iJ3oQQTfAJEBkgEK8uA1wkUpCEI0StPBCrWRX0IYmVJBEqmNPgTiAJEBkgEKocWqwkUpCEI0StPBBOQAkQGSAQoLi6LCIXEaQjZK08EE5gCRAZIBCh4WesJFKQhC'
..'CAAdQAo3j19CGJlSQRKpjT4E6QCRAZIBCo4hDsIhcRpCGQAdQATrAJEBkgEKnOi0wUUpCEIRAB1ABO0AkQGSAQppEVjCjkAIQvypP8EhCkRpYWdvbmFsLTIElgGFAYYBBPEAkQGSAQoGCFnCOhAqQjwtQMEE8wCRAZIBCvnmtMKugENCOC1AwQT1AJEBkgEKtKePwa6A'
..'Q0I4LUDBBPcAkQGSAQpknPrBOhAqQnaJG0AE+QCRAZIBCpoxWcK+H11CPC1AwQT7AJEBkgEKUqVYwvSXQ0L8qT/BBJcBmAGGAQT+AJEBkgEKrNG0wRCBQ0K8SdPBBAABkQGSAQqmCnrCEIFDQrpJ08EEAgGRAZIBChYWDsLtyFVCuknTwQSZAZgBhgEEBQGaAZIBCo4U'
..'N8InjUNC8P0cQAQHAZoBkgEK2SSjwgPVVULn/RxABAkBmgGSAQpvX6vCJ41DQgr+HEAhB0xpYnJhcnkEmwGFAYYBBA0BhQGGAQrh/XPCCKwAQoKsSUMKehRYQv//20EOA2E+BJwBhQGGAQQRAYUBhgEKlW3zwbyzxEFK6ElDBBMBhQGGAQqVbfPBvLPEQTT/SUMEFQGF'
..'AYYBCi3n2MHwFMRBeNFJQwQXAYUBhgEKoczywX0X50F40UlDBBkBhQGGAQqOKwfCvLPEQXjRSUMEGwGFAYYBCm3n88GSYKJBeNFJQwQdAYUBhgEKwfvvwcDKFUKCrElDCj0K6EIehYdBDgNhPgQgAYUBhgEKRufzwQisNELm0+NCCgAA6kIAAMA/Sw8wQwQjAYUBhgEK'
..'QBcDPwisAEKCrElDCgAAXEIAANxBDgNhPgQmAYUBhgEKi2zzwfCfnEEYz+NCCgBA5kIAAIA/AAAwQwQpAYUBhgEKGNuwwgisAELm0+NCCgAAgD8AANxBSw8wQwQsAYUBhgEKuhjcQQisAELm0+NCBC4BhQGGAQpA/SI/vp+kQT73hEIKYMOkQQAAgD/A738/BDEBhQGG'
..'AQpA/SI/vp+oQV/3gkIKYMOkQQAAAEDA738/BDQBhQGGAQqUtjNBvp/AQcD3gEIKAACAPwAAAEH4/Z9ABDcBhQGGAQpsSRzBvp/AQcD3gEIEOQGFAYYBCliFQsK+n8BBwe95Qgr+cp1CAAAAQcDvfz8hDlVuaW9uT3BlcmF0aW9uB8IABD8BhQGGAQajoqUKzE9Dwm4S'
..'AUILK4FCCrgenUI/CsNBwHeUQAquR+E+PQrDQaZFkUAKuEkcwW8SAUKcRIFCCgAAAAAAAAAAAAAAAAq4Hp1CPQrDQS4n4T4Ky09Dwm4SAULB73lCBEcBhQGGAQpABJpBbhIBQgsrgUIK4nqEQTwKw0HAd5RACr0SM0FvEgFCnESBQgrrUYRBPQrDQS4n4T4KvBiaQW4S'
..'AULB73lCBE0BhQGGAQpA/SI/vp+sQYD3gEIKYMOkQQAAQEDA738/BFABhQGGAQpA/SI/vp+wQUDvfUIKYMOkQQAAgEDA738/BFMBhQGGAQpA/SI/vp+0QYHveUIKYMOkQQAAoEDA738/BFYBhQGGAQoAexI/Q4u4QejGcUIKAACpQSlcv0AAF0VABFkBhQGGAQrkdJtB'
..'vp/AQcHveUIKZmZ2QQAAAEHA738/BFwBhQGGAQopbPPBv5+4QejGL0IKAkDmQggAwEBxURBCCgCAHEIAAMBAcFEEQgpcT/JAvp+4QejGKUIKAACBQQAAwEBwURBCCteTmEG+n7hB6MYvQgoAQJxCAADAQHBREEIKFLZDwr6fuEHoxi9CBGUBhQGGAQoStPLBWmQhQqYm'
..'z0EKmZkRQXA9MkEA6NY+BGgBhQGGAQqtynXCCKwAQqYmz0EKCtdbQgAA3EEA6NY+BJ0BhQGGAQRsAYUBhgEKlW3zwWr78kFNwc9BBG4BhQGGAQqVbfPBavvyQZ140EEEcAGFAYYBCi3n2MGeXPJBvQrPQQRyAYUBhgEKoczywZavCkK9Cs9BBHQBhQGGAQqPKwfCavvy'
..'Qb0Kz0EEdgGFAYYBCm3n88FAqNBBvQrPQQR4AYUBhgEKADYIPwisAEKmJs9BBHoBhQGGAQpalfPBEFixQaYmz0EKKFwPQQAA8EAA6NY+BH4BmAGGAQoAAAAAAAA0wwAAAAAKbefzwQisAELD9eNCCgAANMMAAAAAAAA0wwSBAYUBhgEKAAAAAAaB5b/i+q9CBIMBhQGG'
..'AQoAAAAA+n7ywF/lr8IKAopmQiEewEEYGD7BCgAAgD8AAAAAAAAAAAoAAAAAAACAPwAAAAAKrn5nQvl0kECwyw3BCrobhkJM0JBArifiwQqufmdCBnWQQKzLDcEK1ZWHQj7f/0EAP4fACqSth0I+3/9BAD+HwAqKLz1CGvoWQhgYPsEK/f9/PwAAAAAAAAAACv//fz8A'
..'AAAAAAAAAAo43xtBQikIQjgtQMEKAACAvwAAAAAuvbuzCgAAgL8uvbuz7a0JKAouvbuzAACAPy69u7MKAACAPwAAAAAuvTu0CgJmFEIa+hZCGBg+wQpqEVjClEAIQjSqP8EKUqVYwvyXQ0I0qj/BCopBWMIQgUNCuknTwQoAAIC/AAAAAC69uzMKSuFYwimNQ0Lw/RxA'
..'CgAAgL8uvbuzAAAAKApG5/PBCKwAQsX140IKbefzwVK4xEGR7UlDCm3n88EAAPNBhevPQZgBAAABAAIAAwABAAEBAAIABAABAAIBAAIABQABAAMCAAYABwACAAgACQAECgAGAAcACgALAAwADQAOAA8AEAARABIAEwAUABUAFgAXABgAGQAaAA0ACQAECwAGABsACgAL'
..'AAwADQAOABwAEAAdAB4AHwASACAAFAAhABYAIgAYACMAGgANACQABgAACQAECAAKAAsADAANAA4AJQAQACYAEgAnABYAKAAYACkAGgANAAkABAgACgALAAwADQAOACUAEAAqABIAJwAWACsAGAAsABoADQAJAAQIAAoACwAMAA0ADgAlABAALQASACcAFgAuABgALwAa'
..'AA0ACQAECAAKAAsADAANAA4AJQAQADAAEgAnABYAMQAYADIAGgANADMAAgAAAQACAgAGADQAAgA1AAEADQIABgA2AAIANwAJAA4GAAoACwAMAA0AEAA4ABYAOQAYADoAGgANAAkADgYACgALAAwADQAQADsAFgA8ABgAPQAaAA0ACQAOBgAKAAsADAANABAAPgAWAD8A'
..'GAA9ABoADQAJAA4GAAoACwAMAA0AEABAABYAQQAYAEIAGgANAAkADgsABgBDAAoACwAMAA0ADgAlABAARAAeAB8AEgAnABYARQAYAEYAGgANAEcASABJABMDAAYASgAQAEsAFgBMAEkAEwMABgBNABAATgAWAE8AAQANAgAGAFAAAgBRAAkAFgYACgALAAwADQAQAFIA'
..'FgBTABgAVAAaAA0ACQAWCQAKAAsADAANAA4AVQAQAFYAEgBXABQAFQAWAFgAGABZABoADQAJABYJAAoACwAMAA0ADgBVABAAWgASAFcAFAAVABYAWwAYAFwAGgANAAkAFgkACgALAAwADQAOAFUAEABdABIAVwAUABUAFgBeABgAXAAaAA0ACQAWCQAKAAsADAANAA4A'
..'VQAQAF8AEgBXABQAFQAWAGAAGABcABoADQAJABYGAAoACwAMAA0AEABhABYAYgAYAGMAGgANAAkAFgYACgALAAwADQAQAGQAFgBlABgAYwAaAA0ACQAWBgAKAAsADAANABAAZgAWAGcAGABoABoADQAJABYLAAYAQwAKAAsADAANAA4AJQAQAGkAHgAfABIAJwAWAGoA'
..'GABGABoADQBHAEgASQAfAwAGAEoAEABrABYAbABJAB8DAAYATQAQAG0AFgBuAAkAFgkACgALAAwADQAOAFUAEABvABIAVwAUABUAFgBwABgAXAAaAA0ACQAWCQAKAAsADAANAA4AVQAQAHEAEgBXABQAFQAWAHIAGABcABoADQAJABYJAAoACwAMAA0ADgBVABAAcwAS'
..'AFcAFAAVABYAdAAYAFwAGgANAAkAFgkACgALAAwADQAOAFUAEAB1ABIAVwAUABUAFgB2ABgAXAAaAA0ACQAWCQAKAAsADAANAA4AVQAQAHcAEgBXABQAFQAWAHgAGABcABoADQAJABYGAAoACwAMAA0AEAB5ABYAegAYAHsAGgANAAkAFgkACgALAAwADQAOAFUAEAB8'
..'ABIAVwAUABUAFgB9ABgAXAAaAA0ACQAWCQAKAAsADAANAA4AVQAQAH4AEgBXABQAFQAWAH8AGABcABoADQABAA0CAAYAgAACAIEACQAqCwAKAAsADAANAA4AggAQAIMAEgCEABQAhQCGAIcAFgCIAIkAigAYAIsAGgANAAkAKggACgALAAwADQAQAIwAhgCHABYAjQCJ'
..'AIoAGACOABoADQAJACoIAAoACwAMAA0AEACPAIYAhwAWAJAAiQCKABgAjgAaAA0ACQAqCAAKAAsADAANABAAkQCGAIcAFgCSAIkAigAYAJMAGgANAAkAKggACgALAAwADQAQAJQAhgCHABYAlQCJAIoAGACLABoADQAJACoIAAoACwAMAA0AEACWAIYAhwAWAJcAiQCK'
..'ABgAmAAaAA0ACQAqCAAKAAsADAANABAAmQCGAIcAFgCaAIkAigAYAJgAGgANAAkAKggACgALAAwADQAQAJsAhgCHABYAnACJAIoAGACdABoADQAJACoIAAoACwAMAA0AEACeAIYAhwAWAJ8AiQCKABgAmAAaAA0ACQAqCAAKAAsADAANABAAoACGAIcAFgChAIkAigAY'
..'AJ0AGgANAAkAKggACgALAAwADQAQAKIAhgCHABYAowCJAIoAGACYABoADQAJACoNAAYAQwAKAAsADAANAA4AJQAQAKQAHgAfABIAJwCGAIcAFgClAIkAigAYAEYAGgANAEcASABJADYEAAYASgAQAKYAhgCnABYAqABJADYDAAYAqQAQAKoAFgCrAAEADQIABgCsAAIA'
..'rQAJADkIAAoACwAMAA0AEACuAIYAhwAWAK8AiQCKABgAVAAaAA0ACQA5CwAKAAsADAANAA4AVQAQALAAEgBXABQAFQCGAIcAFgCxAIkAigAYAFkAGgANAAkAOQsACgALAAwADQAOAFUAEACyABIAVwAUABUAhgCHABYAswCJAIoAGABcABoADQAJADkLAAoACwAMAA0A'
..'DgBVABAAtAASAFcAFAAVAIYAhwAWALUAiQCKABgAXAAaAA0ACQA5CwAKAAsADAANAA4AVQAQALYAEgBXABQAFQCGAIcAFgC3AIkAigAYAFwAGgANAAkAOQgACgALAAwADQAQALgAhgCHABYAuQCJAIoAGABjABoADQAJADkIAAoACwAMAA0AEAC6AIYAhwAWALsAiQCK'
..'ABgAYwAaAA0ACQA5CAAKAAsADAANABAAvACGAIcAFgC9AIkAigAYAGgAGgANAAkAOQ0ABgBDAAoACwAMAA0ADgAlABAAvgAeAB8AEgAnAIYAhwAWAL8AiQCKABgARgAaAA0ARwBIAEkAQgMABgBKABAAawAWAGwASQBCAwAGAE0AEABtABYAbgAJADkLAAoACwAMAA0A'
..'DgBVABAAwAASAFcAFAAVAIYAhwAWAMEAiQCKABgAXAAaAA0ACQA5CwAKAAsADAANAA4AVQAQAMIAEgBXABQAFQCGAIcAFgDDAIkAigAYAFwAGgANAAkAOQsACgALAAwADQAOAFUAEADEABIAVwAUABUAhgCHABYAxQCJAIoAGABcABoADQAJADkLAAoACwAMAA0ADgBV'
..'ABAAxgASAFcAFAAVAIYAhwAWAMcAiQCKABgAXAAaAA0ACQA5CwAKAAsADAANAA4AVQAQAMgAEgBXABQAFQCGAIcAFgDJAIkAigAYAFwAGgANAAkAOQgACgALAAwADQAQAMoAhgCHABYAywCJAIoAGAB7ABoADQAJADkLAAoACwAMAA0ADgBVABAAzAASAFcAFAAVAIYA'
..'hwAWAM0AiQCKABgAXAAaAA0ACQA5CwAKAAsADAANAA4AVQAQAM4AEgBXABQAFQCGAIcAFgDPAIkAigAYAFwAGgANAAEADQIABgDQAAIA0QAJAE0LAAoACwAMAA0ADgCCABAA0gASAIQAFACFAIYAhwAWANMAiQCKABgA1AAaAA0ACQBNCAAKAAsADAANABAA1QCGAIcA'
..'FgDWAIkAigAYAI4AGgANAAkATQgACgALAAwADQAQANcAhgCHABYA2ACJAIoAGACOABoADQAJAE0IAAoACwAMAA0AEADZAIYAhwAWANoAiQCKABgAkwAaAA0ACQBNCAAKAAsADAANABAA2wCGAIcAFgDcAIkAigAYAN0AGgANAAkATQgACgALAAwADQAQAN4AhgCHABYA'
..'3wCJAIoAGADgABoADQAJAE0IAAoACwAMAA0AEADhAIYAhwAWAOIAiQCKABgAmAAaAA0ACQBNCAAKAAsADAANABAA4wCGAIcAFgDkAIkAigAYAJ0AGgANAAkATQgACgALAAwADQAQAOUAhgCHABYA5gCJAIoAGADnABoADQAJAE0IAAoACwAMAA0AEADoAIYAhwAWAOkA'
..'iQCKABgAnQAaAA0ACQBNCAAKAAsADAANABAA6gCGAIcAFgDrAIkAigAYAJgAGgANAAkATQ0ABgBDAAoACwAMAA0ADgAlABAA7AAeAB8AEgAnAIYAhwAWAO0AiQCKABgARgAaAA0ARwBIAEkAWQQABgBKABAApgCGAKcAFgCoAEkAWQMABgCpABAAqgAWAKsAAQANAgAG'
..'AO4AAgDvAAkAXAsACgALAAwADQAOAIIAEADwABIAhAAUAIUAhgCHABYA8QCJAIoAGADUABoADQAJAFwIAAoACwAMAA0AEADyAIYAhwAWAPMAiQCKABgAjgAaAA0ACQBcCAAKAAsADAANABAA9ACGAIcAFgD1AIkAigAYAI4AGgANAAkAXAgACgALAAwADQAQAPYAhgCH'
..'ABYA9wCJAIoAGACTABoADQAJAFwIAAoACwAMAA0AEAD4AIYAhwAWAPkAiQCKABgA3QAaAA0ACQBcDQAGAEMACgALAAwADQAOACUAEAD6AB4AHwASACcAhgCHABYA+wCJAIoAGABGABoADQBHAEgASQBiBAAGAEoAEACmAIYApwAWAKgASQBiAwAGAKkAEACqABYAqwAB'
..'AFwBAAIA/AAJAGUIAAoACwAMAA0AEAD9AIYAhwAWAP4AiQCKABgAmAAaAA0ACQBlCAAKAAsADAANABAA/wCGAIcAFgAAAYkAigAYAOcAGgANAAkAZQgACgALAAwADQAQAAEBhgCHABYAAgGJAIoAGACdABoADQABAFwBAAIAAwEJAGkIAAoACwAMAA0AEAAEAYYAhwAW'
..'AAUBiQCKABgA4AAaAA0ACQBpCAAKAAsADAANABAABgGGAIcAFgAHAYkAigAYAJ0AGgANAAkAaQgACgALAAwADQAQAAgBhgCHABYACQGJAIoAGACYABoADQABAA0CAAYACgECAAsBCQBtBgAKAAsADAANABAADAEWAA0BGAAOARoADQABAG0CAAYABwACAA8BCQBvCgAG'
..'AAcACgALAAwADQAOAA8AEAAQARIAEwAUABUAFgARARgAGQAaAA0ACQBvCwAGABsACgALAAwADQAOABwAEAASAR4AHwASACAAFAAhABYAEwEYACMAGgANACQAcQAACQBvCAAKAAsADAANAA4AJQAQABQBEgAnABYAFQEYACkAGgANAAkAbwgACgALAAwADQAOACUAEAAW'
..'ARIAJwAWABcBGAAsABoADQAJAG8IAAoACwAMAA0ADgAlABAAGAESACcAFgAZARgALwAaAA0ACQBvCAAKAAsADAANAA4AJQAQABoBEgAnABYAGwEYADIAGgANAAkAbQYACgALAAwADQAQABwBFgAdARgAHgEaAA0ACQBtBgAKAAsADAANABAAHwEWACABGAAhARoADQAJ'
..'AG0GAAoACwAMAA0AEAAiARYAIwEYACQBGgANAAkAbQkACgALAAwADQAOAFUAEAAlARIAVwAUABUAFgAmARgAJwEaAA0ACQBtBgAKAAsADAANABAAKAEWACkBGAAqARoADQAJAG0GAAoACwAMAA0AEAArARYALAEYACoBGgANAAkAbQkACgALAAwADQAOAFUAEAAtARIA'
..'VwAUABUAFgAuARgALwEaAA0ACQBtCQAKAAsADAANAA4AVQAQADABEgBXABQAFQAWADEBGAAyARoADQAJAG0GAAoACwAMAA0AEAAzARYANAEYADUBGgANAAkAbQYACgALAAwADQAQADYBFgA3ARgANQEaAA0ACQBtBgAKAAsADAANABAAOAEWADkBGAA6ARoADQA7AUAC'
..'AAkAQQFCAUMBAAkARAFFAUMBbQcACgALAA4APAEQAD0BEgA+ARQAIQAWAD8BGABAATsBQAIACQBBAUkBQwEACQBKAUsBQwFtBwAKAAsADgA8ARAARgESAD4BFAAhABYARwEYAEgBCQBtCQAKAAsADAANAA4AVQAQAEwBEgBXABQAFQAWAE0BGABOARoADQAJAG0JAAoA'
..'CwAMAA0ADgBVABAATwESAFcAFAAVABYAUAEYAFEBGgANAAkAbQkACgALAAwADQAOAFUAEABSARIAVwAUABUAFgBTARgAVAEaAA0ACQBtCQAKAAsADAANAA4AVQAQAFUBEgBXABQAFQAWAFYBGABXARoADQAJAG0GAAoACwAMAA0AEABYARYAWQEYAFoBGgANADsBQAMA'
..'CQBeAV8BQwEACQBgAWEBQwEACQBiAWMBQwFtBwAKAAsADgCCABAAWwESAIQAFACFABYAXAEYAF0BCQBtBgAKAAsADAANABAAZAEWAGUBGABmARoADQAJAG0GAAoACwAMAA0AEABnARYAaAEYAGkBGgANAAEAbQIABgAHAAIAagEJAIwKAAYABwAKAAsADAANAA4ADwAQ'
..'AGsBEgATABQAFQAWAGwBGAAZABoADQAJAIwLAAYAGwAKAAsADAANAA4AHAAQAG0BHgAfABIAIAAUACEAFgBuARgAIwAaAA0AJACOAAAJAIwIAAoACwAMAA0ADgAlABAAbwESACcAFgBwARgAKQAaAA0ACQCMCAAKAAsADAANAA4AJQAQAHEBEgAnABYAcgEYACwAGgAN'
..'AAkAjAgACgALAAwADQAOACUAEABzARIAJwAWAHQBGAAvABoADQAJAIwIAAoACwAMAA0ADgAlABAAdQESACcAFgB2ARgAMgAaAA0ACQBtBgAKAAsADAANABAAdwEWAHgBGABpARoADQAJAG0GAAoACwAMAA0AEAB5ARYAegEYAHsBGgANAAkAbQ0ABgBDAAoACwAMAA0A'
..'DgAlABAAfAEeAB8AEgAnAIYAfQEWAH4BiQB/ARgARgAaAA0ARwBIAEkAlgMABgBKABAAgAEWAIEBSQCWAwAGAKkAEACCARYAgwEA')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
