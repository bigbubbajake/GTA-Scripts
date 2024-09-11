local QBCore = exports['qb-core']:GetCoreObject()
local pedman
local bagspawned
local bagModel = "prop_ld_case_01"
local baganimDict = "missheistdocksprep1hold_cellphone"
local baganimName = "hold_cellphone"
local vc = nil

Citizen.CreateThread(function()
	RequestModel(GetHashKey(bagModel))
	while not HasModelLoaded(GetHashKey(bagModel)) do
		Citizen.Wait(100)
	end
	while not HasAnimDictLoaded(baganimDict) do
		RequestAnimDict(baganimDict)
		Citizen.Wait(100)
	end
	QBCore.Functions.TriggerCallback('bubba-moneywash:server:pedcoords', function(pedloc)
		RequestModel(Config.pedmodel) while not HasModelLoaded(Config.pedmodel) do Citizen.Wait(1) end
		pedman = CreatePed(0, Config.pedmodel , pedloc.x, pedloc.y, pedloc.z, pedloc.w, false, false)
        vc = {pedloc.x, pedloc.y, pedloc.z}
		SetEntityInvincible(pedman, true)
		bagspawned = CreateObject(GetHashKey(bagModel), pedloc.x +2, pedloc.y+2, pedloc.z, 1, 1, 1)
		Citizen.Wait(1000)
        local netid = ObjToNet(bagspawned)
		SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(bagspawned, pedman, GetPedBoneIndex(pedman, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        TaskPlayAnim(pedman, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(pedman, baganimDict, baganimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
		SetBlockingOfNonTemporaryEvents(pedman, true)
		FreezeEntityPosition(pedman, true)
		SetEntityNoCollisionEntity(pedman, PlayerPedId(), false)

		if Config.OpenWithItem then
			exports['qb-target']:AddCircleZone("WashingPed", vector3(pedloc.x, pedloc.y, pedloc.z), 2.0, { name="WashingPed", debugPoly=false, useZ=true, },{ options = { { event = "bubba-moneywash:client:ShowMenu", icon = "fas fa-certificate", label = "Open Menu", item = Config.ItemName}, }, distance = 2.0 })
		else
			exports['qb-target']:AddCircleZone("WashingPed", vector3(pedloc.x, pedloc.y, pedloc.z), 2.0, { name="WashingPed", debugPoly=false, useZ=true, },{ options = { { event = "bubba-moneywash:client:ShowMenu", icon = "fas fa-certificate", label = "Open Menu"}, }, distance = 2.0 })
		end
	end)
end)

RegisterNetEvent("bubba-moneywash:client:ShowMenu", function()
    local MoneyMenu = {}
    MoneyMenu[#MoneyMenu+1] = { header = "Washing Menu", txt = "", isMenuHeader = true }
    MoneyMenu[#MoneyMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "bubba-moneywash:client:Menu:Close" } }

    MoneyMenu[#MoneyMenu+1] = { header = "Wash Black Money", txt = "Wash black money and receive legal money" ,params = { event = "bubba-moneywash:client:WashInput"}}

    exports['qb-menu']:openMenu(MoneyMenu)
end)

RegisterNetEvent("bubba-moneywash:client:WashInput", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "<center><p><img src=nui://"..Config.img..QBCore.Shared.Items[Config.BlackMoneyName].image.." width=100px></p>"..QBCore.Shared.Items[Config.BlackMoneyName].label,
        submitText = "Change",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = "- How much ? -",
            },
        }
    })    
    if dialog then
        if tonumber(dialog.amount) >= 0  then
            TriggerServerEvent("bubba-moneywash:server:sellthem", dialog.amount)
        else
            QBCore.Functions.Notify("Value must be higher then 0", "error")
        end
    end
        
end)
RegisterNetEvent('bubba-moneywash:client:HackSuccess')
AddEventHandler('bubba-moneywash:client:HackSuccess', function()
    QBCore.Functions.Notify('Successfully jammed phone signals.', 'success', 7500)
    local success = exports['Howdy-hackminigame']:Begin(3, 5000)
    if not success then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("bubba-blackmarket:server:callCops", pos)
    else
        TriggerEvent("bubba-moneywash:client:GetLocation")
    end
end)

RegisterNetEvent("bubba-moneywash:client:GetLocation", function() 
    QBCore.Functions.Notify('You will get the location now', 'success', 7500)
    local locv3 = vector3(vc[1],vc[2],vc[3])
    print(locv3)
    local transG = 250
    local blip = AddBlipForCoord(locv3.x, locv3.y, locv3.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Cleaner")
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)
AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	DeletePed(pedman)
	DeleteObject(bagspawned)
end)