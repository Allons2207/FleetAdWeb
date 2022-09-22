USE [SchoolAd]
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_students]    Script Date: 11/16/2015 9:47:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER    PROCEDURE [dbo].[Insert_tbl_students]
(      
       @studentId nvarchar(20) = null,
       @firstName nvarchar(20) = null,
       @secondName nvarchar(20) = null,
       @surname nvarchar(20) = null,
       @registrationDate smalldatetime = null,
       @dateOfBirth smalldatetime = null,
       @birthNumber nvarchar(30) = null,
       @nationalIdNumber nvarchar(30) = null,
       @sexId nvarchar(30) = null,
       @studentPicture nvarchar(100) = null,
       @homeAddress nvarchar(150) = null,
      -- @unitSectionId nvarchar(30) = null,
       @hostelId nvarchar(30) = null,
       @schoolClassId nvarchar(30) = null,
       @healthConditionId nvarchar(30) = null,
       --@allergy1Id nvarchar(30) = null,
      -- @allergy2Id nvarchar(30) = null,
       @religionId nvarchar(30) = null,
       @schoolPositionId nvarchar(30) = null,
       @boardingStatusId nvarchar(30) = null,
       @disabilityId nvarchar(30) = null,
       @orphanhoodStatusId nvarchar(30) = null,
       @guardianFirstname nvarchar(50) = null,
       @guardianSurname nvarchar(50) = null,
       @relationshipToStudentId nvarchar(30) = null,
       @guardianTitleId nvarchar(30) = null,
       @guardianOccupationId nvarchar(30) = null,
       @guardianAddress nvarchar(150) = null,
       @guardianContactNumber nvarchar(30) = null,
	   @sportsHouseId nvarchar(30) = null,
       @dateLeft smalldatetime = null,
       @reasonForStudentLeavingId nvarchar(30) = null,
       @emailAddress nvarchar(200) = null,
       @guardianEmailAddress nvarchar(200) = null,
       @studentMaritalStatusId nvarchar(30) = null, 
       @guardianMaritalStatusId nvarchar(30) = null,
       @requiresTransportation nvarchar(30) = null,
       @studentContactNumber varchar(20) = null,
       @contractEndDate datetime = null,
       --@paymentFrequencyId nvarchar(30) = null,
       @registeredBy varchar(60) = null
	   )
	   AS 

	   BEGIN

	   INSERT INTO [dbo].[tbl_students]
           ([studentId]
           ,[firstName]
           ,[secondName]
           ,[surname]
           ,[registrationDate]
           ,[dateOfBirth]
           ,[birthNumber]
           ,[nationalIdNumber]
           ,[sexId]
           ,[studentPicture]
           ,[homeAddress]
           --,[unitSectionId]
           ,[hostelId]
           ,[schoolClassId]
           ,[healthConditionId]
           
		    ,[religionId]
           ,[schoolPositionId]
           ,[boardingStatusId]
           ,[disabilityId]
           ,[orphanhoodStatusId]
           ,[guardianFirstname]
           ,[guardianSurname]
           ,[relationshipToStudentId]
           ,[guardianTitleId]
           ,[guardianOccupationId]
           ,[guardianAddress]
           ,[guardianContactNumber]
           ,[sportsHouseId]
           ,[dateLeft]
           ,[reasonForStudentLeavingId]
           ,[emailAddress]
           ,[guardianEmailAddress]
           ,[studentMaritalStatusId]
           ,[guardianMaritalStatusId]
           ,[requiresTransportation]
           ,[studentContactNumber]
           ,[contractEndDate]
           --,[paymentFrequencyId]
           ,[registeredBy])
     VALUES
           (  
	   @studentId,
       @firstName,
       @secondName,
       @surname,
       @registrationDate,
       @dateOfBirth,
       @birthNumber,
       @nationalIdNumber,
       @sexId,
       @studentPicture,
       @homeAddress,
      
       @hostelId,
       @schoolClassId,
       @healthConditionId,
     
       @religionId,
       @schoolPositionId,
       @boardingStatusId,
       @disabilityId,
       @orphanhoodStatusId,
       @guardianFirstname,
       @guardianSurname,
       @relationshipToStudentId,
       @guardianTitleId,
       @guardianOccupationId,
       @guardianAddress,
       @guardianContactNumber,
	   @sportsHouseId,
       @dateLeft,
	   @reasonForStudentLeavingId,
       @emailAddress,
       @guardianEmailAddress,
       @studentMaritalStatusId,
       @guardianMaritalStatusId,
       @requiresTransportation,
       @studentContactNumber,
       @contractEndDate,
     
       @registeredBy
	   )

	   END 

