CREATE OR REPLACE VIEW getFeedback AS
SELECT "User".name, message, dateCreated
FROM "Feedback"
LEFT JOIN "User" ON "Feedback".creatorId = "User".userId;

CREATE OR REPLACE VIEW getAllUsers AS
SELECT name, userid, discordid, level, points, (ExpThreshold - currentExperience) AS LevelUpExperience, role
FROM "User"
LEFT JOIN "Level" on level = levelnum;

CREATE OR REPLACE VIEW viewBugReports AS
SELECT "User".name, bugmessage, isopen, contactedSubmitter, status, datecreated
FROM "BugReport"
JOIN "User" ON creatorid = userid;

CREATE OR REPLACE VIEW viewGroups AS
SELECT groupName, ARRAY_AGG(name)
FROM "GroupMembers"
JOIN "Group" ON "Group".groupid = "GroupMembers".groupid
JOIN "User" ON "User".userid = "GroupMembers".userid
GROUP BY "Group".groupName
ORDER BY "Group".groupname ASC;