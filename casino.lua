getgenv().settin = {
    ['WebHook'] = {
        ['Webhook'] = "https://discord.com/api/webhooks/1020051419967000647/kmR4dFiG7My7RekiRXj0AHZZPoOAD-yBcQr8pM3TixHlJsAtBo9vDZn-4r5nWPYrVuKH",
    },
    ['ServerHopDelay'] = 15, -- minutes, resets every donation
    ['MinimumWithdrawAmount'] = 1000, -- fake withdraw amount
    ['Beg'] = {
        ['Delay'] = 120,
        ['Messages'] = {
           '💝 No Donations? Win a Donation on my slot machine! 💎',
            '💎 Valentine Day Special | Double if you win! 💝',
       
          
        }
    }
}


--[[
	This property is protected.
	You are not allowed to claim this as your own.
	Removal of initial credits to the authors is prohibited.
]]

repeat
	task.wait()
until game:IsLoaded()

if game.PlaceId ~= 8737602449 and game.PlaceId ~= 8943844393 then
	return
end

if getgenv().loadedx then return end
getgenv().loadedx = true

local x_scam = 0

if isfile and writefile and typeof(isfile) == 'function' and typeof(writefile) == 'function' then
	if not isfile('PromptedDiscordCFCommunityRRRRR.txt') then
		writefile('PromptedDiscordCFCommunityRRRRR.txt', game:GetService('HttpService'):JSONEncode('hi'))
		local Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()
		Module.Prompt({
			invite = "https://discord.gg/qRj5MWHgyD",
			name = "WiiHub",
		})
	end
end

local Players = game:GetService('Players')
local debounceThing = Instance.new('Folder', game:GetService('CorePackages'))
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
local unclaimed = {}
local errCount = -1

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/CF-Trail/tzechco-PlsDonateAutofarmBackup/main/casino.lua'))()")

if not getgenv().settin then
	getgenv().settin = {
		['WebHook'] = {
			['Webhook'] = "",
		},
		['ServerHopDelay'] = 15, -- minutes, resets every donation
		['MinimumWithdrawAmount'] = 1000, -- fake withdraw amount
		['Beg'] = {
			['Delay'] = 120,
			['Messages'] = {
				'💸 WIN BOBUX HERE 💸',
				'💸 EARN BY PLAYING 💸',
				'💸 TIRED OF NO DONATIONS? PLAY OUR GAME 💸'
			}
		}
	}
end

local text = [[
      💸 WIN BOBUX 💸
    💸 Z'S CARNIVAL 💸
💸 type ".help" to get started 💸
]]

local plrs = {}

for i, v in next, Players:GetPlayers() do
	v:SetAttribute('Donated', 0)
end

Players.PlayerAdded:Connect(function(player)
	player:SetAttribute('Donated', 0)
end)

function serverHop()
	--local isVip = game:GetService('RobloxReplicatedStorage').GetServerType:InvokeServer()
	--if isVip == "VIPServer" then return end
	local gameId
	gameId = "8737602449"
	local servers = {}
	local req = httprequest({
		Url = "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Desc&limit=100"
	})
	local body = httpservice:JSONDecode(req.Body)
	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.playing) > 19 then
				table.insert(servers, 1, v.id)
			end
		end
	end
	if #servers > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end
	game:GetService("TeleportService").TeleportInitFailed:Connect(function()
		task.wait(0.5)
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end)
end

function webhook(...)
	local args = {
		...
	}
	local a = os.time()
	local a = os.date("!*t", a)
	plr = Players.LocalPlayer
	local c = game:GetService("MarketplaceService")
	local c = c:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
	local a = {
		["title"] = "> Z's Casino™ | **" .. Players.LocalPlayer.Name .. " got donated! :D**",
		["description"] = "money",
		["type"] = "rich",
		["color"] = tonumber(getgenv().embedcolor),
		["thumbnail"] = {
			["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId=" ..
                plr.UserId .. "&width=420&height=420&format=png"
		},
		["image"] = {
			["url"] = "http://www.roblox.com/Thumbs/Asset.ashx?Width=768&Height=432&AssetID=" .. game.PlaceId
		},
		["fields"] = {
			{
				["name"] = "Raised",
				["value"] = "```Amount ▶ " .. tostring(args[1]) .. " (After tax: " .. tostring(args[1] * 0.6) .. ")```",
				["inline"] = true
			},
			{
				["name"] = "Total",
				["value"] = tostring(Players.LocalPlayer.leaderstats.Raised.Value),
				["inline"] = false
			}
		},
		["footer"] = {
			["text"] = "Donated by " .. Players.LocalPlayer.Name,
		},
		["timestamp"] = string.format("%d-%d-%dT%02d:%02d:%02dZ", a.year, a.month, a.day, a.hour, a.min, a.sec)
	}
	httprequest{
		Url = settin.WebHook.Webhook,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"
		},
		Body = game:GetService "HttpService":JSONEncode({
			content = Content,
			embeds = {
				a
			}
		})
	}    
end

function getRemote(name)
	return require(game:GetService("ReplicatedStorage").Remotes).Event(name)
end

getRemote('SetDonatedVisibility'):FireServer(false)

function chat(text)
	game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, 'All')
end

function findUnclaimed()
	for i, v in pairs(Players.LocalPlayer.PlayerGui:WaitForChild'MapUIContainer':WaitForChild'MapUI'.BoothUI:GetChildren()) do
		if (v.Details.Owner.Text == "unclaimed") then
			table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
		end
	end
end

if not pcall(findUnclaimed) then
	serverHop()
end

local function waitServerHop()
	task.wait(settin.ServerHopDelay * 60)
	serverHop()
end
local function hopSet()
	if hopTimer then
		task.cancel(hopTimer)
	end
	hopTimer = task.spawn(waitServerHop)
end

local claimCount = #unclaimed
local function boothclaim()
	require(game:GetService('ReplicatedStorage').Remotes).Event("ClaimBooth"):InvokeServer(unclaimed[1])
	if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
		task.wait(1)
		if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
			error()
		end
	end
end
  --Checks if booth claim fails
while not pcall(boothclaim) do
	if errCount >= claimCount then
		serverHop()
	end
	table.remove(unclaimed, 1)
	errCount = errCount + 1
end
hopSet()
local function walkToBooth()
	theCframe = CFrame.new(0, 0, 3)
	local boothPos, mainPosX
	for i, v in ipairs(game:GetService("Workspace").BoothInteractions:GetChildren()) do
		if v:GetAttribute("BoothSlot") == unclaimed[1] then
			mainPosX = v.CFrame
			boothPos = v.CFrame * theCframe
			break
		end
	end
	game:GetService('VirtualInputManager'):SendKeyEvent(true, "LeftControl", false, game)
	local Controls = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	Controls:Disable()
	local atBooth = false
	pcall(function()
	   game:GetService("Workspace").Map.Main.Bench:Destroy()
	end)
	Players.LocalPlayer.Character.Humanoid:MoveTo(boothPos.Position)
	Players.LocalPlayer.Character.Humanoid.MoveToFinished:Connect(function(reached)
		atBooth = true
	end)
	repeat
		task.wait()
	until atBooth
	Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = CFrame.new(boothPos.Position)
	Controls:Enable()
	game:GetService('VirtualInputManager'):SendKeyEvent(false, "LeftControl", false, game)
	Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Players.LocalPlayer.Character.Humanoid.RootPart.Position, Vector3.new(40, 14, 101)))
end

walkToBooth()

getRemote('SetBoothText'):FireServer(text, 'booth')

local raised = Players.LocalPlayer.leaderstats.Raised
local oldVal = raised.Value
raised:GetPropertyChangedSignal('Value'):Connect(function()
	local newVal = raised.Value
	local raisedN = newVal - oldVal
	if settin.WebHook.Webhook:gsub(' ', '') ~= '' then
		webhook(raisedN)
	end
	task.wait(0.5)
	local LogService = Game:GetService("LogService")
	local logs = LogService:GetLogHistory()
	if string.find(logs[#logs].message, Players.LocalPlayer.DisplayName) then
		local msg = string.gsub(logs[#logs].message, ' tipped ', ''):gsub('', ''):gsub('💸', ''):gsub(' to ', ''):gsub(Players.LocalPlayer.DisplayName, ''):gsub(tostring(RaisedN), ''):gsub('',''):gsub("💰",''):gsub(' ', '')
		for i, v in next, Players:GetPlayers() do
			if v.DisplayName == msg then
				playerWhoDonated = v
				chat(' ' .. raisedN .. ' has been added to your balance! You can now use .play (money)!')
				playerWhoDonated:SetAttribute('Donated', playerWhoDonated:GetAttribute('Donated') + raisedN)
			end
		end
		if not playerWhoDonated then
		   chat('make sure to stay near my booth!')
		   task.wait(6)
		   local players = Players:GetPlayers()
                   local closestPlayer = nil
                   local closestDistance = math.huge

                   for i, player in ipairs(players) do
                     local distance = (player.Character.Head.Position - Players.LocalPlayer.Character.Head.Position).Magnitude
                     if distance < closestDistance and player ~= Players.LocalPlayer then
                       playerWhoDonated = player
                       closestDistance = distance
                     end
                   end
		playerWhoDonated:SetAttribute('Donated',raisedN)
		chat(' You have got ' .. raisedN .. 'money to use on .play ' .. playerWhoDonated.Name .. ' 💸')
		end
        else
		   chat('make sure to stay near my booth!')
		   task.wait(6)
		   local players = Players:GetPlayers()
                   local closestPlayer = nil
                   local closestDistance = math.huge

                   for i, player in ipairs(players) do
                     local distance = (player.Character.Head.Position - Players.LocalPlayer.Character.Head.Position).Magnitude
                     if distance < closestDistance and player ~= Players.LocalPlayer then
                       playerWhoDonated = player
                       closestDistance = distance
                     end
                   end
		playerWhoDonated:SetAttribute('Donated',raisedN)
		chat('Added ' .. raisedN .. ' to ' .. playerWhoDonated.Name .. ' ')
	end
	oldVal = raised.Value
        hopSet()
end)

msgdone = game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.OnMessageDoneFiltering
msgdone.OnClientEvent:Connect(function(msgdata)
	local speaker = tostring(msgdata.FromSpeaker)
	local message = string.lower(msgdata.Message)
	local plrChatted = game:GetService('Players')[speaker] or nil
	if (plrChatted and plrChatted == game:GetService('Players').LocalPlayer) or not plrChatted or debounceThing:FindFirstChild(plrChatted.Name) or string.find(message,'💸') or string.find(message,'💎') then
		return
	end
	local bal = plrChatted:GetAttribute('Donated')
	if message == 'scam' then
		x_scam = x_scam + 1
		if x_scam > 4 then
			serverHop()
		end
	end
	if message == '.balance' or message == '.bal' then
		chat('Your balance: ' .. tostring(bal) or '0' .. ' ')
		return
	end
	if message == '.play' then
		chat(' You need to specify an amount! | .play amount ')
		return
	end
	if string.match(message, '.play ') then
		local slotValx = string.gsub(message, '.play ', '')
		if not tonumber(slotValx) or tonumber(slotValx) < 0 then
			chat(' Enter a valid amount! | .play amount ')
			return
		end
		local slotVal = tonumber(slotValx)
		if bal == 0 then
			chat(' Your balance is 0! You cannot play! ')
			return
		end
		if bal < slotVal then
			chat('💸 Your balance is lower than the value you provided! 💸')
			return
		end
		local num
		local num = math.random() * 2 - 1
		local oldBalance = plrChatted:GetAttribute('Donated')
		local newBalance = math.floor(num * slotValx + oldBalance)
               if newBalance < 0 then
                  newBalance = 0
                end
		if newBalance > oldBalance then
			wait(1)
			chat('Congrats! your new balance is: ' .. newBalance .. ' 💸')
		elseif newBalance < oldBalance then
			wait(1)
			chat('You lost 😭, your new balance is: ' .. newBalance .. ' 💸')
		else
		wait(1)
			chat('Your balance stayed the same 🤷')
		end
		plrChatted:SetAttribute('Donated', newBalance)		
	end
    if message == '.help' then
    	wait(1)
        chat(".help | .withdraw | .play amount | .balance | .info || Z's Carnival!")
    end
     if message == '.stock' then
    	wait(1)
        chat("30k Money Left || Z's Carnival!")
    end
    if message == '.info' then
    	wait(1)
        chat("Information: Z's Carnival is a slot machine based bot to win! (I get teleported to your stand and pay.)")
        wait(0.5)
        chat("To play you need to use the play command and first you have to buy a bet on my stand. After that you get balance to play. If you win, you get money if you lose you dont.")
    end
    if message == '.withdraw' then
        if plrChatted:GetAttribute('Donated') < getgenv().settin.MinimumWithdrawAmount then
        	wait(1)
            chat('You need to get ' .. getgenv().settin.MinimumWithdrawAmount .. ' to withdraw!')
            return
        end
        serverHop()
    end
end)

task.spawn(function()
    while task.wait(settin.Beg.Delay) do
        chat(settin.Beg.Messages[math.random(1,#settin.Beg.Messages)])
    end
end)

chat(settin.Beg.Messages[math.random(1,#settin.Beg.Messages)])

local boothText = require(game.ReplicatedStorage.Remotes).Event("SetBoothText")
task.spawn(function()
	while true do
		task.wait(0.1)
	
	
		boothText:FireServer('<stroke color="#ff257e" thickness="1"><font color="#ffc5e6">z carnival</font></stroke><font size="3"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6"> .info | .help | .stock | .bal | .play (money) </font></stroke></font>', "booth")
		task.wait(3)
		boothText:FireServer('<font size="9"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6">z carnival</font></stroke></font><font size="3"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6"> Best Way of Making Money! </font></stroke></font>', "booth")
		task.wait(3)
		boothText:FireServer('<font size="9"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6">z carnival</font></stroke></font><font size="3"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6"> 💎 Valentine Day Special! 💝 </font></stroke></font>', "booth")
		task.wait(3)
		boothText:FireServer('<stroke color="#ff257e" thickness="1"><font color="#ffc5e6">z carnival</font></stroke><font size="3"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6"> Make sure to stay near my booth and play! </font></stroke></font>', "booth")
		task.wait(3)
		boothText:FireServer('<stroke color="#ff257e" thickness="1"><font color="#ffc5e6">z carnival</font></stroke><font size="3"><stroke color="#ff257e" thickness="1"><font color="#ffc5e6"> PLS DONATE Slot Machine | .stock </font></stroke></font>', "booth")
		task.wait(3)
	end
end)

if setfpscap then setfpscap(60) end

if hookmetamethod then
  local old
  old = hookmetamethod(game,"__namecall",function(self,...)
	local args = {...}
	local method = getnamecallmethod()
	if tostring(self) == "SayMessageRequest" and method == "FireServer" then
		args[1] = args[1]:gsub('💎','💸')
		return old(self,unpack(args))
	end
	return old(self,...)
  end)
end

while task.wait(getgenv().settin.ServerHopDelay * 60) do
	if not hopTimer then
		hopSet()
	end
end
