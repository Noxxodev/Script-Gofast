ESX = exports["es_extended"]:getSharedObject()

---------------------------------- départ -------------------------------

local pos1 = Config.posdebut
local veh = nil
local spawnveh = Config.spawnveh
local temps = Config.temps
gofast = 0

exports.qtarget:AddBoxZone("Gofaststart", pos1, 2.4, 1, {
    name="Gofaststart",
    heading=187.53,
    minZ=51.5,
    maxZ=54.5
      }, {
          options = {
              {
                  event = "gofastdebut", 
                  icon = "far fa-circle",
                  label = "Gofast",
              },
          },
          distance = 3.5
  })
  
RegisterNetEvent('gofastdebut')
AddEventHandler('gofastdebut', function()
    gofaststart()
end)



function gofaststart()
        Citizen.CreateThread(function()            
                if gofast <= 0 then
                    local random = math.random(#Config.deliveryPoints)
                    local randomVeh = math.random(1, #Config.vehicles)
                    local model = Config.vehicles[randomVeh].model
                    gofast = gofast + 1 
                    for k, v in pairs(Config.deliveryPoints) do
                        if random == k then 
                            choosenPos = k                           
                            blip = AddBlipForCoord(v.x, v.y, v.z)                            
                            SetBlipAsShortRange(blip, false)
                            SetBlipSprite (blip, 812)
                            SetBlipDisplay(blip, 2)
                            SetBlipScale  (blip, 1.0)
                            SetBlipAsShortRange(blip, false)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString("Livraison du véhicule")
                            EndTextCommandSetBlipName(blip)
                            SetBlipColour(blip, 5)
                            ClearGpsMultiRoute()
                            StartGpsMultiRoute(12, true, true)                                 
                            AddPointToGpsMultiRoute(v.x, v.y, v.z)
                            SetGpsMultiRouteRender(true) 
                            if Config.notif == 1 then
                                ESX.ShowNotification("Ramène le véhicule au client en bonne état", "info", 10000)
                            end
                            if Config.notif == 2 then
                                ESX.ShowNotification("Gofast", 'Ramène le véhicule au client en bonne état', "info", 8000, "top-left")
                            end                                 
                            if DoesBlipExist(blip) then                                                                                                   
                                local vehiclehash = GetHashKey(model)
                                RequestModel(vehiclehash)                                
                                while not HasModelLoaded(vehiclehash) do
                                    Citizen.Wait(100)
                                end
                                veh = CreateVehicle(vehiclehash, spawnveh, true, false)
                                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                SetVehicleEngineOn(veh, true, true, false) 	
                                FreezeEntityPosition(PlayerPedId(), false)
                                TriggerServerEvent("KraKss:sendNotifToCops")    
                                break                                                                          
                            end                                                                 
                        end                            
                    end
                else
                    

                    if Config.notif == 1 then
                        ESX.ShowNotification("Le GoFast n'est pas disponible pour le moment reviens plus tard", "error", 10000)
                    end
                    if Config.notif == 2 then
                        ESX.ShowNotification("Gofast", 'Le GoFast n\'est pas disponible pour le moment reviens plus tard', "error", 8000, "top-left")
                    end
                    if gofast >= 1 then
                        Wait(temps)
                        gofast = 0
                    end
                end
        end)
end

cancelGoFast = function()  
    RemoveBlip(blip)
    ClearGpsMultiRoute()
    FreezeEntityPosition(PlayerPedId(), false)
    DeleteVehicle(veh)
    veh = nil
    choosenPos = nil
    if Config.notif == 1 then
        ESX.ShowNotification("J'ai annulé le GOFAST, reviens quand tu sera prêt à amener le véhicule au client !", "info", 10000)
    end
    if Config.notif == 2 then
        ESX.ShowNotification("Gofast", 'J\'ai annulé le GOFAST, reviens quand tu sera prêt à amener le véhicule au client !', "info", 8000, "top-left")
    end                                       
end
-------------------------------------------------------------------------

-------------------------- vendre véhicule ------------------------------

local message = Config.message
local car = 'sanchez'
local models = 'sanchez'

Citizen.CreateThread(function()
    while true do
    local waitEnd = 1000
        for k,v in pairs(Config.deliveryPoints) do
            if choosenPos == k then  
                if veh ~= nil and not IsPedSittingInVehicle(PlayerPedId(), veh) then                    
                    cancelGoFast()
                end                 
                local co = GetEntityCoords(PlayerPedId())
                local dist = Vdist(co.x, co.y, co.z, v.x, v.y, v.z)                       
                if dist <= 3.5 then 
                    waitEnd = 0                   
                    DrawMarker(23, v.x, v.y, v.z - 0.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 3.0, 3.0, 3.0, 255, 255, 255, 200, false, false, 2, nil, nil, false)
                    ESX.ShowHelpNotification(message)
                    if IsControlJustPressed(1, 38) then
                        calculEtatVehicle()
                        vente = false
                    end                   
                else
                    break
                end  
            end                          
        end        
    Citizen.Wait(waitEnd)
    end
end)

calculEtatVehicle = function()
    local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false )
	local vehPlate = GetVehicleNumberPlateText(veh)
    local moteurveh = math.floor(GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,2)
    local carosserieVeh = math.floor(GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,2)
    local etat = ((moteurveh + carosserieVeh) /2)      
        endGoFast()
        Citizen.Wait(5000)
        TriggerServerEvent("KraKss:giveMoneyForDelivery", etat)
end			        	

RemoveBlip(blip)
ClearGpsMultiRoute()
FreezeEntityPosition(PlayerPedId(), false)
DeleteVehicle(veh)
veh = nil
choosenPos = nil

endGoFast = function()   
    RemoveBlip(blip)
    ClearGpsMultiRoute()
    FreezeEntityPosition(PlayerPedId(), false)
    DeleteVehicle(veh)
    veh = nil
    choosenPos = nil 
    spawnCar()
        if Config.notif == 1 then
            ESX.ShowNotification("[~c~Client~s~] Merci pour le véhicule ! Voici ton argent.", "success", 10000)
            ESX.ShowNotification("Vous pouvez gardez la sanchez ou la rendre au point de départ du Gofast.", "info", 10000)
        end
        if Config.notif == 2 then
            ESX.ShowNotification("Client", 'Merci pour le véhicule ! Voici ton argent.', "sucess", 8000, "top-left")
            ESX.ShowNotification("Gofast", 'Vous pouvez gardez la sanchez ou la rendre au point de départ du Gofast.', "info", 8000, "top-left")
        end
    
end


function spawnCar()
    local vehiclehashs = GetHashKey(models)
    RequestModel(vehiclehashs)                                
    while not HasModelLoaded(vehiclehashs) do
        Citizen.Wait(100)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    vehs = CreateVehicle(vehiclehashs, x, y, z, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehs, -1)
    SetVehicleEngineOn(vehs, true, true, false) 	
    FreezeEntityPosition(PlayerPedId(), false)
    
    
end

-------------------------------------------------------------------------

----------------------------- Fin gofast --------------------------------

local pos2 = Config.posfin
local supveh = false

exports.qtarget:AddBoxZone("Gofastsupveh", pos2, 2.4, 1, {
    name="Gofastsupveh",
    heading=187.53,
    minZ=51.5,
    maxZ=54.5
      }, {
          options = {
              {
                  event = "gofastsup", 
                  icon = "far fa-circle",
                  label = "Gofast rendre le véhicule",
              },
          },
          distance = 3.5
  })
  
RegisterNetEvent('gofastsup')
AddEventHandler('gofastsup', function()
    gofastsupveh()
end)

function gofastsupveh()
    Citizen.CreateThread(function()
        DeleteVehicle(vehs)
        vehs = nil
    end)
end

-------------------------------------------------------------------------

-------------------------------- Blips ----------------------------------

local blipsposition = Config.position

Citizen.CreateThread(function()
    if blipsposition == true then
        local blipMarker = Config.gofast
        local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

        SetBlipSprite (blipCoord, blipMarker.Sprite)
        SetBlipDisplay(blipCoord, blipMarker.Display)
        SetBlipScale  (blipCoord, blipMarker.Scale)
        SetBlipColour (blipCoord, blipMarker.Colour)
        SetBlipAsShortRange(blipCoord, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipMarker.name)
        EndTextCommandSetBlipName(blipCoord)
    end
end)

-------------------------------------------------------------------------

-------------------------------- Ped ------------------------------------

local ped = Config.ped

if ped == true then
local genderNum = 0
local peds = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < Config.PedsDistance and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			
			if dist >= Config.PedsDistance and peds[k] then
				if Config.Fade then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(peds[k].ped, i, false)
					end
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(1)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end	

	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	end
	
	SetEntityAlpha(ped, 0, false)
	
	if Config.Frozen then
		FreezeEntityPosition(ped, true) 
	end
	
	if Config.Invincible then
		SetEntityInvincible(ped, true) 
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true)
	end
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	
	if Config.Fade then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end

	return ped
end

-- HANDSUP
Citizen.CreateThread(function()
    local dict = "random@mugging3"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10000)
	end
    local handsup = false
	while true do
		Citizen.Wait(4)
		if IsControlJustPressed(1, 323) then -- X
            if not handsup then
                TaskPlayAnim(PlayerPedId(), dict, "handsup_standing_base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end)
end


print("^9-------------------------------------")
print("^4Gofast by Nox Développement^0")
print("^9-------------------------------------")
