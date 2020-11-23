ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

------------ Création du Menu / Sous Menu -----------

RMenu.Add('Shop Mécano', 'main', RageUI.CreateMenu("~y~Shop Mécano~y~", "~y~Menu Shop Mécano🛠~y~"))
RMenu.Add('Shop Mécano', '~b~Kit de réparation🔧~b~', RageUI.CreateSubMenu(RMenu:Get('Shop Mécano', 'main'), "~b~Kit de réparation🔧~b~", "Menu ~b~Kit de réparation🔧~b~"))
RMenu.Add('Shop Mécano', '~o~Kit de carosserie🧰~o~', RageUI.CreateSubMenu(RMenu:Get('Shop Mécano', 'main'), "~o~Kit de carosserie🧰~o~", "Menu ~o~Kit de carosserie🧰~o~"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('Shop Mécano', 'main'), true, true, true, function()

            RageUI.Button("~b~Kit de réparation🔧~b~", "Choisi ton ~b~Kit de réparation🔧~b~ !", {RightLabel = "➡️"},true, function()
            end, RMenu:Get('Shop Mécano', '~b~Kit de réparation🔧~b~'))

            RageUI.Button("~o~Kit de carosserie🧰~o~", "Choisi ton ~o~Kit de carosserie🧰~o~ !", {RightLabel = "➡️"},true, function()
            end, RMenu:Get('Shop Mécano', '~o~Kit de carosserie🧰~o~'))
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('Shop Mécano', '~b~Kit de réparation🔧~b~'), true, true, true, function()

            RageUI.Button("~b~Kit de réparation🔧~b~", "Allez au Travail !", {RightLabel = "~g~100$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('Cho4pik:BuyKit')
                end
            end)
        end, function()
        end)

            RageUI.IsVisible(RMenu:Get('Shop Mécano', '~o~Kit de carosserie🧰~o~'), true, true, true, function()

                RageUI.Button("~o~Kit de carosserie🧰~o~", "On vas la rendre Toute belle !", {RightLabel = "~g~50$"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('Cho4pik:caro')
                    end
                end)
                        
            end, function()
                ---Panels
            end, 1)
    
            Citizen.Wait(0)
        end
    end)



    ---------------------------------------- Position du Menu --------------------------------------------

    local position = {
        {x = -227.20 , y = -1328.44, z = 30.89, }
    }    
    
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then

                   RageUI.Text({
                        message = "~g~Appuyez sur~w~ [~w~E~w~]~g~ pour intéragir avec le ~b~Mécanicien🛠~g~",
                        time_display = 1
                    })
                   -- ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour acceder au ~b~Shop")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('Shop Mécano', 'main'), not RageUI.Visible(RMenu:Get('Shop Mécano', 'main')))
                    end
                end
            end
        end
    end)



       Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_pestcont_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_y_pestcont_01", -227.20, -1328.44, 29.89, 265.75, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

local v1 = vector3(-227.20, -1328.44, 29.89)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 10

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x,v1.y,v1.z, "~y~Parler avec le Mécanicien🛠~y~")
        end
    end
end)