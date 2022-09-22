USE [SchoolAd]
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_setExaminationFees]    Script Date: 11/19/2015 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER    PROCEDURE [dbo].[Insert_tbl_setExaminationFees](
		@streamId int=null,
		@examinationBoardId int=null,
		@centerFee money = null,
		@stationeryFee money = null,
		@subjectId int = null,
		@setExamFee money = null

		)

		AS

		BEGIN

    INSERT INTO [dbo].[tbl_setExaminationFees]
           ([streamId]
           ,[examinationBoardId]
           ,[centerFee]
           ,[stationeryFee]
           ,[subjectId]
           ,[setExamFee])
     VALUES
           (@streamId,
		    @examinationBoardId,
			@centerFee,
			@stationeryFee,
			@subjectId,
			@setExamFee

			)

			END