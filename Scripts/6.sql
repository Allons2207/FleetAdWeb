USE [SchoolAd]
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_RegistrationPayments]    Script Date: 12/11/2015 3:14:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[insert_tbl_RegistrationPayments]
	(
	@studentId						[nvarchar](20),
	@intYear						[int],
	@expectedAmt						[money],
	@amountPaid						[money],
	@monthNumber						[int],
	@date						[smalldatetime],
	@penalty						[money],
	@registrationPaymentID						[int]
	)

	AS 
	
	BEGIN

	If not exists (select * from tbl_RegistrationPayments where studentId = @studentId)
	
	BEGIN

	INSERT INTO tbl_RegistrationPayments
	(
	studentId,
	intYear,
	expectedAmt,
	amountPaid,
	monthNumber,
	Regdate,
	penalty
	)
VALUES
	(
	@studentId,
	@intYear,
	@expectedAmt,
	@amountPaid,
	@monthNumber,
	@date,
	@penalty
	)

	END

	Else 

	BEGIN

	UPDATE tbl_RegistrationPayments

    SET
		studentId			=	@studentId,
		intYear			=	@intYear,
		expectedAmt			=	@expectedAmt,
		amountPaid			=	@amountPaid,
		monthNumber			=	@monthNumber,
		Regdate			=	@date,
		penalty			=	@penalty

	WHERE
(
	studentId	=	@studentId
)

END

END

