CREATE PROCEDURE Insert_tbl_setTuitionPaymentsSchedule(
		@streamId int = null,
		@amountPerMonth money = null,
		@amountPerExtraSubject money = null,
		@computersFee money = null

		)
		AS 

		BEGIN

      INSERT INTO [dbo].[tbl_setTuitionPaymentsSchedule]
           ([streamId]
           ,[amountPerMonth]
           ,[amountPerExtraSubject]
           ,[computersFee])
     VALUES
           (
		       @streamId,
			   @amountPerMonth,
			   @amountPerExtraSubject,
			   @computersFee

			   )
			
	END
		  