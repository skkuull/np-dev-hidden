RegisterCommand('test', function(CurrentAttach)
    local hashB = GetHashKey(modelB)

    LoadEntityModel(hashB)
    
    local vehicleB = CreateVehicle(hashB, playerCoords.x, playerCoords.y, playerCoords.z, + 1.5)
    
    Objects[#Objects+1] = vehicleB

    local result = Citizen.Await(AttachmentPlacement(vehicleA, vehicleB, boneId))

    CurrentAttach = {
        object = {
            model = modelA, hash = hashA, boneId = boneId
        },
        target = {
            model = modelB, hash = hashB
        },
        result = result
    }

    -- DeleteEntity(vehicleA)
    DeleteEntity(vehicleA)
end)

RegisterCommand("completeAttach", function(src, args)
    local save = args[1]

    Placing = false

    Citizen.Wait(1000)

    if save then
        TriggerServerEvent('np:tools:attachments', CurrentAttach)
    end
end, false)

RegisterCommand('deleteAttach', function(src, args)
    local attach = tonumber(args[1])

    if attach then
        DeleteEntity(Objects[attach])
    else
        for _, object in ipairs(Objects) do
            DeleteEntity(object)
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if (resource ~= GetCurrentResourceName()) then
        return
    end
end)