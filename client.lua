local Enabled = false
local CooldownActive = false
local Enable = false
local toggle = false

RegisterCommand("vibrator", function(source, args, rawCommand)
	if Enable == false then
		Toggle(true)
	else
		Toggle(false)
	end
end,false)

function Draw3DText(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

frequency = 25

function Toggle(Enabled)	
	Enable = Enabled
	TriggerEvent('chat:addMessage', {
		color = {255, 0, 100},
		args = {'Vibrator', Enabled and 'on' or 'off'}
	})
	if Enabled then
		while Enabled do
			Wait(0)
			local player = PlayerPedId()
			local coords = GetEntityCoords(player)
			if IsUsingKeyboard(0) then
				Draw3DText(coords.x, coords.y, coords.z+1.05, '~w~Use Left/Right Arrow to adjust speed ~p~(Keyboard)')
			else
				Draw3DText(coords.x, coords.y, coords.z+1.05, '~w~Use DPAD Left/Right to adjust speed ~p~(Gamepad)')
			end
			Draw3DText(coords.x, coords.y, coords.z+0.90, 'Frequency: ~y~~h~'..frequency)
			if IsUsingKeyboard(0) then
				if toggle then
					Draw3DText(coords.x, coords.y, coords.z+1.20, '~p~[E] ~g~Toggle Vibration (On)')
	
					SetPadShake(0, 100, frequency)
				else
					Draw3DText(coords.x, coords.y, coords.z+1.20, '~p~[E] ~w~Toggle Vibration (Off)')
				end
				if IsControlJustPressed(0, 38) then
					toggle = not toggle
					print(toggle)
				end
				if IsControlPressed(0, 307) then
					frequency = frequency+1
				end
				if IsControlPressed(0, 308) then
					frequency = frequency+ -1
					if frequency <= 1 then
						frequency = 1
					end
				end
			else
				if toggle then
					Draw3DText(coords.x, coords.y, coords.z+1.20, '~p~[DPAD UP] ~g~Toggle Vibration (On)')
	
					SetPadShake(0, 100, frequency)
				else
					Draw3DText(coords.x, coords.y, coords.z+1.20, '~p~[DPAD UP] ~w~Toggle Vibration (Off)')
				end
				if IsControlJustPressed(0, 303) then
					toggle = not toggle
					print(toggle)
				end
				if IsControlPressed(1, 307) then
					frequency = frequency+1
				end
				if IsControlPressed(1, 308) then
					frequency = frequency+ -1
					if frequency <= 1 then
						frequency = 1
					end
				end
			end
			if Enable == false then
				break
			end
		end
	end
end
