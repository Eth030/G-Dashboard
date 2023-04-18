wait(35)
local url = "ws://localhost:3000"
local WebSocket = syn.websocket.connect(url)

WebSocket.OnMessage:Connect(function(Msg)
    --print(Msg)
end)

local Library = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
local Ctr = 0
while Ctr < 180 do -- 5 Sekunden * 180 Schleifendurchläufe = 900 Sekunden = 15 Minuten
    local data = {
        username = game.Players.LocalPlayer.Name,
        diamonds = game.Players.LocalPlayer.leaderstats.Diamonds.Value,
        inventory = #Library.Save.Get().Pets .. "/" .. Library.Save.Get().MaxSlots,
        ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("(%w+).*")
    }
    local json_data = game:GetService("HttpService"):JSONEncode(data)
    WebSocket:Send(json_data)
    wait(5)
    Ctr = Ctr + 1
end

WebSocket:Close()
