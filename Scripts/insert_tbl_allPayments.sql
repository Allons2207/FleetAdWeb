Alter PROCEDURE [insert_tbl_allPayments]
	(
	@payment						[varchar](50),
	@amountPaid						[money],
	@studentId						[varchar](20),
	@dtDate						[datetime],
	@details						[nvarchar](100),
	@cashier						[varchar](100)
	)
AS INSERT INTO tbl_allPayments
	(
	payment,
	amountPaid,
	studentId,
	dtDate,
	details,
	cashier
	)
VALUES
	(
	@payment,
	@amountPaid,
	@studentId,
	@dtDate,
	@details,
	@cashier
	)
