CREATE PROCEDURE [update_tbl_allPayments]
(

	@receiptNumber						[varchar](50)
	
)
AS UPDATE tbl_allPayments
SET
		receiptNumber			=	@receiptNumber
		
WHERE
(
	paymentId	=	@receiptNumber
)