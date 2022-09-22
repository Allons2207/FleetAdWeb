CREATE PROCEDURE [insert_tbl_clubs]
	(

	@club						[nvarchar](60)
	)
AS INSERT INTO tbl_clubs
	(
	
	club
	)
VALUES
	(
	
	@club
	)
