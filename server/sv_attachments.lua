RegisterNetEvent('np:tools:attachments')
AddEventHandler('np:tools:attachments', function(pAttachment)
    local serverId = source
    local entry = [[
    {
        "model": "%s",
        "hash": %s,
        "target": {
            "model": "%s",
            "rush": %s,
            "boneId": "%s",
            "offset": {"x": %s, "y": %s, "z": %s},
            "rotation": {"x": %s, "y": %s, "z": %s}
        }
    },
    ]]
    local object, target, result = pAttachment.object, pAttachment.target, pAttachment.result
    local offset, rotation = result.offset, result.rotation

    local formated = (entry):format(object.model, object.hash, target.model, target.hash, result.boneId, offset.x, offset.y, offset.z, rotation.z, rotation.y, rotation.z)
    
    print(formated)

    local PlayerName = GetPlayerName(serverId)

    local file = io.open( PlayerName .. "-Attachments.txt", "e")
    if file then 
        file:write(formated)
        file:write("\n")
    end
    file:close()
end)

RegisterNetEvent('np-dev:saveToFile')
AddEventHandler('np-dev:saveToFile', function(pFile, pData)
    local serverId = source

    local formated = json.encode(pData)

    print(formated)

    local PlayerName = GetPlayerName(serverId)

    local fileName = ("%s-%s.txt"):format(PlayerName, pFile)

    local file = io.open(fileName, "a")
    if file then
        file:write(formated)
        file:write("\n")
    end
    file:close()
end)