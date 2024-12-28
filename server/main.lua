local function CheckRoles(discordID, callback)
    
    local url = ('https://discord.com/api/guilds/%s/members/%s'):format(Config.GuildID, discordID)

    local headers = {
        ["Authorization"] = "Bot " .. Config.BotToken,
        ["Content-Type"] = "application/json"
    }

    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local memberData = json.decode(response)
            local hasRequiredRole = false
            local hasBannedRole = false

            
            for _, roleID in ipairs(memberData.roles) do
                if roleID == Config.RequiredRoleID then
                    hasRequiredRole = true
                end
                if roleID == Config.BannedRoleID then
                    hasBannedRole = true
                end
            end

            callback(hasRequiredRole, hasBannedRole)
        else
            print(('[Discord API] Error %s while checking Discord roles'):format(statusCode))
            callback(false, false)
        end
    end, "GET", "", headers)
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    deferrals.defer()
    local src = source

    Citizen.Wait(100)
    deferrals.update("Checking your Discord roles...")

    local discordID
    for _, identifier in ipairs(GetPlayerIdentifiers(src)) do
        if string.find(identifier, "discord:") then
            discordID = identifier:gsub("discord:", "")
            break
        end
    end

    if not discordID then
        deferrals.done(("You must be connected to Discord to join this server. Join our Discord here: %s"):format(Config.DiscordInviteLink))
        return
    end

    CheckRoles(discordID, function(hasRequiredRole, hasBannedRole)
        if hasBannedRole then
            deferrals.done(("You are banned from this server. Join our Discord here for more information: %s"):format(Config.DiscordInviteLink))
        elseif not hasRequiredRole then
            deferrals.done(("You do not have the required role to join this server. Join our Discord here: %s"):format(Config.DiscordInviteLink))
        else
            deferrals.done()
        end
    end)
end)

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    print(('[INFO] %s is connecting to the server!'):format(name))
end)

RegisterServerEvent('playerDropped')
AddEventHandler('playerDropped', function(reason)
    print(('[INFO] A player has left: %s | Reason: %s'):format(GetPlayerName(source), reason))
end)
