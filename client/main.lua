Citizen.CreateThread(function()
    while true do
        
        local playerId = GetPlayerServerId(PlayerId())
        local playerName = GetPlayerName(PlayerId())
        local players = #GetActivePlayers()
        local maxPlayers = Config.MaxPlayers

        
        SetDiscordAppId(Config.ApplicationID)

        
        local richPresenceText = Config.RichPresenceFormat:format(playerName, playerId, players, maxPlayers)
        SetRichPresence(richPresenceText)

        
        SetDiscordRichPresenceAsset(Config.LargeImage.Name)
        SetDiscordRichPresenceAssetText(Config.LargeImage.Text)

        SetDiscordRichPresenceAssetSmall(Config.SmallImage.Name)
        SetDiscordRichPresenceAssetSmallText(Config.SmallImage.Text)

        
        SetDiscordRichPresenceAction(0, Config.Buttons[1].Label, Config.Buttons[1].URL)
        SetDiscordRichPresenceAction(1, Config.Buttons[2].Label, Config.Buttons[2].URL)

        
        Citizen.Wait(Config.UpdateInterval)
    end
end)
