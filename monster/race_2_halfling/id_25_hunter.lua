--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
--Halfling Hunter, Level: 4, Armourtype: light, Weapontype: distance
local LEVEL = 4

local drop = require("monster.base.drop"){monsterLevel = LEVEL}
local halflings = require("monster.race_2_halfling.base")

--Category 1: Armor
local armorDropGroup = drop.dropGroup()
armorDropGroup.add{itemId = 48} --leather gloves
armorDropGroup.add{itemId = 366} --fur trousers
armorDropGroup.add{itemId = 363} --leather scale armor
armorDropGroup.add{itemId = 365} --half leather armor
armorDropGroup.add{itemId = 365} --half leather armor

--Category 2: Special loot
local specialDropGroup = drop.dropGroup()
specialDropGroup.add{itemId = 553} --rabbit meat
specialDropGroup.add{itemId = 552} --deer meat
specialDropGroup.add{itemId = 555} --rabbit dish
specialDropGroup.add{itemId = 554} --venison dish
specialDropGroup.add{itemId = 2495} --pan

--Category 3: Weapon
local weaponDropGroup = drop.dropGroup()
weaponDropGroup.add{itemId = 1266} --stones
weaponDropGroup.add{itemId = 89} --sling
weaponDropGroup.add{itemId = 65} --short bow
weaponDropGroup.add{itemId = 2714} --hunting bow
weaponDropGroup.add{itemId = 64} --arrows

--Category 4: Perma Loot
drop.addMoneyDrop()

return halflings.generateCallbacks(drop)