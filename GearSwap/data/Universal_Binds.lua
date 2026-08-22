-- Keybinds for modes
windower.send_command('bind !f9 gs c toggle weapons') -- Alt-F9
windower.send_command('bind !f10 gs c toggle nukemode')	-- Alt-F10

windower.send_command('bind !f4 input //send @brd sl start attack')
windower.send_command('bind !f5 input //send @brd sl stop')
windower.send_command('bind !f6 input //send @cor roller start')
windower.send_command('bind !f7 input //send @cor roller stop')

-- Keybinds for alts
windower.send_command('bind !q input //send @brd /so "Chocobo Mazurka" <me>')
windower.send_command('bind ![ input //assist awm') -- attack with me
windower.send_command('bind !p input //assist sa') -- stop attack with
windower.send_command('bind !w input //send @others /ws "Savage Blade" <t>')

-- Whenever user unloads a gearswap file, unbind all keys
-- NOTE:  This may be moot if I'm using the same binds across all jobs
function user_unload()
	
	-- Function Keys
	send_command('unbind !f5') -- Alt-F5
	send_command('unbind !f6') -- Alt-F6
    send_command('unbind !f10') -- Alt-F10
	send_command('unbind !f11') -- Alt-F11
	send_command('unbind !f12') -- Alt-F12
	
	-- Character & Symbol Keys
	send_command('unbind !q') -- Alt-F2
	send_command('unbind !a') -- Alt-F2
	send_command('unbind ![') -- Alt-F2
	send_command('unbind !]') -- Alt-F2
	send_command('unbind !w') -- Alt-F2
end