-- Global Variables
local M = {}
M.nitro = "Off"
M.status = "Off"
M.mode = "Atk&Spd"

function M.auto_brd()
	
	-- If "Auto-Brd" is on, then determine mode and execute spells
	windower.add_to_chat(123, "Auto_BRD Status:\nStatus - "..M.status.."\nMode - "..M.mode)
	if M.status == "On" then
	
		--if M.nitro == "On" then
		--	windower.send_command("send mightywar input /ja 'Nightingale' <me>;wait 5;send mightywar input /ja 'Troubadour' <me>")
		
		if M.mode == "Atk&Spd" then
			windower.send_command("send mightywar input /ma 'Victory March' <me>;wait 15;send mightywar input /ma 'Valor Minuet V' <me>;wait 15;send mightywar input /ma 'Valor Minuet IV' <me>")
		elseif M.mode == "Def&Regen" then
			windower.send_command("send mightywar input /ma 'Army\'s Paeon VI' <me>;wait 15;send mightywar input /ma 'Army\'s Paeon V' <me>;wait 15;send mightywar input /ma 'Knight\'s Minne V' <me>")
		elseif M.mode == "MP" then
			windower.send_command("send mightywar input /ma 'Mage\'s Ballad III' <me>;wait 15;send mightywar input /ma 'Mage\'s Ballad II' <me>;wait 15;send mightywar input /ma 'Mage\'s Ballad' <me>")
		end
		
		-- check for buffs every 145 seconds after casting spells
		-- adjust once brd has more duration gear
		coroutine.schedule(M.auto_brd, 145)
	end
end

-- Helper function to determine if a given value exists within a given table
function contains(tbl, value)
	for i, v in ipairs(tbl) do
		if v == value then
			return true
		end
	end
	return false
end

-- Helper function to determine how many of a given buff has been applied (i.e., 1 minuet, 2 ballads, etc.)
function num_buffs(tbl, value)
	local count = 0
	for i, v in ipairs(tbl) do
		if v == value then
			count = count + 1
		end
	end
	return count
end

return M