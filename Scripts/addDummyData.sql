INSERT INTO "Role"(type, permission)
VALUES('Admin', 'Approve Bug Report');

INSERT INTO "Role"(type, permission)
VALUES('User', 'Create Bug Report');

INSERT INTO "Role"(type, permission)
VALUES('Developer', 'Claim Bug Report');

INSERT INTO "Level"(levelNum, ExpThreshold)
VALUES(1, 100);

INSERT INTO "Level"(levelnum, ExpThreshold)
VALUES(2, 250);

INSERT INTO "Level"(levelnum, ExpThreshold)
VALUES(3, 500);

INSERT INTO "User"(userId, discordId, name, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(1, 123, 'Max', 0, NULL, 0, 0, 'Admin', 1);

INSERT INTO "User"(userid, discordId, name, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(2, 234, 'Kierra', 75, NULL, 75, 0, 'User', 1);

INSERT INTO "User"(userId, discordId, name, currentExperience, lastRewardedMessage, weekStartExperience, points, role, level)
VALUES(3, 345, 'Jay', 100, NULL, 0, 0, 'Developer', 2);

INSERT INTO "BugReport"(bugMessage, githubReportId, isOpen, contactedSubmitter, status, dateCreated, creatorId)
VALUES('The game doesn''t even exist currently', 123, true, false, 'Open', CURRENT_DATE, 1);

INSERT INTO "BugReport"(bugMessage, githubReportId, isOpen, contactedSubmitter, status, dateCreated, creatorId)
VALUES('Where''s the instal link?', 234, true, false, 'Open', CURRENT_DATE, 1);

INSERT INTO "BugFixing"(developer, reportid)
VALUES(3, 1);

INSERT INTO "Group"(groupname)
VALUES('The Best Group');

INSERT INTO "Group"(groupname)
VALUES('The Second Best Group');

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(1, 1);

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(1, 2);

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(1, 3);

INSERT INTO "GroupMembers"(groupId, userId)
VALUES(2, 1);

INSERT INTO "Feedback"(Message, DateCreated, CreatorId)
VALUES('This game is really good', CURRENT_DATE, 1);

INSERT INTO "Rewards"(rewardname, rewardcost)
VALUES('Colored Name', 250);

INSERT INTO "Rewards"(rewardname, rewardcost)
VALUES('Animated Profile Picture', 500);