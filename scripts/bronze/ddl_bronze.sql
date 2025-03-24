/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
-------------------------------------------------------------------------------
Error Logging:
    - Created 'error_log' table to store error details.
    - Created 'err_log' stored procedure to capture errors.
    - This procedure can be called in CATCH blocks of other procedures
      to insert error details automatically.
Usage Example:
	EXEC err_log;
===============================================================================
*/

DROP TABLE IF EXISTS bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12(
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
	ID NVARCHAR(50),
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
);
GO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS  error_log;

CREATE TABLE error_log (
	ErrorId INT IDENTITY(1,1) PRIMARY KEY,
	ErrorProcedure NVARCHAR(255),
	ErrorNumber INT,
	ErrorSeverity INT,
	ErrorState INT,
	ErrorLine INT,
	ErrorMessage NVARCHAR(MAX),
	ErrorDate DATETIME DEFAULT GETDATE()
);
GO

CREATE OR ALTER PROCEDURE err_log AS
BEGIN
	INSERT INTO error_log (ErrorNumber,ErrorProcedure,ErrorSeverity,ErrorState,ErrorLine,ErrorMessage,ErrorDate)
		VALUES (
			ERROR_NUMBER(),
			ERROR_PROCEDURE(),
			ERROR_SEVERITY(),
			ERROR_STATE(),
			ERROR_LINE(),
			ERROR_MESSAGE(),
			GETDATE()
		);
END;