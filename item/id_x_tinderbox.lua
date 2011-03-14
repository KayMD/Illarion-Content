-- tinderbox
-- light a fire

require ("base.common")

module("item.id_x_tinderbox", package.seeall)

WoodIds = {3,543,544,2560};

function UseItem(User,SourceItem,TargetItem,Counter,Param)
	
	-- item in hand?
	if not base.common.IsItemInHands(SourceItem) then
		base.common.TempInformNLS(User,
			"Du musst die Zunderb�chse in die Hand nehmen.",
			"You have to hold the tinderbox in your hands.");
		return;
	end
	
	-- check front position for wood, a kettle or if it's clear
	local foundWood = false;
	local frontItem = nil;
	local frontPos = base.common.GetFrontPosition(User);
	local posOkay = true;
	if world:isItemOnField(frontPos) then
		local frontItem = base.common.GetFrontItem(User);
		if frontItem and frontItem.id == 2488 then -- a kettle
			posOkay = true;
		elseif IsWood(frontItem) then
			foundWood = true;
			posOkay = true;
		else
			frontItem = nil;
			posOkay = false;
		end
	end
	if not posOkay or world:isCharacterOnField(frontPos) then
		base.common.TempInformNLS(User,
			"Du kannst nur unter einem Kessel oder an einer freien Stelle ein Feuer machen.",
			"You have to light a fire beneath a kettle or at a clear place.");
		return;
	end
	
	-- check for and remove wood
	if foundWood then
		-- already found wood in front
		world:erase(frontItem, 1);
		world:createItemFromId(12,1,frontPos,true,333,0); -- the fire
		if frontItem.number > 0 then
			-- there was more than one wood item, so put the rest on top
			world:createItemFromId(frontItem.id,frontItem.number,frontPos,true,333,0);
			-- and erase the rest
			world:erase(frontItem,frontItem.number);
		end
		return;
	end
	
	-- first check the hand slot
	local woodItem = base.common.GetTargetItem(User, SourceItem);
	if IsWood(woodItem) then
		world:erase(woodItem, 1);
		foundWood = true;
	else
		local woodIndex = 0;
		local woodNum = 0;
		while ( woodNum == 0 and woodIndex < table.getn(WoodIds) ) do
			woodIndex = woodIndex + 1;
			woodNum = User:countItemAt("belt", WoodIds[woodIndex]);
			User:inform("idx: ".. woodIndex .."; woodNum: ".. woodNum);
		end
		User:inform("1");
		if woodNum > 0 then
			User:inform("2");
			User:eraseItem(WoodIds[woodIndex],1);
			User:inform("3");
			foundWood = true;
			User:inform("4");
		end
	end
	User:inform("5");
	if foundWood then
		-- light fire
		User:inform("6");
		world:createItemFromId(12,1,frontPos,true,333,0); -- the fire
	else
		base.common.TempInformNLS(User,
			"F�r ein Feuer brauchst du Holz. Lege es vor dich hin, nimm es in die Hand oder platziere es am G�rtel.",
			"For a fire you need wood. Put it on the ground in front of you, take it in your hand or put it at your belt.");
	end
end

function IsWood(item)
	if not item then
		return false;
	end
	
	if item.id == 0 then
		return false;
	end
	
	for _,id in pairs(WoodIds) do
		if id == item.id then
			return true;
		end
	end
	
	return false;
end
