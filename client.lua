local menuOpened = false
local rotatedCam = nil
local oldPartId = nil
local currentModData = {}
local currentFitmentData = {}
vehData = {}
local lastVehicle = nil
local nitroBoosted = false
local popcornEnabled = false
local isIllegalMechanic = false
local currentMechanic = nil
local colorsLoaded = false
local useCountLivery = false
local defaultMod = nil
local modinStart = {}
local basketVersion = {}
local boughtVersion = {}
local moddatainstart = {}
local currentMods = {}
local cartMods = {}
local firstWheelType = nil
local currentWheelType = nil
local savedColorState = {}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
local windowTypes = {
    "WINDOWTINT_NONE",  
	"WINDOWTINT_PURE_BLACK",  
	"WINDOWTINT_DARKSMOKE",  
	"WINDOWTINT_LIGHTSMOKE",  
	"WINDOWTINT_STOCK",  
	"WINDOWTINT_LIMO",  
	"WINDOWTINT_GREEN"  
}
local wheelTypes = {
    ["Sports"] = 0,
    ["Muscle"] = 1,
    ["Lowrider"] = 2,
    ["SUV"] = 3,
    ["Offroad"] = 4,
    ["Tuner"] = 5,
    ["High End"] = 7,
    ["Benny's (1)"] = 8,
    ["Benny's (2)"] = 9,
    ["Open Wheel"] = 10,
    ["Street"] = 11,
    ["Track"] = 12
}

local vehicleTractions = {
	["FWD"] = 1.0,
	["RWD"] = 0.0,
	["AWD"] = 0.02,
	["FourWD"] = 0.5,
}

local fitmentData = {
    ["front-left"] = 0,
    ["front-right"] = 1,
    ["rear-left"] = 2,
    ["rear-right"] = 3,
    ["front-left-camber"] = 0,
    ["front-right-camber"] = 1,
    ["rear-left-camber"] = 2,
    ["rear-right-camber"] = 3,
    ["wheels-width"] = 5,
}

local partData = {
    ["main"] = {
        offset = vector3(-4.5, 4.5, 1.0),
        rotation = vector3(0.0, 0.0, 230.0),
    },
    ["rear bumper"] = {
        offset = vector3(1.0, -4.0, 0.0),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["front bumper"] = {
        offset = vector3(-1.0, 4.0, 0.0),
        rotation = vector3(0.0, 0.0, 210.0),
    },
    ["spoiler"] = {
        offset = vector3(1.5, -4.5, 0.9),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["exhausts"] = {
        offset = vector3(1.0, -3.5, 0.0),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["skirts"] = {
        offset = vector3(2.5, 1.0, 0.0),
        rotation = vector3(0.0, 0.0, 110.0),
    },
    ["suspension"] = {
        offset = vector3(2.0, -3.0, 0.0),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["brakes"] = {
        offset = vector3(-2.0, 2.5, 0.0),
        rotation = vector3(0.0, 0.0, 230.0),
    },
    ["engine"] = {
        offset = vector3(-1.5, 4.0, 1.0),
        rotation = vector3(0.0, 0.0, 210.0),
        doorId = 4,
    },
    ["hood"] = {
        offset = vector3(0.0, 4.5, 1.0),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["turbo"] = {
        offset = vector3(-1.5, 3.5, 1.0),
        rotation = vector3(-10.0, 0.0, 210.0),
        doorId = 4,
    },
    ["horn"] = {
        offset = vector3(-1.5, 3.5, 1.0),
        rotation = vector3(-10.0, 0.0, 210.0),
        doorId = 4,
    },
    ["transmission"] = {
        offset = vector3(-1.5, 3.5, 0.5),
        rotation = vector3(-10.0, 0.0, 210.0),
        doorId = 4,
    },
    ["headlights"] = {
        offset = vector3(1.0, 3.5, 0.3),
        rotation = vector3(0.0, 0.0, 160.0),
    },
    ["headlight color"] = {
        offset = vector3(1.0, 3.5, 0.3),
        rotation = vector3(0.0, 0.0, 160.0),
    },
    ["wheels"] = {
        offset = vector3(2.0, 3.0, 0.0),
        rotation = vector3(0.0, 0.0, 140.0),
    },
    ["aerials"] = {
        offset = vector3(0.0, 4.5, 1.0),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["air filters"] = {
        offset = vector3(0.0, 3.0, 1.0),
        rotation = vector3(-30.0, 0.0, 180.0),
        doorId = 4,
    },
    ["arch cover"] = {
        offset = vector3(0.0, 3.5, 0.3),
        rotation = vector3(0.0, 0.0, 180.0),
    },
    ["engine block"] = {
        offset = vector3(0.0, 3.0, 1.0),
        rotation = vector3(-30.0, 0.0, 180.0),
        doorId = 4,
    },
    ["fenders"] = {
        offset = vector3(4.5, 0.0, 0.5),
        rotation = vector3(0.0, 0.0, 90.0),
    },
    ["frame"] = {
        offset = vector3(0.0, 5.0, 1.0),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["grille"] = {
        offset = vector3(0.0, 4.0, 0.3),
        rotation = vector3(0.0, 0.0, 180.0),
    },
    ["license"] = {
        offset = vector3(1.0, -4.0, 0.5),
        rotation = vector3(-10.0, 0.0, 30.0),
    },
    ["plate holders"] = {
        offset = vector3(0.0, 4.0, 0.3),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["roof"] = {
        offset = vector3(0.0, 2.5, 1.75),
        rotation = vector3(-20.0, 0.0, 180.0),
    },
    ["struts"] = {
        offset = vector3(0.0, 3.0, 1.0),
        rotation = vector3(-30.0, 0.0, 180.0),
        doorId = 4,
    },
    ["tank"] = {
        offset = vector3(0.0, 3.5, 0.0),
        rotation = vector3(0.0, 0.0, 180.0),
    },
    ["trim"] = {
        offset = vector3(0.0, 2.5, 1.75),
        rotation = vector3(-20.0, 0.0, 180.0),
    },
    ["vanity plates"] = {
        offset = vector3(0.0, 3.5, 0.0),
        rotation = vector3(0.0, 0.0, 180.0),
    },
    ["windows"] = {
        offset = vector3(2.0, 0.0, 1.0),
        rotation = vector3(-20.0, 0.0, 90.0),
    },
    ["nitro"] = {
        offset = vector3(1.0, -3.5, 0.0),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["vehicle traction"] = {
        offset = vector3(2.5, 1.0, 0.0),
        rotation = vector3(0.0, 0.0, 110.0),
    },
    ["tuner chip"] = {
        offset = vector3(-1.5, 4.0, 1.0),
        rotation = vector3(0.0, 0.0, 210.0),
        doorId = 4,
    },
    ["dashboard"] = {
        offset = vector3(0.0, -0.2, 0.5),
        rotation = vector3(-10.0, 0.0, 0.0),
    },
    ["dial design"] = {
        offset = vector3(0.0, -0.2, 0.5),
        rotation = vector3(-10.0, 0.0, 0.0),
    },
    ["trim design"] = {
        offset = vector3(0.0, 5.0, 1.0),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["ornaments"] = {
        offset = vector3(0.0, -0.2, 0.5),
        rotation = vector3(-10.0, 0.0, 0.0),
    },
    ["steering wheels"] = {
        offset = vector3(-0.2, -0.2, 0.5),
        rotation = vector3(-10.0, 0.0, 0.0),
    },
    ["shifter leavers"] = {
        offset = vector3(0.0, -0.2, 0.5),
        rotation = vector3(-10.0, 0.0, 0.0),
    },
    ["seats"] = {
        offset = vector3(0.0, 5.0, 1.0),
        rotation = vector3(-10.0, 0.0, 180.0),
    },
    ["plaques"] = {
        offset = vector3(1.5, -4.5, 0.9),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["speakers"] = {
        offset = vector3(1.5, -4.5, 0.9),
        rotation = vector3(0.0, 0.0, 30.0),
    },
    ["trunk"] = {
        offset = vector3(1.5, -4.5, 0.9),
        rotation = vector3(0.0, 0.0, 30.0),
        doorId = 5,
    },
    ["door speaker"] = {
        offset = vector3(-1.2, -1.0, 0.3),
        rotation = vector3(0.0, 0.0, 0.0),
        doorId = 0,
    },
    ["window tint"] = {
        offset = vector3(2.0, 0.0, 1.0),
        rotation = vector3(-20.0, 0.0, 90.0),
    },
    ["tire smoke"] = {
        offset = vector3(1.0, -3.5, 0.0),
        rotation = vector3(0.0, 0.0, 30.0),
    },
}

trim = function(value)
    return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
end

setVehicleTraction = function(vehicle, traction)
    if traction == "Stock" then
        RequestAndWaitModel(GetEntityModel(vehicle))
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        local _, ground = GetGroundZFor_3dCoord(pCoords.x, pCoords.y, pCoords.z, false)
        local dVehicle = CreateVehicle(GetEntityModel(vehicle), pCoords.x, pCoords.y, ground - 50, 0.0, false, false)
        SetEntityVisible(dVehicle, false, false)
        FreezeEntityPosition(playerPed, false)
        local defaultValue = GetVehicleHandlingFloat(dVehicle, 'CHandlingData', 'fDriveBiasFront')
        if DoesEntityExist(dVehicle) then
            DeleteEntity(dVehicle)
        end
        return SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveBiasFront', defaultValue)
    end
    SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveBiasFront', vehicleTractions[traction])
    SetVehicleWheelIsPowered(vehicle, 0, traction ~= "RWD")
    SetVehicleWheelIsPowered(vehicle, 1, traction ~= "RWD")
    SetVehicleWheelIsPowered(vehicle, 3, traction ~= "FWD")
    SetVehicleWheelIsPowered(vehicle, 4, traction ~= "FWD")
end

setVehicleTunerChip = function(vehicle, mode)
    if mode == "Stock" then
        SetVehicleEnginePowerMultiplier(vehicle, 1.0)
        SetVehicleCheatPowerIncrease(vehicle, 1.0)
        return SetVehicleReduceGrip(vehicle, false)
    elseif mode == "performance" then
        SetVehicleEnginePowerMultiplier(vehicle, Config.Settings.performanceMode.engineValue)
        SetVehicleCheatPowerIncrease(vehicle, Config.Settings.performanceMode.torqValue)
    end
end

setVehicleModification = function(pVehicle, plate)
    if not vehData[plate] then
        return
    end
    if vehData[plate].tuner_chip and vehData[plate].tuner_chip == "performance" then
        setVehicleTunerChip(pVehicle, "performance")
    end
    if vehData[plate].vehicle_traction then
        setVehicleTraction(pVehicle, vehData[plate].vehicle_traction)
    end
end

addEffect = function(pVehicle, bone)
    UseParticleFxAssetNextCall('core')
    local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', pVehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, 1.0, false, false, false)
    SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
    return ptfx
end

RegisterNetEvent("0r-mechanic:client:useNitro", function(vehicleId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleId)
    local ptfx01 = addEffect(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_r"))
    local ptfx02 = addEffect(vehicle, GetEntityBoneIndexByName(vehicle, "taillight_l"))
    Citizen.CreateThread(function()
        local remainingTime = GetGameTimer() + Config.Settings.nitro.time   
        while remainingTime > GetGameTimer() do 
            Citizen.Wait(750)
        end
        StopParticleFxLooped(ptfx01)
        StopParticleFxLooped(ptfx02)
    end)
end)

useNitro = function(pVehicle)
    SetVehicleBoostActive(pVehicle, 1, 0)
    TriggerServerEvent("0r-mechanic:server:useNitro", NetworkGetNetworkIdFromEntity(pVehicle))
    StartScreenEffect("RaceTurbo", 3000, false)
    Citizen.CreateThread(function()
        local remainingTime = GetGameTimer() + Config.Settings.nitro.time   
        while remainingTime > GetGameTimer() do 
            SetVehicleForwardSpeed(pVehicle, (GetEntitySpeed(PlayerPedId()) * Config.Settings.nitro.multiplier))
            SetVehicleTurboPressure(pVehicle, 100.0)
            Citizen.Wait(750)
        end
        SetVehicleBoostActive(pVehicle, 0, 0)
    end)

    Citizen.SetTimeout(Config.Settings.nitro.cooldown, function()
        nitroBoosted = false
    end)
end

unregisterCam = function(partId)
    if not partData[partId] then
        return
    end

    if not DoesCamExist(partData[partId].camera) then
        return
    end

    DestroyCam(partData[partId].camera)
    partData[partId].camera = nil
end

registerCam = function(playerVehicle, partId)
    if not playerVehicle then
        return
    end

    if not partData[partId] then
        return
    end

    local data = partData[partId]

    if DoesCamExist(data.camera) then
        return
    end

    local partCoords = GetOffsetFromEntityInWorldCoords(playerVehicle, data.offset)
    local partRotation = GetEntityRotation(playerVehicle) + data.rotation
    data.camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(data.camera, partCoords)
    SetCamRot(data.camera, partRotation)
    SetCamFov(data.camera, 50.0)
end

unregisterAllCams = function()
    for k,v in pairs(partData) do
        if DoesCamExist(v.camera) then
            SetCamActive(v.camera, false)
            DestroyCam(v.camera)
        end
    end
    RenderScriptCams(false, false, 500, false, false)
    DestroyAllCams()
end

rotateCam = function(partId)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId(), false)

    if not partData[partId] then
        return
    end

    if partId ~= "main" then
        unregisterCam(oldPartId)
        oldPartId = partId
    end

    registerCam(vehicle, "main")
    registerCam(vehicle, partId)
    DisableCamCollisionForEntity(vehicle)


    local data = partData[partId]

    if data.doorId then
		if GetVehicleDoorAngleRatio(vehicle, data.doorId) > 0.0 then
			SetVehicleDoorShut(vehicle, data.doorId, false)
		else
			SetVehicleDoorOpen(vehicle, data.doorId, false)
		end
    end

    if partId == "main" then
        for i = 0, 5 do
            if GetVehicleDoorAngleRatio(vehicle, i) > 0.0 then
                SetVehicleDoorShut(vehicle, i, false)
            end
        end
    end

    if DoesCamExist(rotatedCam) and data.camera ~= rotatedCam then
        SetCamActiveWithInterp(data.camera, rotatedCam, 1500, 1, 1)
        SetCamActive(data.camera, true)
    end

    rotatedCam = data.camera
    SetCamActive(rotatedCam, true)
    RenderScriptCams(true, true, 500, true, true)
end

addMod = function(vehicle, modId, stock, modPrice)
	SetVehicleModKit(vehicle, 0)
    local dummy = {}
    local found = false

    if modId == "plates" then
        found = true
        dummy[#dummy + 1] = { modId = "plates", label = "Blue on White 1", mod = 0, img="blueonwhite", price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "plates", label = "Blue On White 2", mod = 3, img="blueonwhite2", price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = "plates", label = "Blue On White 3", mod = 4, img="blueonwhite3", price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = "plates", label = "Yellow on Blue", mod = 2, img="yellowonblue", price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = "plates", label = "Yellow on Black", mod = 1,img="yellowonblack", price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = "plates", label = "Yankton", mod = 5, img="yankton", price = modPrice.basePrice}
        local currentModIndex = GetVehicleNumberPlateTextIndex(vehicle)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == "livery" then
        local liveryCount = GetVehicleLiveryCount(vehicle)
        if liveryCount == -1 then
            useCountLivery = false
            if (GetNumVehicleMods(vehicle, 48) ~= nil and GetNumVehicleMods(vehicle, 48) > 0) then
                if stock then
                    dummy[#dummy + 1] = {
                        label = "Stock",
                        modId = 48,
                        price = 0,
                        mod = -1
                    }
                end
                for i = 0, tonumber(GetNumVehicleMods(vehicle, 48)) - 1 do
                    local modText = GetModTextLabel(vehicle, 48, i)
                    local modLabel = tostring(GetLabelText(modText))
                    dummy[#dummy + 1] = {
                        label = modLabel ~= "NULL" and modLabel or ("Mod %s"):format(#dummy),
                        modId = 48,
                        price = (modPrice.basePrice) + ((modPrice.increaseby and modPrice.increaseby * i) or 0),
                        mod = i,
                    }
                end
    
                local currentMod = GetVehicleMod(vehicle, 48)
                if currentMod > -1 then
                    for k,v in pairs(dummy) do
                        if v.mod == currentMod then
                            dummy[k].attached = true
                        end
                    end
                end
    
                found = true
            end
        else
            useCountLivery = true
            found = true
            local liveryId = GetVehicleLivery(vehicle)
            for i = 1, liveryCount do
                dummy[#dummy + 1] = { modId = "livery", label = ("Livery %s"):format(i), mod = i, price = (modPrice.basePrice) + ((modPrice.increaseby and modPrice.increaseby * i) or 0) }
                if i == liveryId then
                    dummy[#dummy].attached = true
                end
            end
        end
    elseif modId == "vehicle_traction" then
        found = true
        dummy[#dummy + 1] = { modId = "vehicle_traction", label = "Stock", mod = "Stock", price = 0 }
        dummy[#dummy + 1] = { modId = "vehicle_traction", label = "FWD", mod = "FWD", price = modPrice }
        dummy[#dummy + 1] = { modId = "vehicle_traction", label = "RWD", mod = "RWD", price = modPrice}
        dummy[#dummy + 1] = { modId = "vehicle_traction", label = "AWD", mod = "AWD", price = modPrice}
        dummy[#dummy + 1] = { modId = "vehicle_traction", label = "FourWD", mod = "FourWD", price = modPrice}
        local currentModIndex = trim(GetVehicleNumberPlateText(vehicle))
        dummy[1].attached = true
        for plate, vehd in pairs(vehData) do
            if plate == currentModIndex then
                if vehd.vehicle_traction then
                    for k,v in pairs(dummy) do
                        if v.mod == vehd.vehicle_traction then
                            v.attached = true
                            dummy[1].attached = nil
                        end
                    end
                end
            end
        end
    elseif modId == "tuner_chip" then
        found = true
        dummy[#dummy + 1] = { modId = "tuner_chip", label = "Stock", mod = "Stock", price = 0 }
        dummy[#dummy + 1] = { modId = "tuner_chip", label = "Performance Mode", mod = "performance", price = modPrice }
        dummy[#dummy + 1] = { modId = "tuner_chip", label = "Drift Mode", mod = "drift", price = modPrice}
        local currentModIndex = trim(GetVehicleNumberPlateText(vehicle))
        dummy[1].attached = true
        for plate, vehd in pairs(vehData) do
            if plate == currentModIndex then
                if vehd.tuner_chip then
                    for k,v in pairs(dummy) do
                        if v.mod == vehd.tuner_chip then
                            v.attached = true
                            dummy[1].attached = nil
                        end
                    end
                end
            end
        end
    elseif modId == "nitro" then
        found = true
        dummy[#dummy + 1] = { modId = "nitro", label = "Stock", mod = "Stock", price = 0 }
        dummy[#dummy + 1] = { modId = "nitro", label = "NOS", mod = "nos", price = modPrice }
        local currentModIndex = trim(GetVehicleNumberPlateText(vehicle))

        dummy[1].attached = true
        for plate, vehd in pairs(vehData) do
            if plate == currentModIndex then
                if vehd.nitro then
                    for k,v in pairs(dummy) do
                        if v.mod == vehd.nitro then
                            v.attached = true
                            dummy[1].attached = nil
                        end
                    end
                end
            end
        end
    elseif modId == "popcorn" then
        found = true
        dummy[#dummy + 1] = { modId = "popcorn", label = "Stock", mod = "Stock", price = 0 }
        dummy[#dummy + 1] = { modId = "popcorn", label = "Popcorn Exhaust", mod = "popcorn", price = modPrice }
        local currentModIndex = trim(GetVehicleNumberPlateText(vehicle))
        dummy[1].attached = true
        for plate, vehd in pairs(vehData) do
            if plate == currentModIndex then
                if vehd.popcorn then
                    for k,v in pairs(dummy) do
                        if v.mod == vehd.popcorn then
                            v.attached = true
                            dummy[1].attached = nil
                        end
                    end
                end
            end
        end
    elseif modId == "neon" then
        found = true
        dummy[#dummy + 1] = { modId = "neon", label = "Stock", mod = 4, price = 0 }
        dummy[#dummy + 1] = { modId = "neon", label = "Left", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "neon", label = "Right", mod = 1, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "neon", label = "Front", mod = 2, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "neon", label = "Back", mod = 3, price = modPrice.basePrice }
        local neonFound = false
        for i = 0, 3 do
            if IsVehicleNeonLightEnabled(vehicle, i) then
                neonFound = true
                dummy[i + 2].attached = true
            end
        end
        if not neonFound then
            dummy[1].attached = true
        end
    elseif modId == "headlight_color" then
        found = true
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Default Xenon", mod = -1, price = 0 }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "White", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Blue", mod = 1, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Electric Blue", mod = 2, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Mint Green", mod = 3, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Lime Green", mod = 4, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Yellow", mod = 5, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Golden Shower", mod = 6, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Orange", mod = 7, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Red", mod = 8, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Pony Pink", mod = 9, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Hot Pink", mod = 10, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Purple", mod = 11, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "headlight_color", label = "Blacklight", mod = 12, price = modPrice.basePrice }
        local currentModIndex = GetVehicleXenonLightsColor(vehicle)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 12 then
        found = true
        dummy[#dummy + 1] = { modId = 12, label = "Street Brakes", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = 12, label = "Sport Brakes", mod = 1, price = modPrice.basePrice + (modPrice.increaseby * 2) }
        dummy[#dummy + 1] = { modId = 12, label = "Race Brakes", mod = 2, price = modPrice.basePrice + (modPrice.increaseby * 3) }
        local currentModIndex = GetVehicleMod(vehicle, 12)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 13 then
        found = true
        dummy[#dummy + 1] = { modId = 13, label = "Street Transmission", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = 13, label = "Sports Transmission", mod = 1, price = modPrice.basePrice + (modPrice.increaseby * 2) }
        dummy[#dummy + 1] = { modId = 13, label = "Race Transmission", mod = 2, price = modPrice.basePrice + (modPrice.increaseby * 3) }
        local currentModIndex = GetVehicleMod(vehicle, 13)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 18 then
        found = true
        dummy[#dummy + 1] = { modId = 18, label = "None", mod = 0, price = 0 }
        dummy[#dummy + 1] = { modId = 18, label = "Turbo Tuning", mod = 1, price = modPrice }
        if IsToggleModOn(vehicle, 18) then
            dummy[2].attached = true
        else
            dummy[1].attached = true
        end
    elseif modId == "tire_smoke" then
        found = true
        dummy[#dummy + 1] = { modId = "tire_smoke", label = "Disable", mod = 0, price = 0 }
        dummy[#dummy + 1] = { modId = "tire_smoke", label = "Enable", mod = 1, price = modPrice.basePrice}
        if IsToggleModOn(vehicle, 20) then
            dummy[2].attached = true
        else
            dummy[1].attached = true
        end
    elseif modId == "window_tint" then
        found = true
        dummy[#dummy + 1] = { modId = "window_tint", label = "Stock", mod = 4, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = "window_tint", label = "None", mod = 0, price = modPrice.basePrice + (modPrice.increaseby * 2)} 
        dummy[#dummy + 1] = { modId = "window_tint", label = "Limo", mod = 5, price = modPrice.basePrice + (modPrice.increaseby * 3)} 
        dummy[#dummy + 1] = { modId = "window_tint", label = "Light Smoke", mod = 3, price = modPrice.basePrice + (modPrice.increaseby * 4)} 
        dummy[#dummy + 1] = { modId = "window_tint", label = "Dark Smoke", mod = 2, price = modPrice.basePrice + (modPrice.increaseby * 5)} 
        dummy[#dummy + 1] = { modId = "window_tint", label = "Pure Black", mod = 1, price = modPrice.basePrice + (modPrice.increaseby * 6)} 
        dummy[#dummy + 1] = { modId = "window_tint", label = "Green", mod = 6, price = modPrice.basePrice + (modPrice.increaseby * 7)} 
        local currentModIndex = GetVehicleWindowTint(vehicle)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 15 then
        found = true
        dummy[#dummy + 1] = { modId = 15, label = "Lowered Suspension", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = 15, label = "Street Suspension", mod = 1, price = modPrice.basePrice + (modPrice.increaseby * 2) }
        dummy[#dummy + 1] = { modId = 15, label = "Sport Suspension", mod = 2, price = modPrice.basePrice + (modPrice.increaseby * 3) }
        dummy[#dummy + 1] = { modId = 15, label = "Competition Suspension", mod = 3, price = modPrice.basePrice + (modPrice.increaseby * 4) }
        local currentModIndex = GetVehicleMod(vehicle, 15)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 11 then
        found = true
        dummy[#dummy + 1] = { modId = 11, label = "Level 2", mod = 0, price = modPrice.basePrice }
        dummy[#dummy + 1] = { modId = 11, label = "Level 3", mod = 1, price = modPrice.basePrice + (modPrice.increaseby * 2) }
        dummy[#dummy + 1] = { modId = 11, label = "Level 4", mod = 2, price = modPrice.basePrice + (modPrice.increaseby * 3) }
        local currentModIndex = GetVehicleMod(vehicle, 11)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    elseif modId == 22 then
        found = true
        dummy[#dummy + 1] = { modId = 22, label = "Stock Lights", mod = 0, price = 0 }
        dummy[#dummy + 1] = { modId = 22, label = "Xenon Lights", mod = 1, price = modPrice.basePrice }
        if IsToggleModOn(vehicle, 22) then
            dummy[2].attached = true
        else
            dummy[1].attached = true
        end
    elseif modId == 14 then
        found = true
        dummy[#dummy + 1] = { modId = 14, label = "Truck Horn", mod = 0, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Police Horn", mod = 1, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Clown Horn", mod = 2, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Musical Horn 1", mod = 3, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Musical Horn 2", mod = 4, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Musical Horn 3", mod = 5, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Musical Horn 4", mod = 6, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Musical Horn 5", mod = 7, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Sadtrombone Horn", mod = 8, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 1", mod = 9, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 2", mod = 10, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 3", mod = 11, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 4", mod = 12, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 5", mod = 13, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 6", mod = 14, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Calssical Horn 7", mod = 15, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scaledo Horn", mod = 16, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scalere Horn", mod = 17, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scalemi Horn", mod = 18, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scalefa Horn", mod = 19, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scalesol Horn", mod = 20, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scalela Horn", mod = 21, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scaleti Horn", mod = 22, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Scaledo Horn High", mod = 23, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Jazz Horn 1", mod = 25, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Jazz Horn 2", mod = 26, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Jazz Horn 3", mod = 27, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Jazzloop Horn", mod = 28, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Starspangban Horn 1", mod = 29, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Starspangban Horn 2", mod = 30, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Starspangban Horn 3", mod = 31, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Starspangban Horn 4", mod = 32, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Classicalloop Horn 1", mod = 33, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Classicalloop Horn 2", mod = 34, price = modPrice.basePrice}
        dummy[#dummy + 1] = { modId = 14, label = "Classicalloop Horn 3", mod = 35, price = modPrice.basePrice}
        local currentModIndex = GetVehicleMod(vehicle, 14)
        for k,v in pairs(dummy) do
            if v.mod == currentModIndex then
                v.attached = true
            end
        end
    else
        if (GetNumVehicleMods(vehicle, modId) ~= nil and GetNumVehicleMods(vehicle, modId) > 0) then
            if stock then
                dummy[#dummy + 1] = {
                    label = "Stock",
                    modId = modId,
                    price = 0,
                    mod = -1
                }
            end
            for i = 0, tonumber(GetNumVehicleMods(vehicle, modId)) - 1 do
                local modText = GetModTextLabel(vehicle, modId, i)
                local modLabel = tostring(GetLabelText(modText))
                dummy[#dummy + 1] = {
                    label = modLabel ~= "NULL" and modLabel or ("Mod %s"):format(#dummy),
                    modId = modId,
                    price = (modPrice.basePrice) + ((modPrice.increaseby and modPrice.increaseby * i) or 0) ,
                    mod = i,
                }
            end

            local currentMod = GetVehicleMod(vehicle, modId)

            if currentMod > -1 then
                for k,v in pairs(dummy) do
                    if v.mod == currentMod then
                        dummy[k].attached = true
                    end
                end
            end


            found = true
        end
    end
    -- -- --print(json.encode(moddatainstart, {indent = true}), 777)
    if not found then
        return nil
    end

    return dummy
end

loadMods = function(vehicle)
    local modifyMenu = Config.Menus
    local modMenu = {}
    local chassis, interior, fbumper, rbumper, isBike = false, false, false, false, false

    for i = 0, 48 do
        if GetNumVehicleMods(vehicle, i) ~= nil and GetNumVehicleMods(vehicle, i) ~= false and GetNumVehicleMods(vehicle, i) > 0 then
            if i == 1 then
                fbumper = true
            elseif i == 2 then
                rbumper = true
            elseif (i >= 42 and i <= 46) or i == 5 then 
                chassis = true
            elseif i >= 27 and i <= 37 then 
                interior = true
            end
        end
    end

    if IsThisModelABike(GetEntityModel(vehicle)) then
        isBike = true
    end

    modMenu[1] = {
        label = "Vehicle Customization",
        img = "vehicle",
        type = "main",
        items = {}
    }

    modMenu[2] = {
        label = "Vehicle Cosmetics",
        img = "cosmetic",
        type = "main",
        items = {}
    }

    modMenu[3] = {
        label = "Upgrades",
        img = "upgrades",
        type = "main",
        items = {}
    }

    modMenu[4] = {
        label = "Wheels",
        img = "wheel",
        type = "main",
        items = {}
    }

    modMenu[5] = {
        label = "Paint Booth",
        img = "paintbrush",
        type = "main",
        items = {}
    }

    if isIllegalMechanic and not isBike then
        modMenu[6] = {
            label = "Wheel Fitment",
            img = "fitment",
            type = "main",
            items = {}
        }

        modMenu[7] = {
            label = "Vehicle Tunning",
            img = "vehicle_tuning",
            type = "main",
            items = {}
        }
        modMenu[8] = {
            label = "Repair Vehicle",
            img = "repair",
            type = "main",
            items = {}
        }
    else
        modMenu[6] = {
            label = "Repair Vehicle",
            img = "repair",
            type = "main",
            items = {}
        }
    end

    modMenu[3].items["Brakes"] = {
        img = "brakes",
        type = "submenu",
        items = addMod(vehicle, 12, true, modifyMenu.upgrades.brakes)
    }

    modMenu[3].items["Transmission"] = {
        img = "transmission",
        type = "submenu",
        items = addMod(vehicle, 13, true, modifyMenu.upgrades.transmission)
    }

    modMenu[3].items["Turbo"] = {
        img = "turbo",
        type = "submenu",
        items = addMod(vehicle, 18, false, modifyMenu.upgrades.turbo)
    }

    modMenu[3].items["Suspension"] = {
        img = "suspension",
        type = "submenu",
        items = addMod(vehicle, 15, true, modifyMenu.upgrades.suspension)
    }

    modMenu[3].items["Engine"] = {
        img = "engine",
        type = "submenu",
        items = addMod(vehicle, 11, true, modifyMenu.upgrades.engine)
    }

    modMenu[1].items["Spoiler"] = {
        img = "spoiler",
        type = "submenu",
        items = addMod(vehicle, 0, true, modifyMenu.customization.spoiler)
    }

    modMenu[1].items["Skirts"] = {
        img = "skirts",
        type = "submenu",
        items = addMod(vehicle, 3, true, modifyMenu.customization.skirts)
    }

    modMenu[1].items["Exhausts"] = {
        img = "exhausts",
        type = "submenu",
        items = addMod(vehicle, 4, true, modifyMenu.customization.exhausts)
    }

    modMenu[1].items["Grille"] = {
        img = "grille",
        type = "submenu",
        items = addMod(vehicle, 6, true, modifyMenu.customization.grille)
    }

    modMenu[1].items["Hood"] = {
        img = "hood",
        type = "submenu",
        items = addMod(vehicle, 7, true, modifyMenu.customization.hood)
    }

    modMenu[1].items["Fenders"] = {
        img = "fenders",
        type = "submenu",
        items = addMod(vehicle, 8, true, modifyMenu.customization.fenders)
    }

    modMenu[1].items["Roof"] = {
        img = "roof",
        type = "submenu",
        items = addMod(vehicle, 10, true, modifyMenu.customization.roof)
    }

    modMenu[1].items["Horn"] = {
        img = "horn",
        type = "submenu",
        items = addMod(vehicle, 14, true, modifyMenu.customization.horn)
    }

    modMenu[1].items["Engine Block"] = {
        img = "engine_block",
        type = "submenu",
        items = addMod(vehicle, 39, true, modifyMenu.customization.engine_block)
    }

    modMenu[1].items["Air Filters"] = {
        img = "air_filters",
        type = "submenu",
        items = addMod(vehicle, 40, true, modifyMenu.customization.air_filters)
    }

    modMenu[1].items["Struts"] = {
        img = "struts",
        type = "submenu",
        items = addMod(vehicle, 41, true, modifyMenu.customization.struts)
    }

    modMenu[1].items["License"] = {
        img = "license_plate",
        type = "submenu",
        items = addMod(vehicle, "plates", true, modifyMenu.customization.license_plate)
    }

    modMenu[1].items["Plate Holders"] = {
        img = "plate_holders",
        type = "submenu",
        items = addMod(vehicle, 25, true, modifyMenu.customization.plate_holders)
    }

    modMenu[1].items["Vanity Plates"] = {
        img = "vanity_plates",
        type = "submenu",
        items = addMod(vehicle, 26, true, modifyMenu.customization.vanity_plates)
    }

    modMenu[1].items["Headlights"] = {
        img = "headlights",
        type = "submenu",
        items = addMod(vehicle, 22, false, modifyMenu.customization.headlights)
    }

    if fbumper then
        modMenu[1].items["Front Bumper"] = {
            img = "front_bumper",
            type = "submenu",
            items = addMod(vehicle, 1, true, modifyMenu.customization.front_bumper)
        }
    end

    if rbumper then
        modMenu[1].items["Rear Bumper"] = {
            img = "rear_bumper",
            type = "submenu",
            items = addMod(vehicle, 2, true, modifyMenu.customization.rear_bumper)
        }
    end

    if chassis then
        modMenu[1].items["Arch Cover"] = {
            img = "arch_cover",
            type = "submenu",
            items = addMod(vehicle, 42, true, modifyMenu.customization.arch_cover)
        }

        modMenu[1].items["Aerials"] = {
            img = "aerials",
            type = "submenu",
            items = addMod(vehicle, 43, true, modifyMenu.customization.aerials)
        }

        modMenu[1].items["Trim"] = {
            img = "trim",
            type = "submenu",
            items = addMod(vehicle, 44, true, modifyMenu.customization.trim)
        }

        modMenu[1].items["Tank"] = {
            img = "tank",
            type = "submenu",
            items = addMod(vehicle, 45, true, modifyMenu.customization.tank)
        }

        modMenu[1].items["Windows"] = {
            img = "windows",
            type = "submenu",
            items = addMod(vehicle, 46, true, modifyMenu.customization.windows)
        }

        modMenu[1].items["Frame"] = {
            img = "frame",
            type = "submenu",
            items = addMod(vehicle, 5, true, modifyMenu.customization.frame)
        }
    end

    modMenu[2].items["Headlight Color"] = {
        img = "headlights",
        type = "submenu",
        items = addMod(vehicle, "headlight_color", true, modifyMenu.cosmetic.headlight_color)
    }
    modMenu[2].items["Livery"] = {
        img = "livery",
        type = "submenu",
        items = addMod(vehicle, "livery", true, modifyMenu.cosmetic.livery)
    }
    modMenu[2].items["Neon"] = {
        img = "neon",
        type = "submenu",
        items = addMod(vehicle, "neon", true, modifyMenu.cosmetic.neon)
    }
    modMenu[2].items["Window Tint"] = {
        img = "window_tint",
        type = "submenu",
        items = addMod(vehicle, "window_tint", true, modifyMenu.cosmetic.window_tint)
    }
    modMenu[2].items["Tire Smoke"] = {
        img = "tire_smoke",
        type = "submenu",
        items = addMod(vehicle, "tire_smoke", true, modifyMenu.cosmetic.tire_smoke)
    }
    
    if interior then
        modMenu[2].items["Trim Design"] = {
            img = "interior",
            type = "submenu",
            items = addMod(vehicle, 27, true, modifyMenu.cosmetic.trim_design)
        }
        modMenu[2].items["Ornaments"] = {
            img = "ornaments",
            type = "submenu",
            items = addMod(vehicle, 28, true, modifyMenu.cosmetic.ornaments)
        }
        modMenu[2].items["Dashboard"] = {
            img = "dashboard",
            type = "submenu",
            items = addMod(vehicle, 29, true, modifyMenu.cosmetic.dashboard)
        }
        modMenu[2].items["Dial Design"] = {
            img = "dial",
            type = "submenu",
            items = addMod(vehicle, 30, true, modifyMenu.cosmetic.dial_design)
        }
        modMenu[2].items["Door Speaker"] = {
            img = "speaker",
            type = "submenu",
            items = addMod(vehicle, 31, true, modifyMenu.cosmetic.door_speaker)
        }
        modMenu[2].items["Seats"] = {
            img = "seats",
            type = "submenu",
            items = addMod(vehicle, 32, true, modifyMenu.cosmetic.seats)
        }
        modMenu[2].items["Steering Wheels"] = {
            img = "cosmetic",
            type = "submenu",
            items = addMod(vehicle, 33, true, modifyMenu.cosmetic.steering_wheels)
        }
        modMenu[2].items["Shifter leavers"] = {
            img = "shifter_leavers",
            type = "submenu",
            items = addMod(vehicle, 34, true, modifyMenu.cosmetic.shifter_leavers)
        }
        modMenu[2].items["Plaques"] = {
            img = "plaques",
            type = "submenu",
            items = addMod(vehicle, 35, true, modifyMenu.cosmetic.plaques)
        }
        modMenu[2].items["Speakers"] = {
            img = "speaker",
            type = "submenu",
            items = addMod(vehicle, 36, true, modifyMenu.cosmetic.speakers)
        }
        modMenu[2].items["Trunk"] = {
            img = "trunk",
            type = "submenu",
            items = addMod(vehicle, 37, true, modifyMenu.cosmetic.trunk)
        }
    end

    if isBike then
        modMenu[4].items["Front Wheels"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 6,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }  
        modMenu[4].items["Back Wheels"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 6,
            items = addMod(vehicle, 24, true, modifyMenu.cosmetic.wheels)
        }   
    else
        modMenu[4].items["Sports"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 0,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Muscle"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 1,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Lowrider"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 2,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["SUV"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 3,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Offroad"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 4,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Tuner"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 5,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["High End"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 7,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Benny's (1)"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 8,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Benny's (2)"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 9,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Open Wheel"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 10,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Street"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 11,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
        modMenu[4].items["Track"] = {
            img = "wheel",
            type = "submenu",
            wheelType = 12,
            items = addMod(vehicle, 23, true, modifyMenu.cosmetic.wheels)
        }
    end

    if not isBike and isIllegalMechanic then
        modMenu[7].items["Vehicle Traction"] = {
            img = "all_wheel",
            type = "submenu",
            items = addMod(vehicle, "vehicle_traction", true, modifyMenu.tuning.vehicle_traction)
        }
        modMenu[7].items["Tuner Chip"] = {
            img = "chip",
            type = "submenu",
            items = addMod(vehicle, "tuner_chip", true, modifyMenu.tuning.tuner_chip)
        }
        modMenu[7].items["Nitro"] = {
            img = "nitro",
            type = "submenu",
            items = addMod(vehicle, "nitro", true, modifyMenu.tuning.nitro)
        }
        modMenu[7].items["Exhausts"] = {
            img = "popcorn",
            type = "submenu",
            items = addMod(vehicle, "popcorn", true, modifyMenu.tuning.popcorn)
        }
    end

    return modMenu
end

loadExtraMenu = function(vehicle)
    local modMenu = {}
    local modifyMenu = Config.Menus
    local dummy = {}

    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            dummy[#dummy + 1] = { modId = "extra", label = ("Extra %s"):format(i), mod = i, price = Config.Menus.extras.price}
            if IsVehicleExtraTurnedOn(vehicle, i) then
                dummy[#dummy].attached = true
            end
        end
    end
    
    modMenu[1] = {
        label = "Vehicle Customization",
        img = "vehicle",
        type = "main",
        items = {}
    }

    modMenu[2] = {
        label = "Vehicle Cosmetics",
        img = "cosmetic",
        type = "main",
        items = {}
    }

    if next(dummy) then
        modMenu[1].items["Extras"] = {
            img = "extra",
            type = "submenu",
            items = dummy
        }
    end

    modMenu[2].items["Livery"] = {
        img = "livery",
        type = "submenu",
        items = addMod(vehicle, 48, true, modifyMenu.cosmetic.livery)
    }

    return modMenu

end

getVehicleFitment = function(vehicle)
    local dummy = {}
    dummy["wheels-width"] = GetVehicleWheelWidth(vehicle)
    dummy["front-left"] = GetVehicleWheelXOffset(vehicle, 0)
    dummy["front-right"] = GetVehicleWheelXOffset(vehicle, 1)
    dummy["rear-left"] = GetVehicleWheelXOffset(vehicle, 2)
    dummy["rear-right"] = GetVehicleWheelXOffset(vehicle, 3)
    dummy["front-left-camber"] = GetVehicleWheelYRotation(vehicle, 0)
    dummy["front-right-camber"] = GetVehicleWheelYRotation(vehicle, 1)
    dummy["rear-left-camber"] = GetVehicleWheelYRotation(vehicle, 2)
    dummy["rear-right-camber"] = GetVehicleWheelYRotation(vehicle, 3)
    currentFitmentData = dummy
    return dummy
end

openMechanicMenu = function(state, vehicle)
    
    if not colorsLoaded then
        SendNUIMessage({
            type = "COLORS",
            colors = {
                defaultColors = {
                    {name = "Black", colorindex = 0, hex = "#0d1116"},
                    {name = "Carbon Black", colorindex = 147, "#11141a"},
                    {name = "Hraphite", colorindex = 1, hex = "#1c1d21"},
                    {name = "Anhracite Black", colorindex = 11, hex = "#1d2129"},
                    {name = "Black Steel", colorindex = 2, hex = "#32383d"},
                    {name = "Dark Steel", colorindex = 3, hex = "#454b4f"},
                    {name = "Silver", colorindex = 4, hex = "#999da0"},
                    {name = "Bluish Silver", colorindex = 5, hex = "#c2c4c6"},
                    {name = "Rolled Steel", colorindex = 6, hex = "#979a97"},
                    {name = "Shadow Silver", colorindex = 7, hex = "#637380"},
                    {name = "Stone Silver", colorindex = 8, hex = "#63625c"},
                    {name = "Midnight Silver", colorindex = 9, hex = "#3c3f47"},
                    {name = "Cast Iron Silver", colorindex = 10, hex = "#444e54"},
                    {name = "Red", colorindex = 27, hex = "#c00e1a"},
                    {name = "Torino Red", colorindex = 28, hex = "#da1918"},
                    -- {name = "Formula Red", colorindex = 29, hex = "#b6111b"},
                    {name = "Lava Red", colorindex = 150, hex = "#bc1917"},
                    {name = "Blaze Red", colorindex = 30, hex = "#a51e23"},
                    {name = "Grace Red", colorindex = 31, hex = "#7b1a22"},
                    {name = "Garnet Red", colorindex = 32, hex = "#8e1b1f"},
                    {name = "Sunset Red", colorindex = 33, hex = "#6f1818"},
                    {name = "Cabernet Red", colorindex = 34, hex = "#49111d"},
                    {name = "Wine Red", colorindex = 143, hex = "#0e0d14"},
                    {name = "Candy Red", colorindex = 35, hex = "#b60f25"},
                    {name = "Hot Pink", colorindex = 135, hex = "#f21f99"},
                    -- {name = "Pfsiter Pink", colorindex = 137, hex = "#df5891"},
                    -- {name = "Salmon Pink", colorindex = 136, hex = "#fdd6cd"},
                    {name = "Sunrise Orange", colorindex = 36, hex = "#d44a17"},
                    {name = "Orange", colorindex = 38, hex = "#f78616"},
                    -- {name = "Bright Orange", colorindex = 138, hex = "#f6ae20"},
                    {name = "Gold", colorindex = 99, hex = "#ac9975"},
                    {name = "Bronze", colorindex = 90, hex = "#916532"},
                    {name = "Yellow", colorindex = 88, hex = "#ffcf20"},
                    {name = "Race Yellow", colorindex = 89, hex = "#fbe212"},
                    -- {name = "Dew Yellow", colorindex = 91, hex = "#e0e13d"},
                    {name = "Dark Green", colorindex = 49, hex = "#132428"},
                    {name = "Racing Green", colorindex = 50, hex = "#122e2b"},
                    {name = "Sea Green", colorindex = 51, hex = "#12383c"},
                    {name = "Olive Green", colorindex = 52, hex = "#31423f"},
                    {name = "Bright Green", colorindex = 53, hex = "#155c2d"},
                    -- {name = "Gasoline Green", colorindex = 54, hex = "#1b6770"},
                    {name = "Lime Green", colorindex = 92, hex = "#98d223"},
                    -- {name = "Midnight Blue", colorindex = 141, hex = "#0a0c17"},
                    -- {name = "Galaxy Blue", colorindex = 61, hex = "#222e46"},
                    -- {name = "Dark Blue", colorindex = 62, hex = "#233155"},
                    -- {name = "Saxon Blue", colorindex = 63, hex = "#304c7e"},
                    -- {name = "Blue", colorindex = 64, hex = "#47578f"},
                    -- {name = "Mariner Blue", colorindex = 65, hex = "#637ba7"},
                    -- {name = "Harbor Blue", colorindex = 66, hex = "#394762"},
                    -- {name = "Diamond Blue", colorindex = 67, hex = "#d6e7f1"},
                    -- {name = "Surf Blue", colorindex = 68, hex = "#76afbe"},
                    -- {name = "Nautical Blue", colorindex = 69, hex = "#345e72"},
                    {name = "Racing Blue", colorindex = 73, hex = "#2354a1"},
                    {name = "Ultra Blue", colorindex = 70, hex = "#0b9cf1"},
                    {name = "Light Blue", colorindex = 74, hex = "#6ea3c6"},
                    -- {name = "Chocolate Brown", colorindex = 96, hex = "#221b19"},
                    -- {name = "Bison Brown", colorindex = 101, hex = "#402e2b"},
                    -- {name = "Creeen Brown", colorindex = 95, hex = "#473f2b"},
                    -- {name = "Feltzer Brown", colorindex = 94, hex = "#503218"},
                    -- {name = "Maple Brown", colorindex = 97, hex = "#653f23"},
                    {name = "Beechwood Brown", colorindex = 103, hex = "#46231a"},
                    {name = "Sienna Brown", colorindex = 104, hex = "#752b19"},
                    -- {name = "Saddle Brown", colorindex = 98, hex = "#775c3e"},
                    -- {name = "Moss Brown", colorindex = 100, hex = "#6c6b4b"},
                    -- {name = "Woodbeech Brown", colorindex = 102, hex = "#a4965f"},
                    -- {name = "Straw Brown", colorindex = 99, hex = "#ac9975"},
                    -- {name = "Sandy Brown", colorindex = 105, hex = "#bfae7b"},
                    -- {name = "Bleached Brown", colorindex = 106, hex = "#dfd5b2"},
                    -- {name = "Schafter Purple", colorindex = 71, hex = "#2f2d52"},
                    -- {name = "Spinnaker Purple", colorindex = 72, hex = "#282c4d"},
                    -- {name = "Midnight Purple", colorindex = 142, hex = "#0c0d18"},
                    -- {name = "Bright Purple", colorindex = 145, hex = "#621276"},
                    -- {name = "Cream", colorindex = 107, hex = "#f7edd5"},
                    -- {name = "Ice White", colorindex = 111, hex = "#fffff6"},
                    -- {name = "Frost White", colorindex = 112, hex = "#eaeaea"}
                },
                metallicColors = {
                    {name = "Black", colorindex = 0, hex = "#0d1116"},
                    {name = "Carbon Black", colorindex = 147, "#11141a"},
                    {name = "Hraphite", colorindex = 1, hex = "#1c1d21"},
                    {name = "Anhracite Black", colorindex = 11, hex = "#1d2129"},
                    {name = "Black Steel", colorindex = 2, hex = "#32383d"},
                    {name = "Dark Steel", colorindex = 3, hex = "#454b4f"},
                    {name = "Silver", colorindex = 4, hex = "#999da0"},
                    {name = "Bluish Silver", colorindex = 5, hex = "#c2c4c6"},
                    {name = "Rolled Steel", colorindex = 6, hex = "#979a97"},
                    {name = "Shadow Silver", colorindex = 7, hex = "#637380"},
                    {name = "Stone Silver", colorindex = 8, hex = "#63625c"},
                    {name = "Midnight Silver", colorindex = 9, hex = "#3c3f47"},
                    {name = "Cast Iron Silver", colorindex = 10, hex = "#444e54"},
                    {name = "Red", colorindex = 27, hex = "#c00e1a"},
                    {name = "Torino Red", colorindex = 28, hex = "#da1918"},
                    {name = "Formula Red", colorindex = 29, hex = "#b6111b"},
                    {name = "Lava Red", colorindex = 150, hex = "#bc1917"},
                    {name = "Blaze Red", colorindex = 30, hex = "#a51e23"},
                    {name = "Grace Red", colorindex = 31, hex = "#7b1a22"},
                    {name = "Garnet Red", colorindex = 32, hex = "#8e1b1f"},
                    {name = "Sunset Red", colorindex = 33, hex = "#6f1818"},
                    {name = "Cabernet Red", colorindex = 34, hex = "#49111d"},
                    {name = "Wine Red", colorindex = 143, hex = "#0e0d14"},
                    {name = "Candy Red", colorindex = 35, hex = "#b60f25"},
                    {name = "Hot Pink", colorindex = 135, hex = "#f21f99"},
                    {name = "Pfsiter Pink", colorindex = 137, hex = "#df5891"},
                    {name = "Salmon Pink", colorindex = 136, hex = "#fdd6cd"},
                    {name = "Sunrise Orange", colorindex = 36, hex = "#d44a17"},
                    {name = "Orange", colorindex = 38, hex = "#f78616"},
                    {name = "Bright Orange", colorindex = 138, hex = "#f6ae20"},
                    {name = "Gold", colorindex = 99, hex = "#ac9975"},
                    {name = "Bronze", colorindex = 90, hex = "#916532"},
                    {name = "Yellow", colorindex = 88, hex = "#ffcf20"},
                    {name = "Race Yellow", colorindex = 89, hex = "#fbe212"},
                    {name = "Dew Yellow", colorindex = 91, hex = "#e0e13d"},
                    {name = "Dark Green", colorindex = 49, hex = "#132428"},
                    {name = "Racing Green", colorindex = 50, hex = "#122e2b"},
                    {name = "Sea Green", colorindex = 51, hex = "#12383c"},
                    {name = "Olive Green", colorindex = 52, hex = "#31423f"},
                    {name = "Bright Green", colorindex = 53, hex = "#155c2d"},
                    {name = "Gasoline Green", colorindex = 54, hex = "#1b6770"},
                    {name = "Lime Green", colorindex = 92, hex = "#98d223"},
                    {name = "Midnight Blue", colorindex = 141, hex = "#0a0c17"},
                    {name = "Galaxy Blue", colorindex = 61, hex = "#222e46"},
                    {name = "Dark Blue", colorindex = 62, hex = "#233155"},
                    {name = "Saxon Blue", colorindex = 63, hex = "#304c7e"},
                    {name = "Blue", colorindex = 64, hex = "#47578f"},
                    {name = "Mariner Blue", colorindex = 65, hex = "#637ba7"},
                    {name = "Harbor Blue", colorindex = 66, hex = "#394762"},
                    {name = "Diamond Blue", colorindex = 67, hex = "#d6e7f1"},
                    {name = "Surf Blue", colorindex = 68, hex = "#76afbe"},


                },
                matteColors = {
                    {name = "Black", colorindex = 12, hex = "#13181f"},
                    {name = "Gray", colorindex = 13, hex = "#26282a"},
                    {name = "Light Gray", colorindex = 14, hex = "#515554"},
                    {name = "Ice White", colorindex = 131, hex = "#fcf9f1"},
                    {name = "Blue", colorindex = 83, hex = "#253aa7"},
                    {name = "Dark Blue", colorindex = 82, hex = "#1f2852"},
                    {name = "Midnight Blue", colorindex = 84, hex = "#1c3551"},
                    {name = "Midnight Purple", colorindex = 149, hex = "#1e1d22"},
                    {name = "Schafter Purple", colorindex = 148, hex = "#6b1f7b"},
                    {name = "Red", colorindex = 39, hex = "#cf1f21"},
                    {name = "Dark Red", colorindex = 40, hex = "#732021"},
                    {name = "Orange", colorindex = 41, hex = "#f27d20"},
                    {name = "Yellow", colorindex = 42, hex = "#ffc91f"},
                    {name = "Lime Green", colorindex = 55, hex = "#66b81f"},
                    {name = "Green", colorindex = 128, hex = "#4e6443"},
                    {name = "Frost Green", colorindex = 151, hex = "#2d362a"},
                    {name = "Foliage Green", colorindex = 155, hex = "#5a6352"},
                    {name = "Olive Darb", colorindex = 152, hex = "#696748"},
                    {name = "Dark Earth", colorindex = 153, hex = "#7a6c55"},
                    {name = "Desert Tan", colorindex = 154, hex = "#c3b492"}
                },
                metalColors = {
                    {name = "Brushed Steel", colorindex = 117, hex = "#6a747c"},
                    {name = "Brushed Black Steel", colorindex = 118, "#354158"},
                    {name = "Brushed Aluminum", colorindex = 119, hex = "#9ba0a8"},
                    {name = "Pure Gold", colorindex = 158, hex = "#7a6440"},
                    {name = "Brushed Gold", colorindex = 159, hex = "#7f6a48"}
                },
                pearlescentColors = {
                    {name = "Black", colorindex = 0, hex = "#0d1116"},
                    {name = "Carbon Black", colorindex = 147, "#11141a"},
                    {name = "Hraphite", colorindex = 1, hex = "#1c1d21"},
                    {name = "Anhracite Black", colorindex = 11, hex = "#1d2129"},
                    {name = "Black Steel", colorindex = 2, hex = "#32383d"},
                    {name = "Dark Steel", colorindex = 3, hex = "#454b4f"},
                    {name = "Silver", colorindex = 4, hex = "#999da0"},
                    {name = "Bluish Silver", colorindex = 5, hex = "#c2c4c6"},
                    {name = "Rolled Steel", colorindex = 6, hex = "#979a97"},
                    {name = "Shadow Silver", colorindex = 7, hex = "#637380"},
                    {name = "Stone Silver", colorindex = 8, hex = "#63625c"},
                    {name = "Midnight Silver", colorindex = 9, hex = "#3c3f47"},
                    {name = "Cast Iron Silver", colorindex = 10, hex = "#444e54"},
                    {name = "Red", colorindex = 27, hex = "#c00e1a"},
                    {name = "Torino Red", colorindex = 28, hex = "#da1918"},
                    {name = "Formula Red", colorindex = 29, hex = "#b6111b"},
                    {name = "Lava Red", colorindex = 150, hex = "#bc1917"},
                    {name = "Blaze Red", colorindex = 30, hex = "#a51e23"},
                    {name = "Grace Red", colorindex = 31, hex = "#7b1a22"},
                    {name = "Garnet Red", colorindex = 32, hex = "#8e1b1f"},
                    {name = "Sunset Red", colorindex = 33, hex = "#6f1818"},
                    {name = "Cabernet Red", colorindex = 34, hex = "#49111d"},
                    {name = "Wine Red", colorindex = 143, hex = "#0e0d14"},
                    {name = "Candy Red", colorindex = 35, hex = "#b60f25"},
                    {name = "Hot Pink", colorindex = 135, hex = "#f21f99"},
                    {name = "Pfsiter Pink", colorindex = 137, hex = "#df5891"},
                    {name = "Salmon Pink", colorindex = 136, hex = "#fdd6cd"},
                    {name = "Sunrise Orange", colorindex = 36, hex = "#d44a17"},
                    {name = "Orange", colorindex = 38, hex = "#f78616"},
                    {name = "Bright Orange", colorindex = 138, hex = "#f6ae20"},
                    {name = "Gold", colorindex = 99, hex = "#ac9975"},
                    {name = "Bronze", colorindex = 90, hex = "#916532"},
                    {name = "Yellow", colorindex = 88, hex = "#ffcf20"},
                    {name = "Race Yellow", colorindex = 89, hex = "#fbe212"},
                    {name = "Dew Yellow", colorindex = 91, hex = "#e0e13d"},
                    {name = "Dark Green", colorindex = 49, hex = "#132428"},
                    {name = "Racing Green", colorindex = 50, hex = "#122e2b"},
                    {name = "Sea Green", colorindex = 51, hex = "#12383c"},
                    {name = "Olive Green", colorindex = 52, hex = "#31423f"},
                    {name = "Bright Green", colorindex = 53, hex = "#155c2d"},
                    {name = "Gasoline Green", colorindex = 54, hex = "#1b6770"},
                    {name = "Lime Green", colorindex = 92, hex = "#98d223"},
                    {name = "Midnight Blue", colorindex = 141, hex = "#0a0c17"},
                    {name = "Galaxy Blue", colorindex = 61, hex = "#222e46"},
                    {name = "Dark Blue", colorindex = 62, hex = "#233155"},

                },
                chameleonColors = {
                    {name = "Monochrome", colorindex = 223},
                    {name = "Night & Day", colorindex = 224},
                    {name = "The Verlierer", colorindex = 225},
                    {name = "Sprunk Extreme", colorindex = 226},
                    {name = "Vice City", colorindex = 227},
                    {name = "Synthwave Nights", colorindex = 228},
                    {name = "Four Seasons", colorindex = 229},
                    {name = "Maisonette 9 Throwback", colorindex = 230},
                    {name = "Bubblegum", colorindex = 231},
                    {name = "Full Rainbow", colorindex = 232},
                    {name = "Sunset", colorindex = 233},
                    {name = "The Seven", colorindex = 234},
                    {name = "Kamen Rider", colorindex = 235},
                    {name = "Chromatic Aberration", colorindex = 236},
                    {name = "It's Christmas!", colorindex = 237},
                    {name = "Temperature", colorindex = 238}
                },
                chromeColors = {
                    {name = "Chrome", colorindex = 120, hex = "#5870a1" }
                }
            }
        })
        SendNUIMessage({
            type = "SET_PRICES",
            price = Config.Menus.paintBooth
        })
        colorsLoaded = true
    end
    getVehicleFitment(vehicle)
    currentMods = getVehicleProperties(vehicle)
    currentModData = getVehicleProperties(vehicle)
    currentWheelType = GetVehicleWheelType(vehicle)
    firstWheelType = GetVehicleWheelType(vehicle)
    SendNUIMessage({
        type = "OPEN_MENU",
        state = state,
        modMenu = loadMods(vehicle),
    })
    FreezeEntityPosition(vehicle, true)
    SetNuiFocus(state, false)
end

openExtraMenu = function(state, vehicle)
    currentModData = getVehicleProperties(vehicle)
    SendNUIMessage({
        type = "OPEN_MENU",
        state = state,
        modMenu = loadExtraMenu(vehicle),
    })
    SetNuiFocus(state, false)
end

RegisterNUICallback("cursorState", function(data, cbj)
    SetNuiFocus(true, data.cursor)
    
    if data.type == "color" then
        applySavedColors()
    end
    
    cbj("ok")
end)
RegisterNUICallback("disableCamera", function(data, cbj)
    for k,v in pairs(partData) do
        if DoesCamExist(v.camera) then
            SetCamActive(v.camera, false)
            DestroyCam(v.camera)
        end
    end
    RenderScriptCams(false, false, 500, false, false)
    DestroyAllCams()
    cbj("ok")
end)

RegisterNUICallback("rotateCamera", function(data, cbj)
    if data.objectId == 3 then
        data.component = "wheels"
    end

    if not data.component and data.menu == "menu" or data.menu == "submenu" then
        rotateCam("main")
        return cbj("ok")
    end

    if data.component then
        rotateCam(string.lower(data.component))
        return cbj("ok")
    end

    cbj("ok")
end)


RegisterNUICallback("addShopItem", function(data, cbj)
    --print(data.modId)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if data.modId == 23 then
        currentWheelType = GetVehicleWheelType(vehicle)
    end
    if data.modId == "plates" then
        SetVehicleNumberPlateTextIndex(vehicle, data.mod)
    elseif data.modId == 22 then 
        ToggleVehicleMod(vehicle, 22, (not IsToggleModOn(vehicle, 22)))

    elseif data.modId == "headlight_color" then
        --print("headlight color"..data.mod)
        --print(type(data.mod))
        SetVehicleXenonLightsColor(vehicle, data.mod)
    elseif data.modId == "window_tint" then
        SetVehicleWindowTint(vehicle, data.mod)
    elseif data.modId == "neon" then
        -- if data.mod == 4 then
        --     for i = 0, 3 do
        --         SetVehicleNeonLightEnabled(vehicle, i, false)
        --     end
        -- end
        SetVehicleNeonLightEnabled(vehicle, data.mod, true)
    elseif data.modId == "livery" and useCountLivery then
        SetVehicleLivery(vehicle, data.mod)
    else
        if data.modId == "livery" then
            data.modId = 48
        end
        SetVehicleMod(vehicle, data.modId, data.mod)
    end
    cartMods[tostring(data.modId)] = data.mod
    if data.modId == "extra" then
        cbj(loadExtraMenu(vehicle))
    else
        return cbj(loadMods(vehicle))
    end
end)

RegisterNUICallback("deleteShopItem", function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

    cartMods[tostring(data.modId)] = nil
    setVehicleProperties(vehicle, currentMods)
    for modId, mod in pairs(cartMods) do
        if modId == "plates" then
            SetVehicleNumberPlateTextIndex(vehicle, mod)
        elseif data.modId == 22 then 
            ToggleVehicleMod(vehicle, 22, (not IsToggleModOn(vehicle, 22)))
        elseif modId == "headlight_color" then
            
            SetVehicleXenonLightsColor(vehicle, mod)
        elseif modId == "window_tint" then
            -- -- --print(mod, "window tint")
            -- -- --print(data.modId)
            SetVehicleWindowTint(vehicle, mod)
        elseif modId == "neon" then
            if mod == 4 then
                for i = 0, 3 do
                    SetVehicleNeonLightEnabled(vehicle, i, false)
                end
            end
            SetVehicleNeonLightEnabled(vehicle, mod, true)
        elseif modId == "livery" and useCountLivery then
            SetVehicleLivery(vehicle, mod)
        else
            if modId == "livery" then
                modId = 48
            end
            SetVehicleMod(vehicle, tonumber(modId), mod)
        end
    end
    cbj("ok")
end)



RegisterNUICallback("buyComponent", function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local vehPlate = trim(GetVehicleNumberPlateText(vehicle))
    if data.component.modId == "extra" and IsVehicleExtraTurnedOn(vehicle, data.component.mod) then
        if IsVehicleExtraTurnedOn(vehicle, data.component.mod) then
            SetVehicleExtra(vehicle, data.component.mod, true)
            currentModData = getVehicleProperties(vehicle)
            return cbj(loadExtraMenu(vehicle))
        end
    end
    TriggerCallback("0r-mechanic:server:buyComponent", function(result)
        if not result.status then
            return cbj(false)
        end

        data.plate = vehPlate

        if data.component.modId == 18 then
            ToggleVehicleMod(vehicle, 18, (not IsToggleModOn(vehicle, 18)))
        elseif data.component.modId == "neon" then
            --print(data.component.mod, " kanka bu neon light")
            SetVehicleNeonLightEnabled(vehicle, data.component.mod, true)
        elseif data.component.modId == 22 then
            ToggleVehicleMod(vehicle, 22, (not IsToggleModOn(vehicle, 22)))
        elseif data.component.modId == "plates" then
            SetVehicleNumberPlateTextIndex(vehicle, data.component.mod)
        elseif data.component.modId == "headlight_color" then
            SetVehicleXenonLightsColor(vehicle, data.component.mod)
        elseif data.component.modId == "window_tint" then
            SetVehicleWindowTint(vehicle, data.component.mod)
        elseif data.component.modId == "tire_smoke" then
            ToggleVehicleMod(vehicle, 20, (not IsToggleModOn(vehicle, 20)))
            SetVehicleTyreSmokeColor(vehicle, 255, 255, 255)
        elseif data.component.modId == "vehicle_traction" then
            setVehicleTraction(vehicle, data.component.mod)
            TriggerServerEvent("0r-mechanic:server:addElement", data.component.modId, data)
        elseif data.component.modId == "tuner_chip" then
            setVehicleTunerChip(vehicle, data.component.mod)
            TriggerServerEvent("0r-mechanic:server:addElement", data.component.modId, data)
        elseif data.component.modId == "nitro" then
            TriggerServerEvent("0r-mechanic:server:addElement", data.component.modId, data)
        elseif data.component.modId == "popcorn" then
            TriggerServerEvent("0r-mechanic:server:addElement", data.component.modId, data)
        elseif data.component.modId == "extra" then
            if IsVehicleExtraTurnedOn(vehicle, data.component.mod) then
                SetVehicleExtra(vehicle, data.component.mod, true)
            else
                SetVehicleExtra(vehicle, data.component.mod, false)
            end
        elseif data.component.modId == "livery" and useCountLivery then
            SetVehicleLivery(vehicle, data.component.mod)
        else
            if data.component.modId == "livery" then
                data.component.modId = 48
            end
            SetVehicleMod(vehicle, data.component.modId, data.component.mod)
        end

        currentModData = getVehicleProperties(vehicle)

        SendNUIMessage({
            type = "SOUND",
            sound = "wrench",
        })

        if data.component.modId == "extra" then
            cbj(loadExtraMenu(vehicle))
        else
            return cbj(loadMods(vehicle))
        end
        
    end, { 
        price = data.component.price, 
        currentMechanic = currentMechanic,
    })
end)


RegisterNUICallback("applyFitment", function(dt, cbj)
    TriggerCallback("0r-mechanic:server:buyComponent", function(result)
        if not result.status then
            return cbj(false)
        end

        local vehicle = GetVehiclePedIsUsing(PlayerPedId())
        local vehPlate = trim(GetVehicleNumberPlateText(vehicle))
        local data = {
            plate = vehPlate,
            fitment = getVehicleFitment(vehicle)
        }

        SendNUIMessage({
            type = "SOUND",
            sound = "wrench",
        })

        TriggerServerEvent("0r-mechanic:server:syncFitment", NetworkGetNetworkIdFromEntity(vehicle), getVehicleFitment(vehicle))
        TriggerServerEvent("0r-mechanic:server:addElement", "fitment", data)
    end, { 
        price = Config.Menus.fitment.price, 
        currentMechanic = currentMechanic,
    })
    cbj("ok")
end)

RegisterNUICallback("repairVehicle", function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

	WashDecalsFromVehicle(vehicle, 1.0)
	SetVehicleDirtLevel(vehicle)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleEngineHealth(vehicle, 1000.0) 
    SetVehiclePetrolTankHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    cbj("ok")
end)


function applySavedColors()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle and vehicle ~= 0 and savedColorState then
        if type(savedColorState.primaryColor) == "table" then
            SetVehicleCustomPrimaryColour(vehicle, table.unpack(savedColorState.primaryColor))
        else
            SetVehicleColours(vehicle, savedColorState.primaryColor, savedColorState.secondaryColor)
        end

        if type(savedColorState.secondaryColor) == "table" then
            SetVehicleCustomSecondaryColour(vehicle, table.unpack(savedColorState.secondaryColor))
        else
            SetVehicleColours(vehicle, savedColorState.primaryColor, savedColorState.secondaryColor)
        end

        SetVehicleExtraColours(vehicle, savedColorState.pearlescentColor, savedColorState.wheelColor)
        SetVehicleDashboardColour(vehicle, savedColorState.dashboardColor)
        SetVehicleTyreSmokeColor(vehicle, table.unpack(savedColorState.tyreSmokeColor))

        -- --print("Araç renkleri geri yüklendi.")
    else
        -- --print("Araç bulunamadı veya renk bilgisi yok.")
    end
end

RegisterNUICallback("colorState", function(data, cb)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle and vehicle ~= 0 then
        local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

        if GetIsVehiclePrimaryColourCustom(vehicle) then
            local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
            colorPrimary = {r, g, b}
        end

        if GetIsVehicleSecondaryColourCustom(vehicle) then
            local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
            colorSecondary = {r, g, b}
        end

        savedColorState = {
            primaryColor = colorPrimary,
            secondaryColor = colorSecondary,
            pearlescentColor = pearlescentColor,
            dashboardColor = GetVehicleDashboardColour(vehicle),
            wheelColor = wheelColor,
            tyreSmokeColor = {GetVehicleTyreSmokeColor(vehicle)},
        }

        cb(savedColorState)
    else
        cb({})
    end
end)

SetColorDefault = function(vehicle)
    setVehicleProperties(vehicle, currentMods)
    SetVehicleWheelType(vehicle, currentWheelType)
    
end
RegisterNUICallback("buyColor", function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local priceList = Config.Menus.paintBooth
    local colorPrice = priceList.color
    local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

    if GetIsVehiclePrimaryColourCustom(vehicle) then
        local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
        colorPrimary = {r, g, b}
    end

    if GetIsVehicleSecondaryColourCustom(vehicle) then
        local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
        colorSecondary = {r, g, b}
    end
    if data.type.first == "Chameleon" then
        colorPrice = priceList.chameleon
    elseif data.type.second == "Pearlescent" then
        colorPrice = priceList.pearlescent
    elseif data.type.second == "Chrome" then
        colorPrice = priceList.chrome
    elseif data.type.first == "Neon Color" then
        colorPrice = priceList.neon
    elseif data.type.first == "Smoke Color" then
        colorPrice = priceList.smoke
    elseif data.type.first == "Wheel Color" then
        colorPrice = priceList.wheel
    end
    TriggerCallback("0r-mechanic:server:buyComponent", function(result)
        if not result.status then
            return cbj(false)
        end
        SendNUIMessage({
            type = "SOUND",
            sound = "respray",
        })
        savedColorState = {
            primaryColor = colorPrimary,
            secondaryColor = colorSecondary,
            pearlescentColor = pearlescentColor,
            dashboardColor = GetVehicleDashboardColour(vehicle),
            wheelColor = wheelColor,
            tyreSmokeColor = {GetVehicleTyreSmokeColor(vehicle)},
            neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
            headlightColor = GetVehicleHeadlightsColour(vehicle),
            interiorColor = GetVehicleInteriorColour(vehicle),
        }
        setVehicleProperties(vehicle, currentModData)

        if type(savedColorState.primaryColor) == "table" then
            SetVehicleCustomPrimaryColour(vehicle, savedColorState.primaryColor[1], savedColorState.primaryColor[2], savedColorState.primaryColor[3])
        else
            SetVehicleColours(vehicle, savedColorState.primaryColor, savedColorState.secondaryColor)
        end

        if type(savedColorState.secondaryColor) == "table" then
            SetVehicleCustomSecondaryColour(vehicle, savedColorState.secondaryColor[1], savedColorState.secondaryColor[2], savedColorState.secondaryColor[3])
        else
            SetVehicleColours(vehicle, savedColorState.primaryColor, savedColorState.secondaryColor)
        end

        SetVehicleExtraColours(vehicle, savedColorState.pearlescentColor, savedColorState.wheelColor)
        SetVehicleDashboardColour(vehicle, savedColorState.dashboardColor)
        SetVehicleTyreSmokeColor(vehicle, savedColorState.tyreSmokeColor[1], savedColorState.tyreSmokeColor[2], savedColorState.tyreSmokeColor[3])
        SetVehicleNeonLightsColour(vehicle, savedColorState.neonColor[1], savedColorState.neonColor[2], savedColorState.neonColor[3])
        SetVehicleHeadlightsColour(vehicle, savedColorState.headlightColor)
        SetVehicleInteriorColour(vehicle, savedColorState.interiorColor)

        -- currentModData ve currentMods değişkenlerini güncelle
        currentModData = getVehicleProperties(vehicle)
        currentMods = currentModData

        -- Diğer modifikasyonları güncelle
        UpdateMods(vehicle)

    end, { 
        price = colorPrice, 
        currentMechanic = currentMechanic,
    })
    cbj("ok")
end)


UpdateMods = function(vehicle)
    SetVehicleWheelType(vehicle, currentWheelType)
    
    setVehicleProperties(vehicle, currentMods)

    for modId, mod in pairs(cartMods) do
        if modId == "plates" then
            SetVehicleNumberPlateTextIndex(vehicle, mod)
        elseif modId == "headlight_color" then
            SetVehicleXenonLightsColor(vehicle, mod)
        elseif modId == "window_tint" then
            -- -- --print(mod, "window tint")
            -- -- --print(data.modId)
            SetVehicleWindowTint(vehicle, mod)
        elseif modId == "neon" then
            if mod == 4 then
                for i = 0, 3 do
                    SetVehicleNeonLightEnabled(vehicle, i, false)
                end
            end
            SetVehicleNeonLightEnabled(vehicle, mod, true)
        elseif modId == "livery" and useCountLivery then
            SetVehicleLivery(vehicle, mod)
        else
            if modId == "livery" then
                modId = 48
            end
            SetVehicleMod(vehicle, tonumber(modId), mod)
        end
    end
end

RegisterNUICallback('surfItem', function(data, cbj)
    -- -- --print(json.encode(data))
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

    if data.wheelType and data.wheelType ~= "none" then
        -- if data.clear then
        --     UpdateMods(vehicle)
        -- end
        SetVehicleWheelType(vehicle, data.wheelType)
        SetVehicleMod(vehicle,  23, -1)
        return cbj("ok")
    end

    if data.clear then
        UpdateMods(vehicle)
        -- --print("şu an sikiyom")
        for k,v in pairs(currentFitmentData) do
            if k == "wheels-width" then
                SetVehicleWheelWidth(vehicle, v)
            elseif k == "front-left-camber" then
                SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
            elseif k == "front-right-camber" then
                SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
            elseif k == "rear-left-camber" then
                SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
            elseif k == "rear-right-camber" then
                SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
            else
                SetVehicleWheelXOffset(vehicle, fitmentData[k], v)
            end
        end
        return cbj("ok")
    end
    if data.modId == "plates" then
        
        SetVehicleNumberPlateTextIndex(vehicle, data.mod)
    elseif data.modId == 22 then 
        ToggleVehicleMod(vehicle, 22, (not IsToggleModOn(vehicle, 22)))
    elseif data.modId == "headlight_color" then
        SetVehicleXenonLightsColor(vehicle, data.mod)
    elseif data.modId == "window_tint" then
        SetVehicleWindowTint(vehicle, data.mod)
    elseif data.modId == "neon" then
        UpdateMods(vehicle)
        if data.mod == 4 then
            for i = 0, 3 do
                SetVehicleNeonLightEnabled(vehicle, i, false)
            end
        end
        SetVehicleNeonLightEnabled(vehicle, data.mod, true)
    elseif data.modId == "livery" and useCountLivery then
        SetVehicleLivery(vehicle, data.mod)
    else
        if data.modId == "livery" then
            data.modId = 48
        end
        SetVehicleMod(vehicle, data.modId, data.mod)
    end
    
    return cbj("ok")
end)

RegisterNUICallback('changeColor', function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local vehColors = table.pack(GetVehicleColours(vehicle))
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    
    if data.type.first == "Neon Color" then
        return SetVehicleNeonLightsColour(vehicle, data.color.r, data.color.g, data.color.b)
    elseif data.type.first == "Smoke Color" then
        return SetVehicleTyreSmokeColor(vehicle, data.color.r, data.color.g, data.color.b)
    elseif data.type.first == "Wheel Color" then
        return SetVehicleExtraColours(vehicle, pearlescentColor, data.color)
    end
    
    if data.picker then
        if data.type.first == "Primary" then
            return SetVehicleCustomPrimaryColour(vehicle, data.color.r, data.color.g, data.color.b)
        elseif data.type.first == "Secondary" then
            return SetVehicleCustomSecondaryColour(vehicle, data.color.r, data.color.g, data.color.b)
        end
    end

    ClearVehicleCustomPrimaryColour(vehicle)
    ClearVehicleCustomSecondaryColour(vehicle)

    if data.type.first == "Chameleon" then
        return SetVehicleColours(vehicle, data.color, vehColors[2])
    end

    if data.type.second ~= "Pearlescent" then
        return SetVehicleColours(vehicle, data.type.first == "Primary" and data.color or vehColors[1], data.type.first == "Secondary" and data.color or vehColors[2])
    end

    SetVehicleExtraColours(vehicle, data.color, wheelColor)

end)

RegisterNUICallback('changeFitment', function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())

    if data.value == -1 then
        data.value = -1.00
    elseif data.value == 1 then
        data.value = 1.00
    elseif data.value == 0 then
        data.value = 0.00
    end

    if data.type == "wheels-width" then
        SetVehicleWheelWidth(vehicle, data.value)
    elseif data.type == "front-left-camber" then
        SetVehicleWheelYRotation(vehicle, fitmentData[data.type], data.value)
    elseif data.type == "front-right-camber" then
        SetVehicleWheelYRotation(vehicle, fitmentData[data.type], data.value)
    elseif data.type == "rear-left-camber" then
        SetVehicleWheelYRotation(vehicle, fitmentData[data.type], data.value)
    elseif data.type == "rear-right-camber" then
        SetVehicleWheelYRotation(vehicle, fitmentData[data.type], data.value)
    else
        SetVehicleWheelXOffset(vehicle, fitmentData[data.type], data.value)
    end
end)

RegisterNUICallback('getWheelFitment', function(data, cbj)
    cbj(getVehicleFitment(GetVehiclePedIsUsing(PlayerPedId())))
end)


RegisterNUICallback("buyBasket", function(data,cb)
    local retval = nil
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local vehPlate = trim(GetVehicleNumberPlateText(vehicle))
        --print("i bought basket data")
    TriggerCallback("buyBasketData", function(result)
        retval = result.status
        if retval then
            data.plate = vehPlate
            setVehicleProperties(vehicle, currentMods)
            SetVehicleWheelType(vehicle, currentWheelType)
            for modId, mod in pairs(cartMods) do
                if modId == 18 then
                    ToggleVehicleMod(vehicle, 18, (not IsToggleModOn(vehicle, 18)))
                elseif modId == 22 then
                    ToggleVehicleMod(vehicle, 22, (not IsToggleModOn(vehicle, 22)))
                elseif modId == "neon" then
                    if mod == 4 then
                        for i = 0, 3 do
                            SetVehicleNeonLightEnabled(vehicle, i, false)
                        end
                    end
                    SetVehicleNeonLightEnabled(vehicle, mod, true)
                elseif modId == "plates" then
                    SetVehicleNumberPlateTextIndex(vehicle, mod)
                elseif modId == "headlight_color" then
                    SetVehicleXenonLightsColor(vehicle, mod)
                elseif modId == "window_tint" then
                    SetVehicleWindowTint(vehicle, mod)
                elseif modId == "tire_smoke" then
                    ToggleVehicleMod(vehicle, 20, (not IsToggleModOn(vehicle, 20)))
                    SetVehicleTyreSmokeColor(vehicle, 255, 255, 255)
                elseif modId == "vehicle_traction" then
                    setVehicleTraction(vehicle, mod)
                    TriggerServerEvent("0r-mechanic:server:addElement", modId, {
                        modId = modId,
                        mod = mod,
                        plate = vehPlate,
                    })
                elseif modId == "tuner_chip" then
                    setVehicleTunerChip(vehicle, mod)
                    TriggerServerEvent("0r-mechanic:server:addElement", modId, {
                        modId = modId,
                        mod = mod,
                        plate = vehPlate,
                    })
                elseif modId == "nitro" then
                    TriggerServerEvent("0r-mechanic:server:addElement", modId, {
                        modId = modId,
                        mod = mod,
                        plate = vehPlate,
                    })
                elseif modId == "popcorn" then
                    TriggerServerEvent("0r-mechanic:server:addElement", modId, {
                        modId = modId,
                        mod = mod,
                        plate = vehPlate,
                    })
                elseif modId == "extra" then
                    if IsVehicleExtraTurnedOn(vehicle, mod) then
                        SetVehicleExtra(vehicle, mod, true)
                    else
                        SetVehicleExtra(vehicle, mod, false)
                    end
                elseif modId == "livery" and useCountLivery then
                    SetVehicleLivery(vehicle, mod)
                else
                    if modId == "livery" then
                        modId = 48
                    end
                    SetVehicleMod(vehicle, tonumber(modId), mod)
                end
        
                currentModData = getVehicleProperties(vehicle)
        
                SendNUIMessage({
                    type = "SOUND",
                    sound = "wrench",
                })
            end
            ShowNotification(Config.Locale["saved"])
        end
    end, {
        data.type, data.basketdata, currentMechanic
    })
    while retval == nil do
        Citizen.Wait(150)
    end
    cb(retval)
end)

RegisterNUICallback("close", function(data, cbj)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    SendNUIMessage({
        type = "OPEN_MENU",
        state = false,
        modMenu = {},
    })
    FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()), false)
    SetNuiFocus(false, false)
    unregisterAllCams()
    
    menuOpened = false


    if data.type == true then
    else
        ShowNotification(Config.Locale["save_cancel"])
        setVehicleProperties(vehicle, currentModData)

    end
    cartMods = {}
end)

RegisterNetEvent("0r-mechanic:client:updateVehData", function(obj)
    vehData = obj
end)

RegisterNetEvent("0r-mechanic:client:syncFitment", function(vehicleId, fitmentData)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleId)
    for k,v in pairs(fitmentData) do
        if k == "wheels-width" then
            SetVehicleWheelWidth(vehicle, v)
        elseif k == "front-left-camber" then
            SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
        elseif k == "front-right-camber" then
            SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
        elseif k == "rear-left-camber" then
            SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
        elseif k == "rear-right-camber" then
            SetVehicleWheelYRotation(vehicle, fitmentData[k], v)
        else
            SetVehicleWheelXOffset(vehicle, fitmentData[k], v)
        end
    end
end)

local entityEnumerator = {
	__gc = function(enum)
	if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	end
	enum.destructor = nil
	enum.handle = nil
	end
}

local EnumerateEntities = function(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	local iter, id = initFunc()
	if not id or id == 0 then
		disposeFunc(iter)
		return
	end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
	end)
end

local EnumerateVehicles = function()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        if IsPedInAnyVehicle(playerPed) then
            for mName, mData in pairs(Config.Locations) do
                for i, mCoords in pairs(mData.coords) do
                    local dst = #(pCoords - mCoords)
                    if dst <= 20 then
                        sleep = 1
                        if dst <= 3 then
                            if mData.job ~= "none" then
                                if PlayerData.job and PlayerData.job.name == mData.job and not menuOpened then
                                    DrawMarker(1, mCoords.x, mCoords.y, mCoords.z - 0.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 204, 102, 250, false, false, 2, false, 0, 0, 0, 0)
                                    ShowHelpNotification(Config.Locale["open_mechanic_menu"])
                                    if IsControlJustPressed(0, 38) and not menuOpened then
                                        menuOpened = true
                                        isIllegalMechanic = mData.illegalMechanic
                                        currentMechanic = mName
                                        openMechanicMenu(true, GetVehiclePedIsUsing(playerPed))
                                    end
                                end
                            else
                                if not menuOpened then
                                    DrawMarker(1, mCoords.x, mCoords.y, mCoords.z - 0.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 204, 102, 250, false, false, 2, false, 0, 0, 0, 0)
                                    ShowHelpNotification(Config.Locale["open_mechanic_menu"])
                                    if IsControlJustPressed(0, 38) and not menuOpened then
                                        menuOpened = true
                                        isIllegalMechanic = mData.illegalMechanic
                                        currentMechanic = mName
                                        openMechanicMenu(true, GetVehiclePedIsUsing(playerPed))
                                    end
                                end
                            end
                        end
                    end
                end
            end
            for mName, mData in pairs(Config.ExtraMenuLocations) do
                for i, mCoords in pairs(mData.coords) do
                    local dst = #(pCoords - mCoords)
                    if dst <= 20 then
                        sleep = 1
                        if dst <= 3 then
                            if mData.job ~= "none" then
                                if PlayerData.job and PlayerData.job.name == mData.job and not menuOpened then
                                    DrawMarker(1, mCoords.x, mCoords.y, mCoords.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 204, 102, 250, false, false, 2, false, 0, 0, 0, 0)
                                    ShowHelpNotification(Config.Locale["open_extra_menu"])
                                    if IsControlJustPressed(0, 38) and not menuOpened then
                                        menuOpened = true
                                        currentMechanic = mName
                                        openExtraMenu(true, GetVehiclePedIsUsing(playerPed))
                                    end
                                end
                            else
                                if not menuOpened then
                                    DrawMarker(1, mCoords.x, mCoords.y, mCoords.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 204, 102, 250, false, false, 2, false, 0, 0, 0, 0)
                                    ShowHelpNotification(Config.Locale["open_extra_menu"])
                                    if IsControlJustPressed(0, 38) and not menuOpened then
                                        menuOpened = true
                                        currentMechanic = mName
                                        openExtraMenu(true, GetVehiclePedIsUsing(playerPed))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        for mName, mData in pairs(Config.Locations) do
            local dst = #(pCoords - mData.bossMenu)
            if dst <= 7 then
                if mData.job ~= "none" then
                    if PlayerData.job and PlayerData.job.name == mData.job and not menuOpened then
                        sleep = 1
                        DrawMarker(1, mData.bossMenu.x, mData.bossMenu.y, mData.bossMenu.z - 1, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 204, 102, 250, false, false, 2, false, 0, 0, 0, 0)
                        if dst <= 2 then
                            ShowHelpNotification("~INPUT_CONTEXT~ Boss Menu")
                            if IsControlJustPressed(0, 38) then
                                openBossMenu(mData.job)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 750
        local playerPed = PlayerPedId()
        if next(vehData) then
            if IsPedInAnyVehicle(playerPed) and not menuOpened then
                local pVehicle = GetVehiclePedIsUsing(playerPed)
                local vehPlate = trim(GetVehicleNumberPlateText(pVehicle))
                if vehData[vehPlate] then
                    sleep = 1
                    if lastVehicle ~= pVehicle then
                        lastVehicle = pVehicle
                        setVehicleModification(pVehicle, vehPlate)
                    end
                    if vehData[vehPlate].tuner_chip and vehData[vehPlate].tuner_chip == "drift" then
                        if IsControlPressed(0, Config.Settings.driftMode.keyCode) then
                            SetVehicleReduceGrip(pVehicle, true)
                        else
                            if IsControlJustReleased(0, Config.Settings.driftMode.keyCode) then
                                SetVehicleReduceGrip(pVehicle, false)
                            end
                        end
                    end
                    if vehData[vehPlate].nitro and vehData[vehPlate].nitro == "nos" then
                        if IsControlJustPressed(0, Config.Settings.nitro.keyCode) and not nitroBoosted then
                            nitroBoosted = true
                            useNitro(pVehicle)
                        end
                    end
                    if vehData[vehPlate].popcorn and vehData[vehPlate].popcorn == "popcorn" then
                        if IsControlJustPressed(0, Config.Settings.popcornExhaust.openKeyCode) then
                            popcornEnabled = not popcornEnabled
                            ShowNotification((Config.Locale["popcorn_exhaust"]):format(popcornEnabled and "Enabled" or "Disabled"))
                        end
                        if popcornEnabled then
                            if not IsControlPressed(1, 71) and not IsControlPressed(1, 72) then
                                local exhaustCoords = GetWorldPositionOfEntityBone(pVehicle, GetEntityBoneIndexByName(pVehicle, "exhaust"))
                                local RPM = GetVehicleCurrentRpm(pVehicle)
                                if GetPedInVehicleSeat(pVehicle, -1) == playerPed then
                                    if RPM > 0.75 then
                                        AddExplosion(exhaustCoords.x, exhaustCoords.y, exhaustCoords.z, 61, 0.0, true, true, 0.0, true)
                                        UseParticleFxAssetNextCall("core")
                                        local ptfx = StartNetworkedParticleFxLoopedOnEntityBone("veh_backfire", pVehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(pVehicle, "exhaust"), 1.5, 0.0, 0.0, 0.0)
                                        SetVehicleTurboPressure(pVehicle, 25)
                                        Citizen.Wait(500)
                                        StopParticleFxLooped(ptfx, 0)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if Config.Settings.syncFitment and not menuOpened then
                for pVehicle in EnumerateVehicles() do 
                    local vehPlate = trim(GetVehicleNumberPlateText(pVehicle))
                    if vehData[vehPlate] and vehData[vehPlate].fitment then
                        for ftype, value in pairs(vehData[vehPlate].fitment) do
                            if value == -1 then
                                value = -1.00
                            elseif value == 1 then
                                value = 1.00
                            elseif value == 0 then
                                value = 0.00
                            end
                            if ftype == "wheels-width" then
                                SetVehicleWheelWidth(pVehicle, value)
                            elseif ftype == "front-left-camber" then
                                SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                            elseif ftype == "front-right-camber" then
                                SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                            elseif ftype == "rear-left-camber" then
                                SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                            elseif ftype == "rear-right-camber" then
                                SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                            else
                                SetVehicleWheelXOffset(pVehicle, fitmentData[ftype], value)
                            end
                        end
                    end
                end
            else
                if IsPedInAnyVehicle(playerPed) then
                    local pVehicle = GetVehiclePedIsUsing(playerPed)
                    local vehPlate = trim(GetVehicleNumberPlateText(pVehicle))
                    if vehData[vehPlate] and vehData[vehPlate].fitment then
                        if not menuOpened then
                            for ftype, value in pairs(vehData[vehPlate].fitment) do
                                if value == -1 then
                                    value = -1.00
                                elseif value == 1 then
                                    value = 1.00
                                elseif value == 0 then
                                    value = 0.00
                                end
                                if ftype == "wheels-width" then
                                    SetVehicleWheelWidth(pVehicle, value)
                                elseif ftype == "front-left-camber" then
                                    SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                                elseif ftype == "front-right-camber" then
                                    SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                                elseif ftype == "rear-left-camber" then
                                    SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                                elseif ftype == "rear-right-camber" then
                                    SetVehicleWheelYRotation(pVehicle, fitmentData[ftype], value)
                                else
                                    SetVehicleWheelXOffset(pVehicle, fitmentData[ftype], value)
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)
