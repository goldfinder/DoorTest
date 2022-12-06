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

script.Parent.Parent.Events.LoadNextRoom.Event:Connect(function(doorid)
	print("Event Called")
	if doorid ~= door then print "Unable to use doorID" return end
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
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets")["Door"]:Clone()
		currdoor.DID.Value=door+1
		local cinst = game.ReplicatedStorage:FindFirstChild("Assets")[corr.Instance]
		cinst = cinst:Clone()
		if cinst.Name=="LIB" then
			cinst.Arch.Textbox.SurfaceGui.Frame.TextBox.Text=door
			if door~=1000 then
				cinst["20"]:Destroy()
			end
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
		currdoor.DoorHitDetection.ClickDetector.Clicked:Connect(function()
			script.Parent.Parent.Events.LoadNextRoom:Fire(currdoor.DID.Value)
		end)
		wait(.06)
		debounce=false
	elseif door ~= "No more doors :(" then
		lastdoor = currdoor
		currdoor = game.ReplicatedStorage:FindFirstChild("Assets")["Door"]:Clone()
		currdoor.DID.Value=door+1
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
	end
end)
