ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING ALTER COLUMN ACCESS_TOKEN VARCHAR(512);
ALTER TABLE AM_APPLICATION_REGISTRATION ALTER COLUMN TOKEN_SCOPE VARCHAR(1500);

IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_CERTIFICATE_METADATA]') AND TYPE IN (N'U'))
CREATE TABLE AM_CERTIFICATE_METADATA (
  TENANT_ID INTEGER NOT NULL,
  ALIAS VARCHAR(45) NOT NULL,
  END_POINT VARCHAR(100) NOT NULL,
  CONSTRAINT PK_ALIAS PRIMARY KEY (ALIAS),
  CONSTRAINT END_POINT_CONSTRAINT UNIQUE (END_POINT)
);

IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_APPLICATION_GROUP_MAPPING]') AND TYPE IN (N'U'))
CREATE TABLE AM_APPLICATION_GROUP_MAPPING (
    APPLICATION_ID INTEGER NOT NULL,
    GROUP_ID VARCHAR(512),
    TENANT VARCHAR(255),
    PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
    FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_USAGE_UPLOADED_FILES]') AND TYPE IN (N'U'))
CREATE TABLE AM_USAGE_UPLOADED_FILES (
  TENANT_DOMAIN VARCHAR(255) NOT NULL,
  FILE_NAME VARCHAR(255) NOT NULL,
  FILE_TIMESTAMP DATETIME DEFAULT GETDATE(),
  FILE_PROCESSED INTEGER DEFAULT 0,
  FILE_CONTENT VARBINARY(MAX) DEFAULT NULL,
  PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
);


IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_LC_PUBLISH_EVENTS]') AND TYPE IN (N'U'))
CREATE TABLE AM_API_LC_PUBLISH_EVENTS (
    ID INTEGER NOT NULL IDENTITY,
    TENANT_DOMAIN VARCHAR(255) NOT NULL,
    API_ID VARCHAR(500) NOT NULL,
    EVENT_TIME DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (ID)
);
