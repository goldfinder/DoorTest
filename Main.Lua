-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 29084 characters

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
				if door == 1000 and door ~= "No more doors :(" then
					local cinst = game.ReplicatedStorage:FindFirstChild("Assets")[corr.Instance]
					cinst = cinst:Clone()
					if cinst.Name=="LIB" then
						for i=1,20 do
							wait(.15)
							print(i)
							if door/50 ~= i then
								cinst[i]:destroy()
							end
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
						for i=1,20 do
							wait(.15)
							print(i)
							if door/50 ~= i then
								cinst[i]:destroy()
							end
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


local Objects = Decode('AFA2AyEFTW9kZWwhCldvcmxkUGl2b3QEDwMQAxEDBBIDEAMRAwQTAxADEQMEFAMQAxEDIQROYW1lIQREb29yBBUDEAMRAyEEUGFydCEIQW5jaG9yZWQiIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQpCcmlja0NvbG9yB2kBIQZDRnJhbWUEGAAQAxEDIQVDb2xvcgZW'
	..'QjYhCE1hdGVyaWFsAwAAAAAAAIBAIQhQb3NpdGlvbgqau2dCF1j1QpQUkMQhBFNpemUK2kXHQO3WA0EYhSM/IQpUb3BTdXJmYWNlIQpTdXJmYWNlR3VpIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEQQ2xpcHNEZXNjZW5kYW50cyEERmFjZQMAAAAAAAAAQCEOTGln'
	..'aHRJbmZsdWVuY2UhClNpemluZ01vZGUhBUZyYW1lIRBCYWNrZ3JvdW5kQ29sb3IzBv///yEWQmFja2dyb3VuZFRyYW5zcGFyZW5jeQwAAAAAAADNzMw9AAAMAACAPwAAAAAAAGQAIQdUZXh0Qm94DAAAgD8AAAAAgD8AACEERm9udAMAAAAAAAAQQCERUGxhY2Vob2xk'
	..'ZXJDb2xvcjMhBFRleHQhATAhClRleHRDb2xvcjMhCFRleHRTaXplAwAAAAAAAERAIRBEb29ySGl0RGV0ZWN0aW9uB0wBBDsAEAMRAyEKQ2FuQ29sbGlkZQIGdQAAAwAAAAAAwJhACpq7Z0IXWPVCtxGQxAp2Md9AUrgKQVyPQj8hDFRyYW5zcGFyZW5jeSEGU2NyaXB0'
	..'B+oDBEIAEAMRAwbNzc0Kzv50QmQw9UJuF5DECuD74z475w1BAKMtPwRFABADEQMKFAxoQgfx/UJuF5DECmpr3UAg/d4+AKMtPwRIABADEQMK1kZaQhdY9UJuF5DECkAiFj9rYhBBAKMtPyECU1AETAAQAxEDCq5+Z0JMw+xCbheQxArGQeZAQLbiPgCjLT8hBVNvdW5k'
	..'IQdTb3VuZElkIRZyYnhhc3NldGlkOi8vMTU3MTY3MjAzIQ1CaW5kYWJsZUV2ZW50IQZBc3NldHMEFgMQAxEDIQhTdHJhaWdodAQXAxADEQMEVwAQAxEDCg//rUOx6v1C98CLxArGQeZAQLbiPp3DY0EEWgAQAxEDCkE7rEOPM/VC98CLxAoARtY+5ocSQZ3DY0EEXQAQ'
	..'AxEDCsXOr0OPM/VC98CLxARfABADEQMKD/+tQ2FC7EIqwYvECsZB5kBAtuI+6PZjQSEFUkNFTlQEYwAQAxEDCg0FrkOnFvVCqb2LxAoAAIBAAACAPwAAAEAhCkF0dGFjaG1lbnQhA0VuZARoABADEQMKAAAAAAAAAACPwuPAIQlCZWdpbm5pbmcEawAQAxEDCgAAAAAA'
	..'AAAAj8LjQCECVXAEGAMQAxEDBG8AEAMRAwqVX5BDDiIKQ2S/jMQKNhPpQGA5LD+osupBB20BBHQAGQMRAwZqOQkKlWaQQ4fXAEO0FI7ECv/Q5kAAAIA/NnP5QAR3ABkDEQMKlWaQQw6v+0L6N43ECv/Q5kAAAIA/mZmZPwR6ABkDEQMKlWaQQw6v/UJhXo3EBHwAGQMR'
	..'AwqVZpBDDq//QseEjcQEfgAQAxEDCl8ikkM2LwBDOruMxArAvHU+XI+kQYid6EEEgQAQAxEDCm2gjkM2LwBDOruMxASDABADEQMKlV+QQ+2uBEMV74rECjYT6UDOJzlBALSiPgSGABADEQMK1WCQQ0ovAENkv4zEBIgAEAMRAwoAOjS9AACsQKRwZ8EEigAQAxEDCgAA'
	..'VTw3ibXAMLJjQQSMABkDEQMKlWaQQw6v90Iu64zEBI4AGQMRAwqVZpBDDq/5QpQRjcQEkAAZAxEDCpVmkEMOr/FC+neMxASSABkDEQMKlWaQQw+v80JhnozEBJQAGQMRAwqVZpBDDq/1QsfEjMQElgAQAxEDCi9lkEOzPexCOruMxArGQeZAQLbiPoid6EEEmQAaAxED'
	..'CpVmkEMOr+1CLiuMxASbABkDEQMKlWaQQw6v70KUUYzEIQpTdHJhaWdodC0xBBsDHAMRAwdrAASkAB0DHgMGAI+cAwAAAAAAgJRAIQtPcmllbnRhdGlvbgoAAAAAAAA0QwAAAAAKv66fQ+Vw7EL1uY7EIQhSb3RhdGlvbgoAADTDAAAAAAAANMMKPibWQUC24j6InehB'
	..'BKkAHQMeAwr/DZlDHSn5QvW5jsQKgI6DPhiZUkGInehBBKwAHQMeAwoLXqZDHSn5QvW5jsQErgAdAx4DCr+un0PlcOxC1uuMxAo+JtZBQLbiPgD5Rj4EsQAdAx4DCr+un0NU/AJD9bmOxASzAB0DHgMKf/ejQx0p+ULDhpDECvy/HUEYmVJBEqmNPgS2AB0DHgMKMXOb'
	..'Qx0p+ULDhpDEBLgAHQMeAwrXgZ1DhiYBQ8OGkMQKqrSQQXC0gEASqY0+BLsAHQMeAwoxc5tDHSn5QhvrjMQEvQAdAx4DCteBnUOGJgFDG+uMxAS/AB0DHgMKf/ejQx0p+UIb64zEBMEAHQMeAwoFtp9D+yj5QvW5jsQExAAfAxEDCgAAAACaEig3AAAAAAoAQDS9wMrx'
	..'v/DSZUEhAWQExwAQAxEDCgDAVDzByvG/FK5pwSEERG93bgQgAxADEQMEywAdAx4DCjPBikN+XwpDb7aMxATNAB0DHgMKM7qKQ/cUAUMfYYvEBM8AHQMeAwozuopD7in8Qtk9jMQE0QAdAx4DCjO6ikPuKf5CcheMxATTAB0DHgMKM7qKQ/cUAEMM8YvEBNUAHQMeAwpp'
	..'/ohDpmwAQ5m6jMQE1wAdAx4DClmAjEOmbABDmbqMxATZAB0DHgMKM8GKQ13sBEO+ho7EBNsAHQMeAwrzv4pDumwAQ2+2jMQE3QAdAx4DCjO6ikPuKfhCpYqMxATfAB0DHgMKM7qKQ+4p+kI/ZIzEBOEAHQMeAwozuopD7inyQtn9jMQE4wAdAx4DCjO6ikPvKfRCcteM'
	..'xATlAB0DHgMKM7qKQ+4p9kIMsYzEBOcAHQMeAwqZu4pDk7jsQpm6jMQE6QAdAx4DCjO6ikPuKe5CpUqNxATrAB0DHgMKM7qKQ+4p8EI/JI3EIQpEaWFnb25hbC0xBCEDEAMRAwTvAB0DHgMKmtNjQxek7ELgG5HECmRDkUJAtuI+iJ3oQQTyAB0DHgMKIqI/Q1Fc+ULg'
	..'G5HEBPQAHQMeAwpVEIRDUVz5QuAbkcQE9gAdAx4DChLCekMXpOxCwU2PxAT4AB0DHgMKOsljQ+0VA0PgG5HECgBtkUJAtuI+iJ3oQQT7AB0DHgMKanhsQ1Fc+UKv6JLECrWRX0IYmVJBEqmNPgT+AB0DHgMK0o1EQ1Fc+UKv6JLEBAABHQMeAwoeq0hDIEABQ6/oksQE'
	..'AgEdAx4DChprW0NRXPlCBk2PxAo3j19CGJlSQRKpjT4EBQEdAx4DCkJodkMgQAFDBk2PxAQHAR0DHgMKyamBQ1Fc+UIGTY/EBAkBHQMeAwpK7GND9mf5QtoakcQhCkRpYWdvbmFsLTIEIgMQAxEDBA0BHQMeAwoycWRD9qvsQtY0jMQEDwEdAx4DCro/QEMwZPlC1jSM'
	..'xAQRAR0DHgMKH1+EQzBk+ULWNIzEBBMBHQMeAwqqX3tD9qvsQrdmisQEFQEdAx4DCs5mZEPcGQND1jSMxAQXAR0DHgMK4olkQ9Jv+ULQM4zEBCMDJAMRAwQaAR0DHgMKfwyCQ2Bk+UKjAY7EBBwBHQMeAwqKMFxDYGT5QqMBjsQEHgEdAx4DCq4td0MoRAFDowGOxAQl'
	..'AyQDEQMEIQEdAx4DChLubENsavlC/WWKxAQjAR0DHgMKyiBJQy1HAUP9ZYrEBCUBHQMeAwp6A0VDbGr5Qv1lisQhA0xJQgQmAycDEQMEKQEoAykDCr/Us0N+PwND412JxAoAADRDAAAAAAAANEMKehRYQv//20EOA2E+BC0BKgMRAwp5k6RDfj8DQ17PfMQELwEQAxED'
	..'CgAAAAAGgeW/4vqvQgQxARADEQMKAAAAAPp+8sBf5a/CBDMBKAMpAwq/VKRDLIcIQ+NdicQKPQroQh6Fh0EOA2E+BDYBKAMpAwp3k6RDfj8QQyLLfMQKAADqQgAAwD9LDzBDBDkBKAMpAwp3E5VDfj8DQ+NdicQKAABcQgAA3EEOA2E+BDwBHAMRAwrHi6RD5VDtQojK'
	..'fMQKAEDmQgAAgD8AADBDBD8BKAMpAwrJi8FDfj8DQyLLfMQKAACAPwAA3EFLDzBDBEIBKAMpAwp3k4dDfj8DQyLLfMQERAEoAykDCoMDlUPnUO9Cju9wxApgw6RBAACAP8Dvfz8ERwEoAykDCoMDlUPnUPBCkq9wxApgw6RBAAAAQMDvfz8ESgEoAykDCk23j0PnUPZC'
	..'nm9wxAoAAIA/AAAAQfj9n0AETQEoAykDCk03mkPnUPZCnm9wxARPASgDKQMKraWtQ+dQ9kKi72/ECv5ynUIAAABBwO9/PyEOVW5pb25PcGVyYXRpb24HwgAEVQEoAykDBqOipQr7vq1DGFkDQwZ2cMQKuB6dQj8Kw0HAd5RAIQxVc2VQYXJ0Q29sb3IKuB6dQj0Kw0Eu'
	..'J+E+Cvq+rUMYWQNDoe9vxAquR+E+PQrDQWJGkUAKTjeaQxhZA0M5eXDEBF0BKAMpAwq/tItDGFkDQwZ2cMQK4nqEQTwKw0HAd5RACutRhEE9CsNBLifhPgp3s4tDGFkDQ6Pvb8QKrkfhPj0Kw0GmRZFACm28j0MYWQNDOnlwxARkASgDKQMKgwOVQ+dQ8UKWb3DECmDD'
	..'pEEAAEBAwO9/PwRnASgDKQMKgwOVQ+dQ8kKaL3DECmDDpEEAAIBAwO9/PwRqASgDKQMKgwOVQ+dQ80Ke72/ECmDDpEEAAKBAwO9/PwRtASgDKQMKxQuVQ8lL9EIUbW/ECgAAqUEpXL9AABdFQARwASgDKQMKtZ2LQ+dQ9kKi72/ECmZmdkEAAABBwO9/PwRzASgDKQMK'
	..'xYukQ+hQ9EIUTWvECgJA5kIIAMBAcVEQQgoAAIFBAADAQHBREEIKxcuLQ+dQ9EIUTWvECgBAnEIAAMBAcFEQQgrFy61D6FD0QhRNa8QKAIAcQgAAwEBwUQRCCsWLkUPoUPRCFO1qxAR8ASgDKQMKQ4CkQ5JtC0PayWbECpmZEUFwPTJBAOjWPgR/ASgDKQMKWQ60Q34/'
	..'A0PayWbECgrXW0IAANxBAOjWPgSCASgDKQMKWY6kQ/x+8kLayWbECihcD0EAAPBAAOjWPgSFASgDKQMK5xCVQ34/A0PayWbEBCsDEAMRAwSeAScDEQMHxwAEjAEnAxEDBmNfYgMAAAAAAICQQAp+SqpD1sv+Qos2h8QKANejPAAAgD+ZmRk/IQVTaGFwZQSRAREDEAMK'
	..'AAAAAAAANEMAALRCCn5KqkP/p/dCizaHxAoAADTDAAAAAAAAtMIK4XrkQArXozyZmRk/BJUBJwMRAwp+SqpDKITwQos2h8QHagAEmgEnAxEDBtqFQQMAAAAAAAByQAp+SqpDZY7wQos2h8QKisJ1PQAAgD+4HgU/IQxTdXJmYWNlTGlnaHQEngERAxADCn9KqkP/p/dC'
	..'izaHxArheuRAj8J1PbgeBT8EoQEQAxEDCsfLqkM9ngNDizaHxAoAAABAj8LVQQAAAEAEpAEQAxEDCseLpEN6qAZDizaHxAoAALhBAACAPwAAAEAEpwEQAxEDCsdLnkM9ngNDizaHxASzARADEQMEqgEQAxEDCg/NnkPWy/5CizaHxAStAREDJwMKAAAAAAAAAAAAALRC'
	..'Cg/NnkP/p/dCizaHxASvARADEQMKD82eQyiE8EKLNofEBLEBEAMRAwoPzZ5DZY7wQos2h8QEswERAycDCg7NnkP/p/dCizaHxAQsAxADEQMEvwEnAxEDBLcBJwMRAwp+SqpD1sv+Qou2hMQEuQERAxADCn5KqkP/p/dCi7aExAS7AScDEQMKfkqqQyiE8EKLtoTEBL0B'
	..'JwMRAwp+SqpDZY7wQou2hMQEvwERAxADCn9KqkP/p/dCi7aExATBARADEQMKx8uqQz2eA0OLtoTEBMMBEAMRAwrHi6RDeqgGQ4u2hMQExQEQAxEDCsdLnkM9ngNDi7aExATQARADEQMEyAEQAxEDCg/NnkPWy/5Ci7aExATKAREDJwMKD82eQ/+n90KLtoTEBMwBEAMR'
	..'AwoPzZ5DKITwQou2hMQEzgEQAxEDCg/NnkNljvBCi7aExATQAREDJwMKDs2eQ/+n90KLtoTEBNIBEAMRAwrHi6RDc6gGQ4u2hMQKwvWIQOtRuD8AAABABC0DEAMRAwTfAScDEQME1wEnAxEDCn5KqkPWy/5CizaCxATZAREDEAMKfkqqQ/+n90KLNoLEBNsBJwMRAwp+'
	..'SqpDKITwQos2gsQE3QEnAxEDCn5KqkNljvBCizaCxATfAREDEAMKf0qqQ/+n90KLNoLEBOEBEAMRAwrHy6pDPZ4DQ4s2gsQE4wEQAxEDCseLpEN6qAZDizaCxATlARADEQMKx0ueQz2eA0OLNoLEBPABEAMRAwToARADEQMKD82eQ9bL/kKLNoLEBOoBEQMnAwoPzZ5D'
	..'/6f3Qos2gsQE7AEQAxEDCg/NnkMohPBCizaCxATuARADEQMKD82eQ2WO8EKLNoLEBPABEQMnAwoOzZ5D/6f3Qos2gsQELgMQAxEDBPwBJwMRAwT0AScDEQMKfkqqQ9bL/kIWbX/EBPYBEQMQAwp+SqpD/6f3QhZtf8QE+AEnAxEDCn5KqkMohPBCFm1/xAT6AScDEQMK'
	..'fkqqQ2WO8EIWbX/EBPwBEQMQAwp/SqpD/6f3QhZtf8QE/gEQAxEDCsfLqkM9ngNDFm1/xAQAAhADEQMKx4ukQ3qoBkMWbX/EBAICEAMRAwrHS55DPZ4DQxZtf8QEDQIQAxEDBAUCEAMRAwoPzZ5D1sv+QhZtf8QEBwIRAycDCg/NnkP/p/dCFm1/xAQJAhADEQMKD82e'
	..'QyiE8EIWbX/EBAsCEAMRAwoPzZ5DZY7wQhZtf8QEDQIRAycDCg7NnkP/p/dCFm1/xAQvAxADEQMEGQInAxEDBBECJwMRAwp+SqpD1sv+QhZtesQEEwIRAxADCn5KqkP/p/dCFm16xAQVAicDEQMKfkqqQyiE8EIWbXrEBBcCJwMRAwp+SqpDZY7wQhZtesQEGQIRAxAD'
	..'Cn9KqkP/p/dCFm16xAQbAhADEQMKx8uqQz2eA0MWbXrEBB0CEAMRAwrHi6RDeqgGQxZtesQEHwIQAxEDCsdLnkM9ngNDFm16xAQqAhADEQMEIgIQAxEDCg/NnkPWy/5CFm16xAQkAhEDJwMKD82eQ/+n90IWbXrEBCYCEAMRAwoPzZ5DKITwQhZtesQEKAIQAxEDCg/N'
	..'nkNljvBCFm16xAQqAhEDJwMKDs2eQ/+n90IWbXrEBDADEAMRAwQ2AicDEQMELgInAxEDCn5KqkPWy/5CFm11xAQwAhEDEAMKfkqqQ/+n90IWbXXEBDICJwMRAwp+SqpDKITwQhZtdcQENAInAxEDCn5KqkNljvBCFm11xAQ2AhEDEAMKf0qqQ/+n90IWbXXEBDgCEAMR'
	..'AwrHy6pDPZ4DQxZtdcQEOgIQAxEDCseLpEN6qAZDFm11xAQ8AhADEQMKx0ueQz2eA0MWbXXEBEcCEAMRAwQ/AhADEQMKD82eQ9bL/kIWbXXEBEECEQMnAwoPzZ5D/6f3QhZtdcQEQwIQAxEDCg/NnkMohPBCFm11xARFAhADEQMKD82eQ2WO8EIWbXXEBEcCEQMnAwoO'
	..'zZ5D/6f3QhZtdcQhAjIwBDEDMgMzAyEITWVzaFBhcnQhB3VuaTAwMzEHGAAEUAIyAzMDBv/MMwMAAAAAAACRQApzYqVDbakGQy/PhMQKaHcAP1x2iD8AAAA/IQZNZXNoSWQhF3JieGFzc2V0aWQ6Ly8zMjU1Mjc1MTk4IQhNZXNoU2l6ZQpod4A+V3YIP9PMTD0hB3Vu'
	..'aTAwMzAEWAIyAzMDCp/rpEP3pwZDL8+ExArknmY/SKSNPwAAAD8hF3JieGFzc2V0aWQ6Ly8zMjU1Mjc1MjYzCt6e5j5NpA0/08xMPQRdAjIDMwMKj2akQ/enBkMvz4TEBF8CMgMzAwp/4aND96cGQy/PhMQhAy0tLQRiAjQDKQMKsYWkQy0HAkOIimfECo/CXUF7FDZB'
	..'CtfDQCECMTkENQMQAzYDIQd1bmkwMDM5B5cABGsCEAM2AwZ/f38DAAAAAAAAcUAKHxWlQ/mpBkMvz4TECrYwWz8wm4w/AAAAPyEXcmJ4YXNzZXRpZDovLzMyNTUyNzQ1MjQKuDDbPjCbDD/TzEw9IQd1bmkwMDM1BHECEAM2Awpnl6RDnacGQy/PhMQKfIFRP5RQij8A'
	..'AAA/IRdyYnhhc3NldGlkOi8vMzI1NTI3NDkwNQqHgdE+lVAKP9PMTD0EdgIQAzYDCoMYpEMBqAZDL8+ExCECMTchB3VuaTAwMzgEegIQAzYDCmsVpUN3qQZDL8+ExAoOhFw/jDGMPwAAAD8hF3JieGFzc2V0aWQ6Ly8zMjU1Mjc0NjIxCgCE3D6TMQw/08xMPQR/AhAD'
	..'NgMKI5ekQ52nBkMvz4TEBIECEAM2Awo/GKRDAagGQy/PhMQhATghB3VuaTAwMzQEhQIQAzYDCr8ZpUN3qQZDL8+ExApKe2M/XHaIPwAAAD8hF3JieGFzc2V0aWQ6Ly8zMjU1Mjc0OTc0CkV74z5Xdgg/08xMPQSKAhADNgMKE5ekQwGoBkMvz4TEBIwCEAM2AwoDEqRD'
	..'AagGQy/PhMQhAjE4BI8CEAM2AwoHGqVD+akGQy/PhMQEkQIQAzYDCq+YpEMBqAZDL8+ExASTAhADNgMKnxOkQwGoBkMvz4TEIQIxNSEHdW5pMDAzNwf2AwSZAhADNgMGf34ACkcVpUN3qQZDL8+ExArg9kQ/XHaIPwAAAD8hF3JieGFzc2V0aWQ6Ly8zMjU1Mjc0Njg3'
	..'Cs/2xD5Xdgg/08xMPQSeAhADNgMK/5ykQ52nBkMvz4TEBKACEAM2AwobHqRDAagGQy/PhMQhAjE2BKMCEAM2AwpTGqVDd6kGQy/PhMQEpQIQAzYDCmuYpEMBqAZDL8+ExASnAhADNgMKWxOkQwGoBkMvz4TEIQE5BKoCEAM2AwrXFKVDd6kGQy/PhMQErAIQAzYDCs+V'
	..'pEOdpwZDL8+ExASuAhADNgMK6xakQwGoBkMvz4TEIQEzBLECEAM2AwoLG6VDd6kGQy/PhMQEswIQAzYDCtOnpEOdpwZDL8+ExAS1AhADNgMK7yikQwGoBkMvz4TEIQIxNAS4AhADNgMKpxmlQ3epBkMvz4TEBLoCEAM2Awq/naRDAagGQy/PhMQEvAIQAzYDCq8YpEMB'
	..'qAZDL8+ExCEBNSEHdW5pMDAzMgTAAhADNgMKtxWlQ1OrBkMvz4TECrgGTj8JUYo/AAAAPyEXcmJ4YXNzZXRpZDovLzMyNTUyNzUxMjIKqgbOPgxRCj/TzEw9BMUCEAM2AwqjmqRDnacGQy/PhMQExwIQAzYDCr8bpEMBqAZDL8+ExCEBMQTKAhADNgMKg9akQ52nBkMv'
	..'z4TEBMwCEAM2AwqbV6RDAagGQy/PhMQhATYhB3VuaTAwMzME0AIQAzYDCm8apUN5qQZDL8+ExApUcFg/yy6MPwAAAD8hF3JieGFzc2V0aWQ6Ly8zMjU1Mjc1MDQwCkdw2D7HLgw/08xMPQTVAhADNgMKN5mkQwGoBkMvz4TEBNcCEAM2AwonFKRDAagGQy/PhMQhATIE'
	..'2gIQAzYDCu8fpUN3qQZDL8+ExATcAhADNgMKG6mkQwGoBkMvz4TEBN4CEAM2AwoLJKRDAagGQy/PhMQhAjEzIQd1bmkwMDM2BOICEAM2Awq/FaVD5akGQy/PhMQKE0ZbP7ebjD8AAAA/IRdyYnhhc3NldGlkOi8vMzI1NTI3NDc1MgoYRts+t5sMP9PMTD0hAjEyBOgC'
	..'EAM2AwqnGqVD5akGQy/PhMQhAjExBOsCEAM2AwojFKVDnacGQy/PhMQE7QIQAzYDCt+YpEOdpwZDL8+ExATvAhADNgMK+xmkQwGoBkMvz4TEIQE0BPICEAM2AwqfGqVDU6sGQy/PhMQE9AIQAzYDCuebpEMBqAZDL8+ExAT2AhADNgMK1xakQwGoBkMvz4TEIQE3BPkC'
	..'EAM2AwqLFaVDeakGQy/PhMQE+wIQAzYDCu+XpEOdpwZDL8+ExAT9AhADNgMKCxmkQwGoBkMvz4TEIQIxMAQBAxADNgMG/8wyCgsZpUOdpwZDL8+ExAQDAxADNgMKI5qkQwGoBkMvz4TEBAUDEAM2AwoTFaRDAagGQy/PhMQEBwMQAxEDChCbZkIlhexCmZqLxAowM7FC'
	..'j8L1PSlcj0IECgMQAxEDCgAAAACuR5FAAAAAACEPUHJveGltaXR5UHJvbXB0IQpPYmplY3RUZXh0IT1Hb2xkM25GMXIzJ3MgRG9vcnMgRW5naW5lLgoKSW50ZXJhY3Qgd2l0aCBtZSB0byBwbGF5ICJkb29ycyIuIRNSZXF1aXJlc0xpbmVPZlNpZ2h0Cj/1v0O8CZVC'
	..'H80SxAoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACgKKZkK6LA5DJ3WHxAqufmdCO1n1Qo4Uh8QKuhuGQvBe9UKWgYnECq5+Z0I8WfVC6xOQxApht9VDCNWkQTaAhsQKAwWuQ4kW9UKmvYvECtNgkEMsLwBDZL+MxAr9/38/AAAAAAAAAAAK//9/PwAAAAAAAAAACgW2'
	..'n0MdKflC9bmOxAoAAIC/AAAAAC69u7MKAACAvy69uzPtrQkoCi69uzMAAIA/Lr27MwoAAIA/AAAAAC69O7QK9b+KQ5xsAENvtozECkrsY0P4Z/lC2hqRxAriiWRD1m/5QtAzjMQK0qJkQ2Bk+UKjAY7ECgAAgL8AAAAALr27MwriemRDbWr5Qv1lisQKd5OkQ34/A0Ne'
	..'z3zECgAAgL8AAAAAAAAAAAoAAIC/Lr27s+2tCSgKLr27swAAgD8uvbuzCgAAgD8AAAAALr27swrHi6RDPZ4DQ4s2h8QKx4ukQz2eA0OLtoTECseLpEM9ngNDizaCxArHi6RDPZ4DQxZtf8QKx4ukQz2eA0MWbXrECseLpEM9ngNDFm11xAo7laRD9yAGQy/PhMQKAACA'
	..'Py69OzPtrQmnCi69O7MAAIA/Lr07swoAAIA/Lr27M1ocjicKP5WkQwEhBkMvz4TECgAAAAAAAIA/le/JmnUBAQAAAAEAAgADAAEAAQABAAIABAABAAIAAQACAAUAAQADAAEAAgAGAAEABAACAAcACAACAAkACgAFAAoABwAIAAsADAANAA4ADwAQABEAEgATABQAFQAW'
	..'ABcAGAAZABoAGwAOABwABgAFAB0AHgAfAAwAIAAhACIAHgAjAB4AJAAHAAQAJQAmACcAHgAXACgAGQApACoACAAIACUAJgAnAB4AGQArACwALQAuACYALwAwADEAJgAyADMACgAFAAwABwA0AAsADAANAA4ADwA1ABEANgA3ADgAEwA5ABUAOgAXADsAGQA8ABsADgA9'
	..'AB4APgAKAAAACgAFAAgACwAMAA0ADgAPAD8AEQBAABMAQQAXAEIAGQBDABsADgAKAAUACAALAAwADQAOAA8APwARAEQAEwBBABcARQAZAEYAGwAOAAoABQAIAAsADAANAA4ADwA/ABEARwATAEEAFwBIABkASQAbAA4ACgAFAAkABwBKAAsADAANAA4ADwA/ABEASwAT'
	..'AEEAFwBMABkATQAbAA4ATgAPAAEATwBQAD4ABAAAAFEAAwAAAAEAAwACAAcAUgACAFMAAQATAAIABwBUAAIAVQAKABQABgALAAwADQAOABEAVgAXAFcAGQBYABsADgAKABQABgALAAwADQAOABEAWQAXAFoAGQBbABsADgAKABQABgALAAwADQAOABEAXAAXAF0AGQBb'
	..'ABsADgAKABQABgALAAwADQAOABEAXgAXAF8AGQBgABsADgAKABQACwAHAGEACwAMAA0ADgAPAD8AEQBiADcAOAATAEEAFwBjABkAZAAbAA4APQAeAGUAGQADAAcAZgARAGcAFwBoAGUAGQADAAcAaQARAGoAFwBrAAEAEwACAAcAbAACAG0ACgAcAAYACwAMAA0ADgAR'
	..'AG4AFwBvABkAcAAbAA4ACgAcAAkACwAMAA0ADgAPAHEAEQByABMAcwAVABYAFwB0ABkAdQAbAA4ACgAcAAkACwAMAA0ADgAPAHEAEQB2ABMAcwAVABYAFwB3ABkAeAAbAA4ACgAcAAkACwAMAA0ADgAPAHEAEQB5ABMAcwAVABYAFwB6ABkAeAAbAA4ACgAcAAkACwAM'
	..'AA0ADgAPAHEAEQB7ABMAcwAVABYAFwB8ABkAeAAbAA4ACgAcAAYACwAMAA0ADgARAH0AFwB+ABkAfwAbAA4ACgAcAAYACwAMAA0ADgARAIAAFwCBABkAfwAbAA4ACgAcAAYACwAMAA0ADgARAIIAFwCDABkAhAAbAA4ACgAcAAsABwBhAAsADAANAA4ADwA/ABEAhQA3'
	..'ADgAEwBBABcAhgAZAGQAGwAOAD0AHgBlACUAAwAHAGYAEQCHABcAiABlACUAAwAHAGkAEQCJABcAigAKABwACQALAAwADQAOAA8AcQARAIsAEwBzABUAFgAXAIwAGQB4ABsADgAKABwACQALAAwADQAOAA8AcQARAI0AEwBzABUAFgAXAI4AGQB4ABsADgAKABwACQAL'
	..'AAwADQAOAA8AcQARAI8AEwBzABUAFgAXAJAAGQB4ABsADgAKABwACQALAAwADQAOAA8AcQARAJEAEwBzABUAFgAXAJIAGQB4ABsADgAKABwACQALAAwADQAOAA8AcQARAJMAEwBzABUAFgAXAJQAGQB4ABsADgAKABwABgALAAwADQAOABEAlQAXAJYAGQCXABsADgAK'
	..'ABwACQALAAwADQAOAA8AcQARAJgAEwBzABUAFgAXAJkAGQB4ABsADgAKABwACQALAAwADQAOAA8AcQARAJoAEwBzABUAFgAXAJsAGQB4ABsADgABABMAAgAHAJwAAgCdAAoAMAALAAsADAANAA4ADwCeABEAnwATAKAAFQChAKIAowAXAKQApQCmABkApwAbAA4ACgAw'
	..'AAgACwAMAA0ADgARAKgAogCjABcAqQClAKYAGQCqABsADgAKADAACAALAAwADQAOABEAqwCiAKMAFwCsAKUApgAZAKoAGwAOAAoAMAAIAAsADAANAA4AEQCtAKIAowAXAK4ApQCmABkArwAbAA4ACgAwAAgACwAMAA0ADgARALAAogCjABcAsQClAKYAGQCnABsADgAK'
	..'ADAACAALAAwADQAOABEAsgCiAKMAFwCzAKUApgAZALQAGwAOAAoAMAAIAAsADAANAA4AEQC1AKIAowAXALYApQCmABkAtAAbAA4ACgAwAAgACwAMAA0ADgARALcAogCjABcAuAClAKYAGQC5ABsADgAKADAACAALAAwADQAOABEAugCiAKMAFwC7AKUApgAZALQAGwAO'
	..'AAoAMAAIAAsADAANAA4AEQC8AKIAowAXAL0ApQCmABkAuQAbAA4ACgAwAAgACwAMAA0ADgARAL4AogCjABcAvwClAKYAGQC0ABsADgAKADAADQAHAGEACwAMAA0ADgAPAD8AEQDAADcAOAATAEEAogCjABcAwQClAKYAGQBkABsADgA9AB4AZQA8AAQABwBmABEAwgCi'
	..'AMMAFwDEAGUAPAADAAcAxQARAMYAFwDHAAEAEwACAAcAyAACAMkACgA/AAgACwAMAA0ADgARAMoAogCjABcAywClAKYAGQBwABsADgAKAD8ACwALAAwADQAOAA8AcQARAMwAEwBzABUAFgCiAKMAFwDNAKUApgAZAHUAGwAOAAoAPwALAAsADAANAA4ADwBxABEAzgAT'
	..'AHMAFQAWAKIAowAXAM8ApQCmABkAeAAbAA4ACgA/AAsACwAMAA0ADgAPAHEAEQDQABMAcwAVABYAogCjABcA0QClAKYAGQB4ABsADgAKAD8ACwALAAwADQAOAA8AcQARANIAEwBzABUAFgCiAKMAFwDTAKUApgAZAHgAGwAOAAoAPwAIAAsADAANAA4AEQDUAKIAowAX'
	..'ANUApQCmABkAfwAbAA4ACgA/AAgACwAMAA0ADgARANYAogCjABcA1wClAKYAGQB/ABsADgAKAD8ACAALAAwADQAOABEA2ACiAKMAFwDZAKUApgAZAIQAGwAOAAoAPwANAAcAYQALAAwADQAOAA8APwARANoANwA4ABMAQQCiAKMAFwDbAKUApgAZAGQAGwAOAD0AHgBl'
	..'AEgAAwAHAGYAEQCHABcAiABlAEgAAwAHAGkAEQCJABcAigAKAD8ACwALAAwADQAOAA8AcQARANwAEwBzABUAFgCiAKMAFwDdAKUApgAZAHgAGwAOAAoAPwALAAsADAANAA4ADwBxABEA3gATAHMAFQAWAKIAowAXAN8ApQCmABkAeAAbAA4ACgA/AAsACwAMAA0ADgAP'
	..'AHEAEQDgABMAcwAVABYAogCjABcA4QClAKYAGQB4ABsADgAKAD8ACwALAAwADQAOAA8AcQARAOIAEwBzABUAFgCiAKMAFwDjAKUApgAZAHgAGwAOAAoAPwALAAsADAANAA4ADwBxABEA5AATAHMAFQAWAKIAowAXAOUApQCmABkAeAAbAA4ACgA/AAgACwAMAA0ADgAR'
	..'AOYAogCjABcA5wClAKYAGQCXABsADgAKAD8ACwALAAwADQAOAA8AcQARAOgAEwBzABUAFgCiAKMAFwDpAKUApgAZAHgAGwAOAAoAPwALAAsADAANAA4ADwBxABEA6gATAHMAFQAWAKIAowAXAOsApQCmABkAeAAbAA4AAQATAAIABwDsAAIA7QAKAFMACwALAAwADQAO'
	..'AA8AngARAO4AEwCgABUAoQCiAKMAFwDvAKUApgAZAPAAGwAOAAoAUwAIAAsADAANAA4AEQDxAKIAowAXAPIApQCmABkAqgAbAA4ACgBTAAgACwAMAA0ADgARAPMAogCjABcA9AClAKYAGQCqABsADgAKAFMACAALAAwADQAOABEA9QCiAKMAFwD2AKUApgAZAK8AGwAO'
	..'AAoAUwAIAAsADAANAA4AEQD3AKIAowAXAPgApQCmABkA+QAbAA4ACgBTAAgACwAMAA0ADgARAPoAogCjABcA+wClAKYAGQD8ABsADgAKAFMACAALAAwADQAOABEA/QCiAKMAFwD+AKUApgAZALQAGwAOAAoAUwAIAAsADAANAA4AEQD/AKIAowAXAAABpQCmABkAuQAb'
	..'AA4ACgBTAAgACwAMAA0ADgARAAEBogCjABcAAgGlAKYAGQADARsADgAKAFMACAALAAwADQAOABEABAGiAKMAFwAFAaUApgAZALkAGwAOAAoAUwAIAAsADAANAA4AEQAGAaIAowAXAAcBpQCmABkAtAAbAA4ACgBTAA0ABwBhAAsADAANAA4ADwA/ABEACAE3ADgAEwBB'
	..'AKIAowAXAAkBpQCmABkAZAAbAA4APQAeAGUAXwAEAAcAZgARAMIAogDDABcAxABlAF8AAwAHAMUAEQDGABcAxwABABMAAgAHAAoBAgALAQoAYgALAAsADAANAA4ADwCeABEADAETAKAAFQChAKIAowAXAA0BpQCmABkA8AAbAA4ACgBiAAgACwAMAA0ADgARAA4BogCj'
	..'ABcADwGlAKYAGQCqABsADgAKAGIACAALAAwADQAOABEAEAGiAKMAFwARAaUApgAZAKoAGwAOAAoAYgAIAAsADAANAA4AEQASAaIAowAXABMBpQCmABkArwAbAA4ACgBiAAgACwAMAA0ADgARABQBogCjABcAFQGlAKYAGQD5ABsADgAKAGIADQAHAGEACwAMAA0ADgAP'
	..'AD8AEQAWATcAOAATAEEAogCjABcAFwGlAKYAGQBkABsADgA9AB4AZQBoAAQABwBmABEAwgCiAMMAFwDEAGUAaAADAAcAxQARAMYAFwDHAAEAYgABAAIAGAEKAGsACAALAAwADQAOABEAGQGiAKMAFwAaAaUApgAZALQAGwAOAAoAawAIAAsADAANAA4AEQAbAaIAowAX'
	..'ABwBpQCmABkAAwEbAA4ACgBrAAgACwAMAA0ADgARAB0BogCjABcAHgGlAKYAGQC5ABsADgABAGIAAQACAB8BCgBvAAgACwAMAA0ADgARACABogCjABcAIQGlAKYAGQD8ABsADgAKAG8ACAALAAwADQAOABEAIgGiAKMAFwAjAaUApgAZALkAGwAOAAoAbwAIAAsADAAN'
	..'AA4AEQAkAaIAowAXACUBpQCmABkAtAAbAA4AAQATAAIABwAmAQIAJwEKAHMACAALAAwADQAOABEAKAGiAKMAFwApAaUAKgEZACsBGwAOAAoAcwALAAcAYQALAAwADQAOAA8APwARACwBNwA4ABMAQQAXAC0BGQBkABsADgA9AB4AZQB1AAMABwBmABEALgEXAC8BZQB1'
	..'AAMABwDFABEAMAEXADEBCgBzAAgACwAMAA0ADgARADIBogCjABcAMwGlACoBGQA0ARsADgAKAHMACAALAAwADQAOABEANQGiAKMAFwA2AaUAKgEZADcBGwAOAAoAcwAIAAsADAANAA4AEQA4AaIAowAXADkBpQAqARkAOgEbAA4ACgBzAAsACwAMAA0ADgAPAHEAEQA7'
	..'ARMAcwAVABYAogCjABcAPAGlAKYAGQA9ARsADgAKAHMACAALAAwADQAOABEAPgGiAKMAFwA/AaUAKgEZAEABGwAOAAoAcwAIAAsADAANAA4AEQBBAaIAowAXAEIBpQAqARkAQAEbAA4ACgBzAAsACwAMAA0ADgAPAHEAEQBDARMAcwAVABYAogCjABcARAGlACoBGQBF'
	..'ARsADgAKAHMACwALAAwADQAOAA8AcQARAEYBEwBzABUAFgCiAKMAFwBHAaUAKgEZAEgBGwAOAAoAcwAIAAsADAANAA4AEQBJAaIAowAXAEoBpQAqARkASwEbAA4ACgBzAAgACwAMAA0ADgARAEwBogCjABcATQGlACoBGQBLARsADgAKAHMACAALAAwADQAOABEATgGi'
	..'AKMAFwBPAaUAKgEZAFABGwAOAFEBQAIACgBYAVkBowAACgBaAVsBowBzAAoACwAMAA8AUgERAFMBEwBUARUAOgCiAKMAFwBVAaUAKgEZAFYBVwEMAFEBQAIACgBfAWABowAACgBhAWIBowBzAAoACwAMAA8AUgERAFwBEwBUARUAOgCiAKMAFwBdAaUAKgEZAF4BVwEM'
	..'AAoAcwALAAsADAANAA4ADwBxABEAYwETAHMAFQAWAKIAowAXAGQBpQAqARkAZQEbAA4ACgBzAAsACwAMAA0ADgAPAHEAEQBmARMAcwAVABYAogCjABcAZwGlACoBGQBoARsADgAKAHMACwALAAwADQAOAA8AcQARAGkBEwBzABUAFgCiAKMAFwBqAaUAKgEZAGsBGwAO'
	..'AAoAcwALAAsADAANAA4ADwBxABEAbAETAHMAFQAWAKIAowAXAG0BpQAqARkAbgEbAA4ACgBzAAgACwAMAA0ADgARAG8BogCjABcAcAGlACoBGQBxARsADgBRAUADAAoAdQF2AaMAAAoAdwF4AaMAAAoAeQF6AaMAcwAKAAsADAAPAJ4AEQByARMAoAAVAKEAogCjABcA'
	..'cwGlACoBGQB0AVcBDAAKAHMACAALAAwADQAOABEAewGiAKMAFwB8AaUAKgEZAH0BGwAOAAoAcwAIAAsADAANAA4AEQB+AaIAowAXAH8BpQAqARkAgAEbAA4ACgBzAAgACwAMAA0ADgARAIEBogCjABcAggGlACoBGQCDARsADgAKAHMACAALAAwADQAOABEAhAGiAKMA'
	..'FwCFAaUAKgEZAIABGwAOAAEAcwABAAIAhgEBAI8AAQACAIcBCgCQAAwACwAMAA0ADgAPAIgBEQCJARMAigEVAIsBogCjABcAjAGlAKYAGQCNARsADgCOASEACgCQAAsACwAMAA0ADgAPAIgBEQCPARMAigEVAIsBogCQARcAkQGlAJIBGQCTARsADgAKAJAADAALAAwA'
	..'DQAOAA8AiAERAJQBEwCKARUAiwGiAKMAFwCVAaUApgAZAI0BGwAOAI4BIQAKAJAADAALAAwADQAOAA8AlgERAJcBEwCYARUAmQGiAKMAFwCaAaUApgAZAJsBGwAOAI4BIQCcAZQAAgATAJgBIAAOAAoAkAALAAsADAANAA4ADwCWAREAnQETAJgBFQCZAaIAkAEXAJ4B'
	..'pQCSARkAnwEbAA4AnAGWAAIAEwCYASAADgAKAJAADAALAAwADQAOAA8AlgERAIkBEwCYARUAmQGiAKMAFwCMAaUApgAZAJsBGwAOAI4BIQCcAZgAAgATAJgBIAAOAAoAjwAGAAsADAANAA4AEQCgARcAoQEZAKIBGwAOAAoAjwAGAAsADAANAA4AEQCjARcApAEZAKUB'
	..'GwAOAAoAjwAGAAsADAANAA4AEQCmARcApwEZAKIBGwAOAAEAjwABAAIAqAEKAJ0ACgALAAwADQAOAA8AiAERAKkBEwCKARUAiwEXAKoBGQCNARsADgCOASEACgCdAAsACwAMAA0ADgAPAIgBEQCrARMAigEVAIsBogCsARcArQGlAKwBGQCTARsADgAKAJ0ACgALAAwA'
	..'DQAOAA8AiAERAK4BEwCKARUAiwEXAK8BGQCNARsADgCOASEACgCdAAoACwAMAA0ADgAPAJYBEQCwARMAmAEVAJkBFwCxARkAmwEbAA4AjgEhAJwBoQACABMAmAEgAA4ACgCdAAsACwAMAA0ADgAPAJYBEQCyARMAmAEVAJkBogCsARcAswGlAKwBGQCfARsADgCcAaMA'
	..'AgATAJgBIAAOAAoAnQAKAAsADAANAA4ADwCWAREAqQETAJgBFQCZARcAqgEZAJsBGwAOAI4BIQCcAaUAAgATAJgBIAAOAAEAcwABAAIAtAEBAKcAAQACALUBCgCoAAwACwAMAA0ADgAPAIgBEQC2ARMAigEVAIsBogCjABcAtwGlAKYAGQCNARsADgCOASEACgCoAAsA'
	..'CwAMAA0ADgAPAIgBEQC4ARMAigEVAIsBogCQARcAuQGlAJIBGQCTARsADgAKAKgADAALAAwADQAOAA8AiAERALoBEwCKARUAiwGiAKMAFwC7AaUApgAZAI0BGwAOAI4BIQAKAKgADAALAAwADQAOAA8AlgERALwBEwCYARUAmQGiAKMAFwC9AaUApgAZAJsBGwAOAI4B'
	..'IQCcAawAAgATAJgBIAAOAAoAqAALAAsADAANAA4ADwCWAREAvgETAJgBFQCZAaIAkAEXAL8BpQCSARkAnwEbAA4AnAGuAAIAEwCYASAADgAKAKgADAALAAwADQAOAA8AlgERALYBEwCYARUAmQGiAKMAFwC3AaUApgAZAJsBGwAOAI4BIQCcAbAAAgATAJgBIAAOAAoA'
	..'pwAGAAsADAANAA4AEQDAARcAwQEZAKIBGwAOAAoApwAGAAsADAANAA4AEQDCARcAwwEZAKUBGwAOAAoApwAGAAsADAANAA4AEQDEARcAxQEZAKIBGwAOAAEApwABAAIAxgEKALUACgALAAwADQAOAA8AiAERAMcBEwCKARUAiwEXAMgBGQCNARsADgCOASEACgC1AAsA'
	..'CwAMAA0ADgAPAIgBEQDJARMAigEVAIsBogCsARcAygGlAKwBGQCTARsADgAKALUACgALAAwADQAOAA8AiAERAMsBEwCKARUAiwEXAMwBGQCNARsADgCOASEACgC1AAoACwAMAA0ADgAPAJYBEQDNARMAmAEVAJkBFwDOARkAmwEbAA4AjgEhAJwBuQACABMAmAEgAA4A'
	..'CgC1AAsACwAMAA0ADgAPAJYBEQDPARMAmAEVAJkBogCsARcA0AGlAKwBGQCfARsADgCcAbsAAgATAJgBIAAOAAoAtQAKAAsADAANAA4ADwCWAREAxwETAJgBFQCZARcAyAEZAJsBGwAOAI4BIQCcAb0AAgATAJgBIAAOAAoApwAGAAsADAANAA4AEQDRARcA0gEZANMB'
	..'GwAOAAEAcwABAAIA1AEBAMAAAQACANUBCgDBAAwACwAMAA0ADgAPAIgBEQDWARMAigEVAIsBogCjABcA1wGlAKYAGQCNARsADgCOASEACgDBAAsACwAMAA0ADgAPAIgBEQDYARMAigEVAIsBogCQARcA2QGlAJIBGQCTARsADgAKAMEADAALAAwADQAOAA8AiAERANoB'
	..'EwCKARUAiwGiAKMAFwDbAaUApgAZAI0BGwAOAI4BIQAKAMEADAALAAwADQAOAA8AlgERANwBEwCYARUAmQGiAKMAFwDdAaUApgAZAJsBGwAOAI4BIQCcAcUAAgATAJgBIAAOAAoAwQALAAsADAANAA4ADwCWAREA3gETAJgBFQCZAaIAkAEXAN8BpQCSARkAnwEbAA4A'
	..'nAHHAAIAEwCYASAADgAKAMEADAALAAwADQAOAA8AlgERANYBEwCYARUAmQGiAKMAFwDXAaUApgAZAJsBGwAOAI4BIQCcAckAAgATAJgBIAAOAAoAwAAGAAsADAANAA4AEQDgARcA4QEZAKIBGwAOAAoAwAAGAAsADAANAA4AEQDiARcA4wEZAKUBGwAOAAoAwAAGAAsA'
	..'DAANAA4AEQDkARcA5QEZAKIBGwAOAAEAwAABAAIA5gEKAM4ACgALAAwADQAOAA8AiAERAOcBEwCKARUAiwEXAOgBGQCNARsADgCOASEACgDOAAsACwAMAA0ADgAPAIgBEQDpARMAigEVAIsBogCsARcA6gGlAKwBGQCTARsADgAKAM4ACgALAAwADQAOAA8AiAERAOsB'
	..'EwCKARUAiwEXAOwBGQCNARsADgCOASEACgDOAAoACwAMAA0ADgAPAJYBEQDtARMAmAEVAJkBFwDuARkAmwEbAA4AjgEhAJwB0gACABMAmAEgAA4ACgDOAAsACwAMAA0ADgAPAJYBEQDvARMAmAEVAJkBogCsARcA8AGlAKwBGQCfARsADgCcAdQAAgATAJgBIAAOAAoA'
	..'zgAKAAsADAANAA4ADwCWAREA5wETAJgBFQCZARcA6AEZAJsBGwAOAI4BIQCcAdYAAgATAJgBIAAOAAEAcwABAAIA8QEBANgAAQACAPIBCgDZAAwACwAMAA0ADgAPAIgBEQDzARMAigEVAIsBogCjABcA9AGlAKYAGQCNARsADgCOASEACgDZAAsACwAMAA0ADgAPAIgB'
	..'EQD1ARMAigEVAIsBogCQARcA9gGlAJIBGQCTARsADgAKANkADAALAAwADQAOAA8AiAERAPcBEwCKARUAiwGiAKMAFwD4AaUApgAZAI0BGwAOAI4BIQAKANkADAALAAwADQAOAA8AlgERAPkBEwCYARUAmQGiAKMAFwD6AaUApgAZAJsBGwAOAI4BIQCcAd0AAgATAJgB'
	..'IAAOAAoA2QALAAsADAANAA4ADwCWAREA+wETAJgBFQCZAaIAkAEXAPwBpQCSARkAnwEbAA4AnAHfAAIAEwCYASAADgAKANkADAALAAwADQAOAA8AlgERAPMBEwCYARUAmQGiAKMAFwD0AaUApgAZAJsBGwAOAI4BIQCcAeEAAgATAJgBIAAOAAoA2AAGAAsADAANAA4A'
	..'EQD9ARcA/gEZAKIBGwAOAAoA2AAGAAsADAANAA4AEQD/ARcAAAIZAKUBGwAOAAoA2AAGAAsADAANAA4AEQABAhcAAgIZAKIBGwAOAAEA2AABAAIAAwIKAOYACgALAAwADQAOAA8AiAERAAQCEwCKARUAiwEXAAUCGQCNARsADgCOASEACgDmAAsACwAMAA0ADgAPAIgB'
	..'EQAGAhMAigEVAIsBogCsARcABwKlAKwBGQCTARsADgAKAOYACgALAAwADQAOAA8AiAERAAgCEwCKARUAiwEXAAkCGQCNARsADgCOASEACgDmAAoACwAMAA0ADgAPAJYBEQAKAhMAmAEVAJkBFwALAhkAmwEbAA4AjgEhAJwB6gACABMAmAEgAA4ACgDmAAsACwAMAA0A'
	..'DgAPAJYBEQAMAhMAmAEVAJkBogCsARcADQKlAKwBGQCfARsADgCcAewAAgATAJgBIAAOAAoA5gAKAAsADAANAA4ADwCWAREABAITAJgBFQCZARcABQIZAJsBGwAOAI4BIQCcAe4AAgATAJgBIAAOAAEAcwABAAIADgIBAPAAAQACAA8CCgDxAAwACwAMAA0ADgAPAIgB'
	..'EQAQAhMAigEVAIsBogCjABcAEQKlAKYAGQCNARsADgCOASEACgDxAAsACwAMAA0ADgAPAIgBEQASAhMAigEVAIsBogCQARcAEwKlAJIBGQCTARsADgAKAPEADAALAAwADQAOAA8AiAERABQCEwCKARUAiwGiAKMAFwAVAqUApgAZAI0BGwAOAI4BIQAKAPEADAALAAwA'
	..'DQAOAA8AlgERABYCEwCYARUAmQGiAKMAFwAXAqUApgAZAJsBGwAOAI4BIQCcAfUAAgATAJgBIAAOAAoA8QALAAsADAANAA4ADwCWAREAGAITAJgBFQCZAaIAkAEXABkCpQCSARkAnwEbAA4AnAH3AAIAEwCYASAADgAKAPEADAALAAwADQAOAA8AlgERABACEwCYARUA'
	..'mQGiAKMAFwARAqUApgAZAJsBGwAOAI4BIQCcAfkAAgATAJgBIAAOAAoA8AAGAAsADAANAA4AEQAaAhcAGwIZAKIBGwAOAAoA8AAGAAsADAANAA4AEQAcAhcAHQIZAKUBGwAOAAoA8AAGAAsADAANAA4AEQAeAhcAHwIZAKIBGwAOAAEA8AABAAIAIAIKAP4ACgALAAwA'
	..'DQAOAA8AiAERACECEwCKARUAiwEXACICGQCNARsADgCOASEACgD+AAsACwAMAA0ADgAPAIgBEQAjAhMAigEVAIsBogCsARcAJAKlAKwBGQCTARsADgAKAP4ACgALAAwADQAOAA8AiAERACUCEwCKARUAiwEXACYCGQCNARsADgCOASEACgD+AAoACwAMAA0ADgAPAJYB'
	..'EQAnAhMAmAEVAJkBFwAoAhkAmwEbAA4AjgEhAJwBAgECABMAmAEgAA4ACgD+AAsACwAMAA0ADgAPAJYBEQApAhMAmAEVAJkBogCsARcAKgKlAKwBGQCfARsADgCcAQQBAgATAJgBIAAOAAoA/gAKAAsADAANAA4ADwCWAREAIQITAJgBFQCZARcAIgIZAJsBGwAOAI4B'
	..'IQCcAQYBAgATAJgBIAAOAAEAcwABAAIAKwIBAAgBAQACACwCCgAJAQwACwAMAA0ADgAPAIgBEQAtAhMAigEVAIsBogCjABcALgKlAKYAGQCNARsADgCOASEACgAJAQsACwAMAA0ADgAPAIgBEQAvAhMAigEVAIsBogCQARcAMAKlAJIBGQCTARsADgAKAAkBDAALAAwA'
	..'DQAOAA8AiAERADECEwCKARUAiwGiAKMAFwAyAqUApgAZAI0BGwAOAI4BIQAKAAkBDAALAAwADQAOAA8AlgERADMCEwCYARUAmQGiAKMAFwA0AqUApgAZAJsBGwAOAI4BIQCcAQ0BAgATAJgBIAAOAAoACQELAAsADAANAA4ADwCWAREANQITAJgBFQCZAaIAkAEXADYC'
	..'pQCSARkAnwEbAA4AnAEPAQIAEwCYASAADgAKAAkBDAALAAwADQAOAA8AlgERAC0CEwCYARUAmQGiAKMAFwAuAqUApgAZAJsBGwAOAI4BIQCcAREBAgATAJgBIAAOAAoACAEGAAsADAANAA4AEQA3AhcAOAIZAKIBGwAOAAoACAEGAAsADAANAA4AEQA5AhcAOgIZAKUB'
	..'GwAOAAoACAEGAAsADAANAA4AEQA7AhcAPAIZAKIBGwAOAAEACAEBAAIAPQIKABYBCgALAAwADQAOAA8AiAERAD4CEwCKARUAiwEXAD8CGQCNARsADgCOASEACgAWAQsACwAMAA0ADgAPAIgBEQBAAhMAigEVAIsBogCsARcAQQKlAKwBGQCTARsADgAKABYBCgALAAwA'
	..'DQAOAA8AiAERAEICEwCKARUAiwEXAEMCGQCNARsADgCOASEACgAWAQoACwAMAA0ADgAPAJYBEQBEAhMAmAEVAJkBFwBFAhkAmwEbAA4AjgEhAJwBGgECABMAmAEgAA4ACgAWAQsACwAMAA0ADgAPAJYBEQBGAhMAmAEVAJkBogCsARcARwKlAKwBGQCfARsADgCcARwB'
	..'AgATAJgBIAAOAAoAFgEKAAsADAANAA4ADwCWAREAPgITAJgBFQCZARcAPwIZAJsBGwAOAI4BIQCcAR4BAgATAJgBIAAOAAEAcwACAAcASAICAEkCSgIgAQsABwBLAgsADAAPAEwCEQBNAjcAOAATAE4CFQBPAhcAUAIZAFECUgJTAlQCVQJKAiABCwAHAFYCCwAMAA8A'
	..'TAIRAFcCNwA4ABMATgIVAE8CFwBYAhkAWQJSAloCVAJbAkoCIAELAAcAVgILAAwADwBMAhEAXAI3ADgAEwBOAhUATwIXAF0CGQBZAlICWgJUAlsCSgIgAQsABwBWAgsADAAPAEwCEQBeAjcAOAATAE4CFQBPAhcAXwIZAFkCUgJaAlQCWwIKACABCgAHAGACCwAMAA0A'
	..'DgAPAJYBEQBhAhMAmAEVADoAFwBiAhkAYwIbAA4AAQBzAAIABwBkAgIAZQJKAiYBCwAHAGYCCwAMAA8AZwIRAGgCNwA4ABMAaQIVAGoCFwBrAhkAbAJSAm0CVAJuAkoCJgELAAcAbwILAAwADwBnAhEAcAI3ADgAEwBpAhUAagIXAHECGQByAlICcwJUAnQCSgImAQsA'
	..'BwBWAgsADAAPAGcCEQB1AjcAOAATAGkCFQBqAhcAdgIZAFkCUgJaAlQCWwIBAHMAAgAHAHcCAgBlAkoCKgELAAcAeAILAAwADwBnAhEAeQI3ADgAEwBpAhUAagIXAHoCGQB7AlICfAJUAn0CSgIqAQsABwBvAgsADAAPAGcCEQB+AjcAOAATAGkCFQBqAhcAfwIZAHIC'
	..'UgJzAlQCdAJKAioBCwAHAFYCCwAMAA8AZwIRAIACNwA4ABMAaQIVAGoCFwCBAhkAWQJSAloCVAJbAgEAcwACAAcAggICAGUCSgIuAQsABwCDAgsADAAPAGcCEQCEAjcAOAATAGkCFQBqAhcAhQIZAIYCUgKHAlQCiAJKAi4BCwAHAFYCCwAMAA8AZwIRAIkCNwA4ABMA'
	..'aQIVAGoCFwCKAhkAWQJSAloCVAJbAkoCLgELAAcAVgILAAwADwBnAhEAiwI3ADgAEwBpAhUAagIXAIwCGQBZAlICWgJUAlsCAQBzAAIABwCNAgIAZQJKAjIBCwAHAGYCCwAMAA8AZwIRAI4CNwA4ABMAaQIVAGoCFwCPAhkAbAJSAm0CVAJuAkoCMgELAAcAVgILAAwA'
	..'DwBnAhEAkAI3ADgAEwBpAhUAagIXAJECGQBZAlICWgJUAlsCSgIyAQsABwBWAgsADAAPAGcCEQCSAjcAOAATAGkCFQBqAhcAkwIZAFkCUgJaAlQCWwIBAHMAAgAHAJQCAgBlAkoCNgELAAcAlQILAAwADwCWAhEAlwI3ADgAEwCYAhUATwIXAJkCGQCaAlICmwJUApwC'
	..'SgI2AQsABwBvAgsADAAPAJYCEQCdAjcAOAATAJgCFQBPAhcAngIZAHICUgJzAlQCdAJKAjYBCwAHAFYCCwAMAA8AlgIRAJ8CNwA4ABMAmAIVAE8CFwCgAhkAWQJSAloCVAJbAgEAcwACAAcAoQICAGUCSgI6AQsABwB4AgsADAAPAGcCEQCiAjcAOAATAGkCFQBqAhcA'
	..'owIZAHsCUgJ8AlQCfQJKAjoBCwAHAFYCCwAMAA8AZwIRAKQCNwA4ABMAaQIVAGoCFwClAhkAWQJSAloCVAJbAkoCOgELAAcAVgILAAwADwBnAhEApgI3ADgAEwBpAhUAagIXAKcCGQBZAlICWgJUAlsCAQBzAAIABwCoAgIAZQJKAj4BCwAHAIMCCwAMAA8AZwIRAKkC'
	..'NwA4ABMAaQIVAGoCFwCqAhkAhgJSAocCVAKIAkoCPgELAAcAbwILAAwADwBnAhEAqwI3ADgAEwBpAhUAagIXAKwCGQByAlICcwJUAnQCSgI+AQsABwBWAgsADAAPAGcCEQCtAjcAOAATAGkCFQBqAhcArgIZAFkCUgJaAlQCWwIBAHMAAgAHAK8CAgBlAkoCQgELAAcA'
	..'SwILAAwADwBnAhEAsAI3ADgAEwBpAhUAagIXALECGQBRAlICUwJUAlUCSgJCAQsABwBvAgsADAAPAGcCEQCyAjcAOAATAGkCFQBqAhcAswIZAHICUgJzAlQCdAJKAkIBCwAHAFYCCwAMAA8AZwIRALQCNwA4ABMAaQIVAGoCFwC1AhkAWQJSAloCVAJbAgEAcwACAAcA'
	..'tgICAGUCSgJGAQsABwCVAgsADAAPAGcCEQC3AjcAOAATAGkCFQBqAhcAuAIZAJoCUgKbAlQCnAJKAkYBCwAHAFYCCwAMAA8AZwIRALkCNwA4ABMAaQIVAGoCFwC6AhkAWQJSAloCVAJbAkoCRgELAAcAVgILAAwADwBnAhEAuwI3ADgAEwBpAhUAagIXALwCGQBZAlIC'
	..'WgJUAlsCAQBzAAIABwC9AgIAZQJKAkoBCwAHAL4CCwAMAA8AlgIRAL8CNwA4ABMAmAIVAE8CFwDAAhkAwQJSAsICVALDAkoCSgELAAcAbwILAAwADwCWAhEAxAI3ADgAEwCYAhUATwIXAMUCGQByAlICcwJUAnQCSgJKAQsABwBWAgsADAAPAJYCEQDGAjcAOAATAJgC'
	..'FQBPAhcAxwIZAFkCUgJaAlQCWwIBAHMAAgAHAMgCAgBlAkoCTgELAAcAbwILAAwADwBnAhEAyQI3ADgAEwBpAhUAagIXAMoCGQByAlICcwJUAnQCSgJOAQsABwBWAgsADAAPAGcCEQDLAjcAOAATAGkCFQBqAhcAzAIZAFkCUgJaAlQCWwIBAHMAAgAHAM0CAgBlAkoC'
	..'UQELAAcAzgILAAwADwBnAhEAzwI3ADgAEwBpAhUAagIXANACGQDRAlIC0gJUAtMCSgJRAQsABwBWAgsADAAPAGcCEQDUAjcAOAATAGkCFQBqAhcA1QIZAFkCUgJaAlQCWwJKAlEBCwAHAFYCCwAMAA8AZwIRANYCNwA4ABMAaQIVAGoCFwDXAhkAWQJSAloCVAJbAgEA'
	..'cwACAAcA2AICAGUCSgJVAQsABwBLAgsADAAPAGcCEQDZAjcAOAATAGkCFQBqAhcA2gIZAFECUgJTAlQCVQJKAlUBCwAHAFYCCwAMAA8AZwIRANsCNwA4ABMAaQIVAGoCFwDcAhkAWQJSAloCVAJbAkoCVQELAAcAVgILAAwADwBnAhEA3QI3ADgAEwBpAhUAagIXAN4C'
	..'GQBZAlICWgJUAlsCAQBzAAIABwDfAgIAZQJKAlkBCwAHAOACCwAMAA8AZwIRAOECNwA4ABMAaQIVAGoCFwDiAhkA4wJSAuQCVALlAkoCWQELAAcAbwILAAwADwBnAhEAcAI3ADgAEwBpAhUAagIXAHECGQByAlICcwJUAnQCSgJZAQsABwBWAgsADAAPAGcCEQB1AjcA'
	..'OAATAGkCFQBqAhcAdgIZAFkCUgJaAlQCWwIBAHMAAgAHAOYCAgBlAkoCXQELAAcA4AILAAwADwBnAhEA5wI3ADgAEwBpAhUAagIXAOgCGQDjAlIC5AJUAuUCSgJdAQsABwBWAgsADAAPAGcCEQCQAjcAOAATAGkCFQBqAhcAkQIZAFkCUgJaAlQCWwJKAl0BCwAHAFYC'
	..'CwAMAA8AZwIRAJICNwA4ABMAaQIVAGoCFwCTAhkAWQJSAloCVAJbAgEAcwACAAcA6QICAGUCSgJhAQsABwBvAgsADAAPAGcCEQDqAjcAOAATAGkCFQBqAhcA6wIZAHICUgJzAlQCdAJKAmEBCwAHAG8CCwAMAA8AZwIRAOwCNwA4ABMAaQIVAGoCFwDtAhkAcgJSAnMC'
	..'VAJ0AkoCYQELAAcAVgILAAwADwBnAhEA7gI3ADgAEwBpAhUAagIXAO8CGQBZAlICWgJUAlsCAQBzAAIABwDwAgIAZQJKAmUBCwAHAL4CCwAMAA8AZwIRAPECNwA4ABMAaQIVAGoCFwDyAhkAwQJSAsICVALDAkoCZQELAAcAVgILAAwADwBnAhEA8wI3ADgAEwBpAhUA'
	..'agIXAPQCGQBZAlICWgJUAlsCSgJlAQsABwBWAgsADAAPAGcCEQD1AjcAOAATAGkCFQBqAhcA9gIZAFkCUgJaAlQCWwIBAHMAAgAHAPcCAgBlAkoCaQELAAcAzgILAAwADwBnAhEA+AI3ADgAEwBpAhUAagIXAPkCGQDRAlIC0gJUAtMCSgJpAQsABwBvAgsADAAPAGcC'
	..'EQD6AjcAOAATAGkCFQBqAhcA+wIZAHICUgJzAlQCdAJKAmkBCwAHAFYCCwAMAA8AZwIRAPwCNwA4ABMAaQIVAGoCFwD9AhkAWQJSAloCVAJbAgEAcwACAAcA/gICAGUCSgJtAQsABwBvAgsADAAPAEwCEQD/AjcAOAATAAADFQBPAhcAAQMZAHICUgJzAlQCdAJKAm0B'
	..'CwAHAFYCCwAMAA8ATAIRAAIDNwA4ABMAAAMVAE8CFwADAxkAWQJSAloCVAJbAkoCbQELAAcAVgILAAwADwBMAhEABAM3ADgAEwAAAxUATwIXAAUDGQBZAlICWgJUAlsCPgATAAAACgABAAkACwAMAA0ADgAPAJ4AEQAGAxMAoAAVADoAFwAHAxkACAMbAA4ACgABAAoA'
	..'CwAMAA0ADgAPAJ4AEQAJAzcAOAATAKAAFwAKAxkAZAAbAA4APQAeAAsDcwECAAwDDQMOAzgAPgBzAQAAAA==')
for _,obj in pairs(Objects) do
	obj.Parent = script or workspace
end

RunScripts()
