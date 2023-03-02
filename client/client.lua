local QBCore = exports['qb-core']:GetCoreObject()
local zones = {}
local location = nil

RegisterCommand('test', function()
    EnterCustom("Benny's")
end, false)

RegisterNUICallback('hideUI', function(data, cb)
    closeMenu()
    cb(1)
end)

RegisterNUICallback("PreviewChange", function(data, cb)
    PreviewChange(data)
    cb(1)
end)

RegisterNUICallback("RepairVehicle", function(data, cb)
    -- RepairVehicle()
    TriggerServerEvent('xv-customs:server:buyRepair', data)
    cb(1)
end)

RegisterNUICallback("ResetVehicle", function(data, cb)
    ResetVehicleData(false)
    print('reset')
    cb(1)
end)

RegisterNUICallback("PreviewColor", function(data, cb)
    PreviewColour(data)
    cb(1)
end)

RegisterNetEvent("FullReset", function(data, cb)
    ResetVehicleData(true)
    cb(1)
end)

RegisterNUICallback("UpdateCart", function(data, cb)
    UpdateCart(data)
    cb(1)
end)

RegisterNUICallback("PurchaseCart", function(data, cb)
    local veh = cache.vehicle
    
    local mods = QBCore.Functions.GetVehicleProperties(veh)
    local plate = QBCore.Functions.GetPlate(veh)

    local sendData = {
        plate = plate,
        mods = mods
    }
    
    TriggerServerEvent('qbx-customs:server:buyCart', sendData)
    
    cb(1)
end)

local function onEnter(self)
    if not IsPedInAnyVehicle(cache.ped, false) then return end

    lib.showTextUI('Customize Vehicle', { position = 'left-center' })
    lib.addRadialItem({
        id = 'customs_radial',
        label = 'Enter Bennys',
        icon = 'wrench',
        onSelect = function()
            EnterCustom(location)
        end,
    })
    location = self.name
end

local function onExit(self)
    lib.removeRadialItem('customs_radial')
    lib.hideTextUI()
    location = nil
end

local function CreateBennysShops()
    for _, zone in pairs(Config.Spots) do
        zones[zone.name] = lib.zones.box({
            name = zone.name,
            coords = zone.coords,
            size = zone.size,
            rotation = zone.rotation,
            debug = false,
            onExit = onExit,
            onEnter = onEnter,
        })
    end
end

local function RemoveBennysShops()
    onExit()
end

function LoggedIn()
    CreateBennysShops()
end

function LoggedOff()
    RemoveBennysShops()
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then return end
    LoggedIn()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        RemoveBennysShops()
    end
end)

AddStateBagChangeHandler('isLoggedIn', _, function(_bagName, _key, value, _reserved, _replicated)
    if value then LoggedIn() else LoggedOff() end
end)
