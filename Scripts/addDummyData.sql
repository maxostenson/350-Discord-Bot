INSERT INTO "Role"(type, permission)
VALUES('Admin', 'Approve Bug Report');

INSERT INTO "Role"(type, permission)
VALUES('User', 'Create Bug Report');

INSERT INTO "Role"(type, permission)
VALUES('Developer', 'Claim Bug Report');

INSERT INTO "Level"(levelNum, expToNextLevel)
VALUES(1, 100);

INSERT INTO "Level"(levelnum, expToNextLevel)
VALUES(2, 250);

INSERT INTO "Level"(levelnum, expToNextLevel)
VALUES(3, 500);

INSERT INTO "User"(userId, discordId, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(1, 123, 0, NULL, 0, 0, 'Admin', 1);

INSERT INTO "User"(userid, discordId, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(2, 234, 75, NULL, 75, 0, 'User', 1);

INSERT INTO "User"(userId, discordId, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(3, 345, 100, NULL, 0, 0, 'Developer', 2);

INSERT INTO "BugReport"(reportId, bugMessage, githubReportId, isOpen, contactedSubmitter, status, dateCreated, creatorId)
VALUES(1, 'The game doesn''t even exist currently', 123, true, false, 'Open', CURRENT_DATE, 1);

INSERT INTO "BugFixing"(developer, reportid)
VALUES(3, 1);

INSERT INTO "Group"(groupid, groupname)
VALUES(1, 'The Best Group');

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(1, 1);

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(1, 3);