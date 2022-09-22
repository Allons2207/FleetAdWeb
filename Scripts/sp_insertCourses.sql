CREATE PROCEDURE [insert_tbl_subjects]
	(
	@subject						[nvarchar](50)
	)
AS INSERT INTO tbl_subjects
	(
	subject
	)
VALUES
	(
	@subject
	)
