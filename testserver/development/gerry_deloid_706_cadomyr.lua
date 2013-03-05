-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (706, 'quest.gerry_deloid_706_cadomyr');

require("base.common")
module("development.gerry_deloid_706_cadomyr", package.seeall)

GERMAN = Player.german
ENGLISH = Player.english

-- Insert the quest title here, in both languages
Title = {}
Title[GERMAN] = "Das Kerzenziehen"
Title[ENGLISH] = "Candle making"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Sammel 20 Honigwaben f�r Gerry Deloid bei den Bienenst�cken auf dem Tisch vor ihm."
Description[ENGLISH][1] = "Collect 20 honeycombs for Gerry Deloid at the beehives on the tabel in front of him."
Description[GERMAN][3] = "Stell 20 St�ck Wachs beim Kerzenziehertisch her und zeig diese Gerry Deloid."
Description[ENGLISH][3] = "Produce 20 pieces of wax at the chandler table and show these to Gerry Deloid."
Description[GERMAN][5] = "Stell zehn Kerzen f�r Gerry Deloid her."
Description[ENGLISH][5] = "Produce ten candles for Gerry Deloid."
Description[GERMAN][7] = "Stell mittels schwarzen Disteln zwei Flaschen Lampen�l an der �lpresse in Cadomyr her und bring diese zu Gerry Deloid."
Description[ENGLISH][7] = "Produce two bottles lamp oil with black thistles at the press in Cadomyr and bring these to Gerry Deloid."
Description[GERMAN][8] = "Du hast alle Aufgaben von Gerry Deloid erf�llt."
Description[ENGLISH][8] = "You have fulfilled all tasks of Gerry Deloid."


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
QuestTarget = {}
QuestTarget[1] = {position(126, 572, 0), position(125, 574, 0)} -- Beehives
QuestTarget[2] = {position(126, 572, 0)} 
QuestTarget[3] = {position(126, 572, 0), position(138, 582, 0)} -- Chandler table
QuestTarget[4] = {position(126, 572, 0)} 
QuestTarget[5] = {position(126, 572, 0), position(138, 582, 0)} -- Chandler table
QuestTarget[6] = {position(126, 572, 0)} 
QuestTarget[7] = {position(126, 572, 0), position(87, 630, 0)} -- Grass

-- Insert the quest status which is reached at the end of the quest
FINAL_QUEST_STATUS = 8


function QuestTitle(user)
    return base.common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return base.common.GetNLS(user, german, english)
end

function QuestTargets(user, status)
    return QuestTarget[status]
end

function QuestFinalStatus()
    return FINAL_QUEST_STATUS
end
