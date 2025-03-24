/*
===============================================================================
DDL Script: Create silver Tables
===============================================================================
Script Purpose:
    - This script creates tables in the 'silver' schema, dropping existing tables 
	  if they already exist.
	- Run this script to re-define the DDL structure of 'silver' Tables.
    - After creating each table, a trigger is created to automatically update 
      the 'dwh_update_timestamp' column whenever any row in the table is updated.
===============================================================================
*/
DROP TABLE IF EXISTS silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_cust_info;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_cust_info
ON silver.crm_cust_info
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.crm_cust_info
    SET dwh_update_timestamp = GETDATE()
    FROM silver.crm_cust_info c
    INNER JOIN inserted i ON c.cst_id = i.cst_id;
END;
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	cat_id NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_prd_info;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_prd_info
ON silver.crm_prd_info
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.crm_prd_info
    SET dwh_update_timestamp = GETDATE()
    FROM silver.crm_prd_info p
    INNER JOIN inserted i ON p.prd_id = i.prd_id;
END;
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_sales_details;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_sales_details
ON silver.crm_sales_details
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.crm_sales_details
    SET dwh_update_timestamp = GETDATE()
    FROM silver.crm_sales_details s
    INNER JOIN inserted i ON s.sls_cust_id = i.sls_cust_id;
END;
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12(
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50),

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_cust_az12;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_cust_az12
ON silver.erp_cust_az12
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.erp_cust_az12
    SET dwh_update_timestamp = GETDATE()
    FROM silver.erp_cust_az12 az
    INNER JOIN inserted i ON az.CID = i.CID;
END;
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50),

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_loc_a101;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_loc_a101
ON silver.erp_loc_a101
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.erp_loc_a101
    SET dwh_update_timestamp = GETDATE()
    FROM silver.erp_loc_a101 a1
    INNER JOIN inserted i ON a1.CID = i.CID;
END;
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2(
	ID NVARCHAR(50),
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50),

	dwh_load_timestamp	DATETIME2(0) DEFAULT GETDATE(),
	dwh_update_timestamp DATETIME2(0) DEFAULT GETDATE()	
);
GO


DROP TRIGGER IF EXISTS silver.trg_dwh_update_timestamp_px_cat_g1v2;
GO
CREATE TRIGGER silver.trg_dwh_update_timestamp_px_cat_g1v2
ON silver.erp_px_cat_g1v2
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE silver.erp_px_cat_g1v2
    SET dwh_update_timestamp = GETDATE()
    FROM silver.erp_px_cat_g1v2 g1
    INNER JOIN inserted i ON g1.ID = i.ID;
END;
GO