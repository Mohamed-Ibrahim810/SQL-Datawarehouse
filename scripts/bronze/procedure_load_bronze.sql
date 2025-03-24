/*
======================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the existing bronze tables before loading new data.
    - Uses the BULK INSERT command to efficiently load data into the bronze tables.
	- Measurs every operation load time.

Parameters:
    None. 
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
--------------------------------------------------------------------------------------
Error Handling:
    - In case of any error, "SET XACT_ABORT ON" ensures that the entire transaction is 
      automatically rolled back, preventing partial data loads and preserving data integrity.
    - If a runtime error occurs, the procedure "err_log" is executed in the CATCH block.
      This procedure logs error details into the table "error_log" for troubleshooting 
      and auditing purposes.
======================================================================================

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	SET XACT_ABORT ON
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
	BEGIN TRANSACTION

		PRINT '==================================================';
		PRINT '             Loading Bronze Layer';
		PRINT '==================================================';
			
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_cust_info';
			TRUNCATE TABLE bronze.crm_cust_info;
			PRINT '>> Inserting Data Into: bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM "D:\SQL-Datawarehouse\datasets\source_crm\cust_info.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);
		----------------------------------------------------------------------------------------------------------------------------------------
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_prd_info';	
			TRUNCATE TABLE bronze.crm_prd_info;
			PRINT '>> Inserting Data Into: bronze.crm_prd_info';
			BULK INSERT bronze.crm_prd_info
			FROM "D:\SQL-Datawarehouse\datasets\source_crm\prd_info.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);
		----------------------------------------------------------------------------------------------------------------------------------------
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_sales_details';
			TRUNCATE TABLE bronze.crm_sales_details;
			PRINT '>> Inserting Data Into: bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM "D:\SQL-Datawarehouse\datasets\source_crm\sales_details.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);
		----------------------------------------------------------------------------------------------------------------------------------------
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12
			PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM "D:\SQL-Datawarehouse\datasets\source_erp\cust_az12.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);
		----------------------------------------------------------------------------------------------------------------------------------------
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;
			PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM "D:\SQL-Datawarehouse\datasets\source_erp\loc_a101.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);
		----------------------------------------------------------------------------------------------------------------------------------------
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;
			PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM "D:\SQL-Datawarehouse\datasets\source_erp\px_cat_g1v2.csv"
			WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
			);
			SET @end_time = GETDATE();

			PRINT '>> Load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR);

		COMMIT TRANSACTION;

		END TRY
		BEGIN CATCH
				PRINT'=================================='
				PRINT'        !! ERROR OCCURD !!'
				PRINT'=================================='
			EXEC err_log; 
		END CATCH;
		
END;