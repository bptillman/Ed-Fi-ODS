-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

------------------------------ dbo.ResourceClaimActions -------------------------------------------------
CREATE TABLE dbo.ResourceClaimActions(
	ResourceClaimActionId SERIAL NOT NULL,
	ActionId INT NOT NULL,
	ResourceClaimId INT NOT NULL,
	ValidationRuleSetName VARCHAR NULL,
 CONSTRAINT ResourceClaimActionId_PK PRIMARY KEY
(
	ResourceClaimActionId 
));

CREATE INDEX IF NOT EXISTS IX_ResourceClaimActions_ActionId
    ON dbo.ResourceClaimActions
	(ActionId);

CREATE INDEX IF NOT EXISTS IX_ResourceClaimActions_ResourceClaimId
    ON dbo.ResourceClaimActions
	(ResourceClaimId);

ALTER TABLE dbo.ResourceClaimActions  ADD  CONSTRAINT FK_ResourceClaimActions_Actions FOREIGN KEY(ActionId)
REFERENCES dbo.Actions (ActionId)
ON DELETE CASCADE;

ALTER TABLE dbo.ResourceClaimActions  ADD  CONSTRAINT FK_ResourceClaimActions_ResourceClaims FOREIGN KEY(ResourceClaimId)
REFERENCES dbo.ResourceClaims (ResourceClaimId)
ON DELETE CASCADE;

---------------------------- dbo.ClaimSetResourceClaimActions --------------------------------------------------------

CREATE TABLE dbo.ClaimSetResourceClaimActions(
	ClaimSetResourceClaimActionId SERIAL NOT NULL,
	ActionId INT NOT NULL,
	ClaimSetId INT NOT NULL,
	ResourceClaimId INT NOT NULL,
	ValidationRuleSetNameOverride VARCHAR NULL,
 CONSTRAINT ClaimSetResourceClaimActions_PK PRIMARY KEY  
(
	ClaimSetResourceClaimActionId 
));

CREATE INDEX IF NOT EXISTS IX_ClaimSetResourceClaimActions_ActionId
    ON dbo.ClaimSetResourceClaimActions(ActionId);

CREATE INDEX IF NOT EXISTS IX_ClaimSetResourceClaimActions_ClaimSetId
    ON dbo.ClaimSetResourceClaimActions(ClaimSetId);

CREATE INDEX IF NOT EXISTS IX_ClaimSetResourceClaimActions_ResourceClaimId
    ON dbo.ClaimSetResourceClaimActions(ResourceClaimId);


ALTER TABLE dbo.ClaimSetResourceClaimActions ADD CONSTRAINT FK_ClaimSetResourceClaimActions_Actions FOREIGN KEY(ActionId)
REFERENCES dbo.Actions (ActionId)
ON DELETE CASCADE;

ALTER TABLE dbo.ClaimSetResourceClaimActions ADD CONSTRAINT FK_ClaimSetResourceClaimActions_ClaimSets FOREIGN KEY(ClaimSetId)
REFERENCES dbo.ClaimSets (ClaimSetId)
ON DELETE CASCADE;

ALTER TABLE dbo.ClaimSetResourceClaimActions  ADD  CONSTRAINT FK_ClaimSetResourceClaimActions_ResourceClaims FOREIGN KEY(ResourceClaimId)
REFERENCES dbo.ResourceClaims (ResourceClaimId);



---------------------------- dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides --------------------------------------------------------


CREATE TABLE dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides(
	ClaimSetResourceClaimActionAuthorizationStrategyOverrideId SERIAL NOT NULL,
	ClaimSetResourceClaimActionId INT NOT NULL,
	AuthorizationStrategyId INT NOT NULL,
 CONSTRAINT ClaimSetResourceClaimActionAuthorizationStrategyOverrides_PK PRIMARY KEY  
(
	ClaimSetResourceClaimActionAuthorizationStrategyOverrideId 
));


CREATE INDEX IF NOT EXISTS IX_ActionAuthorizationStrategyOverrides_AuthorizationStrategyId
    ON dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides
	(AuthorizationStrategyId);


CREATE INDEX IF NOT EXISTS IX_ActionAuthorizationStrategyOverrides__ClaimActionId
    ON dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides
	(ClaimSetResourceClaimActionId);

ALTER TABLE dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides  ADD  CONSTRAINT FK_ActionAuthorizationStrategyOverrides_AuthorizationStrategies FOREIGN KEY(AuthorizationStrategyId)
REFERENCES dbo.AuthorizationStrategies (AuthorizationStrategyId)
ON DELETE CASCADE;


ALTER TABLE dbo.ClaimSetResourceClaimActionAuthorizationStrategyOverrides  ADD  CONSTRAINT FK_ActionAuthorizationStrategyOverrides_ActionAuthorizations FOREIGN KEY(ClaimSetResourceClaimActionId)
REFERENCES dbo.ClaimSetResourceClaimActions (ClaimSetResourceClaimActionId);

------------------------------ dbo.ResourceClaimActionAuthorizationStrategies -------------------------------------------------


CREATE TABLE dbo.ResourceClaimActionAuthorizationStrategies(
	ResourceClaimActionAuthorizationStrategyId SERIAL NOT NULL,
	ResourceClaimActionId INT NOT NULL,
	AuthorizationStrategyId INT NOT NULL,
 CONSTRAINT ResourceClaimActionAuthorizationStrategies_PK PRIMARY KEY
(
	ResourceClaimActionAuthorizationStrategyId 
));


CREATE INDEX IF NOT EXISTS IX_ActionAuthorizationStrategies_AuthorizationStrategyId
    ON dbo.ResourceClaimActionAuthorizationStrategies
	(AuthorizationStrategyId);

CREATE INDEX IF NOT EXISTS IX_ActionAuthorizationStrategies_ClaimActionId
    ON dbo.ResourceClaimActionAuthorizationStrategies
	(ResourceClaimActionId);


ALTER TABLE dbo.ResourceClaimActionAuthorizationStrategies   ADD  CONSTRAINT FK_ActionAuthorizationStrategies_AuthorizationStrategyId FOREIGN KEY(AuthorizationStrategyId)
REFERENCES dbo.AuthorizationStrategies (AuthorizationStrategyId)
ON DELETE CASCADE;

ALTER TABLE dbo.ResourceClaimActionAuthorizationStrategies   ADD  CONSTRAINT FK_ActionAuthorizationStrategies_ActionAuthorizationId FOREIGN KEY(ResourceClaimActionId)
REFERENCES dbo.ResourceClaimActions (ResourceClaimActionId);