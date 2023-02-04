
RegisterServerEvent('qbx-customs:server:buyRepair', function(data)
    local src = source
    TriggerClientEvent("qbx-customs:client:repairVehicle", src)
end)

RegisterNetEvent("qbx-customs:server:buyCart", function(cart)
    local src = source

end)