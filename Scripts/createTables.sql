CREATE TABLE "Role"
(
  Type VARCHAR(255) NOT NULL,
  Permission VARCHAR(255) NOT NULL,
  PRIMARY KEY (Type)
);

CREATE TABLE "Level"
(
  LevelNum INT NOT NULL,
  ExpToNextLevel INT NOT NULL,
  PRIMARY KEY (LevelNum)
);

CREATE TABLE "Group"
(
  GroupId INT NOT NULL,
  GroupName VARCHAR(255) NOT NULL,
  PRIMARY KEY (GroupId)
);

CREATE TABLE "Rewards"
(
  RewardId INT NOT NULL,
  RewardName VARCHAR(255) NOT NULL,
  RewardCost INT NOT NULL,
  PRIMARY KEY (RewardId)
);

CREATE TABLE "User"
(
  UserId INT NOT NULL,
  DiscordId INT NOT NULL,
  CurrentExperience INT NOT NULL,
  LastRewardedMessage INT,
  WeekStartExperience INT NOT NULL,
  Points INT NOT NULL,
  Role VARCHAR(255) NOT NULL,
  Level INT NOT NULL,
  PRIMARY KEY (UserId),
  FOREIGN KEY (Role) REFERENCES "Role"(Type),
  FOREIGN KEY (Level) REFERENCES "Level"(LevelNum),
  UNIQUE (DiscordId)
);

CREATE TABLE "Feedback"
(
  FeedbackId INT NOT NULL,
  Message VARCHAR(255) NOT NULL,
  DateCreated DATE NOT NULL,
  CreatorId INT NOT NULL,
  PRIMARY KEY (FeedbackId),
  FOREIGN KEY (CreatorId) REFERENCES "User"(UserId)
);

CREATE TABLE "BugReport"
(
  ReportId INT NOT NULL,
  BugMessage VARCHAR(255) NOT NULL,
  GithubReportId INT,
  IsOpen BOOL NOT NULL,
  ContactedSubmitter BOOL NOT NULL,
  Status VARCHAR(255) NOT NULL,
  DateCreated DATE NOT NULL,
  CreatorId INT NOT NULL,
  PRIMARY KEY (ReportId),
  FOREIGN KEY (CreatorId) REFERENCES "User"(UserId)
);

CREATE TABLE "GroupMembers"
(
  GroupId INT NOT NULL,
  UserId INT NOT NULL,
  PRIMARY KEY (GroupId, UserId),
  FOREIGN KEY (GroupId) REFERENCES "Group"(GroupId),
  FOREIGN KEY (UserId) REFERENCES "User"(UserId)
);

CREATE TABLE "EarnedRewards"
(
  UserId INT NOT NULL,
  RewardId INT NOT NULL,
  PRIMARY KEY (UserId, RewardId),
  FOREIGN KEY (UserId) REFERENCES "User"(UserId),
  FOREIGN KEY (RewardId) REFERENCES "Rewards"(RewardId)
);

CREATE TABLE "BugFixing"
(
  Developer INT NOT NULL,
  ReportId INT NOT NULL,
  PRIMARY KEY (Developer, ReportId),
  FOREIGN KEY (Developer) REFERENCES "User"(UserId),
  FOREIGN KEY (ReportId) REFERENCES "BugReport"(ReportId)
);