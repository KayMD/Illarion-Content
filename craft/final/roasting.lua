--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
local crafts = require("craft.base.crafts")

module("craft.final.roasting", package.seeall)

roasting = crafts.Craft:new{
                    craftEN = "Roasting",
                    craftDE = "Braten",
                    handTool = 2495,
                    leadSkill = Character.cookingAndBaking,
                    sfx = 7,
                    sfxDuration = 27,
                  }

roasting:addTool(304) -- smoke oven
roasting:addTool(305) -- smoke oven

local catId = roasting:addCategory("Meat", "Fleisch")

-- Ham
local product = roasting:addProduct(catId, 306, 1)
product:addIngredient(307) -- pork

-- Smoked chicken
local product = roasting:addProduct(catId, 3709, 1)
product:addIngredient(1151) -- chicken meat

-- Smoked rabbit
local product = roasting:addProduct(catId, 3710, 1)
product:addIngredient(553) -- rabbit meat

-- Grilled lamb
local product = roasting:addProduct(catId, 3713, 1)
product:addIngredient(2934) -- lamb meat

-- Grilled venison
local product = roasting:addProduct(catId, 3714, 1)
product:addIngredient(552) -- deer meat

-- Grilled steak
local product = roasting:addProduct(catId, 3606, 1)
product:addIngredient(2940) -- raw steak

local catId = roasting:addCategory("Fish", "Fisch")

-- Smoked rose fish
local product = roasting:addProduct(catId, 3915, 1)
product:addIngredient(1210) -- rose fish

-- Smoked salmon
local product = roasting:addProduct(catId, 3916, 1)
product:addIngredient(355) -- salmon

-- Smoked horse mackerel
local product = roasting:addProduct(catId, 3914, 1)
product:addIngredient(1209) -- horse mackerel

-- Smoked trout
local product = roasting:addProduct(catId, 455, 1)
product:addIngredient(73) -- trout