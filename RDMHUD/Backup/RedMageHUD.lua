_addon.commands = {'redmagehud', 'rmh'}
_addon.name = 'RedMageHUD'
_addon.author = 'ofdarkhope'
_addon.version = '1.0.0'

file  = require('files')
require('logger')
texts = require('texts')
res = require('resources')

xpos = 1700
ypos = 420

-- MV Boli

textbox = texts.new("RedMageHUD")
texts.visible(textbox, true)
texts.pos(textbox, xpos, ypos)
texts.bg_alpha(textbox, 75)
texts.pad(textbox, 5)
texts.size(textbox, 10)
texts.font(textbox, 'Arial')
texts.color(textbox, 255, 255, 255)
texts.bold(textbox, true)
texts.stroke_alpha(textbox, 255)
texts.stroke_color(textbox, 255, 255, 255)
texts.alpha(textbox, 255)

function updateHUD()
	local report = {}
	for _, monster_data in ipairs(FarmBuddy.farm_data) do
		report[#report+1] = tostring(monster_data.name..': '..monster_data.kills)
	end
	texts.text(textbox, "FarmBuddy-ng:\n"..table.concat(report, "\n"))
end