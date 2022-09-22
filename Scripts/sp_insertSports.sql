CREATE PROCEDURE [insert_tbl_sports]
	(

	@sport						[nvarchar](50)
	)
AS INSERT INTO tbl_sports
	(
	
	sport
	)
VALUES
	(
	
	@sport
	)
