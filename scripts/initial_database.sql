/*
===========================================
Create Database and Schemas
===========================================
Script purpose:
	This script creates a new databse named 'DataWarehouse',
	the script sets up three schemas within the databse: 'bronze', 'silver', and 'gold'.

WARNING:
	ENSURE YOU HAVE A PROPER BACKUP BEFORE RUNNING THIS SCRIPT.
*/


-- Create the 'data warehouse' database
CREATE DATABASE DataWarehouse;
GO

-- use DataWarehouse
-- Create schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO