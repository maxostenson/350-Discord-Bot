DELETE FROM "BugFixing"
WHERE reportid = 1;

DELETE FROM "BugReport"
WHERE reportid = 1;

DELETE FROM "GroupMembers"
WHERE userId = 1;

DELETE FROM "GroupMembers"
WHERE userId = 3;

DELETE FROM "Group"
WHERE groupId = 1;

DELETE FROM "User"
WHERE userid = '1';

DELETE FROM "User"
WHERE userid = '2';

DELETE FROM "User"
WHERE userid ='3';

DELETE FROM "Role"
WHERE type = 'Admin';

DELETE FROM "Role"
WHERE type = 'User';

DELETE FROM "Role"
WHERE type = 'Developer';

DELETE FROM "Level"
WHERE levelnum = 1;

DELETE FROM "Level"
WHERE levelnum = 2;

DELETE FROM "Level"
WHERE levelnum = 3;