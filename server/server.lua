
RegisterServerEvent('qbx-customs:server:buyRepair', function(data)
    local src = source
    TriggerClientEvent("qbx-customs:client:repairVehicle", src)
end)

RegisterNetEvent("qbx-customs:server:buyCart", function(cart)
    local src = source
    
    local plate = cart.plate
    local mods = cart.mods

    if not IsVehicleOwned(plate) then return end
    exports.oxmysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(mods), plate})
    
end)



local function IsVehicleOwned(plate)
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return true
    end
    return false
end