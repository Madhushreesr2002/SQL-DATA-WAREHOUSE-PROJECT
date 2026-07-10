CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME, @batch_start_time DATETIME,@batch_end_time DATETIME
	SET @batch_start_time = GETDATE();
	BEGIN TRY

		print '=================================';
		print 'Loading Bronze Layer';
		print '=================================';

		print '---------------------------------';
		print 'Loading CRM tables';
		print '---------------------------------';

		SET @Start_time = GETDATE();
		print '>> Truncating Table : bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;

		print '>> Inserting Data into Table : bronze.crm_cust_info ';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\DWH-PROJECT\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		SET @Start_time = GETDATE();
		Print '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		Print '>> Inserting Data into Table : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\DWH-PROJECT\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		SET @Start_time = GETDATE()
		print '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		print '>> Inserting Data into Table : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\DWH-PROJECT\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		print '---------------------------------';
		print 'Loading ERP tables';
		print '---------------------------------';

		SET @Start_time = GETDATE();
		print '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		print '>> Inserting Data into Table : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\DWH-PROJECT\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		SET @Start_time = GETDATE()
		print '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		print '>> Inserting Data into Table : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\DWH-PROJECT\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		SET @Start_time = GETDATE();
		print '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		print '>> Inserting Data into Table : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\DWH-PROJECT\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		Print '>> Load Duration :' + CAST(DATEDIFF(second, @Start_time, @End_time) AS NVARCHAR) +' seconds';
		Print '----------';

		SET @batch_end_time = GETDATE()
		print '=======================================================';
		print 'Loading Bronze Layer is Completed';
		print ' - Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) +' seconds';
		print '=======================================================';

	END TRY
	BEGIN CATCH
		print '===========================================';
		print 'ERROR OCCURED DURING LOADING BRONZE LAYEY';
		print 'ERROR MESSAGE :' + ERROR_MESSAGE();
		print 'ERROR NUMBER :' + CAST(ERROR_NUMBER() AS VARCHAR);
		print 'ERROR STATE :' +CAST(ERROR_STATE() AS VARCHAR);
		print '===========================================';
	END CATCH
END;

EXEC bronze.load_bronze;
