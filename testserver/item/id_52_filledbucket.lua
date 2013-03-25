-- fill cauldron
-- large empty bottle (2498) --> blue potion (2496) aka bottle with water
-- extinguish forge (2835) --> (2836)
-- extinguish fire
-- pour on character
-- UPDATE common SET com_script='item.id_52_filledbucket' WHERE com_itemid IN (52);

require("base.common")
require("alchemy.base.alchemy")

module("item.id_52_filledbucket", package.seeall)

function UseItem(User, SourceItem, ltstate)

  -- look for cauldron
  TargetItem = GetCauldron(User);
  if (TargetItem ~= nil) then
    if not base.common.IsLookingAt( User, TargetItem.pos ) then -- check looking direction
      base.common.TurnTo( User, TargetItem.pos ); -- turn if necessary
    end
    WaterIntoCauldron(User,SourceItem,TargetItem,ltstate);
    return;
  end
  
  -- look for forge
  TargetItem = base.common.GetItemInArea(User.pos, 2835, 1, true);
  if (TargetItem ~= nil) then
    world:makeSound(9, TargetItem.pos)
    world:swap(TargetItem, 2836, 333);
    base.common.InformNLS(User,
    "Du l�schst das Feuer in der Esse.",
    "You extinguish the fire in the forge.");
    world:gfx(11,TargetItem.pos)
	CreateEmptyBucket(User, SourceItem,1)
    return;
  end
  
  -- look for fire
  local FireItem, bool = base.common.GetItemInArea(User.pos, 12, 1, true);
  if (FireItem == nil or FireItem.wear == 255) then
    local i = base.common.GetItemInArea(User.pos, 12, 1, true);
    if (i ~= nil) then
      FireItem = i;
    end
  end
  if (FireItem ~= nil) then
    if not base.common.IsLookingAt( User, FireItem.pos ) then -- check looking direction
      base.common.TurnTo( User, FireItem.pos ); -- turn if necessary
    end
    -- TODO is a noobia check needed?
    -- Don't extinguish static fires.
    world:makeSound(9, FireItem.pos);
    if (FireItem.wear == 255) then
      base.common.InformNLS(User,
      "Das Wasser verdampft in dem Feuer ohne es zu l�schen.",
      "The water vaporises in the fire but it does not extinguish it.");
    else
	  local frontitem = base.common.GetFrontItem(User);
	  if frontitem~=nil then
		world:erase(frontitem,frontitem.number);
		base.common.InformNLS(User,
			"Du l�schst das Feuer.",
			"You extinguish the fire.");
	  end
    end
    world:gfx(11,FireItem.pos)
	CreateEmptyBucket(User, SourceItem,1)
    return;
  end
  
  -- pour water on character. Either on the one in front or on the User himself.
  local TargetChar = base.common.GetFrontCharacter(User);
  if (TargetChar ~= nil) then
    -- is this really a player?
    local players = world:getPlayersInRangeOf(TargetChar.pos, 0);
    for _,p in pairs(players) do 
      if (p.id == TargetChar.id) then
        base.common.InformNLS(User,
        "Du sch�ttest das Wasser �ber die Person vor dir.",
        "You pour the water on the person in front of you.");
        PourOnCharacter(TargetChar, SourceItem);
        world:gfx(11,TargetChar.pos)
		CreateEmptyBucket(User, SourceItem,1)
		return;
      end
    end    
  end
  -- nothing; we empty all buckets
  CreateEmptyBucket(User, SourceItem, SourceItem.number)
end

function PourOnCharacter (TargetCharacter, SourceItem )
  world:makeSound( 9, TargetCharacter.pos );
  world:swap(SourceItem, 51, 333);
	base.common.InformNLS(TargetCharacter, 
  "Du f�hlst dich gleich viel sauberer.", 
  "You feel much cleaner.");
end

function WaterIntoCauldron(User,SourceItem,TargetItem,ltstate)
    local cauldron = TargetItem
	
	if ( ltstate == Action.abort ) then
	   base.common.InformNLS(User, "Du brichst deine Arbeit ab.", "You abort your work.")
	   return
	end
		
	-- is the char an alchemist?
	local anAlchemist = alchemy.base.alchemy.CheckIfAlchemist(User,"Nur jene, die in die Kunst der Alchemie eingef�hrt worden sind, k�nnen hier ihr Werk vollrichten.","Only those who have been introduced to the art of alchemy are able to work here.")
	if not anAlchemist then
		return
	end
		
	if ( ltstate == Action.none ) then
		User:startAction( 20, 21, 5, 0, 0)
		return
	end	

	-- water, essence brew, potion or stock is in the cauldron; leads to a failure
	if cauldron:getData("filledWith") == "water" then
		base.common.InformNLS( User,
				"Der Kessel l�uft �ber. Offensichtlich war schon Wasser in ihm.",
				"The water runs over. Obviously, ther was already water in it.")
		world:makeSound(9,cauldron.pos)
		world:gfx(11,cauldron.pos)
		
	elseif cauldron:getData("filledWith") == "essenceBrew" then 
		world:gfx(1,cauldron.pos)
		base.common.InformNLS(User, "Der Inhalt des Kessels verpufft, als du das Wasser hinzu tust.", 
		                            "The substance in the cauldron blows out, as you fill the water in.")
		alchemy.base.alchemy.RemoveAll(cauldron)		
									
	elseif cauldron:getData("filledWith") == "potion" then
		alchemy.base.alchemy.RemoveAll(cauldron)
		if cauldron.id == 1013 then
		    world:makeSound(10,cauldron.pos)
		    cauldron:setData("filledWith","water")
		else
			base.common.InformNLS(User, "Der Inhalt des Kessels verpufft, als du das Wasser hinzu tust.", 
										"The substance in the cauldron blows out, as you fill the water in.")
		end
		world:gfx(1,cauldron.pos)
		
	elseif cauldron:getData("filledWith") == "stock" then
		world:gfx(1,cauldron.pos)
		base.common.InformNLS(User, "Der Inhalt des Kessels verpufft, als du das Wasser hinzu tust.", 
		                            "The substance in the cauldron blows out, as you fill the water in.")
	    alchemy.base.alchemy.RemoveAll(cauldron)
	    
	else -- nothing in the cauldron, we just fill in the water
	    world:makeSound(10,cauldron.pos)
		cauldron:setData("filledWith","water")
		cauldron.id = 1010
    end
    CreateEmptyBucket(User, SourceItem, 1)
	world:changeItem(cauldron)
end

function CreateEmptyBucket(User, SourceItem,amount)
    --[[if SourceItem.number > 1 then
	    world:erase(SourceItem,amount)
		local notCreated=User:createItem(51,amount,333,nil)
		if notCreated ~= 0 then
			world:createItemFromId(51,notCreated,User.pos,true,333,nil)
		end
	else	
		SourceItem.id = 51
		SourceItem.quality = 333
		world:changeItem(SourceItem)
	end]]
	
	
	
	local notCreated = User:createItem( 51, 1, 333, nil ); -- create the new produced items
	if ( notCreated > 0 ) then -- too many items -> character can't carry anymore
		world:createItemFromId( 51, notCreated, User.pos, true, 333, nil );
		base.common.HighInformNLS(User,
		"Du kannst nichts mehr halten.",
		"You can't carry any more.");
		world:erase(SourceItem,1)
		return
	else -- character can still carry something
		if SourceItem.number == 1 then
		    world:erase(SourceItem,1)
			return
        else
		    world:erase(SourceItem,1)
			SourceItem.number = SourceItem.number-1
			world:changeItem(SourceItem)
			User:changeSource(SourceItem)
			User:startAction( 20, 21, 5, 10, 25);
		end	
	end
end

function GetCauldron(User)
  -- first check in front
  local frontPos = base.common.GetFrontPosition(User);
  if (world:isItemOnField(frontPos)) then
    local item = world:getItemOnField(frontPos);
    if (item.id > 1007 and item.id < 1019) then
      return item;
    end
  end
  local Radius = 1;
  for x=-Radius,Radius do
    for y=-Radius,Radius do 
      local targetPos = position(User.pos.x + x, User.pos.y, User.pos.z);
      if (world:isItemOnField(targetPos)) then
        local item = world:getItemOnField(targetPos);
        if (item.id > 1007 and item.id < 1019) then
          return item;
        end
      end
    end
  end
  return nil;
end
