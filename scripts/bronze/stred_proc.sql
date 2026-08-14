CREATE OR ALTER PROCEDURE bronze.load_bronze as 
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time datetime,@batch_end_time datetime;

	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '=========================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=========================================================';

		PRINT '=========================================================';
		PRINT 'Loading CRM Tables';
		PRINT '=========================================================';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\cust_info.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
		PRINT '>> -------------------';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE [bronze].[crm_prd_info];
		BULK INSERT [bronze].[crm_prd_info]
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\prd_info.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
		PRINT '>> -------------------';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE [bronze].[crm_sales_details];
		BULK INSERT [bronze].[crm_sales_details]
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\sales_details.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
		PRINT '>> -------------------';

		PRINT '=========================================================';
		PRINT 'Loading ERP Tables';
		PRINT '=========================================================';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE [bronze].[erp_loc_a101];
		BULK INSERT [bronze].[erp_loc_a101]
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\LOC_A101.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
		PRINT '>> -------------------';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\PX_CAT_G1V2.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+ cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
		PRINT '>> -------------------';

		SET @start_time=GETDATE();
		PRINT '>>Truncating Table'
		TRUNCATE TABLE [bronze].[erp_cust_az12];
		BULK INSERT [bronze].[erp_cust_az12]
		from 'C:\Users\iwass\Downloads\main-learnings\sql\warehouse proj by baraa salkini\sql-data-analytics-project\datasets\flat-files\CUST_AZ12.csv'

		with(
		firstrow=2,
		fieldterminator=',',
		tablock
		);
	SET @batch_end_time=GETDATE();
	PRINT '### BATCH LOAD DURATION: ' + cast(DATEDIFF(second,@batch_start_time,@batch_end_time) as nvarchar) + ' seconds'
	END TRY
	BEGIN CATCH

		PRINT '========================================================='
		PRINT 'ERROR OCCURED during load to bronze layer'
		PRINT 'Error Message' + ERROR_MESSAGE();
		print 'Error Message' + cast(ERROR_NUMBER() as nvarchar);
		print 'Error Message' + cast(ERROR_STATE() as nvarchar);
	END CATCH 
END

EXEC bronze.load_bronze
