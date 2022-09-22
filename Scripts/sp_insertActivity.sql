CREATE PROCEDURE [insert_tbl_extraCurriculaActivities]
	(
	
	@activityName						[nvarchar](50)
	)
AS INSERT INTO tbl_extraCurriculaActivities
	(
	
	activityName
	)
VALUES
	(

	@activityName
	)
