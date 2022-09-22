USE [master]
GO
/****** Object:  Database [SchoolAd]    Script Date: 21-Jul-2016 1:49:33 PM ******/
CREATE DATABASE [SchoolAd]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'schoolAd', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolAd.mdf' , SIZE = 17408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'schoolAd_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SchoolAd_1.ldf' , SIZE = 6272KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SchoolAd] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolAd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolAd] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolAd] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolAd] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolAd] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolAd] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolAd] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SchoolAd] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolAd] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolAd] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolAd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolAd] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolAd] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolAd] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolAd] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolAd] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolAd] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SchoolAd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolAd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolAd] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolAd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolAd] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolAd] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolAd] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolAd] SET RECOVERY FULL 
GO
ALTER DATABASE [SchoolAd] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolAd] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolAd] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolAd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolAd] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SchoolAd]
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_allPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_allPayments]
	(
	@payment						[varchar](50),
	@amountPaid						[money],
	@studentId						[varchar](20),
	@dtDate						[datetime],
	@details						[nvarchar](100),
	@cashier						[varchar](100),
	@receiptNumber						[varchar](30)
	)
AS INSERT INTO tbl_allPayments
	(
	payment,
	amountPaid,
	studentId,
	dtDate,
	details,
	cashier,
	receiptNumber
	)
VALUES
	(
	@payment,
	@amountPaid,
	@studentId,
	@dtDate,
	@details,
	@cashier,
	@receiptNumber
	)

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_cashBook_closing]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_tbl_cashBook_closing]
	(
	    @entryNumber [int],
		@dtDate [date],
		@closing [money],
		@balance [money],
		@narration [nvarchar] (200),
		@capturedBy [nvarchar] (100)
	)

	AS
	BEGIN

	if  exists( select * from tbl_cashBook where entryNumber = @entryNumber)

	BEGIN

	UPDATE [dbo].tbl_cashBook

	SET
		dtDate = @dtDate,
		closing = @closing,
		balance = @balance,
		narration = @narration,
		capturedBy = @capturedBy
	WHERE
	(
	 entryNumber = @entryNumber
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_cashBook
	(
	dtDate, closing, balance, narration, capturedBy
	)
VALUES
	(
	@dtDate, @closing, @balance, @narration,@capturedBy
	)
END

END

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_cashBook_incoming]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_tbl_cashBook_incoming]
	(
	    @entryNumber [int],
		@dtDate [date],
		@incoming [money],
		@balance [money],
		@narration [nvarchar] (200),
		@capturedBy [nvarchar] (100)
	)

	AS
	BEGIN

	if  exists( select * from tbl_cashBook where entryNumber = @entryNumber)

	BEGIN

	UPDATE [dbo].tbl_cashBook

	SET
		dtDate = @dtDate,
		incoming = @incoming,
		balance = @balance,
		narration = @narration,
		capturedBy = @capturedBy
	WHERE
	(
	 entryNumber = @entryNumber
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_cashBook
	(
	dtDate, incoming, balance, narration, capturedBy
	)
VALUES
	(
	@dtDate, @incoming, @balance, @narration,@capturedBy
	)
END

END

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_cashBook_opening]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_tbl_cashBook_opening]
	(
	    @entryNumber [int],
		@dtDate [date],
		@opening [money],
		@balance [money],
		@narration [nvarchar] (200),
		@capturedBy [nvarchar] (100)
	)

	AS
	BEGIN

	if  exists( select * from tbl_cashBook where entryNumber = @entryNumber)

	BEGIN

	UPDATE [dbo].tbl_cashBook

	SET
		dtDate = @dtDate,
		opening = @opening,
		balance = @balance,
		narration = @narration,
		capturedBy = @capturedBy
	WHERE
	(
	 entryNumber = @entryNumber
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_cashBook
	(
	dtDate, opening, balance, narration, capturedBy
	)
VALUES
	(
	@dtDate, @opening, @balance, @narration,@capturedBy
	)
END

END

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_cashBook_outgoing]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insert_tbl_cashBook_outgoing]
	(
	    @entryNumber [int],
		@dtDate [date],
		@outgoing [money],
		@balance [money],
		@narration [nvarchar] (200),
		@capturedBy [nvarchar] (100)
	)

	AS
	BEGIN

	if  exists( select * from tbl_cashBook where entryNumber = @entryNumber)

	BEGIN

	UPDATE [dbo].tbl_cashBook

	SET
		dtDate = @dtDate,
		outgoing = @outgoing,
		balance = @balance,
		narration = @narration,
		capturedBy = @capturedBy
	WHERE
	(
	 entryNumber = @entryNumber
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_cashBook
	(
	dtDate, outgoing, balance, narration, capturedBy
	)
VALUES
	(
	@dtDate, @outgoing, @balance, @narration,@capturedBy
	)
END

END

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_classAttendanceRegister]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_classAttendanceRegister]
	(
	@dtDate						[smalldatetime],
	@stream						[nvarchar](30),
	@schClass						[nvarchar](30),
	@studentId						[nvarchar](20),
	@attendance						[bit],
	@comments						[nvarchar](30)
	)
	AS
	BEGIN
	if exists(select * from tbl_classAttendanceRegister where dtDate = @dtDate and studentId= @studentId )
	INSERT INTO tbl_classAttendanceRegister
	(
	dtDate,
	stream,
	schClass,
	studentId,
	attendance,
	comments
	)
	VALUES
	(
	@dtDate,
	@stream,
	@schClass,
	@studentId,
	@attendance,
	@comments
	)
	ELSE
	BEGIN
	UPDATE tbl_classAttendanceRegister
	SET
		dtDate			=	@dtDate,
		stream			=	@stream,
		schClass			=	@schClass,
		studentId			=	@studentId,
		attendance			=	@attendance,
		comments			=	@comments
	WHERE
	(
	dtDate = @dtDate and studentId= @studentId
	)
	END
	END
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_classTimeTable]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_classTimeTable]
	(
	@dDay						[nvarchar](30),
	@periodNumber						[int],
	@stream						[nvarchar](30),
	@class						[nvarchar](30),
	@subject						[nvarchar](30),
	@dayNumba						[int],
	@TeacherCode					[nvarchar](30)
	)
	AS

	BEGIN

	IF EXISTS(SELECT * FROM tbl_classTimeTable WHERE periodNumber = @periodNumber AND schClass = @class AND dayNumba = @dayNumba)

	BEGIN

	UPDATE tbl_classTimeTable
	SET
		dDay			=	@dDay,
		periodNumber	=	@periodNumber,
		stream			=	@stream,
		schClass			=	@class,
		[subject]			=	@subject,
		dayNumba		=	@dayNumba,
		TeacherCode		=	@TeacherCode
	WHERE
	(
	 periodNumber = @periodNumber AND schClass = @class AND dayNumba = @dayNumba
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_classTimeTable
	(
	dDay,
	periodNumber,
	stream,
	schClass,
	subject,
	dayNumba,
	TeacherCode
	)
VALUES
	(
	@dDay,
	@periodNumber,
	@stream,
	@class,
	@subject,
	@dayNumba,
	@TeacherCode
	)
	
	END

END
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_clubs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_clubs]
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

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_extraCurriculaActivities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_extraCurriculaActivities]
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

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_incidents]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_incidents]
	(
	@incidentNumber						[nvarchar](30),
	@dtDate						[smalldatetime],
	@incidentTypeId						[nvarchar](30),
	@incidentLevelId						[nvarchar](30),
	@location						[nvarchar](30),
	@offenderCategoryId						[nvarchar](30),
	@offenderId						[nvarchar](30),
	@offender						[nvarchar](100),
	@incidentDescription						[nvarchar](250),
	@disciplinaryActionId						[nvarchar](30),
	@stream						[nvarchar](30),
	@Schclass						[nvarchar](30)
	)
AS INSERT INTO tbl_incidents
	(
	
	incidentNumber,
	dtDate,
	incidentTypeId,
	incidentLevelId,
	location,
	offenderCategoryId,
	offenderId,
	offender,
	incidentDescription,
	disciplinaryActionId,
	stream,
	Schclass
	)
VALUES
	(
	
	@incidentNumber,
	@dtDate,
	@incidentTypeId,
	@incidentLevelId,
	@location,
	@offenderCategoryId,
	@offenderId,
	@offender,
	@incidentDescription,
	@disciplinaryActionId,
	@stream,
	@Schclass
	)

GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_LevyPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_tbl_LevyPayments](
		@studentd varchar(20) = null,
		@intYear int = null,
		@strTerm varchar(20) = null,
		@expectedAmt money = null,
		@amountPaid money = null,
		@termNumber int = null,
		@penalty money = null,
		@receiptNumber varchar(30)= null
		)
		AS 

		BEGIN

      INSERT INTO [dbo].[tbl_LevyPayments]
           ([studentd]
           ,[intYear]
           ,[strTerm]
           ,[expectedAmt]
           ,[amountPaid]
           ,[termNumber],
		    penalty,
			receiptNumber)
     VALUES
           (
		       @studentd,
			   @intYear,
			   @strTerm,
			   @expectedAmt,
			   @amountPaid,
			   @termNumber,
			   @penalty,
			   @receiptNumber
			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_libraryBookLending]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_libraryBookLending]
	(
	@bookId						[nvarchar](50),
	@title						[nvarchar](50),
	@authour						[nvarchar](60),
	@serialNumber						[nvarchar](30),
	@bookType						[nvarchar](30),
	@borrowerName						[nvarchar](60),
	@borrowerType						[nvarchar](30),
	@borrowerIdNumber						[nvarchar](30),
	@dateLoanedOut						[date],
	@loanDays						[nvarchar](30),
	@dueDate						[date],
	--@returnDate						[nvarchar](20),
	@returnStatus						[nvarchar](30),
	@penaltyAmt						[money],
----@numberOfBooks						[nvarchar](30),
	@comments						[nvarchar](255)
	--@penaltyPaid						[money]
	)
AS
BEGIN
IF EXISTS (Select * from tbl_libraryBookLending where bookId = @bookId)
BEGIN
 UPDATE tbl_libraryBookLending
SET
		bookId			=	@bookId,
		title			=	@title,
		authour			=	@authour,
		serialNumber			=	@serialNumber,
		bookType			=	@bookType,
		borrowerName			=	@borrowerName,
		borrowerType			=	@borrowerType,
		borrowerIdNumber			=	@borrowerIdNumber,
		dateLoanedOut			=	@dateLoanedOut,
		loanDays			=	@loanDays,
		dueDate			=	@dueDate,
		--returnDate			=	@returnDate,
		returnStatus			=	@returnStatus,
		penaltyAmt			=	@penaltyAmt,
		--numberOfBooks			=	@numberOfBooks,
		comments			=	@comments
		--penaltyPaid			=	@penaltyPaid
WHERE
(
	bookId	=	@bookId
)
END

ELSE

BEGIN

 INSERT INTO tbl_libraryBookLending
	(
	bookId,
	title,
	authour,
	serialNumber,
	bookType,
	borrowerName,
	borrowerType,
	borrowerIdNumber,
	dateLoanedOut,
	loanDays,
	dueDate,
	--returnDate,
	returnStatus,
	penaltyAmt,
	--numberOfBooks,
	comments
	--penaltyPaid
	)
VALUES
	(
	@bookId,
	@title,
	@authour,
	@serialNumber,
	@bookType,
	@borrowerName,
	@borrowerType,
	@borrowerIdNumber,
	@dateLoanedOut,
	@loanDays,
	@dueDate,
	--@returnDate,
	@returnStatus,
	@penaltyAmt,
	--@numberOfBooks,
	@comments
	--@penaltyPaid
	)
END

END
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_libraryBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_libraryBooks]
	(
	--@ctr						[int],
	@bookId						[nvarchar](50),
	@bookTitle						[nvarchar](50),
	@authorFirstName						[nvarchar](40),
	@authorSurname						[nvarchar](40),
	@subjectId						[int],
	@level1						[int],
	@level2						[int],
	@version						[nvarchar](50),
	@yearPublished						[int],
	@availability						[nvarchar](50),
	@lendingDays						[int],
	@bookTypeId						[int],
	@supplierId						[int],
	@conditionId						[int],
	@serialNumber						[nvarchar](50),
	@dateSupplied						[DATE]
		)

	AS
	BEGIN

	if  exists( select * from tbl_libraryBooks where bookId = @bookId)

	BEGIN

	UPDATE [dbo].[tbl_libraryBooks]

	SET
		--ctr			=	@ctr,
		bookId			=	@bookId,
		bookTitle			=	@bookTitle,
		authorFirstName			=	@authorFirstName,
		authorSurname			=	@authorSurname,
		subjectId			=	@subjectId,
		level1			=	@level1,
		level2			=	@level2,
		version			=	@version,
		yearPublished			=	@yearPublished,
		availability			=	@availability,
		lendingDays			=	@lendingDays,
		bookTypeId			=	@bookTypeId,
		supplierId			=	@supplierId,
		conditionId			=	@conditionId,
		serialNumber			=	@serialNumber,
		dateSupplied			=	@dateSupplied
	WHERE
	(
	bookId	=	@bookId
	)

	END

	ELSE

	BEGIN

	INSERT INTO tbl_libraryBooks
	(
	--ctr,
	bookId,
	bookTitle,
	authorFirstName,
	authorSurname,
	subjectId,
	level1,
	level2,
	version,
	yearPublished,
	availability,
	lendingDays,
	bookTypeId,
	supplierId,
	conditionId,
	serialNumber,
	dateSupplied
	)
VALUES
	(
	--@ctr,
	@bookId,
	@bookTitle,
	@authorFirstName,
	@authorSurname,
	@subjectId,
	@level1,
	@level2,
	@version,
	@yearPublished,
	@availability,
	@lendingDays,
	@bookTypeId,
	@supplierId,
	@conditionId,
	@serialNumber,
	@dateSupplied
	)
	END

	END
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_RegistrationPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_RegistrationPayments]
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


GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_schoolAssets]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_schoolAssets]
	(

	@assetName						[nvarchar](50),
	@assetNumber						[nvarchar](50),
	@serialNumber						[nvarchar](50),
	@functionalStateId						[nvarchar](50),
	@description						[nvarchar](150),
	@dateBought						[smalldatetime],
	@supplierId						[nvarchar](50),
	@quantity						[nvarchar](50),
	@totalValue						[money],
	@assetLocation						[nvarchar](50),
	@assetUser						[nvarchar](60)
	

	)
	AS


	if not exists (select * from tbl_schoolAssets where assetNumber = @assetNumber)
	BEGIN
	INSERT INTO tbl_schoolAssets
	(
	
	assetName,
	assetNumber,
	serialNumber,
	functionalStateId,
	[description],
	dateBought,
	supplierId,
	quantity,
	totalValue,
	assetLocation,
	assetUser
	
	)
VALUES
	(
	
	@assetName,
	@assetNumber,
	@serialNumber,
	@functionalStateId,
	@description,
	@dateBought,
	@supplierId,
	@quantity,
	@totalValue,
	@assetLocation,
	@assetUser
	)
	END

	ELSE

	BEGIN

	 UPDATE tbl_schoolAssets
		SET
		
		assetName			=	@assetName,
		assetNumber			=	@assetNumber,
		serialNumber			=	@serialNumber,
		functionalStateId			=	@functionalStateId,
		description			=	@description,
		dateBought			=	@dateBought,
		supplierId			=	@supplierId,
		quantity			=	@quantity,
		totalValue			=	@totalValue,
		assetLocation			=	@assetLocation,
		assetUser			=	@assetUser
WHERE
(
	assetNumber	=	@assetNumber
)
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_setExaminationFees]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_setExaminationFees](
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
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_setLevyPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_tbl_setLevyPaymentsSchedule](
		@streamId int = null,
		@amountPerTerm money = null
		
		)
		AS 

BEGIN
		if not exists( select * from [tbl_setLevyPaymentsSchedule] where streamid = @streamId)
BEGIN
      INSERT INTO [dbo].[tbl_setLevyPaymentsSchedule]
           ([streamId]
           ,amountPerTerm
           
		   )
     VALUES
           (
		       @streamId,
			   @amountPerTerm
			  
			   )

			   END

			   ELSE

 BEGIN

			   UPDATE [tbl_setLevyPaymentsSchedule] 

			   SET [streamId] = @streamId,
			    amountPerTerm = @amountPerTerm

			   WHERE streamId = @streamId

			END
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_setRegistrationPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_tbl_setRegistrationPaymentsSchedule](
		@streamId int = null,
		@amount money = null
		
		)
		AS 

BEGIN
		if not exists( select * from [tbl_setRegistrationPaymentsSchedule] where streamid = @streamId)
BEGIN
      INSERT INTO [dbo].[tbl_setRegistrationPaymentsSchedule]
           ([streamId]
           ,amount
           
		   )
     VALUES
           (
		       @streamId,
			   @amount
			  
			   )

			   END

			   ELSE

 BEGIN

			   UPDATE [tbl_setRegistrationPaymentsSchedule] 

			   SET [streamId] = @streamId,
			    amount = @amount

			   WHERE streamId = @streamId

			END
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_setTuitionPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_tbl_setTuitionPaymentsSchedule](
		@streamId int = null,
		@amountPerMonth money = null,
		@amountPerExtraSubject money = null,
		@computersFee money = null

		)
		AS 

		BEGIN
		if not exists( select * from [tbl_setTuitionPaymentsSchedule] where streamid = @streamId)
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

			 ELSE
	BEGIN
		  
		  UPDATE [tbl_setTuitionPaymentsSchedule] 

			   SET [streamId] = @streamId,
			    amountPerMonth = @amountPerMonth,
				[amountPerExtraSubject] = @amountPerExtraSubject,
				computersFee = @computersFee

			   WHERE streamId = @streamId

	END
	
END	  
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_sports]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_sports]
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

GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_staffDetails]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_staffDetails](

       @titleId int=null,
       @firstName nvarchar(50) = null,
       @secondName nvarchar(50) = null,
       @surname nvarchar(50) = null,
       @natIdNumber nvarchar(50) = null,
       @employmentNumber nvarchar(50) = null,
       @sexId int = null,
       @dateOfBirth smalldatetime = null,
       @jobTitleId int = null,
       @schoolStaffPositionId int = null,
       @dateOfInitiation smalldatetime = null,
       @dateAppointedToSchool smalldatetime = null,
       @contactNumber nvarchar(50) = null,
       @homeAddress nvarchar(80) = null,
       @maritalStatusId int = null,
       @numberOfDependants int = null,
       @nextOfKinName  nvarchar(80) = null,
       @relationshipId int = null,
       @nextOfKinContactNumber nvarchar(50) = null,
       @nextOfKinAddress nvarchar(80) = null,
       @salary  nvarchar(50) = null,
       @officeNumber nvarchar(50) = null,
       @dateLeft smalldatetime = null,
       @reasonForLeavingId int = null,
       @healthConditionId int = null,
       @emailAddress nvarchar(50) = null,
       @unitSectionId int = null
	   )

 AS 

 BEGIN
 
		if not exists( select * from [tbl_staffDetails] where employmentNumber = @employmentNumber)
		BEGIN

INSERT INTO [dbo].[tbl_staffDetails]
           ([titleId]
           ,[firstName]
           ,[secondName]
           ,[surname]
           ,[natIdNumber]
           ,[employmentNumber]
           ,[sexId]
           ,[dateOfBirth]
           ,[jobTitleId]
           ,[schoolStaffPositionId]
           ,[dateOfInitiation]
           ,[dateAppointedToSchool]
           ,[contactNumber]
           ,[homeAddress]
           ,[maritalStatusId]
           ,[numberOfDependants]
           ,[nextOfKinName]
           ,[relationshipId]
           ,[nextOfKinContactNumber]
           ,[nextOfKinAddress]
           ,[salary]
           ,[officeNumber]
           ,[dateLeft]
           ,[reasonForLeavingId]
           ,[healthConditionId]
           ,[emailAddress]
           ,[unitSectionId])
     VALUES
	 (
       @titleId,
       @firstName,
       @secondName,
       @surname,
       @natIdNumber,
       @employmentNumber,
       @sexId,
       @dateOfBirth,
       @jobTitleId,
       @schoolStaffPositionId,
       @dateOfInitiation,
       @dateAppointedToSchool,
       @contactNumber,
       @homeAddress,
       @maritalStatusId,
       @numberOfDependants,
       @nextOfKinName,
       @relationshipId,
       @nextOfKinContactNumber,
       @nextOfKinAddress,
       @salary,
       @officeNumber,
       @dateLeft,
       @reasonForLeavingId,
       @healthConditionId,
       @emailAddress,
       @unitSectionId
	   )
END
 ELSE
	BEGIN
		  
		  UPDATE [dbo].[tbl_staffDetails]
		  SET
		titleId			=	@titleId,
		firstName			=	@firstName,
		secondName			=	@secondName,
		surname			=	@surname,
		natIdNumber			=	@natIdNumber,
		employmentNumber			=	@employmentNumber,
		sexId			=	@sexId,
		dateOfBirth			=	@dateOfBirth,
		jobTitleId			=	@jobTitleId,
		schoolStaffPositionId			=	@schoolStaffPositionId,
		dateOfInitiation			=	@dateOfInitiation,
		dateAppointedToSchool			=	@dateAppointedToSchool,
		contactNumber			=	@contactNumber,
		homeAddress			=	@homeAddress,
		maritalStatusId			=	@maritalStatusId,
		numberOfDependants			=	@numberOfDependants,
		nextOfKinName			=	@nextOfKinName,
		relationshipId			=	@relationshipId,
		nextOfKinContactNumber			=	@nextOfKinContactNumber,
		nextOfKinAddress			=	@nextOfKinAddress,
		salary			=	@salary,
		officeNumber			=	@officeNumber,
		dateLeft			=	@dateLeft,
		reasonForLeavingId			=	@reasonForLeavingId,
		healthConditionId			=	@healthConditionId,
		emailAddress			=	@emailAddress,
		unitSectionId			=	@unitSectionId
WHERE
(
	 employmentNumber = @employmentNumber
)
 
 END

 END

GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_staffQualifications]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_tbl_staffQualifications](
		@employmentNumber varchar(30) = null,
		@qualificationId  varchar(10) = null,
		@qualificationLevelId varchar(10) = null,
		@collegeId varchar(10) = null,
		@yearAttained date = null

		)
		AS 

		BEGIN

      INSERT INTO tbl_staffQualifications
           (employmentNumber
           ,qualificationId
           ,qualificationLevelId
           ,collegeId
		   ,yearAttained )
     VALUES
           (
		       @employmentNumber,
			   @qualificationId,
			   @qualificationLevelId,
			   @collegeId,
			  year(@yearAttained)

			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_studentClubs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_studentClubs]
( 
	@club nvarchar(50) = null,
	@studentId nvarchar(50) = null
   )
 AS 

 BEGIN
 INSERT INTO [dbo].tbl_studentClubs
           ([studentId]
           , club)
     VALUES
           (
		   @studentId,
		   @club
		   )
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_studentExtraCurriculaActivities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_studentExtraCurriculaActivities]
( 
	@activityId nvarchar(50) = null,
	@studentId nvarchar(50) = null
   )
 AS 

 BEGIN
 INSERT INTO [dbo].tbl_studentExtraCurriculaActivities
           ([studentId]
           ,activityId)
     VALUES
           (
		   @studentId,
		   @activityId
		   )
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_students]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_students]
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
       @Status nvarchar(30) = null,
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
	
		if  exists( select * from [tbl_students] where studentid = @studentId)
		BEGIN

UPDATE [dbo].[tbl_students]

   SET [studentId] = @studentId
      ,[firstName] = @firstName
      ,[secondName] = @secondName
      ,[surname] = @surname
      ,[registrationDate] = @registrationDate
      ,[dateOfBirth] = @dateOfBirth
      ,[birthNumber] = @birthNumber
      ,[nationalIdNumber] = @nationalIdNumber
      ,[sexId] = @sexId
      ,[studentPicture] = @studentPicture
      ,[homeAddress] = @homeAddress
      ,[hostelId] = @hostelId
      ,[schoolClassId] = @schoolClassId
      ,[healthConditionId] = @healthConditionId
      ,[religionId] = @religionId
      ,[schoolPositionId] = @schoolPositionId
      ,[boardingStatusId] = @boardingStatusId
      ,[disabilityId] = @disabilityId
      ,[orphanhoodStatusId] = @orphanhoodStatusId
      ,[guardianFirstname] = @guardianFirstname
      ,[guardianSurname] = @guardianSurname
	  ,[status] = @Status
      ,[relationshipToStudentId] = @relationshipToStudentId
      ,[guardianTitleId] = @guardianTitleId
      ,[guardianOccupationId] = @guardianOccupationId
      ,[guardianAddress] = @guardianAddress
      ,[guardianContactNumber] = @guardianContactNumber
      ,[dateLeft] = @dateLeft
      ,[reasonForStudentLeavingId] = @reasonForStudentLeavingId
      ,[emailAddress] = @emailAddress
      ,[guardianEmailAddress] = @guardianAddress
      ,[studentMaritalStatusId] = @studentMaritalStatusId
      ,[guardianMaritalStatusId] = @guardianMaritalStatusId
      ,[requiresTransportation] = @requiresTransportation
      ,[studentContactNumber] = @studentContactNumber
      ,[contractEndDate] = @contractEndDate
      ,[registeredBy] = @registeredBy

 WHERE StudentId = @studentId

END 

			 ELSE
	BEGIN
		  INSERT INTO tbl_students

	  ( [studentId] 
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
      ,[hostelId]
	  ,[status]
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
      ,[dateLeft]
      ,[reasonForStudentLeavingId]
      ,[emailAddress]
      ,[guardianEmailAddress]
      ,[studentMaritalStatusId]
      ,[guardianMaritalStatusId]
      ,[requiresTransportation]
      ,[studentContactNumber]
      ,[contractEndDate]
      ,[registeredBy] 
	  )
	 VALUES
	 (
	  @studentId,
	  @firstName,
	  @secondName,
	  @surname,
	  @registrationDate
      ,@dateOfBirth
      ,@birthNumber
      ,@nationalIdNumber
      ,@sexId
      ,@studentPicture
      ,@homeAddress
      ,@hostelId
	  ,@Status
      ,@schoolClassId
      ,@healthConditionId
      ,@religionId
      ,@schoolPositionId
      ,@boardingStatusId
      ,@disabilityId
      ,@orphanhoodStatusId
      ,@guardianFirstname
      ,@guardianSurname
      ,@relationshipToStudentId
      ,@guardianTitleId
      ,@guardianOccupationId
      ,@guardianAddress
      ,@guardianContactNumber
      ,@dateLeft
      ,@reasonForStudentLeavingId
      ,@emailAddress
      ,@guardianAddress
      ,@studentMaritalStatusId
      ,@guardianMaritalStatusId
      ,@requiresTransportation
      ,@studentContactNumber
      ,@contractEndDate
      ,@registeredBy
	  )

	END
	
END	  







GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_studentSports]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_studentSports]
( 
	@sport nvarchar(30) = null,
	@studentId nvarchar(50) = null
   )
 AS 

 BEGIN
 INSERT INTO [dbo].[tbl_studentSports]
           ([studentId]
           ,sport)
     VALUES
           (
		   @studentId,
		   @sport
		   )
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_studentSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[Insert_tbl_studentSubjects]
( 
	@subject nvarchar(30) = null,
	@studentId nvarchar(50) = null
   )
 AS 

 BEGIN
 INSERT INTO [dbo].[tbl_studentSubjects]
           ([studentId]
           ,[subjectId])
     VALUES
           (
		   @studentId,
		   @subject
		   )
END
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_subjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_subjects]
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

GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_systemUsers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tbl_systemUsers]
	(
	@userId						[nvarchar](50),
	@firstName						[nvarchar](30),
	@lastName						[nvarchar](30),
	@active						[int],
	@password						[nvarchar](50),
	@userGroupId						[int]
	)
	AS
	BEGIN
	If exists (select * from tbl_systemUsers where userId = @userId	)

	INSERT INTO tbl_systemUsers
	(
	userId,
	firstName,
	lastName,
	active,
	[password],
	userGroupId
	)
VALUES
	(
	@userId,
	@firstName,
	@lastName,
	@active,
	@password,
	@userGroupId
	)
 ELSE

 UPDATE tbl_systemUsers
SET
		userId			=	@userId,
		firstName			=	@firstName,
		lastName			=	@lastName,
		active			=	@active,
		[password]			=	@password,
		userGroupId			=	@userGroupId
WHERE
(
	userId	=	@userId
)

END
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_transportPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_tbl_transportPayments](
		@studentId varchar(20) = null,
		@yYear int = null,
		@mMonth varchar(20) = null,
		@setAmount money = null,
		@amountPaid money = null,
		@receiptNumber int = null

		)
		AS 

		BEGIN

      INSERT INTO [dbo].tbl_transportPayments
           ([studentId]
           ,yYear
           ,mMonth
           ,setAmount
           ,[amountPaid]
           ,receiptNumber)
     VALUES
           (
		       @studentId,
			   @yYear,
			   @mMonth,
			   @setAmount,
			   @amountPaid,
			   @receiptNumber
			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_transportSetAmounts]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_tbl_transportSetAmounts](
		@mmonth varchar(20) = null,
		@amount money = null,
		@yYear int = null

		)
		AS 

		BEGIN
		if not exists( select * from tbl_transportSetAmounts where mmonth = @mmonth)
		BEGIN
      INSERT INTO [dbo].[tbl_transportSetAmounts]
           (mmonth
           ,amount
           ,yYear
           )
     VALUES
           (
		       @mmonth,
			   @amount,
			   @yYear
			   
			   )
			END 

			 ELSE
	BEGIN
		  
		  UPDATE [tbl_transportSetAmounts] 

			   SET mmonth = @mmonth,
			    amount = @amount,
				yYear = @yYear
				

			  where mmonth = @mmonth

	END
	
END	  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_tuitionPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_tbl_tuitionPayments](
		@studentId varchar(20) = null,
		@intYear int = null,
		@strMonth varchar(20) = null,
		@expectedAmt money =  null,
		@amountPaid money = null,
		@monthNumber int = null,
		@penalty money = null,
		@receiptNumber nvarchar(20) = null
		)
		AS 

		BEGIN

      INSERT INTO [dbo].[tbl_tuitionPayments]
           ([studentId]
           ,[intYear]
           ,[strMonth]
           ,[expectedAmt]
           ,[amountPaid]
           ,[monthNumber],
		   date,
		   penalty,
		   receiptNumber
		   )
     VALUES
           (
		       @studentId,
			   @intYear,
			   @strMonth,
			   @expectedAmt,
			   @amountPaid,
			   @monthNumber,
			   GETDATE(),
			   @penalty,
			   @receiptNumber
			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_uniformItems]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Insert_tbl_uniformItems](
		
		@uniformItem varchar(20) = null,
		@price money = null
		
	
		)
		AS 
		 
		BEGIN

      INSERT INTO [dbo].tbl_uniformItems
           (
           uniformItem,
		   price
           )
     VALUES
           (
		    @uniformItem,
			@price 

			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[Insert_tbl_uniformSales]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Insert_tbl_uniformSales](
		
		@dtDate date = null,
		@receiptNumber int = null,
		@studentId varchar(20) = null,
		@uniformItem varchar(50) = null,
		@unitPrice money = null,
		@quantity int = null,
		@totalPrice money = null
	
		)
		AS 
		 
		BEGIN

      INSERT INTO [dbo].tbl_uniformSales
           (
           dtDate
           ,receiptNumber
           ,studentId
           ,uniformItem
		   ,unitPrice
		   ,quantity
		   ,totalPrice)
     VALUES
           (
		      
			   @dtDate,
			   @receiptNumber,
			   @studentId,
			   @uniformItem,
			   @unitPrice,
			   @quantity,
			   @totalPrice

			   )
			
	END
		  
GO
/****** Object:  StoredProcedure [dbo].[insert_tblIncidentsLocation]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_tblIncidentsLocation]
	(
	@locationID						[int],
	@location						[nvarchar](50)
	)
AS INSERT INTO tblIncidentsLocation
	(
	locationID,
	location
	)
VALUES
	(
	@locationID,
	@location
	)


GO
/****** Object:  StoredProcedure [dbo].[sp_generate_inserts]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[sp_generate_inserts]
(
	@table_name varchar(776),  		-- The table/view for which the INSERT statements will be generated using the existing data
	@target_table varchar(776) = NULL, 	-- Use this parameter to specify a different table name into which the data will be inserted
	@include_column_list bit = 1,		-- Use this parameter to include/ommit column list in the generated INSERT statement
	@from varchar(800) = NULL, 		-- Use this parameter to filter the rows based on a filter condition (using WHERE)
	@include_timestamp bit = 0, 		-- Specify 1 for this parameter, if you want to include the TIMESTAMP/ROWVERSION column's data in the INSERT statement
	@debug_mode bit = 0,			-- If @debug_mode is set to 1, the SQL statements constructed by this procedure will be printed for later examination
	@owner varchar(64) = NULL,		-- Use this parameter if you are not the owner of the table
	@ommit_images bit = 0,			-- Use this parameter to generate INSERT statements by omitting the 'image' columns
	@ommit_identity bit = 0,		-- Use this parameter to ommit the identity columns
	@top int = NULL,			-- Use this parameter to generate INSERT statements only for the TOP n rows
	@cols_to_include varchar(8000) = NULL,	-- List of columns to be included in the INSERT statement
	@cols_to_exclude varchar(8000) = NULL,	-- List of columns to be excluded from the INSERT statement
	@disable_constraints bit = 0,		-- When 1, disables foreign key constraints and enables them after the INSERT statements
	@ommit_computed_cols bit = 0		-- When 1, computed columns will not be included in the INSERT statement
	
)
AS
BEGIN

/***********************************************************************************************************
Procedure:	sp_generate_inserts  (Build 22) 
		(Copyright © 2002 Narayana Vyas Kondreddi. All rights reserved.)
                                          
Purpose:	To generate INSERT statements from existing data. 
		These INSERTS can be executed to regenerate the data at some other location.
		This procedure is also useful to create a database setup, where in you can 
		script your data along with your table definitions.

Written by:	Narayana Vyas Kondreddi
	        http://vyaskn.tripod.com

Acknowledgements:
		Divya Kalra	-- For beta testing
		Mark Charsley	-- For reporting a problem with scripting uniqueidentifier columns with NULL values
		Artur Zeygman	-- For helping me simplify a bit of code for handling non-dbo owned tables
		Joris Laperre   -- For reporting a regression bug in handling text/ntext columns

Tested on: 	SQL Server 7.0 and SQL Server 2000 and SQL Server 2005

Date created:	January 17th 2001 21:52 GMT

Date modified:	May 1st 2002 19:50 GMT

Email: 		vyaskn@hotmail.com

NOTE:		This procedure may not work with tables with too many columns.
		Results can be unpredictable with huge text columns or SQL Server 2000's sql_variant data types
		Whenever possible, Use @include_column_list parameter to ommit column list in the INSERT statement, for better results
		IMPORTANT: This procedure is not tested with internation data (Extended characters or Unicode). If needed
		you might want to convert the datatypes of character variables in this procedure to their respective unicode counterparts
		like nchar and nvarchar

		ALSO NOTE THAT THIS PROCEDURE IS NOT UPDATED TO WORK WITH NEW DATA TYPES INTRODUCED IN SQL SERVER 2005 / YUKON
		

Example 1:	To generate INSERT statements for table 'titles':
		
		EXEC sp_generate_inserts 'titles'

Example 2: 	To ommit the column list in the INSERT statement: (Column list is included by default)
		IMPORTANT: If you have too many columns, you are advised to ommit column list, as shown below,
		to avoid erroneous results
		
		EXEC sp_generate_inserts 'titles', @include_column_list = 0

Example 3:	To generate INSERT statements for 'titlesCopy' table from 'titles' table:

		EXEC sp_generate_inserts 'titles', 'titlesCopy'

Example 4:	To generate INSERT statements for 'titles' table for only those titles 
		which contain the word 'Computer' in them:
		NOTE: Do not complicate the FROM or WHERE clause here. It's assumed that you are good with T-SQL if you are using this parameter

		EXEC sp_generate_inserts 'titles', @from = "from titles where title like '%Computer%'"

Example 5: 	To specify that you want to include TIMESTAMP column's data as well in the INSERT statement:
		(By default TIMESTAMP column's data is not scripted)

		EXEC sp_generate_inserts 'titles', @include_timestamp = 1

Example 6:	To print the debug information:
  
		EXEC sp_generate_inserts 'titles', @debug_mode = 1

Example 7: 	If you are not the owner of the table, use @owner parameter to specify the owner name
		To use this option, you must have SELECT permissions on that table

		EXEC sp_generate_inserts Nickstable, @owner = 'Nick'

Example 8: 	To generate INSERT statements for the rest of the columns excluding images
		When using this otion, DO NOT set @include_column_list parameter to 0.

		EXEC sp_generate_inserts imgtable, @ommit_images = 1

Example 9: 	To generate INSERT statements excluding (ommiting) IDENTITY columns:
		(By default IDENTITY columns are included in the INSERT statement)

		EXEC sp_generate_inserts mytable, @ommit_identity = 1

Example 10: 	To generate INSERT statements for the TOP 10 rows in the table:
		
		EXEC sp_generate_inserts mytable, @top = 10

Example 11: 	To generate INSERT statements with only those columns you want:
		
		EXEC sp_generate_inserts titles, @cols_to_include = "'title','title_id','au_id'"

Example 12: 	To generate INSERT statements by omitting certain columns:
		
		EXEC sp_generate_inserts titles, @cols_to_exclude = "'title','title_id','au_id'"

Example 13:	To avoid checking the foreign key constraints while loading data with INSERT statements:
		
		EXEC sp_generate_inserts titles, @disable_constraints = 1

Example 14: 	To exclude computed columns from the INSERT statement:
		EXEC sp_generate_inserts MyTable, @ommit_computed_cols = 1
***********************************************************************************************************/

SET NOCOUNT ON

--Making sure user only uses either @cols_to_include or @cols_to_exclude
IF ((@cols_to_include IS NOT NULL) AND (@cols_to_exclude IS NOT NULL))
	BEGIN
		RAISERROR('Use either @cols_to_include or @cols_to_exclude. Do not use both the parameters at once',16,1)
		RETURN -1 --Failure. Reason: Both @cols_to_include and @cols_to_exclude parameters are specified
	END

--Making sure the @cols_to_include and @cols_to_exclude parameters are receiving values in proper format
IF ((@cols_to_include IS NOT NULL) AND (PATINDEX('''%''',@cols_to_include) = 0))
	BEGIN
		RAISERROR('Invalid use of @cols_to_include property',16,1)
		PRINT 'Specify column names surrounded by single quotes and separated by commas'
		PRINT 'Eg: EXEC sp_generate_inserts titles, @cols_to_include = "''title_id'',''title''"'
		RETURN -1 --Failure. Reason: Invalid use of @cols_to_include property
	END

IF ((@cols_to_exclude IS NOT NULL) AND (PATINDEX('''%''',@cols_to_exclude) = 0))
	BEGIN
		RAISERROR('Invalid use of @cols_to_exclude property',16,1)
		PRINT 'Specify column names surrounded by single quotes and separated by commas'
		PRINT 'Eg: EXEC sp_generate_inserts titles, @cols_to_exclude = "''title_id'',''title''"'
		RETURN -1 --Failure. Reason: Invalid use of @cols_to_exclude property
	END


--Checking to see if the database name is specified along wih the table name
--Your database context should be local to the table for which you want to generate INSERT statements
--specifying the database name is not allowed
IF (PARSENAME(@table_name,3)) IS NOT NULL
	BEGIN
		RAISERROR('Do not specify the database name. Be in the required database and just specify the table name.',16,1)
		RETURN -1 --Failure. Reason: Database name is specified along with the table name, which is not allowed
	END

--Checking for the existence of 'user table' or 'view'
--This procedure is not written to work on system tables
--To script the data in system tables, just create a view on the system tables and script the view instead

IF @owner IS NULL
	BEGIN
		IF ((OBJECT_ID(@table_name,'U') IS NULL) AND (OBJECT_ID(@table_name,'V') IS NULL)) 
			BEGIN
				RAISERROR('User table or view not found.',16,1)
				PRINT 'You may see this error, if you are not the owner of this table or view. In that case use @owner parameter to specify the owner name.'
				PRINT 'Make sure you have SELECT permission on that table or view.'
				RETURN -1 --Failure. Reason: There is no user table or view with this name
			END
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table_name AND (TABLE_TYPE = 'BASE TABLE' OR TABLE_TYPE = 'VIEW') AND TABLE_SCHEMA = @owner)
			BEGIN
				RAISERROR('User table or view not found.',16,1)
				PRINT 'You may see this error, if you are not the owner of this table. In that case use @owner parameter to specify the owner name.'
				PRINT 'Make sure you have SELECT permission on that table or view.'
				RETURN -1 --Failure. Reason: There is no user table or view with this name		
			END
	END

--Variable declarations
DECLARE		@Column_ID int, 		
		@Column_List varchar(8000), 
		@Column_Name varchar(128), 
		@Start_Insert varchar(786), 
		@Data_Type varchar(128), 
		@Actual_Values varchar(8000),	--This is the string that will be finally executed to generate INSERT statements
		@IDN varchar(128)		--Will contain the IDENTITY column's name in the table

--Variable Initialization
SET @IDN = ''
SET @Column_ID = 0
SET @Column_Name = ''
SET @Column_List = ''
SET @Actual_Values = ''

IF @owner IS NULL 
	BEGIN
		SET @Start_Insert = 'INSERT INTO ' + '[' + RTRIM(COALESCE(@target_table,@table_name)) + ']' 
	END
ELSE
	BEGIN
		SET @Start_Insert = 'INSERT ' + '[' + LTRIM(RTRIM(@owner)) + '].' + '[' + RTRIM(COALESCE(@target_table,@table_name)) + ']' 		
	END


--To get the first column's ID

SELECT	@Column_ID = MIN(ORDINAL_POSITION) 	
FROM	INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
WHERE 	TABLE_NAME = @table_name AND
(@owner IS NULL OR TABLE_SCHEMA = @owner)



--Loop through all the columns of the table, to get the column names and their data types
WHILE @Column_ID IS NOT NULL
	BEGIN
		SELECT 	@Column_Name = QUOTENAME(COLUMN_NAME), 
		@Data_Type = DATA_TYPE 
		FROM 	INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
		WHERE 	ORDINAL_POSITION = @Column_ID AND 
		TABLE_NAME = @table_name AND
		(@owner IS NULL OR TABLE_SCHEMA = @owner)



		IF @cols_to_include IS NOT NULL --Selecting only user specified columns
		BEGIN
			IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_include) = 0 
			BEGIN
				GOTO SKIP_LOOP
			END
		END

		IF @cols_to_exclude IS NOT NULL --Selecting only user specified columns
		BEGIN
			IF CHARINDEX( '''' + SUBSTRING(@Column_Name,2,LEN(@Column_Name)-2) + '''',@cols_to_exclude) <> 0 
			BEGIN
				GOTO SKIP_LOOP
			END
		END

		--Making sure to output SET IDENTITY_INSERT ON/OFF in case the table has an IDENTITY column
		IF (SELECT COLUMNPROPERTY( OBJECT_ID(QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + @table_name),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsIdentity')) = 1 
		BEGIN
			IF @ommit_identity = 0 --Determing whether to include or exclude the IDENTITY column
				SET @IDN = @Column_Name
			ELSE
				GOTO SKIP_LOOP			
		END
		
		--Making sure whether to output computed columns or not
		IF @ommit_computed_cols = 1
		BEGIN
			IF (SELECT COLUMNPROPERTY( OBJECT_ID(QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + @table_name),SUBSTRING(@Column_Name,2,LEN(@Column_Name) - 2),'IsComputed')) = 1 
			BEGIN
				GOTO SKIP_LOOP					
			END
		END
		
		--Tables with columns of IMAGE data type are not supported for obvious reasons
		IF(@Data_Type in ('image'))
			BEGIN
				IF (@ommit_images = 0)
					BEGIN
						RAISERROR('Tables with image columns are not supported.',16,1)
						PRINT 'Use @ommit_images = 1 parameter to generate INSERTs for the rest of the columns.'
						PRINT 'DO NOT ommit Column List in the INSERT statements. If you ommit column list using @include_column_list=0, the generated INSERTs will fail.'
						RETURN -1 --Failure. Reason: There is a column with image data type
					END
				ELSE
					BEGIN
					GOTO SKIP_LOOP
					END
			END

		--Determining the data type of the column and depending on the data type, the VALUES part of
		--the INSERT statement is generated. Care is taken to handle columns with NULL values. Also
		--making sure, not to lose any data from flot, real, money, smallmomey, datetime columns
		SET @Actual_Values = @Actual_Values  +
		CASE 
			WHEN @Data_Type IN ('char','varchar','nchar','nvarchar') 
				THEN 
					'COALESCE('''''''' + REPLACE(RTRIM(' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')'
			WHEN @Data_Type IN ('datetime','smalldatetime') 
				THEN 
					'COALESCE('''''''' + RTRIM(CONVERT(char,' + @Column_Name + ',109))+'''''''',''NULL'')'
			WHEN @Data_Type IN ('uniqueidentifier') 
				THEN  
					'COALESCE('''''''' + REPLACE(CONVERT(char(255),RTRIM(' + @Column_Name + ')),'''''''','''''''''''')+'''''''',''NULL'')'
			WHEN @Data_Type IN ('text','ntext') 
				THEN  
					'COALESCE('''''''' + REPLACE(CONVERT(char(8000),' + @Column_Name + '),'''''''','''''''''''')+'''''''',''NULL'')'					
			WHEN @Data_Type IN ('binary','varbinary') 
				THEN  
					'COALESCE(RTRIM(CONVERT(char,' + 'CONVERT(int,' + @Column_Name + '))),''NULL'')'  
			WHEN @Data_Type IN ('timestamp','rowversion') 
				THEN  
					CASE 
						WHEN @include_timestamp = 0 
							THEN 
								'''DEFAULT''' 
							ELSE 
								'COALESCE(RTRIM(CONVERT(char,' + 'CONVERT(int,' + @Column_Name + '))),''NULL'')'  
					END
			WHEN @Data_Type IN ('float','real','money','smallmoney')
				THEN
					'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' +  @Column_Name  + ',2)' + ')),''NULL'')' 
			ELSE 
				'COALESCE(LTRIM(RTRIM(' + 'CONVERT(char, ' +  @Column_Name  + ')' + ')),''NULL'')' 
		END   + '+' +  ''',''' + ' + '
		
		--Generating the column list for the INSERT statement
		SET @Column_List = @Column_List +  @Column_Name + ','	

		SKIP_LOOP: --The label used in GOTO

		SELECT 	@Column_ID = MIN(ORDINAL_POSITION) 
		FROM 	INFORMATION_SCHEMA.COLUMNS (NOLOCK) 
		WHERE 	TABLE_NAME = @table_name AND 
		ORDINAL_POSITION > @Column_ID AND
		(@owner IS NULL OR TABLE_SCHEMA = @owner)


	--Loop ends here!
	END

--To get rid of the extra characters that got concatenated during the last run through the loop
SET @Column_List = LEFT(@Column_List,len(@Column_List) - 1)
SET @Actual_Values = LEFT(@Actual_Values,len(@Actual_Values) - 6)

IF LTRIM(@Column_List) = '' 
	BEGIN
		RAISERROR('No columns to select. There should at least be one column to generate the output',16,1)
		RETURN -1 --Failure. Reason: Looks like all the columns are ommitted using the @cols_to_exclude parameter
	END

--Forming the final string that will be executed, to output the INSERT statements
IF (@include_column_list <> 0)
	BEGIN
		SET @Actual_Values = 
			'SELECT ' +  
			CASE WHEN @top IS NULL OR @top < 0 THEN '' ELSE ' TOP ' + LTRIM(STR(@top)) + ' ' END + 
			'''' + RTRIM(@Start_Insert) + 
			' ''+' + '''(' + RTRIM(@Column_List) +  '''+' + ''')''' + 
			' +''VALUES(''+ ' +  @Actual_Values  + '+'')''' + ' ' + 
			COALESCE(@from,' FROM ' + CASE WHEN @owner IS NULL THEN '' ELSE '[' + LTRIM(RTRIM(@owner)) + '].' END + '[' + rtrim(@table_name) + ']' + '(NOLOCK)')
	END
ELSE IF (@include_column_list = 0)
	BEGIN
		SET @Actual_Values = 
			'SELECT ' + 
			CASE WHEN @top IS NULL OR @top < 0 THEN '' ELSE ' TOP ' + LTRIM(STR(@top)) + ' ' END + 
			'''' + RTRIM(@Start_Insert) + 
			' '' +''VALUES(''+ ' +  @Actual_Values + '+'')''' + ' ' + 
			COALESCE(@from,' FROM ' + CASE WHEN @owner IS NULL THEN '' ELSE '[' + LTRIM(RTRIM(@owner)) + '].' END + '[' + rtrim(@table_name) + ']' + '(NOLOCK)')
	END	

--Determining whether to ouput any debug information
IF @debug_mode =1
	BEGIN
		PRINT '/*****START OF DEBUG INFORMATION*****'
		PRINT 'Beginning of the INSERT statement:'
		PRINT @Start_Insert
		PRINT ''
		PRINT 'The column list:'
		PRINT @Column_List
		PRINT ''
		PRINT 'The SELECT statement executed to generate the INSERTs'
		PRINT @Actual_Values
		PRINT ''
		PRINT '*****END OF DEBUG INFORMATION*****/'
		PRINT ''
	END
		
PRINT '--INSERTs generated by ''sp_generate_inserts'' stored procedure written by Vyas'
PRINT '--Build number: 22'
PRINT '--Problems/Suggestions? Contact Vyas @ vyaskn@hotmail.com'
PRINT '--http://vyaskn.tripod.com'
PRINT ''
PRINT 'SET NOCOUNT ON'
PRINT ''


--Determining whether to print IDENTITY_INSERT or not
IF (@IDN <> '')
	BEGIN
		PRINT 'SET IDENTITY_INSERT ' + QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + QUOTENAME(@table_name) + ' ON'
		PRINT 'GO'
		PRINT ''
	END


IF @disable_constraints = 1 AND (OBJECT_ID(QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + @table_name, 'U') IS NOT NULL)
	BEGIN
		IF @owner IS NULL
			BEGIN
				SELECT 	'ALTER TABLE ' + QUOTENAME(COALESCE(@target_table, @table_name)) + ' NOCHECK CONSTRAINT ALL' AS '--Code to disable constraints temporarily'
			END
		ELSE
			BEGIN
				SELECT 	'ALTER TABLE ' + QUOTENAME(@owner) + '.' + QUOTENAME(COALESCE(@target_table, @table_name)) + ' NOCHECK CONSTRAINT ALL' AS '--Code to disable constraints temporarily'
			END

		PRINT 'GO'
	END

PRINT ''
PRINT 'PRINT ''Inserting values into ' + '[' + RTRIM(COALESCE(@target_table,@table_name)) + ']' + ''''


--All the hard work pays off here!!! You'll get your INSERT statements, when the next line executes!
EXEC (@Actual_Values)

PRINT 'PRINT ''Done'''
PRINT ''


IF @disable_constraints = 1 AND (OBJECT_ID(QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + @table_name, 'U') IS NOT NULL)
	BEGIN
		IF @owner IS NULL
			BEGIN
				SELECT 	'ALTER TABLE ' + QUOTENAME(COALESCE(@target_table, @table_name)) + ' CHECK CONSTRAINT ALL'  AS '--Code to enable the previously disabled constraints'
			END
		ELSE
			BEGIN
				SELECT 	'ALTER TABLE ' + QUOTENAME(@owner) + '.' + QUOTENAME(COALESCE(@target_table, @table_name)) + ' CHECK CONSTRAINT ALL' AS '--Code to enable the previously disabled constraints'
			END

		PRINT 'GO'
	END

PRINT ''
IF (@IDN <> '')
	BEGIN
		PRINT 'SET IDENTITY_INSERT ' + QUOTENAME(COALESCE(@owner,USER_NAME())) + '.' + QUOTENAME(@table_name) + ' OFF'
		PRINT 'GO'
	END

PRINT 'SET NOCOUNT OFF'


SET NOCOUNT OFF
RETURN 0 --Success. We are done!
END

GO
/****** Object:  StoredProcedure [dbo].[sp_myTest1]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_myTest1] AS

SELECT * FROM  tbl_staffDetails



GO
/****** Object:  StoredProcedure [dbo].[sp_trimStaffData]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_trimStaffData] AS

UPDATE tbl_staffDetails
SET 

tbl_staffDetails.firstName= LTRIM(RTRIM(tbl_staffDetails.firstName)),

tbl_staffDetails.secondName= LTRIM(RTRIM(tbl_staffDetails.secondName)),

tbl_staffDetails.surname= LTRIM(RTRIM(tbl_staffDetails.surname)),

tbl_staffDetails.natIdNumber= LTRIM(RTRIM(tbl_staffDetails.natIdNumber)),

tbl_staffDetails.employmentNumber= LTRIM(RTRIM(tbl_staffDetails.employmentNumber)),

tbl_staffDetails.contactNumber= LTRIM(RTRIM(tbl_staffDetails.contactNumber)),

tbl_staffDetails.homeAddress= LTRIM(RTRIM(tbl_staffDetails.homeAddress)),

tbl_staffDetails.nextOfKinName= LTRIM(RTRIM(tbl_staffDetails.nextOfKinName)),

tbl_staffDetails.nextOfKinContactNumber= LTRIM(RTRIM(tbl_staffDetails.nextOfKinContactNumber)),

tbl_staffDetails.nextOfKinAddress= LTRIM(RTRIM(tbl_staffDetails.nextOfKinAddress)),

tbl_staffDetails.officeNumber= LTRIM(RTRIM(tbl_staffDetails.officeNumber)),

tbl_staffDetails.emailAddress= LTRIM(RTRIM(tbl_staffDetails.emailAddress))


GO
/****** Object:  StoredProcedure [dbo].[sp_updateStudentStatus]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateStudentStatus]
(
	
	@studentId						[nvarchar](20),
	@status						[varchar](60)
)
AS UPDATE tbl_students
SET
		
		
		status			=	@status
WHERE
(
	studentId	=	@studentId
)
GO
/****** Object:  StoredProcedure [dbo].[update_tbl_allPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_tbl_allPayments]
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
GO
/****** Object:  StoredProcedure [dbo].[update_tbl_libraryBookLending]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_tbl_libraryBookLending]
(
	@bookId						[nvarchar](50),
	@returnDate						[date],
	@returnStatus						[nvarchar](30),
	@penaltyPaid					[money]
	
)
AS UPDATE tbl_libraryBookLending
SET
		bookId			=	@bookId,
		returnDate			=	@returnDate,
		returnStatus			=	@returnStatus,
		penaltyPaid			=	@penaltyPaid
		
WHERE
(
	bookId	=	@bookId
)
GO
/****** Object:  StoredProcedure [dbo].[update_tbl_libraryBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_tbl_libraryBooks]
(

	@bookId						[nvarchar](50),
	@availability						[nvarchar](50)
)
AS UPDATE tbl_libraryBooks
SET
		
		bookId			=	@bookId,
		
		availability			=	@availability
WHERE
(
	bookId	=	@bookId
)
GO
/****** Object:  Table [dbo].[occupations]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[occupations](
	[occupationIId] [int] NOT NULL,
	[Occupation] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[suburbs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[suburbs](
	[suburbId] [int] NULL,
	[cityId] [int] NULL,
	[Suburb] [nvarchar](255) NULL,
	[sectionId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[suburbsVF]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[suburbsVF](
	[suburbId] [int] NULL,
	[cityId] [int] NULL,
	[Suburb] [nvarchar](255) NULL,
	[sectionId] [int] NULL,
	[ctr] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_aggregationMarksSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_aggregationMarksSchedule](
	[numOfStreamStudents] [int] NULL,
	[numOfClassStudents] [int] NULL,
	[yYear] [int] NULL,
	[tTerm] [varchar](30) NULL,
	[stream] [varchar](30) NULL,
	[schoolClass] [varchar](30) NULL,
	[studentId] [varchar](20) NULL,
	[student] [varchar](90) NULL,
	[overalPercntgMark] [int] NULL,
	[overallGrade] [char](10) NULL,
	[overallClassPosition] [int] NULL,
	[overallStreamPosition] [int] NULL,
	[subject] [varchar](30) NULL,
	[percentage] [int] NULL,
	[streamPosition] [int] NULL,
	[classPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[aggregationLevel] [varchar](30) NULL,
	[grade] [char](10) NULL,
	[selected] [int] NULL,
	[numOfStreamStudentTestWriters] [int] NULL,
	[numOfClassStudentTestWriters] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_allData]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_allData](
	[ID] [int] NOT NULL,
	[studentId] [nvarchar](255) NULL,
	[fullName] [nvarchar](255) NULL,
	[firstName] [nvarchar](255) NULL,
	[surname] [nvarchar](255) NULL,
	[secondName] [nvarchar](255) NULL,
	[form] [nvarchar](255) NULL,
	[Class] [nvarchar](255) NULL,
	[classId] [int] NULL,
	[dateOfBirth] [nvarchar](255) NULL,
	[disabilityStatus] [nvarchar](255) NULL,
	[disabilityId] [int] NULL,
	[sex] [int] NULL,
	[collegeIdNum] [nvarchar](255) NULL,
	[College ID] [nvarchar](255) NULL,
	[studentMaritalStatus] [nvarchar](255) NULL,
	[studentMaritalStatusId] [int] NULL,
	[orphanStatus22] [nvarchar](255) NULL,
	[orphanStatusId] [int] NULL,
	[religion] [nvarchar](255) NULL,
	[religionId] [int] NULL,
	[allergy] [nvarchar](255) NULL,
	[allergyId] [int] NULL,
	[healthCondition] [nvarchar](255) NULL,
	[healthConditionId] [int] NULL,
	[schoolHouse] [nvarchar](255) NULL,
	[schoolHouseId] [int] NULL,
	[schoolPosition] [nvarchar](255) NULL,
	[schoolPositionId] [int] NULL,
	[contactNumber] [nvarchar](255) NULL,
	[home Address] [nvarchar](255) NULL,
	[nameOfParent] [nvarchar](255) NULL,
	[Suburb] [nvarchar](255) NULL,
	[suburbId2] [int] NULL,
	[sectionId2] [int] NULL,
	[maritalStatus] [nvarchar](255) NULL,
	[maritalStatusId] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[TitleId] [int] NULL,
	[Email Address] [nvarchar](255) NULL,
	[Occupation] [nvarchar](255) NULL,
	[OccupationId] [int] NULL,
	[relation] [nvarchar](255) NULL,
	[relationId] [int] NULL,
	[studentPicture] [nvarchar](255) NULL,
	[hostelId] [int] NULL,
	[cityId] [int] NULL,
	[suburbId] [int] NULL,
	[sectionId] [int] NULL,
	[dateOfBirthNew] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_allData2]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_allData2](
	[ID] [int] NOT NULL,
	[studentId] [nvarchar](255) NULL,
	[fullName] [nvarchar](255) NULL,
	[firstName] [nvarchar](255) NULL,
	[surname] [nvarchar](255) NULL,
	[secondName] [nvarchar](255) NULL,
	[form] [nvarchar](255) NULL,
	[Class] [nvarchar](255) NULL,
	[classId] [int] NULL,
	[dateOfBirth] [smalldatetime] NULL,
	[disabilityStatus] [nvarchar](255) NULL,
	[disabilityId] [int] NULL,
	[sex] [nvarchar](255) NULL,
	[collegeIdNum] [nvarchar](255) NULL,
	[College ID] [nvarchar](255) NULL,
	[studentMaritalStatus] [nvarchar](255) NULL,
	[studentMaritalStatusId] [int] NULL,
	[orphanStatus22] [nvarchar](255) NULL,
	[orphanStatusId] [int] NULL,
	[religion] [nvarchar](255) NULL,
	[religionId] [int] NULL,
	[allergy] [nvarchar](255) NULL,
	[allergyId] [int] NULL,
	[healthCondition] [nvarchar](255) NULL,
	[healthConditionId] [int] NULL,
	[schoolHouse] [nvarchar](255) NULL,
	[schoolHouseId] [int] NULL,
	[schoolPosition] [nvarchar](255) NULL,
	[schoolPositionId] [int] NULL,
	[contactNumber] [nvarchar](255) NULL,
	[home Address] [nvarchar](255) NULL,
	[nameOfParent] [nvarchar](255) NULL,
	[Suburb] [nvarchar](255) NULL,
	[suburbId2] [int] NULL,
	[sectionId2] [int] NULL,
	[maritalStatus] [nvarchar](255) NULL,
	[maritalStatusId] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[TitleId] [int] NULL,
	[Email Address] [nvarchar](255) NULL,
	[Occupation] [nvarchar](255) NULL,
	[OccupationId] [int] NULL,
	[relation] [nvarchar](255) NULL,
	[relationId] [int] NULL,
	[studentPicture] [nvarchar](255) NULL,
	[hostelId] [int] NULL,
	[cityId] [int] NULL,
	[suburbId] [int] NULL,
	[sectionId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_allergy]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_allergy](
	[allergyId] [int] IDENTITY(1,1) NOT NULL,
	[allergy] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_allPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_allPayments](
	[paymentId] [int] IDENTITY(1,1) NOT NULL,
	[payment] [varchar](50) NOT NULL,
	[amountPaid] [money] NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[receiptNumber] [varchar](30) NULL,
	[dtDate] [datetime] NOT NULL,
	[details] [nvarchar](100) NULL,
	[cashier] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_assetIDCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_assetIDCodeGen](
	[centerCode] [char](10) NULL,
	[lastAssetNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_assets]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_assets](
	[assetTypeId] [int] NULL,
	[assetId] [int] IDENTITY(1,1) NOT NULL,
	[asset] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_assetTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_assetTypes](
	[assetTypeId] [int] IDENTITY(1,1) NOT NULL,
	[assetType] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_auditTrail]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_auditTrail](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [datetime] NULL,
	[tTime] [datetime] NULL,
	[userName] [nvarchar](60) NULL,
	[mModule] [nvarchar](50) NULL,
	[auditType] [nvarchar](30) NULL,
	[auditSubject] [nvarchar](30) NULL,
	[details] [nvarchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_billPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_billPayments](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [nvarchar](255) NULL,
	[amountOwing] [money] NULL,
	[amountPaid] [money] NULL,
	[narration] [nvarchar](255) NULL,
	[balance] [money] NULL,
	[capturedBy] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_boardingStatus]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_boardingStatus](
	[boardingStatusId] [int] IDENTITY(1,1) NOT NULL,
	[boardingStatus] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_bookAvailabilityStatuses]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_bookAvailabilityStatuses](
	[availabilityId] [int] IDENTITY(1,1) NOT NULL,
	[availability] [char](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_bookCondition]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bookCondition](
	[bookConditionId] [int] IDENTITY(1,1) NOT NULL,
	[bookCondition] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_bookSubjectTopics]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bookSubjectTopics](
	[bookId] [nvarchar](50) NULL,
	[topicId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_bookTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bookTypes](
	[bookTypeId] [int] IDENTITY(1,1) NOT NULL,
	[bookType] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_bookVersions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bookVersions](
	[versionId] [int] IDENTITY(1,1) NOT NULL,
	[version] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_cashBook]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cashBook](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [datetime] NULL,
	[opening] [money] NULL,
	[incoming] [money] NULL,
	[outgoing] [money] NULL,
	[closing] [money] NULL,
	[balance] [money] NULL,
	[narration] [nvarchar](255) NULL,
	[capturedBy] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_cashBookVariances]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cashBookVariances](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [nvarchar](255) NULL,
	[mode] [nvarchar](255) NULL,
	[expected] [nvarchar](255) NULL,
	[captured] [nvarchar](255) NULL,
	[variance] [nvarchar](255) NULL,
	[narration] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_cities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cities](
	[cityId] [int] IDENTITY(1,1) NOT NULL,
	[city] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_classAttendanceRegister]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_classAttendanceRegister](
	[dtDate] [smalldatetime] NULL,
	[stream] [nvarchar](30) NULL,
	[schClass] [nvarchar](30) NULL,
	[studentId] [nvarchar](20) NULL,
	[attendance] [int] NULL,
	[comments] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_classMasters]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_classMasters](
	[schoolClassId] [int] NULL,
	[employmentNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_classPeriods]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_classPeriods](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[period] [int] NOT NULL,
	[fromTime] [datetime] NOT NULL,
	[toTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_classSubjectTeacher]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_classSubjectTeacher](
	[employmentNumber] [nvarchar](30) NULL,
	[subjectId] [int] NULL,
	[classId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_classTimeTable]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_classTimeTable](
	[dDay] [nvarchar](30) NOT NULL,
	[periodNumber] [int] NOT NULL,
	[stream] [nvarchar](30) NOT NULL,
	[schClass] [nvarchar](30) NOT NULL,
	[subject] [nvarchar](30) NOT NULL,
	[dayNumba] [int] NULL,
	[TeacherCode] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_clubMembers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_clubMembers](
	[clubId] [int] NULL,
	[studentId] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_clubs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_clubs](
	[clubId] [int] IDENTITY(1,1) NOT NULL,
	[club] [nvarchar](60) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_colleges]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_colleges](
	[collegeId] [int] IDENTITY(1,1) NOT NULL,
	[college] [nvarchar](50) NULL,
	[contactNumber] [nvarchar](30) NULL,
	[collegeAddress] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_departments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_departments](
	[departmentId] [int] IDENTITY(1,1) NOT NULL,
	[departmentName] [nvarchar](50) NULL,
	[headOfDepartmentStaffId] [nvarchar](50) NULL,
	[officePhoneNumber] [nvarchar](30) NULL,
	[officeNumber] [nvarchar](30) NULL,
	[comments] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_departmentSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_departmentSubjects](
	[departmentId] [int] NOT NULL,
	[subjectId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_disabilities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_disabilities](
	[disabilityId] [int] IDENTITY(1,1) NOT NULL,
	[disability] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_disciplinaryActions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_disciplinaryActions](
	[actionId] [int] IDENTITY(1,1) NOT NULL,
	[action] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_donors]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_donors](
	[donorId] [int] IDENTITY(1,1) NOT NULL,
	[donor] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_duties]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_duties](
	[dutyId] [int] IDENTITY(1,1) NOT NULL,
	[duty] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_dutyFilterCategories]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_dutyFilterCategories](
	[dutyFilterId] [int] IDENTITY(1,1) NOT NULL,
	[dutyFilter] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_dutyLocations]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_dutyLocations](
	[dutyLocationId] [int] IDENTITY(1,1) NOT NULL,
	[dutyLocation] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_dutyRoster]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_dutyRoster](
	[assigneeId] [nvarchar](20) NULL,
	[duty] [nvarchar](60) NULL,
	[dateFrom] [smalldatetime] NULL,
	[dateTo] [smalldatetime] NULL,
	[dutyNumber] [int] IDENTITY(1,1) NOT NULL,
	[assigneeMode] [nvarchar](20) NULL,
	[dutyLocation] [nvarchar](60) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_employees]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_employees](
	[employeeCode] [nvarchar](30) NULL,
	[employeeName] [nvarchar](60) NULL,
	[designation] [nvarchar](50) NULL,
	[empLevel] [int] NULL,
	[role] [nvarchar](50) NULL,
	[emailAddress] [nvarchar](100) NULL,
	[contactNo] [nvarchar](30) NULL,
	[empPassword] [nvarchar](30) NULL,
	[active] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_events]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_events](
	[eventId] [int] IDENTITY(1,1) NOT NULL,
	[event] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_examinationAuthourities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_examinationAuthourities](
	[authourityId] [int] IDENTITY(1,1) NOT NULL,
	[authourity] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_examinationBoards]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationBoards](
	[examinationBoardId] [int] IDENTITY(1,1) NOT NULL,
	[examinationBoard] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationFeeBySubjectSetUp]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationFeeBySubjectSetUp](
	[examBoardId] [int] NOT NULL,
	[examLevelId] [int] NOT NULL,
	[subject] [varchar](60) NOT NULL,
	[examFee] [money] NOT NULL,
	[centerFee] [money] NULL,
	[stationeryFee] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationFeesPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationFeesPayments](
	[yYear] [int] NOT NULL,
	[levelId] [int] NOT NULL,
	[examBoardId] [int] NOT NULL,
	[studentId] [char](30) NOT NULL,
	[centerFee] [money] NOT NULL,
	[numberOfSubjects] [int] NOT NULL,
	[stationeryFee] [money] NOT NULL,
	[amountDue] [money] NOT NULL,
	[amountPaid] [money] NOT NULL,
	[paymentId] [varchar](20) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationFeesPaymentsByStudentNSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationFeesPaymentsByStudentNSubjects](
	[examLevelId] [int] NOT NULL,
	[examBoardId] [int] NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[subject] [varchar](80) NOT NULL,
	[amountDue] [money] NOT NULL,
	[amountPaid] [money] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationMarks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationMarks](
	[examId] [nvarchar](30) NULL,
	[studentId] [nvarchar](30) NULL,
	[markObtained] [int] NULL,
	[percentage] [real] NULL,
	[grade] [nvarchar](20) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[examLevel] [nvarchar](20) NULL,
	[stream] [varchar](30) NULL,
	[schClass] [varchar](30) NULL,
	[selected] [int] NULL,
	[percentWeight] [real] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationMarksAggregatedBySubject]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationMarksAggregatedBySubject](
	[studentId] [varchar](30) NULL,
	[intYear] [int] NULL,
	[term] [varchar](30) NULL,
	[stream] [varchar](30) NULL,
	[schClass] [varchar](30) NULL,
	[subject] [varchar](50) NULL,
	[percentMarkObtained] [real] NULL,
	[grade] [char](10) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[aggregationLevel] [varchar](30) NULL,
	[selected] [int] NULL,
	[comments] [nvarchar](240) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationMarksOveralAgregation]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinationMarksOveralAgregation](
	[studentId] [varchar](30) NOT NULL,
	[intYear] [int] NOT NULL,
	[term] [varchar](30) NOT NULL,
	[stream] [varchar](30) NULL,
	[schClass] [varchar](30) NULL,
	[overallMark] [real] NULL,
	[overallGrade] [char](10) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[selected] [int] NULL,
	[positionDeviation] [int] NULL,
	[classTeacherComment] [varchar](250) NULL,
	[principalComment] [varchar](250) NULL,
	[numOfStreamStudents] [int] NULL,
	[numOfClassStudents] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_examinationQuestions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_examinationQuestions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[examId] [nvarchar](20) NULL,
	[qtnCounter] [int] NULL,
	[qtnNumber] [nvarchar](30) NULL,
	[qtnTypeId] [int] NULL,
	[qtnDerivedFrmPassage] [int] NULL,
	[passageId] [nvarchar](30) NULL,
	[qtnHasDiagram] [int] NULL,
	[diagramPath] [nvarchar](200) NULL,
	[diagram] [nvarchar](100) NULL,
	[question] [nvarchar](250) NULL,
	[qtnTopic] [nvarchar](50) NULL,
	[mcAnswerA] [nvarchar](250) NULL,
	[mcAnswerB] [nvarchar](250) NULL,
	[mcAnswerC] [nvarchar](250) NULL,
	[mcAnswerD] [nvarchar](250) NULL,
	[mcAnswerE] [nvarchar](250) NULL,
	[answer] [nvarchar](250) NULL,
	[qtnMarks] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_examinations]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_examinations](
	[examId] [nvarchar](20) NULL,
	[examDate] [smalldatetime] NULL,
	[stream] [nvarchar](20) NULL,
	[subject] [nvarchar](30) NULL,
	[paper] [nvarchar](30) NULL,
	[highestPossibleMark] [int] NULL,
	[authourity] [nvarchar](50) NULL,
	[examPaperPath] [varchar](250) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_externalStudentExamFeePayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_externalStudentExamFeePayments](
	[studentId] [varchar](20) NOT NULL,
	[levelId] [int] NOT NULL,
	[boardId] [int] NOT NULL,
	[overRideStatus] [int] NOT NULL,
	[totalAmountDue] [money] NOT NULL,
	[totalAmountPaid] [money] NOT NULL,
	[receiptNumber] [varchar](20) NOT NULL,
	[comments] [varchar](150) NULL,
	[dtDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_externalStudents]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_externalStudents](
	[surname] [varchar](30) NULL,
	[firstName] [varchar](30) NULL,
	[secondName] [varchar](30) NULL,
	[idNumber] [varchar](20) NOT NULL,
	[sexId] [int] NULL,
	[dob] [datetime] NULL,
	[contactAddress] [varchar](150) NULL,
	[contactNumber] [varchar](20) NULL,
	[nextOfKin] [varchar](60) NULL,
	[nextOfKinContactNumber] [varchar](20) NULL,
	[levelId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_externalStudentsExamFeesSetUp]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_externalStudentsExamFeesSetUp](
	[levelId] [int] NOT NULL,
	[examBoardId] [int] NOT NULL,
	[centerFee] [money] NULL,
	[stationeryFee] [money] NULL,
	[subject] [varchar](50) NOT NULL,
	[examFee] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_externalStudentSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_externalStudentSubjects](
	[studentId] [varchar](20) NOT NULL,
	[levelId] [int] NOT NULL,
	[boardId] [int] NOT NULL,
	[subject] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_extraCurriculaActivities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_extraCurriculaActivities](
	[activityId] [int] IDENTITY(1,1) NOT NULL,
	[activityName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_extraCurriculaActivitiesCalendar]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_extraCurriculaActivitiesCalendar](
	[eventId] [int] IDENTITY(1,1) NOT NULL,
	[activityType] [nvarchar](50) NULL,
	[event] [nvarchar](50) NULL,
	[dtDate] [smalldatetime] NULL,
	[venue] [nvarchar](50) NULL,
	[comments] [nvarchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_extraCurriculaActivityTeams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_extraCurriculaActivityTeams](
	[activityId] [int] IDENTITY(1,1) NOT NULL,
	[teamId] [int] NOT NULL,
	[team] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_functionalStates]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_functionalStates](
	[stateId] [int] IDENTITY(1,1) NOT NULL,
	[functionalState] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_gradeRanges]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gradeRanges](
	[gradingId] [int] NULL,
	[gradeId] [int] IDENTITY(1,1) NOT NULL,
	[grade] [nvarchar](20) NULL,
	[fromMark] [int] NULL,
	[toMark] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_gradings]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gradings](
	[gradingId] [int] IDENTITY(1,1) NOT NULL,
	[gradingName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_healthConditions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_healthConditions](
	[healthConditionId] [int] IDENTITY(1,1) NOT NULL,
	[healthCondition] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_hostels]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_hostels](
	[hostelId] [int] IDENTITY(1,1) NOT NULL,
	[hostel] [nvarchar](60) NULL,
	[superitendant] [nvarchar](50) NULL,
	[numberOfRooms] [nvarchar](255) NULL,
	[numberOfBeds] [int] NULL,
	[numberOfToiletSeats] [nvarchar](255) NULL,
	[numberOfShowers] [nvarchar](255) NULL,
	[numberOfBathTubs] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_incidentIDCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_incidentIDCodeGen](
	[centreCode] [char](10) NOT NULL,
	[lastIncidentNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_incidentLevels]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incidentLevels](
	[incidentLevelId] [int] IDENTITY(1,1) NOT NULL,
	[incidentLevel] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_incidents]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incidents](
	[caseNumber] [int] IDENTITY(1,1) NOT NULL,
	[incidentNumber] [nvarchar](30) NULL,
	[dtDate] [smalldatetime] NULL,
	[incidentTypeId] [nvarchar](30) NULL,
	[incidentLevelId] [nvarchar](30) NULL,
	[location] [nvarchar](30) NULL,
	[offenderCategoryId] [nvarchar](30) NULL,
	[offenderId] [nvarchar](30) NULL,
	[offender] [nvarchar](100) NULL,
	[incidentDescription] [nvarchar](250) NULL,
	[disciplinaryActionId] [nvarchar](30) NULL,
	[stream] [nvarchar](30) NULL,
	[Schclass] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_incidentsCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_incidentsCodeGen](
	[centreCode] [char](10) NULL,
	[lastIncidentNumber] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_incidentTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_incidentTypes](
	[incidentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[incidentType] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_inventory]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_inventory](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [datetime] NULL,
	[opening] [int] NULL,
	[incoming] [int] NULL,
	[outgoing] [int] NULL,
	[closing] [int] NULL,
	[balance] [int] NULL,
	[narration] [nvarchar](255) NULL,
	[capturedBy] [nvarchar](255) NULL,
	[itemType] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_inventoryVariances]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_inventoryVariances](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [nvarchar](255) NULL,
	[mode] [nvarchar](255) NULL,
	[expected] [nvarchar](255) NULL,
	[captured] [nvarchar](255) NULL,
	[variance] [nvarchar](255) NULL,
	[narration] [nvarchar](255) NULL,
	[itemType] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_jobTitles]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_jobTitles](
	[jobTitleId] [int] IDENTITY(1,1) NOT NULL,
	[jobTitle] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_kits]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_kits](
	[activityType] [nvarchar](30) NULL,
	[activity] [nvarchar](50) NULL,
	[team] [nvarchar](50) NULL,
	[kitType] [nvarchar](30) NULL,
	[supplier] [nvarchar](50) NULL,
	[dateBought] [smalldatetime] NULL,
	[itemDescription] [nvarchar](200) NULL,
	[quantity] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_kits2]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_kits2](
	[activityType] [nvarchar](30) NULL,
	[activity] [nvarchar](50) NULL,
	[team] [nvarchar](50) NULL,
	[kitType] [nvarchar](30) NULL,
	[supplier] [nvarchar](50) NULL,
	[dateBought] [datetime] NULL,
	[itemDescription] [nvarchar](200) NULL,
	[quantity] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_LevyPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_LevyPayments](
	[studentd] [nvarchar](20) NOT NULL,
	[intYear] [int] NOT NULL,
	[strTerm] [char](20) NOT NULL,
	[expectedAmt] [money] NULL,
	[amountPaid] [money] NULL,
	[termNumber] [int] NOT NULL,
	[penalty] [money] NULL,
	[levyPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[receiptNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_libraryBookIDCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_libraryBookIDCodeGen](
	[centerCode] [char](10) NULL,
	[subjectId] [int] NULL,
	[lastBookNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_libraryBookLending]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_libraryBookLending](
	[bookId] [nvarchar](50) NULL,
	[title] [nvarchar](50) NULL,
	[authour] [nvarchar](60) NULL,
	[serialNumber] [nvarchar](30) NULL,
	[bookType] [nvarchar](30) NULL,
	[borrowerName] [nvarchar](60) NULL,
	[borrowerType] [nvarchar](30) NULL,
	[borrowerIdNumber] [nvarchar](30) NULL,
	[dateLoanedOut] [date] NULL,
	[loanDays] [nvarchar](30) NULL,
	[dueDate] [date] NULL,
	[returnDate] [nvarchar](20) NULL,
	[returnStatus] [nvarchar](30) NULL,
	[penaltyAmt] [money] NULL,
	[numberOfBooks] [nvarchar](30) NULL,
	[comments] [nvarchar](255) NULL,
	[penaltyPaid] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_libraryBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_libraryBooks](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[bookId] [nvarchar](50) NULL,
	[bookTitle] [nvarchar](50) NULL,
	[authorFirstName] [nvarchar](40) NULL,
	[authorSurname] [nvarchar](40) NULL,
	[subjectId] [int] NULL,
	[level1] [int] NULL,
	[level2] [int] NULL,
	[version] [nvarchar](50) NULL,
	[yearPublished] [int] NULL,
	[availability] [nvarchar](50) NULL,
	[lendingDays] [int] NULL,
	[bookTypeId] [int] NULL,
	[supplierId] [int] NULL,
	[conditionId] [int] NULL,
	[serialNumber] [nvarchar](50) NULL,
	[dateSupplied] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_libraryLostBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_libraryLostBooks](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[bookId] [nvarchar](30) NOT NULL,
	[dateLost] [smalldatetime] NULL,
	[loserType] [nvarchar](20) NULL,
	[lostBy] [nvarchar](60) NULL,
	[loserId] [nvarchar](30) NULL,
	[bookTitle] [nvarchar](50) NULL,
	[bookAuthour] [nvarchar](60) NULL,
	[bookType] [nvarchar](60) NULL,
	[restitutionAction] [char](20) NULL,
	[dateReplaced] [smalldatetime] NULL,
	[amountPaid] [money] NULL,
	[receiptNumber] [nvarchar](20) NULL,
	[replacingBookId] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_lostBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_lostBooks](
	[bookId] [nvarchar](30) NULL,
	[serialNumber] [nvarchar](30) NULL,
	[dateLost] [smalldatetime] NULL,
	[comments] [nvarchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_maritalStatuses]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_maritalStatuses](
	[maritalStatusId] [int] IDENTITY(1,1) NOT NULL,
	[maritalStatus] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_occupations]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_occupations](
	[occupationId] [int] IDENTITY(1,1) NOT NULL,
	[occupation] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_offenderCategories]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_offenderCategories](
	[offenderCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[offenderCategory] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_orphanhoodStatuses]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_orphanhoodStatuses](
	[orphanhoodStatusId] [int] IDENTITY(1,1) NOT NULL,
	[orphanhoodStatus] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_paymentExemptions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_paymentExemptions](
	[exemptionId] [int] IDENTITY(1,1) NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[paymentType] [varchar](50) NOT NULL,
	[fromDate] [datetime] NOT NULL,
	[toDate] [datetime] NOT NULL,
	[comments] [varchar](200) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paymentFrequencies]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_paymentFrequencies](
	[frequencyId] [int] IDENTITY(1,1) NOT NULL,
	[frequency] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paymentQueries]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_paymentQueries](
	[qryNumber] [int] IDENTITY(1,1) NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[qryDate] [datetime] NOT NULL,
	[qryDetails] [varchar](200) NOT NULL,
	[qryStatus] [char](20) NOT NULL,
	[solutionDetails] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paymentReceiptCodeNumberGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_paymentReceiptCodeNumberGen](
	[centerCode] [char](10) NULL,
	[lastReceiptNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paymentReceiptGenerationNumbers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_paymentReceiptGenerationNumbers](
	[schoolCode] [char](10) NULL,
	[lastPaymentNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_payments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_payments](
	[paymentId] [int] IDENTITY(1,1) NOT NULL,
	[intYear] [int] NULL,
	[term] [nvarchar](30) NULL,
	[payment] [nvarchar](50) NULL,
	[paymentLevel] [nvarchar](30) NULL,
	[subjectSpecific] [int] NULL,
	[subject] [nvarchar](50) NULL,
	[studentId] [nvarchar](20) NULL,
	[amtRequired] [money] NULL,
	[amtPaid] [money] NULL,
	[numberOfSubjects] [money] NULL,
	[penaltyAmtPaid] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_payments_TMP]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_payments_TMP](
	[Year_] [int] NULL,
	[Term_] [nvarchar](30) NULL,
	[Payment_] [nvarchar](50) NULL,
	[Level_] [nvarchar](30) NULL,
	[Stream_] [nvarchar](30) NULL,
	[Class_] [nvarchar](30) NULL,
	[Subject_] [nvarchar](50) NULL,
	[Student Id] [nvarchar](20) NULL,
	[Surname_] [nvarchar](50) NULL,
	[First Name] [nvarchar](50) NULL,
	[Second Name] [nvarchar](50) NULL,
	[Amount Required] [money] NULL,
	[Amount Paid] [money] NULL,
	[OutstandingAmt] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_paymentsHistory]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_paymentsHistory](
	[paymentId] [int] NULL,
	[dtDate] [smalldatetime] NULL,
	[setAmount] [money] NULL,
	[amountPaid] [money] NULL,
	[totalAmountPaid] [money] NULL,
	[balance] [money] NULL,
	[InvoiceNumber] [nvarchar](30) NULL,
	[ReceiptNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_penaltyPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_penaltyPayments](
	[receiptNumber] [nvarchar](20) NOT NULL,
	[dtDate] [datetime] NOT NULL,
	[studentId] [nvarchar](30) NOT NULL,
	[penaltyType] [nvarchar](50) NOT NULL,
	[amountPayable] [money] NULL,
	[amountPaid] [money] NOT NULL,
	[comments] [nvarchar](100) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_penaltyTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_penaltyTypes](
	[penaltyTypeId] [int] IDENTITY(1,1) NOT NULL,
	[penaltyType] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_qualificationLevels]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_qualificationLevels](
	[qualificationLevelId] [int] IDENTITY(1,1) NOT NULL,
	[qualificationLevel] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_qualifications]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_qualifications](
	[qualificationId] [int] IDENTITY(1,1) NOT NULL,
	[qualification] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_reasonForStudentLeaving]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reasonForStudentLeaving](
	[reasonForStudentLeavingId] [int] IDENTITY(1,1) NOT NULL,
	[reasonForStudentLeaving] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_reasonsForAbsence]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reasonsForAbsence](
	[reasonForAbsenceId] [int] IDENTITY(1,1) NOT NULL,
	[reasonForAbsence] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_reasonsForAssetDisposal]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reasonsForAssetDisposal](
	[disposalReasonId] [int] IDENTITY(1,1) NOT NULL,
	[disposalReason] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_reasonsForStaffLeaving]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reasonsForStaffLeaving](
	[reasonForStaffLeavingId] [int] IDENTITY(1,1) NOT NULL,
	[reasonForStaffLeaving] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_reasonsForTransfers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reasonsForTransfers](
	[reasonId] [int] IDENTITY(1,1) NOT NULL,
	[reason] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_receiptBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_receiptBooks](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [datetime] NULL,
	[receiptNumber] [nvarchar](255) NULL,
	[purpose] [nvarchar](255) NULL,
	[receivedBy] [nvarchar](255) NULL,
	[issuedTo] [nvarchar](255) NULL,
	[acknowledgement] [nvarchar](255) NULL,
	[capturedBy] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_receiptCounter]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_receiptCounter](
	[ctr] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_RegistrationPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_RegistrationPayments](
	[studentId] [nvarchar](20) NOT NULL,
	[intYear] [int] NOT NULL,
	[expectedAmt] [money] NULL,
	[amountPaid] [money] NULL,
	[monthNumber] [int] NULL,
	[Regdate] [smalldatetime] NULL,
	[penalty] [money] NULL,
	[registrationPaymentID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_relationships]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_relationships](
	[relationshipId] [int] IDENTITY(1,1) NOT NULL,
	[relationship] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_religions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_religions](
	[religionId] [int] IDENTITY(1,1) NOT NULL,
	[religion] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_responsibleAuthourities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_responsibleAuthourities](
	[authourityId] [int] IDENTITY(1,1) NOT NULL,
	[authourity] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_revenueBook]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_revenueBook](
	[entryNumber] [int] IDENTITY(1,1) NOT NULL,
	[itemType] [nvarchar](255) NULL,
	[dtDate] [nvarchar](255) NULL,
	[expected] [money] NULL,
	[cashAtHand] [money] NULL,
	[cashLeft] [money] NULL,
	[variance] [money] NULL,
	[acknowledgement] [nvarchar](255) NULL,
	[notes] [nvarchar](255) NULL,
	[capturedBy] [nvarchar](255) NULL,
	[receiptedBy] [nvarchar](255) NULL,
	[center] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_revenueItemTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_revenueItemTypes](
	[itemTypeID] [int] NOT NULL,
	[itemType] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_rooms]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rooms](
	[buildingId] [int] NULL,
	[roomNumber] [nvarchar](50) NULL,
	[roomTypeId] [int] NULL,
	[roomDescription] [nvarchar](200) NULL,
	[chairRowCols] [int] NULL,
	[chairRows] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolAssets]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolAssets](
	[assetId] [int] NULL,
	[assetName] [nvarchar](50) NULL,
	[assetNumber] [nvarchar](50) NULL,
	[serialNumber] [nvarchar](50) NULL,
	[functionalStateId] [int] NULL,
	[description] [nvarchar](150) NULL,
	[dateBought] [smalldatetime] NULL,
	[supplierId] [int] NULL,
	[quantity] [int] NULL,
	[totalValue] [money] NULL,
	[assetLocation] [nvarchar](50) NULL,
	[assetUser] [nvarchar](60) NULL,
	[assetUserType] [nvarchar](50) NULL,
	[disposalStatus] [int] NULL,
	[dateDisposed] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolAssetsDisposed]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolAssetsDisposed](
	[assetType] [nvarchar](50) NULL,
	[assetName] [nvarchar](50) NULL,
	[assetNumber] [nvarchar](50) NULL,
	[serialNumber] [nvarchar](50) NULL,
	[functionalState] [nvarchar](50) NULL,
	[description] [nvarchar](150) NULL,
	[dateBought] [smalldatetime] NULL,
	[supplier] [nvarchar](50) NULL,
	[quantityDisposed] [int] NULL,
	[valueOfDisposedAssets] [money] NULL,
	[reasonForDisposal] [nvarchar](50) NULL,
	[dateDisposed] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolBuildings]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolBuildings](
	[buildingId] [int] IDENTITY(1,1) NOT NULL,
	[buildingName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolCalendar]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolCalendar](
	[eventNumber] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [int] NULL,
	[dtDate] [smalldatetime] NULL,
	[startTime] [nvarchar](30) NULL,
	[endingTime] [nvarchar](30) NULL,
	[venue] [nvarchar](50) NULL,
	[contactPerson] [nvarchar](60) NULL,
	[contactNumber] [nvarchar](20) NULL,
	[details] [nvarchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolClasses]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolClasses](
	[schoolClassId] [int] IDENTITY(1,1) NOT NULL,
	[schoolClass] [nvarchar](30) NULL,
	[streamId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolCoreDetails]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_schoolCoreDetails](
	[schoolCode] [nvarchar](20) NOT NULL,
	[schoolName] [nvarchar](100) NULL,
	[physicalAddress] [nvarchar](250) NULL,
	[postalAddress] [nvarchar](250) NULL,
	[telephoneNumber] [nvarchar](30) NULL,
	[cellNumber] [nvarchar](30) NULL,
	[emailAddress] [nvarchar](120) NULL,
	[webAddress] [nvarchar](120) NULL,
	[dateFounded] [nvarchar](50) NULL,
	[responsibleAuthourityId] [int] NULL,
	[schoolHeadName] [nvarchar](100) NULL,
	[position1] [nvarchar](30) NULL,
	[position1Name] [nvarchar](60) NULL,
	[position1ContactNumber] [nvarchar](30) NULL,
	[position2] [nvarchar](30) NULL,
	[position2Name] [nvarchar](60) NULL,
	[position2ContactNumber] [nvarchar](30) NULL,
	[position3] [nvarchar](30) NULL,
	[position3Name] [nvarchar](60) NULL,
	[position3ContactNumber] [nvarchar](30) NULL,
	[responsibleChurch] [nvarchar](50) NULL,
	[missionStatement] [nvarchar](250) NULL,
	[schoolSuffixLetter] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_schoolFileType]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolFileType](
	[fileTypeId] [int] IDENTITY(1,1) NOT NULL,
	[fileType] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolStaffPositions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolStaffPositions](
	[schoolStaffPositionId] [int] IDENTITY(1,1) NOT NULL,
	[schoolStaffPosition] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolStudentPositions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolStudentPositions](
	[schoolStudentPositionId] [int] IDENTITY(1,1) NOT NULL,
	[schoolStudentPosition] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_schoolTerms]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_schoolTerms](
	[termId] [int] IDENTITY(1,1) NOT NULL,
	[term] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SDACommitteeMembers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SDACommitteeMembers](
	[memberId] [int] IDENTITY(1,1) NOT NULL,
	[memberName] [nvarchar](60) NULL,
	[contactNumber] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sectionUnits]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sectionUnits](
	[suburbId] [int] NULL,
	[sectionUnitId] [int] IDENTITY(1,1) NOT NULL,
	[sectionUnit] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setExaminationFees]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setExaminationFees](
	[streamId] [int] NOT NULL,
	[examinationBoardId] [int] NOT NULL,
	[centerFee] [money] NOT NULL,
	[stationeryFee] [money] NOT NULL,
	[subjectId] [int] NOT NULL,
	[setExamFee] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setLevyPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setLevyPaymentsSchedule](
	[levyPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[streamId] [int] NULL,
	[amountPerTerm] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setRegistrationPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setRegistrationPaymentsSchedule](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[streamId] [int] NULL,
	[amount] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setTuitionPaymentsSchedule]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setTuitionPaymentsSchedule](
	[tuitionPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[streamId] [int] NULL,
	[amountPerMonth] [money] NULL,
	[amountPerExtraSubject] [money] NULL,
	[computersFee] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setTuitionPaymentsSchedule2]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setTuitionPaymentsSchedule2](
	[streamId] [int] NULL,
	[amountPerMonth] [money] NULL,
	[amountPerExtraSubject] [money] NULL,
	[computersFee] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sex]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sex](
	[sexId] [int] IDENTITY(1,1) NOT NULL,
	[sex] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportAccoladeRecipients]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportAccoladeRecipients](
	[sport] [nvarchar](50) NULL,
	[event] [nvarchar](80) NULL,
	[accoladeLevel] [nvarchar](50) NULL,
	[accolade] [nvarchar](100) NULL,
	[dtDate] [smalldatetime] NULL,
	[recipient] [nvarchar](100) NULL,
	[detailsComments] [nvarchar](200) NULL,
	[ctr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportHouses]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportHouses](
	[sportsHouseId] [int] IDENTITY(1,1) NOT NULL,
	[sportsHouse] [nvarchar](255) NULL,
	[sportsHouseColor] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sports]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sports](
	[sportId] [int] IDENTITY(1,1) NOT NULL,
	[sport] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsAccoladeEvents]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsAccoladeEvents](
	[sportId] [int] NULL,
	[eventId] [int] IDENTITY(1,1) NOT NULL,
	[event] [nvarchar](80) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsAccoladeLevels]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsAccoladeLevels](
	[accoladeLevelId] [int] IDENTITY(1,1) NOT NULL,
	[accoladeLevel] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsAccolades]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsAccolades](
	[accoladeLevelId] [int] NULL,
	[accoladeId] [int] IDENTITY(1,1) NOT NULL,
	[accolade] [nvarchar](100) NULL,
	[sportId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsTeamMembers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsTeamMembers](
	[sportsTeamId] [int] NULL,
	[studentId] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsTeams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsTeams](
	[sportId] [int] NULL,
	[sportsTeamId] [int] IDENTITY(1,1) NOT NULL,
	[sportsTeam] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sportsUniforms]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sportsUniforms](
	[teamId] [nvarchar](255) NULL,
	[kitNumber] [nvarchar](255) NULL,
	[kitDescription] [nvarchar](200) NULL,
	[dateBought] [smalldatetime] NULL,
	[supplierId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffAttendance]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffAttendance](
	[employmentNumber] [nvarchar](255) NULL,
	[dtDate] [smalldatetime] NULL,
	[present] [int] NULL,
	[reasonForAbsence] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffClubs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffClubs](
	[club] [nvarchar](30) NULL,
	[employmentNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffDepartments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffDepartments](
	[employmentNumber] [nvarchar](30) NULL,
	[departmentId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffDetails]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffDetails](
	[titleId] [int] NULL,
	[firstName] [nvarchar](50) NULL,
	[secondName] [nvarchar](50) NULL,
	[surname] [nvarchar](50) NULL,
	[natIdNumber] [nvarchar](30) NULL,
	[employmentNumber] [nvarchar](30) NULL,
	[sexId] [int] NULL,
	[dateOfBirth] [smalldatetime] NULL,
	[jobTitleId] [int] NULL,
	[schoolStaffPositionId] [int] NULL,
	[dateOfInitiation] [smalldatetime] NULL,
	[dateAppointedToSchool] [smalldatetime] NULL,
	[contactNumber] [nvarchar](30) NULL,
	[homeAddress] [nvarchar](100) NULL,
	[maritalStatusId] [int] NULL,
	[numberOfDependants] [int] NULL,
	[nextOfKinName] [nvarchar](60) NULL,
	[relationshipId] [int] NULL,
	[nextOfKinContactNumber] [nvarchar](30) NULL,
	[nextOfKinAddress] [nvarchar](100) NULL,
	[salary] [money] NULL,
	[officeNumber] [nvarchar](20) NULL,
	[dateLeft] [smalldatetime] NULL,
	[reasonForLeavingId] [int] NULL,
	[healthConditionId] [int] NULL,
	[emailAddress] [nvarchar](150) NULL,
	[unitSectionId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffIDCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_staffIDCodeGen](
	[centerCode] [char](10) NULL,
	[lastStaffIDNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_staffQualifications]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffQualifications](
	[employmentNumber] [nvarchar](30) NULL,
	[qualificationId] [int] NULL,
	[qualificationLevelId] [int] NULL,
	[collegeId] [int] NULL,
	[yearAttained] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffSports]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffSports](
	[sport] [nvarchar](30) NULL,
	[employmentNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffSubjects](
	[subject] [nvarchar](30) NULL,
	[employmentNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffSubjectsAbility]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffSubjectsAbility](
	[subject] [nvarchar](30) NULL,
	[employmentNumber] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_staffToNextOfKinRelationship]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_staffToNextOfKinRelationship](
	[relationshipId] [int] IDENTITY(1,1) NOT NULL,
	[relationship] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_streams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_streams](
	[streamId] [int] IDENTITY(1,1) NOT NULL,
	[stream] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentAttendance]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentAttendance](
	[schoolClassId] [int] NULL,
	[studentId] [nvarchar](20) NULL,
	[dtDate] [smalldatetime] NULL,
	[present] [nvarchar](255) NULL,
	[reasonForAbsenceId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentClubs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentClubs](
	[studentId] [nvarchar](255) NULL,
	[club] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentExamMarks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentExamMarks](
	[studentId] [nvarchar](30) NULL,
	[examinationId] [int] NULL,
	[markObtained] [int] NULL,
	[teacherComment] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentExtraCurriculaActivities]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentExtraCurriculaActivities](
	[studentId] [nvarchar](20) NULL,
	[activityId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentIDCodeGen]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_studentIDCodeGen](
	[centerCode] [char](10) NULL,
	[yYear] [int] NULL,
	[streamId] [int] NULL,
	[lastNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_studentIDGenerationNumber]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_studentIDGenerationNumber](
	[schoolCode] [char](10) NULL,
	[streamId] [int] NULL,
	[lastStudentNumber] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_students]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_students](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[studentId] [nvarchar](20) NULL,
	[firstName] [nvarchar](50) NULL,
	[secondName] [nvarchar](50) NULL,
	[surname] [nvarchar](50) NULL,
	[registrationDate] [smalldatetime] NULL,
	[dateOfBirth] [smalldatetime] NULL,
	[birthNumber] [nvarchar](30) NULL,
	[nationalIdNumber] [nvarchar](30) NULL,
	[sexId] [int] NULL,
	[studentPicture] [nvarchar](100) NULL,
	[homeAddress] [nvarchar](150) NULL,
	[hostelId] [int] NULL,
	[schoolClassId] [int] NULL,
	[healthConditionId] [int] NULL,
	[religionId] [int] NULL,
	[schoolPositionId] [int] NULL,
	[boardingStatusId] [int] NULL,
	[disabilityId] [int] NULL,
	[orphanhoodStatusId] [int] NULL,
	[guardianFirstname] [nvarchar](50) NULL,
	[guardianSurname] [nvarchar](50) NULL,
	[relationshipToStudentId] [int] NULL,
	[guardianTitleId] [int] NULL,
	[guardianOccupationId] [int] NULL,
	[guardianAddress] [nvarchar](150) NULL,
	[guardianContactNumber] [nvarchar](30) NULL,
	[sportsHouseId] [int] NULL,
	[dateLeft] [smalldatetime] NULL,
	[reasonForStudentLeavingId] [int] NULL,
	[emailAddress] [nvarchar](200) NULL,
	[guardianEmailAddress] [nvarchar](200) NULL,
	[studentMaritalStatusId] [int] NULL,
	[guardianMaritalStatusId] [int] NULL,
	[requiresTransportation] [int] NULL,
	[studentContactNumber] [varchar](20) NULL,
	[contractEndDate] [datetime] NULL,
	[registeredBy] [varchar](60) NULL,
	[status] [varchar](60) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_studentSports]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentSports](
	[studentId] [nvarchar](30) NULL,
	[sport] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentSubjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentSubjects](
	[studentId] [nvarchar](30) NULL,
	[subjectId] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentTeams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentTeams](
	[studentId] [int] NULL,
	[sportId] [int] NULL,
	[teamId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_studentTests]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_studentTests](
	[testId] [int] NULL,
	[studentId] [nvarchar](20) NULL,
	[markObtained] [int] NULL,
	[teacherComment] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_subjects]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_subjects](
	[subjectId] [int] IDENTITY(1,1) NOT NULL,
	[subject] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_subjectTopics]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_subjectTopics](
	[subjectTopicId] [int] IDENTITY(1,1) NOT NULL,
	[subjectTopic] [nvarchar](50) NULL,
	[subjectId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_suburbs]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_suburbs](
	[cityId] [int] NULL,
	[suburbId] [int] IDENTITY(1,1) NOT NULL,
	[suburb] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_suppliers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_suppliers](
	[supplierId] [int] IDENTITY(1,1) NOT NULL,
	[supplier] [nvarchar](50) NULL,
	[address] [nvarchar](150) NULL,
	[contactNumber] [nvarchar](50) NULL,
	[contactPerson] [nvarchar](60) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_systemErrors]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_systemErrors](
	[dDate] [datetime] NULL,
	[tTime] [datetime] NULL,
	[systemUser] [nvarchar](60) NULL,
	[module] [nvarchar](50) NULL,
	[task] [nvarchar](50) NULL,
	[errorNumber] [nvarchar](30) NULL,
	[errorMsg] [nvarchar](255) NULL,
	[ctr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_systemModules]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_systemModules](
	[sysModuleId] [int] IDENTITY(1,1) NOT NULL,
	[sysModule] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_systemModuleSections]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_systemModuleSections](
	[sysSectionId] [int] IDENTITY(1,1) NOT NULL,
	[sysSection] [varchar](50) NULL,
	[sysModuleId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_systemUsers]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_systemUsers](
	[userId] [nvarchar](50) NULL,
	[firstName] [nvarchar](30) NULL,
	[lastName] [nvarchar](30) NULL,
	[active] [int] NULL,
	[password] [nvarchar](50) NULL,
	[userGroupId] [int] NULL,
	[id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_teams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_teams](
	[teamId] [int] IDENTITY(1,1) NOT NULL,
	[team] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testDiagrams]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testDiagrams](
	[testId] [nvarchar](20) NULL,
	[questionNumber] [nvarchar](30) NULL,
	[diagramFilePath] [nvarchar](250) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testMarkAggregatesBySubject]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testMarkAggregatesBySubject](
	[studentId] [nvarchar](30) NULL,
	[subject] [nvarchar](30) NULL,
	[intYear] [int] NULL,
	[term] [nvarchar](30) NULL,
	[markObtained] [real] NULL,
	[percentage] [real] NULL,
	[grade] [nvarchar](20) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[aggregationLevel] [nvarchar](20) NULL,
	[selected] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testMarkOveralAggregation]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_testMarkOveralAggregation](
	[yYear] [int] NOT NULL,
	[tTerm] [varchar](30) NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[overalPercntgMark] [int] NULL,
	[overallGrade] [char](10) NULL,
	[overallClassPosition] [int] NULL,
	[overallStreamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[aggregationLevel] [varchar](30) NULL,
	[selected] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_testMarks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testMarks](
	[testId] [nvarchar](30) NULL,
	[studentId] [nvarchar](30) NULL,
	[markObtained] [int] NULL,
	[percentage] [int] NULL,
	[grade] [nvarchar](20) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[testLevel] [nvarchar](20) NULL,
	[stream_] [nvarchar](30) NULL,
	[class_] [nvarchar](30) NULL,
	[selected] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testPassageQuestions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testPassageQuestions](
	[testId] [nvarchar](20) NULL,
	[passageTitle] [nvarchar](150) NULL,
	[questionNumber] [nvarchar](20) NULL,
	[question] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testPassages]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testPassages](
	[testId] [nvarchar](20) NULL,
	[passageId] [int] IDENTITY(1,1) NOT NULL,
	[passageTitle] [nvarchar](150) NULL,
	[passageFilePath] [nvarchar](150) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testQtnMCAnswers_TMP]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testQtnMCAnswers_TMP](
	[testId] [nvarchar](20) NULL,
	[qtnNumber] [nvarchar](50) NULL,
	[option_] [nvarchar](10) NULL,
	[answer] [nvarchar](250) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testQuestions]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testQuestions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[testId] [nvarchar](20) NULL,
	[qtnCounter] [int] NULL,
	[qtnNumber] [nvarchar](30) NULL,
	[qtnTypeId] [int] NULL,
	[qtnDerivedFrmPassage] [int] NULL,
	[passageId] [nvarchar](30) NULL,
	[qtnHasDiagram] [int] NULL,
	[diagramPath] [nvarchar](200) NULL,
	[diagram] [nvarchar](100) NULL,
	[question] [nvarchar](250) NULL,
	[qtnTopic] [nvarchar](50) NULL,
	[mcAnswerA] [nvarchar](250) NULL,
	[mcAnswerB] [nvarchar](250) NULL,
	[mcAnswerC] [nvarchar](250) NULL,
	[mcAnswerD] [nvarchar](250) NULL,
	[mcAnswerE] [nvarchar](250) NULL,
	[answer] [nvarchar](250) NULL,
	[qtnMarks] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testQuestionTags]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testQuestionTags](
	[testId] [nvarchar](30) NULL,
	[questionNumber] [nvarchar](40) NULL,
	[tagId] [int] IDENTITY(1,1) NOT NULL,
	[tag] [nvarchar](150) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testQuestionTypes]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testQuestionTypes](
	[testQtnTypeId] [int] IDENTITY(1,1) NOT NULL,
	[testQtnType] [nvarchar](40) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_tests]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tests](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[testId] [nvarchar](20) NULL,
	[subject] [nvarchar](30) NULL,
	[testName] [nvarchar](30) NULL,
	[stream] [nvarchar](20) NULL,
	[dtDate] [smalldatetime] NULL,
	[highestPossibleMark] [int] NULL,
	[description] [nvarchar](200) NULL,
	[schClass] [nvarchar](30) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_testTopics]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_testTopics](
	[testId] [nvarchar](30) NULL,
	[subjectTopic] [nvarchar](40) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_textBooks]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_textBooks](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[bookId] [nvarchar](50) NULL,
	[bookTitle] [nvarchar](50) NULL,
	[authorFirstName] [nvarchar](40) NULL,
	[authorSurname] [nvarchar](40) NULL,
	[subjectId] [int] NULL,
	[level1] [int] NULL,
	[level2] [int] NULL,
	[version] [nvarchar](50) NULL,
	[yearPublished] [int] NULL,
	[availability] [nvarchar](50) NULL,
	[lendingDays] [int] NULL,
	[bookTypeId] [int] NULL,
	[supplierId] [int] NULL,
	[conditionId] [int] NULL,
	[serialNumber] [nvarchar](50) NULL,
	[dateSupplied] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_titles]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_titles](
	[titleId] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_TMP_studentMonthlyPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_TMP_studentMonthlyPayments](
	[studentId] [varchar](20) NOT NULL,
	[january] [money] NULL,
	[february] [money] NULL,
	[march] [money] NULL,
	[april] [money] NULL,
	[may] [money] NULL,
	[june] [money] NULL,
	[july] [money] NULL,
	[august] [money] NULL,
	[september] [money] NULL,
	[october] [money] NULL,
	[november] [money] NULL,
	[december] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_TMP_testMarkAggregatesBySubject]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TMP_testMarkAggregatesBySubject](
	[studentId] [nvarchar](30) NULL,
	[subject] [nvarchar](30) NULL,
	[intYear] [int] NULL,
	[term] [nvarchar](30) NULL,
	[markObtained] [int] NULL,
	[percentage] [int] NULL,
	[grade] [nvarchar](20) NULL,
	[classPosition] [int] NULL,
	[streamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[aggregationLevel] [nvarchar](20) NULL,
	[selected] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_TMP_testMarkOveralAggregation]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_TMP_testMarkOveralAggregation](
	[yYear] [int] NOT NULL,
	[tTerm] [varchar](30) NOT NULL,
	[studentId] [varchar](20) NOT NULL,
	[overalPercntgMark] [int] NULL,
	[overallGrade] [char](10) NULL,
	[overallClassPosition] [int] NULL,
	[overallStreamPosition] [int] NULL,
	[positionDeviation] [int] NULL,
	[aggregationLevel] [varchar](30) NULL,
	[selected] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_transferedStudents]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_transferedStudents](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[studentId] [nvarchar](20) NULL,
	[firstName] [nvarchar](50) NULL,
	[secondName] [nvarchar](50) NULL,
	[surname] [nvarchar](50) NULL,
	[registrationDate] [smalldatetime] NULL,
	[dateOfBirth] [smalldatetime] NULL,
	[birthNumber] [nvarchar](30) NULL,
	[nationalIdNumber] [nvarchar](30) NULL,
	[sexId] [int] NULL,
	[studentPicture] [nvarchar](100) NULL,
	[homeAddress] [nvarchar](150) NULL,
	[unitSectionId] [int] NULL,
	[hostelId] [int] NULL,
	[schoolClassId] [int] NULL,
	[healthConditionId] [int] NULL,
	[allergy1Id] [int] NULL,
	[allergy2Id] [int] NULL,
	[religionId] [int] NULL,
	[schoolPositionId] [int] NULL,
	[boardingStatusId] [int] NULL,
	[disabilityId] [int] NULL,
	[orphanhoodStatusId] [int] NULL,
	[guardianFirstname] [nvarchar](50) NULL,
	[guardianSurname] [nvarchar](50) NULL,
	[relationshipToStudentId] [int] NULL,
	[guardianOccupationId] [int] NULL,
	[guardianAddress] [nvarchar](150) NULL,
	[guardianContactNumber] [nvarchar](30) NULL,
	[sportsHouseId] [int] NULL,
	[dateLeft] [smalldatetime] NULL,
	[reasonForStudentLeavingId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_transportPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_transportPayments](
	[yYear] [int] NOT NULL,
	[mMonth] [char](30) NOT NULL,
	[studentId] [char](30) NULL,
	[setAmount] [money] NULL,
	[amountPaid] [money] NULL,
	[receiptNumber] [char](20) NULL,
	[transportPaymentId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_transportPaymentsHistory]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_transportPaymentsHistory](
	[dtDate] [datetime] NOT NULL,
	[studentId] [char](30) NOT NULL,
	[amountPaid] [money] NOT NULL,
	[receiptNumber] [nvarchar](30) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_transportSetAmounts]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_transportSetAmounts](
	[ctr] [int] IDENTITY(1,1) NOT NULL,
	[mmonth] [char](20) NOT NULL,
	[amount] [money] NOT NULL,
	[yYear] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_tuitionPayments]    Script Date: 21-Jul-2016 1:49:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_tuitionPayments](
	[studentId] [nvarchar](20) NOT NULL,
	[intYear] [int] NOT NULL,
	[strMonth] [char](20) NOT NULL,
	[expectedAmt] [money] NULL,
	[amountPaid] [money] NULL,
	[monthNumber] [int] NULL,
	[date] [smalldatetime] NULL,
	[penalty] [money] NULL,
	[tuitionPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[receiptNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_tuitionPayments] PRIMARY KEY CLUSTERED 
(
	[tuitionPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_tuitionPenaltyRates]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tuitionPenaltyRates](
	[range] [nchar](10) NOT NULL,
	[fromDayNumber] [int] NULL,
	[toDayNumber] [int] NULL,
	[penaltyAmount] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_uniformItems]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_uniformItems](
	[uniformItemId] [int] IDENTITY(1,1) NOT NULL,
	[uniformItem] [char](30) NULL,
	[price] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_uniformItems2]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_uniformItems2](
	[uniformItemId] [int] NOT NULL,
	[uniformItem] [nvarchar](30) NULL,
	[price] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_uniformSales]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_uniformSales](
	[saleId] [int] IDENTITY(1,1) NOT NULL,
	[dtDate] [datetime] NOT NULL,
	[receiptNumber] [char](10) NOT NULL,
	[studentId] [nvarchar](20) NOT NULL,
	[uniformItem] [char](20) NOT NULL,
	[unitPrice] [money] NOT NULL,
	[quantity] [int] NOT NULL,
	[totalPrice] [money] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_userGroups]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_userGroups](
	[userGroupId] [int] IDENTITY(1,1) NOT NULL,
	[userGroup] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_userGroups2]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userGroups2](
	[userGroupId] [int] NOT NULL,
	[userGroup] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userGroupSysPermissions]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userGroupSysPermissions](
	[userGroupId] [int] NOT NULL,
	[sysModuleSectionId] [int] NOT NULL,
	[sysRead] [int] NULL,
	[sysWrite] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userGroupSysPermissions2]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userGroupSysPermissions2](
	[userGroupId] [int] NOT NULL,
	[sysModuleSectionId] [int] NOT NULL,
	[sysRead] [int] NULL,
	[sysWrite] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userSysPermissions]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userSysPermissions](
	[userId] [nvarchar](50) NOT NULL,
	[sysModuleSectionId] [int] NOT NULL,
	[sysRead] [int] NULL,
	[sysWrite] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userSysPermissions2]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userSysPermissions2](
	[userId] [nvarchar](50) NOT NULL,
	[sysModuleSectionId] [int] NOT NULL,
	[sysRead] [int] NULL,
	[sysWrite] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFiles]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFiles](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileTypeID] [int] NULL,
	[Author] [varchar](150) NULL,
	[Title] [varchar](150) NULL,
	[Description] [varchar](255) NULL,
	[Date] [datetime] NULL,
	[FilePath] [varchar](255) NULL,
	[FileExtension] [varchar](50) NULL,
	[AuthorOrganization] [varchar](150) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ApplySecurity] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblIncidentsLocation]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblIncidentsLocation](
	[locationID] [int] NOT NULL,
	[location] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblReports]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblReports](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](255) NOT NULL,
	[LeftValue] [int] NOT NULL,
	[RightValue] [int] NOT NULL,
	[ParentID] [int] NULL,
	[TreeID] [int] NULL,
	[ReportName] [varchar](255) NULL,
	[IsContainerOnly] [bit] NULL,
	[IsSingleSelectionTree] [bit] NULL,
	[IsSearchable] [bit] NULL,
	[Mem2000Match] [int] NULL,
	[XMLString] [varchar](3000) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[IsSubscriptionBased] [bit] NULL,
	[ReportActionsXML] [varchar](3000) NULL,
	[ReportData] [varchar](max) NULL,
	[IsEditable] [bit] NULL,
	[HasParameters] [bit] NULL,
	[DisplayGroupTree] [bit] NULL,
 CONSTRAINT [PK__tblReports__34C8D9D1] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vwTimeTable]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwTimeTable] AS 

SELECT daynumba, dDay, periodNumber,CAST(fromTime AS TIME) AS FromTime,CAST(toTime AS TIME) AS Totime,stream,schClass,CL.subject, TeacherCode FROM tbl_classTimeTable CL join 
tbl_classPeriods CP ON CL.periodNumber=CP.period 




GO
/****** Object:  View [dbo].[vwTimeeTable]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwTimeeTable] AS 

SELECT dDay, periodNumber,CAST(fromTime AS TIME) AS FromTime,CAST(toTime AS TIME) AS Totime,stream,class,CL.subject, SD.employmentNumber, title+' '+ surname 
AS TeacherName FROM tbl_classTimeTable CL JOIN tbl_subjects S ON CL.subject = S.subject JOIN tbl_classSubjectTeacher ST ON ST.subjectId = S.subjectId join 
tbl_classPeriods CP ON CL.periodNumber=CP.period JOIN tbl_staffDetails SD ON St.employmentNumber = SD.employmentNumber JOIN tbl_titles T ON 
Sd.titleId = T.titleId

UNION

SELECT        dDay, periodNumber,CAST(fromTime AS TIME) AS FromTime,CAST(toTime AS TIME) AS Totime, stream, class, '' AS subject, '' AS employmentNumber, '' AS TeacherName
FROM            dbo.[vwTimeTable] AS CL



GO
/****** Object:  View [dbo].[vwAllPayments]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwAllPayments]
AS
SELECT        dbo.tbl_allPayments.dtDate, dbo.tbl_allPayments.payment, dbo.tbl_allPayments.amountPaid, dbo.tbl_allPayments.studentId, dbo.tbl_allPayments.receiptNumber, dbo.tbl_allPayments.details, 
                         dbo.tbl_allPayments.cashier, dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS studentName
FROM            dbo.tbl_allPayments INNER JOIN
                         dbo.tbl_students ON dbo.tbl_allPayments.studentId = dbo.tbl_students.studentId
WHERE        (dbo.tbl_allPayments.payment = 'Tuition')

GO
/****** Object:  View [dbo].[vwLevyReceipt]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwLevyReceipt]
AS
SELECT        dbo.tbl_allPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_allPayments.dtDate AS Date, dbo.tbl_allPayments.payment AS [payment type], 
                         dbo.tbl_allPayments.amountPaid, dbo.tbl_allPayments.paymentId, dbo.tbl_students.firstName + ' ' + dbo.tbl_students.secondName + ' ' + dbo.tbl_students.surname AS studentName, 
                         dbo.tbl_allPayments.receiptNumber, dbo.tbl_allPayments.details, dbo.tbl_allPayments.cashier, dbo.tbl_LevyPayments.studentd, dbo.tbl_LevyPayments.strTerm, dbo.tbl_LevyPayments.penalty
FROM            dbo.tbl_LevyPayments INNER JOIN
                         dbo.tbl_allPayments ON dbo.tbl_LevyPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber AND dbo.tbl_LevyPayments.studentd = dbo.tbl_allPayments.studentId INNER JOIN
                         dbo.tbl_schoolClasses INNER JOIN
                         dbo.tbl_students ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId INNER JOIN
                         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId ON dbo.tbl_LevyPayments.studentd = dbo.tbl_students.studentId

GO
/****** Object:  View [dbo].[vwStudentReports]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStudentReports]
AS
SELECT        dbo.tbl_tuitionPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.intYear, dbo.tbl_tuitionPayments.strMonth, dbo.tbl_tuitionPayments.expectedAmt, 
                         dbo.tbl_tuitionPayments.amountPaid, dbo.tbl_tuitionPayments.expectedAmt - dbo.tbl_tuitionPayments.amountPaid AS balance, dbo.tbl_tuitionPayments.monthNumber, dbo.tbl_tuitionPayments.date, 
                         dbo.tbl_tuitionPayments.penalty, dbo.tbl_tuitionPayments.tuitionPaymentId, dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS student, dbo.tbl_students.registrationDate, 
                         dbo.tbl_students.dateOfBirth, dbo.tbl_students.homeAddress, dbo.tbl_tuitionPayments.receiptNumber, dbo.tbl_allPayments.cashier
FROM            dbo.tbl_tuitionPayments INNER JOIN
                         dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN
                         dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN
                         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId INNER JOIN
                         dbo.tbl_allPayments ON dbo.tbl_tuitionPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber
WHERE        (dbo.tbl_tuitionPayments.expectedAmt - dbo.tbl_tuitionPayments.amountPaid > 0)
UNION
SELECT        dbo.tbl_tuitionPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_tuitionPayments.intYear, dbo.tbl_tuitionPayments.strMonth, dbo.tbl_tuitionPayments.expectedAmt, 
                         dbo.tbl_tuitionPayments.amountPaid, 0 AS balance, dbo.tbl_tuitionPayments.monthNumber, dbo.tbl_tuitionPayments.date, dbo.tbl_tuitionPayments.penalty, dbo.tbl_tuitionPayments.tuitionPaymentId, 
                         dbo.tbl_students.firstName + ' ' + dbo.tbl_students.surname AS student, dbo.tbl_students.registrationDate, dbo.tbl_students.dateOfBirth, dbo.tbl_students.homeAddress, dbo.tbl_tuitionPayments.receiptNumber, 
                         dbo.tbl_allPayments.cashier
FROM            dbo.tbl_tuitionPayments INNER JOIN
                         dbo.tbl_students ON dbo.tbl_tuitionPayments.studentId = dbo.tbl_students.studentId INNER JOIN
                         dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN
                         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId INNER JOIN
                         dbo.tbl_allPayments ON dbo.tbl_tuitionPayments.receiptNumber = dbo.tbl_allPayments.receiptNumber
WHERE        (dbo.tbl_tuitionPayments.expectedAmt - dbo.tbl_tuitionPayments.amountPaid <= 0)

GO
/****** Object:  View [dbo].[vwTotalEnrolmentByClass]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwTotalEnrolmentByClass]
AS
SELECT        dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, COUNT(dbo.tbl_students.studentId) AS NumOfStudents
FROM            dbo.tbl_schoolClasses INNER JOIN
                         dbo.tbl_students ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId INNER JOIN
                         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId
GROUP BY dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass

GO
/****** Object:  View [dbo].[vwTotalEnrolmentByClassBySex]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwTotalEnrolmentByClassBySex]
AS
SELECT        stream, schoolClass, SUM(Males) AS Males, SUM(Females) AS Females
FROM            (SELECT        dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_sex.sex, COUNT(dbo.tbl_students.studentId) AS Males, 0 AS Females
                          FROM            dbo.tbl_schoolClasses INNER JOIN
                                                    dbo.tbl_students ON dbo.tbl_schoolClasses.schoolClassId = dbo.tbl_students.schoolClassId INNER JOIN
                                                    dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId INNER JOIN
                                                    dbo.tbl_sex ON dbo.tbl_students.sexId = dbo.tbl_sex.sexId
                          GROUP BY dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_sex.sex
                          HAVING         (dbo.tbl_sex.sex = N'Male')
                          UNION
                          SELECT        tbl_streams_1.stream, tbl_schoolClasses_1.schoolClass, tbl_sex_1.sex, 0 AS Males, COUNT(tbl_students_1.studentId) AS Females
                          FROM            dbo.tbl_schoolClasses AS tbl_schoolClasses_1 INNER JOIN
                                                   dbo.tbl_students AS tbl_students_1 ON tbl_schoolClasses_1.schoolClassId = tbl_students_1.schoolClassId INNER JOIN
                                                   dbo.tbl_streams AS tbl_streams_1 ON tbl_schoolClasses_1.streamId = tbl_streams_1.streamId INNER JOIN
                                                   dbo.tbl_sex AS tbl_sex_1 ON tbl_students_1.sexId = tbl_sex_1.sexId
                          GROUP BY tbl_streams_1.stream, tbl_schoolClasses_1.schoolClass, tbl_sex_1.sex
                          HAVING        (tbl_sex_1.sex = N'Female')) AS derivedtbl_1
GROUP BY stream, schoolClass

GO
/****** Object:  View [dbo].[vwTransportReceipt]    Script Date: 21-Jul-2016 1:49:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwTransportReceipt] as
SELECT        dbo.tbl_allPayments.studentId, dbo.tbl_streams.stream, dbo.tbl_schoolClasses.schoolClass, dbo.tbl_allPayments.dtDate as Date, tbl_allPayments.payment [payment type],
                         dbo.tbl_allPayments.amountPaid,dbo.tbl_allPayments.paymentId, dbo.tbl_students.firstName, dbo.tbl_students.surname, 
                         dbo.tbl_students.registrationDate, dbo.tbl_students.dateOfBirth, dbo.tbl_students.sexId, dbo.tbl_students.homeAddress
FROM            dbo.tbl_allPayments INNER JOIN
                         dbo.tbl_students ON dbo.tbl_allPayments.studentId = dbo.tbl_students.studentId INNER JOIN
                         dbo.tbl_schoolClasses ON dbo.tbl_students.schoolClassId = dbo.tbl_schoolClasses.schoolClassId INNER JOIN
                         dbo.tbl_streams ON dbo.tbl_schoolClasses.streamId = dbo.tbl_streams.streamId

GO
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (1, N'Accontant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (2, N'Accountant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (3, N'Accounts clerk')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (4, N'Advocate')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (5, N'Agent')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (6, N'Air Hostess')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (7, N'Airside Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (8, N'Anglo American')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (9, N'Architecture')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (10, N'Army general')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (11, N'Art Painter')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (12, N'Artisan')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (13, N'Ass Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (14, N'Assistant Commisioner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (15, N'Assistant Commissioner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (16, N'Assistant Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (17, N'Audit manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (18, N'Auditor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (19, N'Bank Auditor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (20, N'Bank Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (21, N'Bank teller')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (22, N'Banker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (23, N'Beauty therapist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (24, N'Bookkeeper')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (25, N'Brigadier')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (26, N'Builder')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (27, N'Businessman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (28, N'Businesswoman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (29, N'Bussiness')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (30, N'Bussinessman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (31, N'Bussinesswoman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (32, N'C .operator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (33, N'C.C.C.')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (34, N'C/A')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (35, N'Caretaker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (36, N'Cashier')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (37, N'Central Intelligence Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (38, N'CEO')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (39, N'Chartered A/C')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (40, N'Chartered Accountant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (41, N'Chef')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (42, N'CIS Administrator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (43, N'City Council')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (44, N'Civil servant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (45, N'Civil service (UZ)')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (46, N'Civil sevant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (47, N'Clearing Agent')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (48, N'Clerk')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (49, N'Coach')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (50, N'Commissioner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (51, N'Commodity Broker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (52, N'Constructor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (53, N'Consultant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (54, N'Contractor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (55, N'cook')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (56, N'Cooker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (57, N'Cross border')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (58, N'Deputy  Director of Finance')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (59, N'Deputy Head')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (60, N'Director')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (61, N'Doctor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (62, N'Dressmaker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (63, N'Driver')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (64, N'Electrical engineer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (65, N'Electrician')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (66, N'Eletrician')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (67, N'Engineer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (68, N'Enginner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (69, N'Enterprenuer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (70, N'Environment Agent')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (71, N'Evaluator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (72, N'Exterminator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (73, N'Fabricator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (74, N'Fashion Designer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (75, N'Finance Director')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (76, N'Fire Brigade')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (77, N'Fireman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (78, N'Food World')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (79, N'Freelance cameramen')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (80, N'Fuel Attendant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (81, N'G.M')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (82, N'General manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (83, N'Global Admin')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (84, N'Greenleaf Admin')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (85, N'Guard')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (86, N'Hair dresser')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (87, N'Hairdresser')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (88, N'Headmistress')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (89, N'Hosewife')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (90, N'Housewife')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (91, N'Imports Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (92, N'Insurance Ptactioner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (93, N'ISA manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (94, N'Justice and Legal Dept')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (95, N'Lab Scientist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (96, N'Lawyer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (97, N'Line Assembler (ZESA)')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (98, N'Logistics')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (99, N'Maid')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (100, N'Manager')
GO
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (101, N'Manageress')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (102, N'Managing Director')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (103, N'Mechanic')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (104, N'Member of Parliament')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (105, N'Merchandiser')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (106, N'Messenger')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (107, N'Miner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (108, N'Missing')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (109, N'Motor Engineer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (110, N'N/A')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (111, N'Network engineer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (112, N'Network enginneer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (113, N'Nurse')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (114, N'Nurse Aid')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (115, N'Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (116, N'Operating Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (117, N'Operations Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (118, N'Operator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (119, N'P.A')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (120, N'P.Valuator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (121, N'Painter')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (122, N'Panel beater')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (123, N'Pastor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (124, N'Pensioner')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (125, N'PG Glass')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (126, N'Pharmacist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (127, N'Physiotherapist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (128, N'Pilot')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (129, N'Plumber')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (130, N'Poet man')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (131, N'Police')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (132, N'Police man')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (133, N'Police office')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (134, N'Police officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (135, N'Policeman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (136, N'Politician')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (137, N'Presenter')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (138, N'Presidents office')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (139, N'Principal')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (140, N'Prison Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (141, N'Private nurse')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (142, N'Programmer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (143, N'Project Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (144, N'Prosecutor General')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (145, N'Pubilc worker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (146, N'Public service')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (147, N'Public worker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (148, N'Publisher')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (149, N'Purchasing Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (150, N'PVI')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (151, N'Pysioterapist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (152, N'Receptioniist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (153, N'Receptionist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (154, N'Red cross')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (155, N'Registry Manager')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (156, N'Retired soldier')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (157, N'Sales man')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (158, N'Sales rep')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (159, N'Sales wonan')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (160, N'Scretary')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (161, N'Sculptor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (162, N'Secretary')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (163, N'Security Guard')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (164, N'Security Officer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (165, N'Self emlpoyed')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (166, N'Self employed')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (167, N'Sergeant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (168, N'Shop Assistant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (169, N'Shop attendant')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (170, N'Shopkeeper')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (171, N'Sinage Installer')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (172, N'Social worker')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (173, N'Soldier')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (174, N'Storeman')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (175, N'Supervisor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (176, N'Surveyor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (177, N'Switchboard operator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (178, N'Tailor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (179, N'Tax Driver')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (180, N'Taxi Driver')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (181, N'Teacher')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (182, N'Technician')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (183, N'Till operator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (184, N'Travel agent')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (185, N'Treasure')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (186, N'Truck Driver')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (187, N'Turmer mechanist')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (188, N'UNICEF Admin')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (189, N'Valuator')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (190, N'Vendor')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (191, N'War veteran')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (192, N'ZCTU')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (193, N'Zimbabwe Prisons')
INSERT [dbo].[occupations] ([occupationIId], [Occupation]) VALUES (194, N'ZWF Chairperson')
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Adbernie', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Airport', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Alex Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Arcadia', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Ashdown', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Avenues', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Avondale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Avondale West', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Belgravia', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Belvedere', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Bluffhill', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Borrowdale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Borrowdale Brooke', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Borrowdale West', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Braeside', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Broadlands', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'BTD', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro 1', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro 2', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro 4', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Budiriro 5', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Callaway', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Camp', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chadcombe', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chartsworth', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chihota', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chikurubi Prison', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chishawasha Hills', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Chisipite', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Cold Comfort', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Cranborne', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Crowhill', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Crowhill View', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Crowrobough', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Damofalls', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Dawnville', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Dzivarasekwa', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Dzivarasekwa 2', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Dzivarasekwa 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Dzivarasekwa Extension', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Eastlea', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Eastview', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Emerald Hill', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Epworth', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Fairfied', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Flates', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Gardens', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glamis', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glaudina', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen Lorne', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen Norah', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen Norah A', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen Norah B', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen Norah C', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View 1', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View 2', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View 7', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glen View 8', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glenara Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glendale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glenforest', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glenhood Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Glenwood', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Goromonzi', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Greencroft', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Greendale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Greystone Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Gwebi College', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Haig Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Harare', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Hatcliffe', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Hatcliffe Extension', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Hatfield', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Helensvale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Highfields', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Highlands', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Hillside', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Houghton Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Irvines', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kambuzuma', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kufakose', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana 5', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana 7', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana Extension', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Kuwadzana Phase 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Lenana Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Lockingva', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mabvuku', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mainway Meadows', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mandara', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Manyame Airbase', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Manyame Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Manyame Training Centre', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Maranatha Park', NULL)
GO
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Marlbereign', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Marlborough', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Masasa', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Masvingo', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mbare', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mbare Police Camp', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Melbourne', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Melfort Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Merryic Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Milton Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Missing', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Monavale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Msasa', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Msasa Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mt Hampden', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mt Pleasant', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mt Pleasant Heights', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Mufakose', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'National Defence College', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'New Ceney Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'New Flats', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'New Mabvuku', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'New Marlborough', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Newcene Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Norton', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Norton Jeffrey', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Old Mazowe Road', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Parktown', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Pilanike', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Prospect', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Queen Elizabeth School', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Queensdale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Rhodesville Police Camp', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Ridgeview', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'RoadWaterfalls', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Rugare', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Rusununguko', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Ruwa', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sally Mugabe', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sam Levy', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Section C Agriculture', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sentosa', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Shevert', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Southerton', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Southlea Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Souyhlands Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'St Martins', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Stoneyridge Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Strathaven', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sunningdale', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sunningdale 2', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sunningdale 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Sunridge', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Tafara', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Tombli Flats', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Tynwald', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Tynwald South', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Vainona', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Warren', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Warren Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Warren Park 1', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Warren Park D', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Waterfalls', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Westgate', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Westlea', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Westwood', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Whitecliff', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 1, N'Zimre Park', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 2, N'Chitungwiza', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 2, N'St Marys', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 2, N'Zengeza 3', NULL)
INSERT [dbo].[suburbs] ([suburbId], [cityId], [Suburb], [sectionId]) VALUES (NULL, 2, N'Zengeza 4', NULL)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (1, 1, N'Adbernie', 1, 1)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (2, 1, N'Airport', 2, 2)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (3, 1, N'Alex Park', 3, 3)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (4, 1, N'Arcadia', 4, 4)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (5, 1, N'Ashdown', 5, 5)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (6, 1, N'Avenues', 6, 6)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (7, 1, N'Avondale', 7, 7)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (8, 1, N'Avondale West', 8, 8)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (9, 1, N'Belgravia', 9, 9)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (10, 1, N'Belvedere', 10, 10)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (11, 1, N'Bluffhill', 11, 11)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (12, 1, N'Borrowdale', 12, 12)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (13, 1, N'Borrowdale Brooke', 13, 13)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (14, 1, N'Borrowdale West', 14, 14)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (15, 1, N'Braeside', 15, 15)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (16, 1, N'Broadlands', 16, 16)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (17, 1, N'BTD', 17, 17)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (18, 1, N'Budiriro', 18, 18)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (19, 1, N'Budiriro 1', 19, 19)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (20, 1, N'Budiriro 2', 20, 20)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (21, 1, N'Budiriro 3', 21, 21)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (22, 1, N'Budiriro 4', 22, 22)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (23, 1, N'Budiriro 5', 23, 23)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (24, 1, N'Callaway', 24, 24)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (25, 1, N'Camp', 25, 25)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (26, 1, N'Chadcombe', 26, 26)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (27, 1, N'Chartsworth', 27, 27)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (28, 1, N'Chihota', 28, 28)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (29, 1, N'Chikurubi Prison', 29, 29)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (30, 1, N'Chishawasha Hills', 30, 30)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (31, 1, N'Chisipite', 31, 31)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (32, 1, N'Cold Comfort', 32, 32)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (33, 1, N'Cranborne', 33, 33)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (34, 1, N'Crowhill', 34, 34)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (35, 1, N'Crowhill View', 35, 35)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (36, 1, N'Crowrobough', 36, 36)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (37, 1, N'Damofalls', 37, 37)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (38, 1, N'Dawnville', 38, 38)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (39, 1, N'Dzivarasekwa', 39, 39)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (40, 1, N'Dzivarasekwa 2', 40, 40)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (41, 1, N'Dzivarasekwa 3', 41, 41)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (42, 1, N'Dzivarasekwa Extension', 42, 42)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (43, 1, N'Eastlea', 43, 43)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (44, 1, N'Eastview', 44, 44)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (45, 1, N'Emerald Hill', 45, 45)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (46, 1, N'Epworth', 46, 46)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (47, 1, N'Fairfied', 47, 47)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (48, 1, N'Flates', 48, 48)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (49, 1, N'Gardens', 49, 49)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (50, 1, N'Glamis', 50, 50)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (51, 1, N'Glaudina', 51, 51)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (52, 1, N'Glen Lorne', 52, 52)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (53, 1, N'Glen Norah', 53, 53)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (54, 1, N'Glen Norah A', 54, 54)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (55, 1, N'Glen Norah B', 55, 55)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (56, 1, N'Glen Norah C', 56, 56)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (57, 1, N'Glen View', 57, 57)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (58, 1, N'Glen View 1', 58, 58)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (59, 1, N'Glen View 2', 59, 59)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (60, 1, N'Glen View 3', 60, 60)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (61, 1, N'Glen View 7', 61, 61)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (62, 1, N'Glen View 8', 62, 62)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (63, 1, N'Glenara Park', 63, 63)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (64, 1, N'Glendale', 64, 64)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (65, 1, N'Glenforest', 65, 65)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (66, 1, N'Glenhood Park', 66, 66)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (67, 1, N'Glenwood', 67, 67)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (68, 1, N'Goromonzi', 68, 68)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (69, 1, N'Greencroft', 69, 69)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (70, 1, N'Greendale', 70, 70)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (71, 1, N'Greystone Park', 71, 71)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (72, 1, N'Gwebi College', 72, 72)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (73, 1, N'Haig Park', 73, 73)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (74, 1, N'Harare', 74, 74)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (75, 1, N'Hatcliffe', 75, 75)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (76, 1, N'Hatcliffe Extension', 76, 76)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (77, 1, N'Hatfield', 77, 77)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (78, 1, N'Helensvale', 78, 78)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (79, 1, N'Highfields', 79, 79)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (80, 1, N'Highlands', 80, 80)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (81, 1, N'Hillside', 81, 81)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (82, 1, N'Houghton Park', 82, 82)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (83, 1, N'Irvines', 83, 83)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (84, 1, N'Kambuzuma', 84, 84)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (85, 1, N'Kufakose', 85, 85)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (86, 1, N'Kuwadzana', 86, 86)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (87, 1, N'Kuwadzana 3', 87, 87)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (88, 1, N'Kuwadzana 5', 88, 88)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (89, 1, N'Kuwadzana 7', 89, 89)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (90, 1, N'Kuwadzana Extension', 90, 90)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (91, 1, N'Kuwadzana Phase 3', 91, 91)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (92, 1, N'Lenana Park', 92, 92)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (93, 1, N'Lockingva', 93, 93)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (94, 1, N'Mabvuku', 94, 94)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (95, 1, N'Mainway Meadows', 95, 95)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (96, 1, N'Mandara', 96, 96)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (97, 1, N'Manyame Airbase', 97, 97)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (98, 1, N'Manyame Park', 98, 98)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (99, 1, N'Manyame Training Centre', 99, 99)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (100, 1, N'Maranatha Park', 100, 100)
GO
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (101, 1, N'Marlbereign', 101, 101)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (102, 1, N'Marlborough', 102, 102)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (103, 1, N'Masasa', 103, 103)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (104, 1, N'Masvingo', 104, 104)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (105, 1, N'Mbare', 105, 105)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (106, 1, N'Mbare Police Camp', 106, 106)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (107, 1, N'Melbourne', 107, 107)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (108, 1, N'Melfort Park', 108, 108)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (109, 1, N'Merryic Park', 109, 109)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (110, 1, N'Milton Park', 110, 110)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (111, 1, N'Missing', 111, 111)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (112, 1, N'Monavale', 112, 112)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (113, 1, N'Msasa', 113, 113)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (114, 1, N'Msasa Park', 114, 114)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (115, 1, N'Mt Hampden', 115, 115)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (116, 1, N'Mt Pleasant', 116, 116)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (117, 1, N'Mt Pleasant Heights', 117, 117)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (118, 1, N'Mufakose', 118, 118)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (119, 1, N'National Defence College', 119, 119)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (120, 1, N'New Ceney Park', 120, 120)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (121, 1, N'New Flats', 121, 121)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (122, 1, N'New Mabvuku', 122, 122)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (123, 1, N'New Marlborough', 123, 123)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (124, 1, N'Newcene Park', 124, 124)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (125, 1, N'Norton', 125, 125)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (126, 1, N'Norton Jeffrey', 126, 126)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (127, 1, N'Old Mazowe Road', 127, 127)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (128, 1, N'Parktown', 128, 128)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (129, 1, N'Pilanike', 129, 129)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (130, 1, N'Prospect', 130, 130)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (131, 1, N'Queen Elizabeth School', 131, 131)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (132, 1, N'Queensdale', 132, 132)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (133, 1, N'Rhodesville Police Camp', 133, 133)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (134, 1, N'Ridgeview', 134, 134)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (135, 1, N'RoadWaterfalls', 135, 135)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (136, 1, N'Rugare', 136, 136)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (137, 1, N'Rusununguko', 137, 137)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (138, 1, N'Ruwa', 138, 138)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (139, 1, N'Sally Mugabe', 139, 139)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (140, 1, N'Sam Levy', 140, 140)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (141, 1, N'Section C Agriculture', 141, 141)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (142, 1, N'Sentosa', 142, 142)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (143, 1, N'Shevert', 143, 143)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (144, 1, N'Southerton', 144, 144)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (145, 1, N'Southlea Park', 145, 145)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (146, 1, N'Souyhlands Park', 146, 146)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (147, 1, N'St Martins', 147, 147)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (148, 1, N'Stoneyridge Park', 148, 148)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (149, 1, N'Strathaven', 149, 149)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (150, 1, N'Sunningdale', 150, 150)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (151, 1, N'Sunningdale 2', 151, 151)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (152, 1, N'Sunningdale 3', 152, 152)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (153, 1, N'Sunridge', 153, 153)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (154, 1, N'Tafara', 154, 154)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (155, 1, N'Tombli Flats', 155, 155)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (156, 1, N'Tynwald', 156, 156)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (157, 1, N'Tynwald South', 157, 157)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (158, 1, N'Vainona', 158, 158)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (159, 1, N'Warren', 159, 159)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (160, 1, N'Warren Park', 160, 160)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (161, 1, N'Warren Park 1', 161, 161)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (162, 1, N'Warren Park D', 162, 162)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (163, 1, N'Waterfalls', 163, 163)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (164, 1, N'Westgate', 164, 164)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (165, 1, N'Westlea', 165, 165)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (166, 1, N'Westwood', 166, 166)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (167, 1, N'Whitecliff', 167, 167)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (168, 1, N'Zimre Park', 168, 168)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (169, 2, N'Chitungwiza', 169, 169)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (170, 2, N'St Marys', 170, 170)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (171, 2, N'Zengeza 3', 171, 171)
INSERT [dbo].[suburbsVF] ([suburbId], [cityId], [Suburb], [sectionId], [ctr]) VALUES (172, 2, N'Zengeza 4', 172, 172)
SET IDENTITY_INSERT [dbo].[tbl_allergy] ON 

INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (1, N'Aspirin')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (2, N'Jacarandah/Flowers/Grass')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (3, N'None')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (5, N'Dust/Smoke/Wind')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (6, N'Fish/Eggs                                         ')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (13, N'Pineapple/Pears')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (14, N'Missing                                           ')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (9, N'Perfume')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (10, N'Smoke')
INSERT [dbo].[tbl_allergy] ([allergyId], [allergy]) VALUES (11, N'Sun')
SET IDENTITY_INSERT [dbo].[tbl_allergy] OFF
SET IDENTITY_INSERT [dbo].[tbl_allPayments] ON 

INSERT [dbo].[tbl_allPayments] ([paymentId], [payment], [amountPaid], [studentId], [receiptNumber], [dtDate], [details], [cashier]) VALUES (1, N'Tuition', 180.0000, N'HCBD16F1013D', N'1', CAST(0x0000A60400000000 AS DateTime), N'tuiton payment for  HCBD16F1013D', N'Leslie Nyakudya')
INSERT [dbo].[tbl_allPayments] ([paymentId], [payment], [amountPaid], [studentId], [receiptNumber], [dtDate], [details], [cashier]) VALUES (2, N'Tuition', 180.0000, N'HCBD16F1010D', N'H0000048', CAST(0x0000A64A00000000 AS DateTime), N'tuiton payment for  HCBD16F1010D', N'Leslie Nyakudya')
SET IDENTITY_INSERT [dbo].[tbl_allPayments] OFF
SET IDENTITY_INSERT [dbo].[tbl_assets] ON 

INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (1, 10, N'Desk(s)')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (2, 1, N'Bus')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (2, 2, N'Lorry')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (3, 3, N'Computer')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (3, 4, N'Lawn Mower')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (3, 5, N'Printer')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (3, 6, N'Projector')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (3, 7, N'Piano')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (1, 8, N'Table(s)')
INSERT [dbo].[tbl_assets] ([assetTypeId], [assetId], [asset]) VALUES (1, 9, N'Chair(s)')
SET IDENTITY_INSERT [dbo].[tbl_assets] OFF
SET IDENTITY_INSERT [dbo].[tbl_assetTypes] ON 

INSERT [dbo].[tbl_assetTypes] ([assetTypeId], [assetType]) VALUES (1, N'Furniture')
INSERT [dbo].[tbl_assetTypes] ([assetTypeId], [assetType]) VALUES (2, N'Vehicles')
INSERT [dbo].[tbl_assetTypes] ([assetTypeId], [assetType]) VALUES (3, N'Machinery')
SET IDENTITY_INSERT [dbo].[tbl_assetTypes] OFF
SET IDENTITY_INSERT [dbo].[tbl_boardingStatus] ON 

INSERT [dbo].[tbl_boardingStatus] ([boardingStatusId], [boardingStatus]) VALUES (1, N'Boarder')
INSERT [dbo].[tbl_boardingStatus] ([boardingStatusId], [boardingStatus]) VALUES (0, N'Day Scholar')
SET IDENTITY_INSERT [dbo].[tbl_boardingStatus] OFF
SET IDENTITY_INSERT [dbo].[tbl_bookAvailabilityStatuses] ON 

INSERT [dbo].[tbl_bookAvailabilityStatuses] ([availabilityId], [availability]) VALUES (1, N'Available                     ')
INSERT [dbo].[tbl_bookAvailabilityStatuses] ([availabilityId], [availability]) VALUES (2, N'Loaned Out                    ')
INSERT [dbo].[tbl_bookAvailabilityStatuses] ([availabilityId], [availability]) VALUES (3, N'Lost                          ')
INSERT [dbo].[tbl_bookAvailabilityStatuses] ([availabilityId], [availability]) VALUES (4, N'With-Held                     ')
SET IDENTITY_INSERT [dbo].[tbl_bookAvailabilityStatuses] OFF
SET IDENTITY_INSERT [dbo].[tbl_bookCondition] ON 

INSERT [dbo].[tbl_bookCondition] ([bookConditionId], [bookCondition]) VALUES (1, N'New')
INSERT [dbo].[tbl_bookCondition] ([bookConditionId], [bookCondition]) VALUES (2, N'Fair')
INSERT [dbo].[tbl_bookCondition] ([bookConditionId], [bookCondition]) VALUES (3, N'Old')
SET IDENTITY_INSERT [dbo].[tbl_bookCondition] OFF
SET IDENTITY_INSERT [dbo].[tbl_bookTypes] ON 

INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (1, N'Standard Text Book')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (2, N'Margazine')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (3, N'Journal')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (4, N'Examination Papers')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (5, N'Report')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (6, N'Novels')
INSERT [dbo].[tbl_bookTypes] ([bookTypeId], [bookType]) VALUES (7, N'Test Book Type 44')
SET IDENTITY_INSERT [dbo].[tbl_bookTypes] OFF
SET IDENTITY_INSERT [dbo].[tbl_bookVersions] ON 

INSERT [dbo].[tbl_bookVersions] ([versionId], [version]) VALUES (1, N'Version 1')
INSERT [dbo].[tbl_bookVersions] ([versionId], [version]) VALUES (2, N'Version 2')
INSERT [dbo].[tbl_bookVersions] ([versionId], [version]) VALUES (3, N'Vesrion 3')
INSERT [dbo].[tbl_bookVersions] ([versionId], [version]) VALUES (4, N'Version 4')
INSERT [dbo].[tbl_bookVersions] ([versionId], [version]) VALUES (5, N'Version 5')
SET IDENTITY_INSERT [dbo].[tbl_bookVersions] OFF
SET IDENTITY_INSERT [dbo].[tbl_cashBook] ON 

INSERT [dbo].[tbl_cashBook] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy]) VALUES (1, CAST(0x0000A61A00000000 AS DateTime), 1000.0000, NULL, NULL, NULL, 1000.0000, N'Test 1', N'Leslie Nyakudya')
INSERT [dbo].[tbl_cashBook] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy]) VALUES (2, CAST(0x0000A61A00000000 AS DateTime), NULL, 500.0000, NULL, NULL, 1500.0000, N'test 2', N'Leslie Nyakudya')
SET IDENTITY_INSERT [dbo].[tbl_cashBook] OFF
SET IDENTITY_INSERT [dbo].[tbl_cashBookVariances] ON 

INSERT [dbo].[tbl_cashBookVariances] ([entryNumber], [dtDate], [mode], [expected], [captured], [variance], [narration]) VALUES (1, N'6/3/2016', N'Opening Balance', N'0', N'1000', N'1000', N'Test 1')
SET IDENTITY_INSERT [dbo].[tbl_cashBookVariances] OFF
SET IDENTITY_INSERT [dbo].[tbl_cities] ON 

INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (1, N'Harare')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (2, N'Chitungwiza')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (3, N'Mutare')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (4, N'Gweru')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (5, N'Bulawayo')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (6, N'Masvingo')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (7, N'Chinhoyi')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (8, N'Mutare                        ')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (9, N'Test City                     ')
INSERT [dbo].[tbl_cities] ([cityId], [city]) VALUES (10, N'Norton                        ')
SET IDENTITY_INSERT [dbo].[tbl_cities] OFF
SET IDENTITY_INSERT [dbo].[tbl_classPeriods] ON 

INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (1, 1, CAST(0xFFFFFFFE0083D600 AS DateTime), CAST(0xFFFFFFFE009450C0 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (2, 2, CAST(0xFFFFFFFE009450C0 AS DateTime), CAST(0xFFFFFFFE00A4CB80 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (3, 3, CAST(0xFFFFFFFE00A4CB80 AS DateTime), CAST(0xFFFFFFFE00B54640 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (4, 4, CAST(0xFFFFFFFE00B54640 AS DateTime), CAST(0xFFFFFFFE00000000 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (5, 5, CAST(0xFFFFFFFE00000000 AS DateTime), CAST(0xFFFFFFFE00D63BC0 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (6, 6, CAST(0xFFFFFFFE00D63BC0 AS DateTime), CAST(0xFFFFFFFE00E6B680 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (7, 7, CAST(0xFFFFFFFE00E6B680 AS DateTime), CAST(0xFFFFFFFE00F73140 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (8, 8, CAST(0xFFFFFFFE00F73140 AS DateTime), CAST(0xFFFFFFFE0107AC00 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (9, 9, CAST(0xFFFFFFFE0107AC00 AS DateTime), CAST(0xFFFFFFFE011826C0 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (10, 10, CAST(0xFFFFFFFE011826C0 AS DateTime), CAST(0xFFFFFFFE0128A180 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (11, 11, CAST(0xFFFFFFFE0128A180 AS DateTime), CAST(0xFFFFFFFE01391C40 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (12, 12, CAST(0xFFFFFFFE01391C40 AS DateTime), CAST(0xFFFFFFFE01499700 AS DateTime))
INSERT [dbo].[tbl_classPeriods] ([ctr], [period], [fromTime], [toTime]) VALUES (13, 13, CAST(0xFFFFFFFE01499700 AS DateTime), CAST(0xFFFFFFFE015A11C0 AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_classPeriods] OFF
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0009                        ', 20, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0009                        ', 2, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0009                        ', 20, 21)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0009                        ', 7, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0009                        ', 2, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0020                        ', 3, 21)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0020                        ', 3, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0020                        ', 3, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0020                        ', 3, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0020                        ', 3, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 7, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 24, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 7, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 24, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 7, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 1, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 7, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0019                        ', 1, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 1, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 16)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 20)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0003                        ', 1, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 3, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 3, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 21, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 3, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 3, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 21, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 21, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0016                        ', 21, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 22)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 18)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0034                        ', 5, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0002                        ', 6, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 2, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 2, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 2, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 2, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 21, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0028                        ', 2, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0012                        ', 3, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0012                        ', 3, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0012                        ', 3, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 15, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 15, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 15, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 15, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 16, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 17, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 16, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0010                        ', 15, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 5, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 5, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 4, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 5, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 4, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0018                        ', 5, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0014                        ', 26, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0014                        ', 26, 21)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 18, 20)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 15, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 19, 16)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 1, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 18, 16)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 1, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0008                        ', 19, 20)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 15, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 15, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 15, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 15, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 1, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 15, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0005                        ', 17, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0004                        ', 4, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0004                        ', 4, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0004                        ', 4, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0004                        ', 4, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 4, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 4, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 4, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 7, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 7, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 7, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 4, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0011                        ', 7, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0017                        ', 7, 12)
GO
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0017                        ', 7, 11)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0017                        ', 7, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0017                        ', 27, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0017                        ', 7, 21)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0013                        ', 6, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0013                        ', 21, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0013                        ', 21, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0013                        ', 6, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 13)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 12)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 16)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 17)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 18)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 5)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 1)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 2)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 8)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 4)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 9)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 14)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 20)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 21)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 22)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 7)
INSERT [dbo].[tbl_classSubjectTeacher] ([employmentNumber], [subjectId], [classId]) VALUES (N'HA0039                        ', 30, 11)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 2', N'2 Blue', N'COPS', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 3', N'3 Cream', N'Biology', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 3', N'3 Gold', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 4', N'4 Blue', N'Business Studies', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 4', N'4 Cream', N'Accounts', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 4', N'4 Red', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 5', N'L6A', N'Shona', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 5', N'L6C', N'Accounts', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 5', N'L6S', N'Physics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 6', N'U6A', N'Divinity', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 1, N'Form 6', N'U6S', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 1', N'1 Blue', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 3', N'3 Blue', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 3', N'3 Cream', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 3', N'3 Gold', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 4', N'4 Blue', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 4', N'4 Cream', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 4', N'4 Gold', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 4', N'4 Red', N'COPS', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 5', N'L6A', N'Shona', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 5', N'L6S', N'Physics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 6', N'U6A', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 2, N'Form 6', N'U6S', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 1', N'1 Blue', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 2', N'2 Blue', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 2', N'2 Gold', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 3', N'3 Blue', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 3', N'3 Cream', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 3', N'3 Gold', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 4', N'4 Blue', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 4', N'4 Cream', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 4', N'4 Gold', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 4', N'4 Red', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 3, N'Form 6', N'U6S', N'COPS', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 2', N'2 Blue', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 2', N'2 Gold', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 3', N'3 Blue', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 3', N'3 Cream', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 3', N'3 Gold', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 4', N'4 Blue', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 4', N'4 Cream', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 4', N'4 Gold', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 5', N'L6A', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 6', N'U6A', N'Shona', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 4, N'Form 6', N'U6S', N'Chemistry', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 1', N'1 Blue', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 1', N'1 Gold', N'Shona', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 2', N'2 Blue', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 2', N'2 Gold', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 3', N'3 Blue', N'COPS', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 3', N'3 Cream', N'Shona', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 3', N'3 Gold', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 4', N'4 Blue', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 4', N'4 Gold', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 4', N'4 Red', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 5', N'L6A', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 6', N'U6A', N'English Literature', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 5, N'Form 6', N'U6S', N'Chemistry', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 1', N'1 Gold', N'Accounts', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 2', N'2 Blue', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 2', N'2 Gold', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 3', N'3 Blue', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 3', N'3 Cream', N'Commerce', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 3', N'3 Gold', N'Business Studies', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 4', N'4 Blue', N'Accounts', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 4', N'4 Cream', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 4', N'4 Gold', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 4', N'4 Red', N'Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 7, N'Form 5', N'L6A', N'English Literature', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 1', N'1 Gold', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 1', N'1 Gold', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 2', N'2 Blue', N'Accounts', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 2', N'2 Gold', N'English Language', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 3', N'3 Blue', N'History', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 3', N'3 Cream', N'Geography', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 3', N'3 Gold', N'Religious & Moral Education', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 4', N'4 Blue', N'COPS', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 4', N'4 Cream', N'Physical Science', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 4', N'4 Red', N'Mathematics', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Friday', 8, N'Form 5', N'L6A', N'English Literature', 6, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 1', N'1 Blue', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 1', N'1 Gold', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 2', N'2 Gold', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 3', N'3 Cream', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 3', N'3 Gold', N'Commerce', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 4', N'4 Blue', N'English Language', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 4', N'4 Cream', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 4', N'4 Gold', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 4', N'4 Red', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 5', N'L6A', N'Sociology', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 6', N'U6A', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 6', N'U6C', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 6', N'U6S', N'Physics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 1', N'1 Temp', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 2', N'2 Blue', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 2', N'2 Gold', N'Commerce', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 3', N'3 Blue', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 3', N'3 Cream', N'Physical Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 4', N'4 Blue', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 4', N'4 Cream', N'Shona', 2, NULL)
GO
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 4', N'4 Gold', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 4', N'4 Red', N'English Language', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 5', N'L6A', N'Sociology', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 6', N'U6A', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 2, N'Form 6', N'U6C', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 1', N'1 Blue', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 3', N'3 Blue', N'Religious & Moral Education', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 3', N'3 Gold', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 4', N'4 Blue', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 4', N'4 Cream', N'COPS', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 4', N'4 Gold', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 4', N'4 Red', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 5', N'L6A', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 3, N'Form 5', N'L6S', N'Chemistry', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 1', N'1 Blue', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 1', N'1 Gold', N'COPS', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 2', N'2 Blue', N'Religious & Moral Education', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 2', N'2 Gold', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 3', N'3 Blue', N'Commerce', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 3', N'3 Cream', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 3', N'3 Gold', N'Business Studies', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 4', N'4 Blue', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 4', N'4 Gold', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 5', N'L6A', N'Divinity', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 5', N'L6S', N'Chemistry', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 4, N'Form 6', N'U6A', N'Sociology', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 1', N'1 Blue', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 1', N'1 Gold', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 2', N'2 Blue', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 2', N'2 Gold', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 3', N'3 Blue', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 3', N'3 Gold', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 4', N'4 Blue', N'Science', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 4', N'4 Cream', N'English Language', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 4', N'4 Cream', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 4', N'4 Gold', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 5, N'Form 5', N'L6S', N'COPS', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 1', N'1 Blue', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 1', N'1 Gold', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 2', N'2 Blue', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 2', N'2 Gold', N'Religious & Moral Education', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 3', N'3 Blue', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 3', N'3 Cream', N'Commerce', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 3', N'3 Gold', N'Commerce', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 3', N'3 Gold', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 4', N'4 Blue', N'Business Studies', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 4', N'4 Cream', N'Biology', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 4', N'4 Gold', N'English Language', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 4', N'4 Red', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 5', N'L6A', N'English Literature', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 5', N'L6C', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 7, N'Form 5', N'L6S', N'Physics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 1', N'1 Blue', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 1', N'1 Blue', N'Religious & Moral Education', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 1', N'1 Gold', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 2', N'2 Blue', N'Geography', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 2', N'2 Gold', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 3', N'3 Blue', N'History', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 4', N'4 Blue', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 4', N'4 Cream', N'Accounts', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 4', N'4 Gold', N'Shona', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 8, N'Form 5', N'L6S', N'Mathematics', 2, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 1', N'1 Blue', N'Geography', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 2', N'2 Gold', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 3', N'3 Blue', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 3', N'3 Cream', N'COPS', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 3', N'3 Gold', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 4', N'4 Blue', N'English Language', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 4', N'4 Cream', N'Commerce', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 4', N'4 Gold', N'Religious & Moral Education', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 4', N'4 Red', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 5', N'L6C', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 6', N'U6A', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 1, N'Form 6', N'U6S', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 1', N'1 Blue', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 2', N'2 Blue', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 2', N'2 Gold', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 3', N'3 Blue', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 3', N'3 Cream', N'Biology', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 4', N'4 Blue', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 4', N'4 Cream', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 4', N'4 Gold', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 4', N'4 Gold', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 4', N'4 Red', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 5', N'L6C', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 2, N'Form 6', N'U6A', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 1', N'1 Blue', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 1', N'1 Gold', N'COPS', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 1', N'1 Gold', N'Geography', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 2', N'2 Blue', N'Commerce', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 2', N'2 Gold', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 3', N'3 Cream', N'Physical Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 3', N'3 Gold', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 4', N'4 Blue', N'Geography', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 4', N'4 Cream', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 4', N'4 Red', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 3, N'Form 5', N'L6A', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 2', N'2 Blue', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 3', N'3 Blue', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 3', N'3 Cream', N'Science', 5, NULL)
GO
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 4', N'4 Blue', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 4', N'4 Blue', N'Commerce', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 4', N'4 Cream', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 4', N'4 Gold', N'English Language', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 5', N'L6A', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 5', N'L6A', N'Sociology', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 4, N'Form 6', N'U6A', N'Sociology', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 1', N'1 Blue', N'Shona', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 1', N'1 Gold', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 2', N'2 Gold', N'COPS', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 3', N'3 Blue', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 3', N'3 Cream', N'History', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 3', N'3 Gold', N'Religious & Moral Education', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 4', N'4 Gold', N'Science', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 4', N'4 Red', N'Mathematics', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 6', N'U6A', N'Divinity', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 5, N'Form 6', N'U6C', N'Accounts', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Thursday', 7, N'Form 2', N'2 Gold', N'Geography', 5, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 1', N'1 Blue', N'Science', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 1', N'1 Gold', N'Science', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 2', N'2 Blue', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 2', N'2 Gold', N'COPS', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 3', N'3 Blue', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 3', N'3 Cream', N'Geography', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 3', N'3 Gold', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 4', N'4 Blue', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 4', N'4 Cream', N'Biology', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 5', N'L6A', N'Divinity', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 1, N'Form 5', N'L6S', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 1', N'1 Blue', N'Geography', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 1', N'1 Gold', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 2', N'2 Blue', N'Shona', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 3', N'3 Blue', N'Shona', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 3', N'3 Cream', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 3', N'3 Gold', N'Science', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 4', N'4 Blue', N'Religious & Moral Education', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 4', N'4 Cream', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 4', N'4 Gold', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 5', N'L6A', N'Divinity', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 2, N'Form 5', N'L6S', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 2', N'2 Blue', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 2', N'2 Gold', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 3', N'3 Cream', N'Physical Science', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 3', N'3 Gold', N'Shona', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 4', N'4 Blue', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 4', N'4 Cream', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 4', N'4 Gold', N'Religious & Moral Education', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 4', N'4 Red', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 3, N'Form 5', N'L6A', N'Geography', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 1', N'1 Blue', N'COPS', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 1', N'1 Blue', N'Religious & Moral Education', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 2', N'2 Blue', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 3', N'3 Blue', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 3', N'3 Cream', N'Biology', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 4', N'4 Blue', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 4', N'4 Blue', N'Shona', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 4', N'4 Cream', N'Physical Science', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 4', N'4 Gold', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 4', N'4 Red', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 5', N'L6A', N'Shona', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 6', N'U6A', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 4, N'Form 6', N'U6S', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 1', N'1 Gold', N'Accounts', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 2', N'2 Blue', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 2', N'2 Gold', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 3', N'3 Cream', N'Mathematics', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 3', N'3 Gold', N'Religious & Moral Education', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 4', N'4 Cream', N'Commerce', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 4', N'4 Gold', N'Geography', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 4', N'4 Red', N'English Language', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 6', N'U6A', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 6', N'U6A', N'Sociology', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 5, N'Form 6', N'U6S', N'Chemistry', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Tuesday', 8, N'Form 4', N'4 Cream', N'History', 3, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 1', N'1 Blue', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 2', N'2 Blue', N'Geography', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 2', N'2 Gold', N'Religious & Moral Education', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 3', N'3 Blue', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 3', N'3 Cream', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 4', N'4 Blue', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 4', N'4 Cream', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 4', N'4 Gold', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 4', N'4 Red', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 1, N'Form 6', N'U6A', N'English Literature', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 1', N'1 Blue', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 1', N'1 Gold', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 2', N'2 Blue', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 2', N'2 Gold', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 3', N'3 Blue', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 3', N'3 Cream', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 4', N'4 Blue', N'English Language', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 4', N'4 Cream', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 4', N'4 Gold', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 4', N'4 Red', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 5', N'L6A', N'Divinity', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 2, N'Form 6', N'U6A', N'English Literature', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 1', N'1 Blue', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 2', N'2 Gold', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 3', N'3 Blue', N'Geography', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 3', N'3 Gold', N'Business Studies', 4, NULL)
GO
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 4', N'4 Blue', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 4', N'4 Cream', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 4', N'4 Gold', N'COPS', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 4', N'4 Gold', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 5', N'L6A', N'Sociology', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 5', N'L6S', N'Chemistry', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 6', N'U6A', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 3, N'Form 6', N'U6C', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 1', N'1 Blue', N'COPS', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 1', N'1 Gold', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 2', N'2 Blue', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 2', N'2 Gold', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 3', N'3 Blue', N'Religious & Moral Education', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 3', N'3 Cream', N'Geography', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 4', N'4 Blue', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 4', N'4 Cream', N'English Language', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 4', N'4 Gold', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 4', N'4 Red', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 4, N'Form 5', N'L6A', N'English Literature', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 1', N'1 Blue', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 2', N'2 Blue', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 2', N'2 Gold', N'English Language', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 3', N'3 Blue', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 3', N'3 Cream', N'English Language', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 3', N'3 Gold', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 3', N'3 Gold', N'COPS', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 4', N'4 Cream', N'Biology', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 4', N'4 Red', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 5', N'L6A', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 5, N'Form 5', N'L6S', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 1', N'1 Blue', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 1', N'1 Gold', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 2', N'2 Blue', N'COPS', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 2', N'2 Gold', N'Geography', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 3', N'3 Blue', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 3', N'3 Cream', N'Commerce', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 3', N'3 Gold', N'History', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 4', N'4 Blue', N'Religious & Moral Education', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 4', N'4 Cream', N'Physical Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 4', N'4 Gold', N'English Language', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 4', N'4 Red', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 6', N'U6A', N'Divinity', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 7, N'Form 6', N'U6S', N'Physics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 1', N'1 Blue', N'Mathematics', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 1', N'1 Gold', N'Accounts', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 2', N'2 Blue', N'Religious & Moral Education', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 2', N'2 Gold', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 3', N'3 Cream', N'Science', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 4', N'4 Blue', N'Business Studies', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 4', N'4 Gold', N'Shona', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Wednesday', 8, N'Form 6', N'U6A', N'Divinity', 4, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 12, N'1', N'2', N'2', 1, NULL)
INSERT [dbo].[tbl_classTimeTable] ([dDay], [periodNumber], [stream], [schClass], [subject], [dayNumba], [TeacherCode]) VALUES (N'Monday', 1, N'Form 1', N'1 Blue', N'Mathematics', 1, NULL)
SET IDENTITY_INSERT [dbo].[tbl_clubs] ON 

INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (1, N'Interact')
INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (2, N'Debate')
INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (3, N'Computer')
INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (4, N'Scouts')
INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (5, N'Test Club 1')
INSERT [dbo].[tbl_clubs] ([clubId], [club]) VALUES (6, N'Test Club 2')
SET IDENTITY_INSERT [dbo].[tbl_clubs] OFF
SET IDENTITY_INSERT [dbo].[tbl_colleges] ON 

INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (1, N'Belvedere Teachers College', N'0000', N'Belvedere')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (2, N'Hillside  Teachers College', N'0000', N'Bulawayo')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (3, N'Test College 1', N'047864546', N'Test Address')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (4, N'Progressive Inside Tailors', N'04702445', N'Labros House
Room No. 204''
14 Forbes Avenue
Harare')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (5, N'Zimbabwe Open University', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (6, N'Mutare Teachers College', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (7, N'University of Zimbabwe', N'-', N'Mt Pleasant')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (8, N'Chinhoyi University of Technology', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (9, N'NUST', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (10, N'MSU', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (11, N'WITS', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (12, N'SU', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (13, N'ZDECO', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (14, N'Harare Polytechnic', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (15, N'Gweru Teachers College', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (16, N'Speciss College', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (17, N'Trust Academy', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (18, N'Herentals College', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (19, N'Peoples College', N'-', N'-')
INSERT [dbo].[tbl_colleges] ([collegeId], [college], [contactNumber], [collegeAddress]) VALUES (20, N'Unspecified', N'-', N'-')
SET IDENTITY_INSERT [dbo].[tbl_colleges] OFF
SET IDENTITY_INSERT [dbo].[tbl_departments] ON 

INSERT [dbo].[tbl_departments] ([departmentId], [departmentName], [headOfDepartmentStaffId], [officePhoneNumber], [officeNumber], [comments]) VALUES (1, N'Science', NULL, N'121', N'H24', N'None')
INSERT [dbo].[tbl_departments] ([departmentId], [departmentName], [headOfDepartmentStaffId], [officePhoneNumber], [officeNumber], [comments]) VALUES (2, N'Commercials', N'aaaaaaa', N'sdbab', N'dbsrb', NULL)
INSERT [dbo].[tbl_departments] ([departmentId], [departmentName], [headOfDepartmentStaffId], [officePhoneNumber], [officeNumber], [comments]) VALUES (3, N'Arts', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_departments] OFF
SET IDENTITY_INSERT [dbo].[tbl_disabilities] ON 

INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (1, N'Blind')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (2, N'Crippled')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (3, N'Deaf')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (4, N'Down Syndrome')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (5, N'None')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (6, N'Mid Retardation')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (7, N'blind                                             ')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (8, N'Hearing Impairment')
INSERT [dbo].[tbl_disabilities] ([disabilityId], [disability]) VALUES (9, N'Poor Eyesight')
SET IDENTITY_INSERT [dbo].[tbl_disabilities] OFF
SET IDENTITY_INSERT [dbo].[tbl_disciplinaryActions] ON 

INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (1, N'In-school Suspension')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (2, N'Out-of-school Suspension')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (3, N'Expulsion')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (4, N'1st Warning')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (5, N'2nd Warning')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (6, N'Corporal Punishment')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (7, N'Labor Punishment')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (8, N'Forced Transer')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (9, N'Test Disciplinary Action 1')
INSERT [dbo].[tbl_disciplinaryActions] ([actionId], [action]) VALUES (10, N'Test Disciplinary Action 2')
SET IDENTITY_INSERT [dbo].[tbl_disciplinaryActions] OFF
SET IDENTITY_INSERT [dbo].[tbl_donors] ON 

INSERT [dbo].[tbl_donors] ([donorId], [donor]) VALUES (1, N'UNICEF')
SET IDENTITY_INSERT [dbo].[tbl_donors] OFF
SET IDENTITY_INSERT [dbo].[tbl_duties] ON 

INSERT [dbo].[tbl_duties] ([dutyId], [duty]) VALUES (1, N'Test Duty 1')
SET IDENTITY_INSERT [dbo].[tbl_duties] OFF
SET IDENTITY_INSERT [dbo].[tbl_dutyFilterCategories] ON 

INSERT [dbo].[tbl_dutyFilterCategories] ([dutyFilterId], [dutyFilter]) VALUES (1, N'Duty')
INSERT [dbo].[tbl_dutyFilterCategories] ([dutyFilterId], [dutyFilter]) VALUES (2, N'Duty Assignee')
INSERT [dbo].[tbl_dutyFilterCategories] ([dutyFilterId], [dutyFilter]) VALUES (3, N'Duty Location')
SET IDENTITY_INSERT [dbo].[tbl_dutyFilterCategories] OFF
SET IDENTITY_INSERT [dbo].[tbl_dutyLocations] ON 

INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (1, N'Classrooms')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (2, N'School Grounds')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (3, N'F1-R1')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (4, N'F1-R2')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (5, N'F2-R1')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (6, N'F2-R12')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (7, N'N/A')
INSERT [dbo].[tbl_dutyLocations] ([dutyLocationId], [dutyLocation]) VALUES (8, N'None')
SET IDENTITY_INSERT [dbo].[tbl_dutyLocations] OFF
INSERT [dbo].[tbl_employees] ([employeeCode], [employeeName], [designation], [empLevel], [role], [emailAddress], [contactNo], [empPassword], [active]) VALUES (N'Admin', N'Leslie Nyakudya', N'Accounts Clerk', 1, N'Supervisor', N'nyakudya.leslie@gmail.com', N'0772590044', N'@337', 1)
SET IDENTITY_INSERT [dbo].[tbl_events] ON 

INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (1, N'Opening Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (2, N'Closing Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (3, N'Parents Consultation Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (4, N'Parents and Prize Giving Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (5, N'Civics Days')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (6, N'Internal Examinations Start Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (7, N'External Examinations Start Day')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (8, N'Sports Day - Inter-houses')
INSERT [dbo].[tbl_events] ([eventId], [event]) VALUES (9, N'Sports Day - Inter-schools')
SET IDENTITY_INSERT [dbo].[tbl_events] OFF
SET IDENTITY_INSERT [dbo].[tbl_examinationAuthourities] ON 

INSERT [dbo].[tbl_examinationAuthourities] ([authourityId], [authourity]) VALUES (1, N'Local (Internal Examination)')
INSERT [dbo].[tbl_examinationAuthourities] ([authourityId], [authourity]) VALUES (2, N'External (ZIMSEC)')
INSERT [dbo].[tbl_examinationAuthourities] ([authourityId], [authourity]) VALUES (3, N'External (Cambridge)')
SET IDENTITY_INSERT [dbo].[tbl_examinationAuthourities] OFF
SET IDENTITY_INSERT [dbo].[tbl_examinationBoards] ON 

INSERT [dbo].[tbl_examinationBoards] ([examinationBoardId], [examinationBoard]) VALUES (1, N'Internal')
INSERT [dbo].[tbl_examinationBoards] ([examinationBoardId], [examinationBoard]) VALUES (2, N'External - ZimSec')
INSERT [dbo].[tbl_examinationBoards] ([examinationBoardId], [examinationBoard]) VALUES (3, N'External -  Hexco')
INSERT [dbo].[tbl_examinationBoards] ([examinationBoardId], [examinationBoard]) VALUES (4, N'External - ICDL')
SET IDENTITY_INSERT [dbo].[tbl_examinationBoards] OFF
SET IDENTITY_INSERT [dbo].[tbl_extraCurriculaActivities] ON 

INSERT [dbo].[tbl_extraCurriculaActivities] ([activityId], [activityName]) VALUES (1, N'Choir')
INSERT [dbo].[tbl_extraCurriculaActivities] ([activityId], [activityName]) VALUES (2, N'Drum Majorates')
INSERT [dbo].[tbl_extraCurriculaActivities] ([activityId], [activityName]) VALUES (3, N'Percussion')
INSERT [dbo].[tbl_extraCurriculaActivities] ([activityId], [activityName]) VALUES (4, N'Traditional Dance')
SET IDENTITY_INSERT [dbo].[tbl_extraCurriculaActivities] OFF
SET IDENTITY_INSERT [dbo].[tbl_functionalStates] ON 

INSERT [dbo].[tbl_functionalStates] ([stateId], [functionalState]) VALUES (1, N'Functional - Good State')
INSERT [dbo].[tbl_functionalStates] ([stateId], [functionalState]) VALUES (2, N'Functional - Needs Repair')
INSERT [dbo].[tbl_functionalStates] ([stateId], [functionalState]) VALUES (3, N'Nonfunctional - Needs Repair')
INSERT [dbo].[tbl_functionalStates] ([stateId], [functionalState]) VALUES (4, N'Nonfunctional - Beyond Repair')
INSERT [dbo].[tbl_functionalStates] ([stateId], [functionalState]) VALUES (5, N'Other (See asset description/comments)')
SET IDENTITY_INSERT [dbo].[tbl_functionalStates] OFF
SET IDENTITY_INSERT [dbo].[tbl_gradeRanges] ON 

INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 1, N'1', 90, 100)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 2, N'2', 80, 89)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 3, N'3', 70, 79)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 4, N'4', 60, 69)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 5, N'5', 50, 59)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 6, N'6', 40, 49)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 7, N'7', 30, 39)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 8, N'8', 20, 29)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (1, 9, N'9', 0, 19)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 10, N'A', 70, 100)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 11, N'B', 60, 69)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 12, N'C', 50, 59)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 13, N'D', 45, 49)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 14, N'E', 40, 44)
INSERT [dbo].[tbl_gradeRanges] ([gradingId], [gradeId], [grade], [fromMark], [toMark]) VALUES (2, 15, N'U', 0, 39)
SET IDENTITY_INSERT [dbo].[tbl_gradeRanges] OFF
SET IDENTITY_INSERT [dbo].[tbl_gradings] ON 

INSERT [dbo].[tbl_gradings] ([gradingId], [gradingName]) VALUES (1, N'Primary School (Standard)')
INSERT [dbo].[tbl_gradings] ([gradingId], [gradingName]) VALUES (2, N'Ordinary Level (Standard)')
SET IDENTITY_INSERT [dbo].[tbl_gradings] OFF
SET IDENTITY_INSERT [dbo].[tbl_healthConditions] ON 

INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (1, N'Asthmatic')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (2, N'High Blood Pressure')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (3, N'None')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (4, N'Chest Pains')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (5, N'Epileptic                             ')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (6, N'Eye (sight) Problems')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (7, N'Hay Fever                 ')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (8, N'Heache/Migrane')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (9, N'Nose bleeding                                         ')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (10, N'Swollen legs                                        ')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (11, N'Ulcers')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (12, N'Synus')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (13, N'Heart problem')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (14, N'Hernia')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (15, N'Colour blind')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (16, N'Complicated')
INSERT [dbo].[tbl_healthConditions] ([healthConditionId], [healthCondition]) VALUES (17, N'BQ                                                ')
SET IDENTITY_INSERT [dbo].[tbl_healthConditions] OFF
SET IDENTITY_INSERT [dbo].[tbl_hostels] ON 

INSERT [dbo].[tbl_hostels] ([hostelId], [hostel], [superitendant], [numberOfRooms], [numberOfBeds], [numberOfToiletSeats], [numberOfShowers], [numberOfBathTubs]) VALUES (1, N'N/A', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_hostels] OFF
INSERT [dbo].[tbl_incidentIDCodeGen] ([centreCode], [lastIncidentNumber]) VALUES (N'HA        ', 10)
SET IDENTITY_INSERT [dbo].[tbl_incidentLevels] ON 

INSERT [dbo].[tbl_incidentLevels] ([incidentLevelId], [incidentLevel]) VALUES (1, N'Individual')
INSERT [dbo].[tbl_incidentLevels] ([incidentLevelId], [incidentLevel]) VALUES (2, N'Group')
INSERT [dbo].[tbl_incidentLevels] ([incidentLevelId], [incidentLevel]) VALUES (3, N'Class')
INSERT [dbo].[tbl_incidentLevels] ([incidentLevelId], [incidentLevel]) VALUES (4, N'Whole School')
SET IDENTITY_INSERT [dbo].[tbl_incidentLevels] OFF
SET IDENTITY_INSERT [dbo].[tbl_incidents] ON 

INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (1, N'H15F1006HA201615', CAST(0xA5F90000 AS SmallDateTime), N'1', N'1', N'', N'RadComboBoxItem1', N'H15F1006HA', N'Mark Masongomayi', N'bullying', N'1', N'Form 1', N'1 Blue')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (2, N'201616', CAST(0xA5DB0000 AS SmallDateTime), N'', N'', N'', N'RadComboBoxItem1', N'', N'', N'', N'', N'', N'')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (3, N'H15F1006HA201616', CAST(0xA5800000 AS SmallDateTime), N'1', N'1', N'Class', N'RadComboBoxItem2', N'H15F1006HA', N'Mark Masongomayi', N'test', N'1', N'Form 1', N'1 Blue')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (4, N'H15F1006HA201616', CAST(0xA5DB0000 AS SmallDateTime), N'1', N'1', N'Class', N'RadComboBoxItem2', N'H15F1006HA', N'Mark Masongomayi', N'test', N'1', N'Form 1', N'1 Blue')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (5, N'H15F1008HA201616', CAST(0xA5DB0000 AS SmallDateTime), N'1', N'1', N'Class', N'RadComboBoxItem2', N'H15F1008HA', N'Sharon Chinhamo', N'test', N'1', N'Form 1', N'1 Gold')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (6, N'H15F1019HA201616', CAST(0xA5DB0000 AS SmallDateTime), N'1', N'1', N'Class', N'RadComboBoxItem2', N'H15F1019HA', N'Simbarashe Scope', N'test', N'1', N'Form 1', N'1 Blue')
INSERT [dbo].[tbl_incidents] ([caseNumber], [incidentNumber], [dtDate], [incidentTypeId], [incidentLevelId], [location], [offenderCategoryId], [offenderId], [offender], [incidentDescription], [disciplinaryActionId], [stream], [Schclass]) VALUES (7, N'H15F1008HA201619', CAST(0xA5800000 AS SmallDateTime), N'3', N'1', N'Class', N'RadComboBoxItem2', N'H15F1008HA', N'Sharon Chinhamo', N'TEST', N'3', N'Form 1', N'1 Gold')
SET IDENTITY_INSERT [dbo].[tbl_incidents] OFF
SET IDENTITY_INSERT [dbo].[tbl_incidentsCodeGen] ON 

INSERT [dbo].[tbl_incidentsCodeGen] ([centreCode], [lastIncidentNumber]) VALUES (N'HA        ', 1)
SET IDENTITY_INSERT [dbo].[tbl_incidentsCodeGen] OFF
SET IDENTITY_INSERT [dbo].[tbl_incidentTypes] ON 

INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (1, N'Bullying')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (2, N'Assault/Fight')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (3, N'Pregnancy')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (4, N'Theft')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (5, N'Drugs')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (6, N'Gun')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (7, N'Students Strike/Demonstration')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (8, N'Staff Strike/Demonstration')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (9, N'Rape')
INSERT [dbo].[tbl_incidentTypes] ([incidentTypeId], [incidentType]) VALUES (10, N'Sexual Harrassment')
SET IDENTITY_INSERT [dbo].[tbl_incidentTypes] OFF
SET IDENTITY_INSERT [dbo].[tbl_inventory] ON 

INSERT [dbo].[tbl_inventory] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy], [itemType]) VALUES (1, CAST(0x0000A64000000000 AS DateTime), 120, NULL, NULL, NULL, 120, N'fyfyi', N'1', N'T-Shirts')
INSERT [dbo].[tbl_inventory] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy], [itemType]) VALUES (2, CAST(0x0000A64000000000 AS DateTime), NULL, 50, NULL, NULL, 170, N'huogho', N'1', N'T-Shirts')
INSERT [dbo].[tbl_inventory] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy], [itemType]) VALUES (3, CAST(0x0000A64000000000 AS DateTime), NULL, NULL, 100, NULL, 70, N'ug98g08gh', N'1', N'T-Shirts')
INSERT [dbo].[tbl_inventory] ([entryNumber], [dtDate], [opening], [incoming], [outgoing], [closing], [balance], [narration], [capturedBy], [itemType]) VALUES (4, CAST(0x0000A64000000000 AS DateTime), NULL, NULL, NULL, 90, 90, N'yfiuguogoi', N'1', N'T-Shirts')
SET IDENTITY_INSERT [dbo].[tbl_inventory] OFF
SET IDENTITY_INSERT [dbo].[tbl_jobTitles] ON 

INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (1, N'Teacher')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (2, N'Bursar')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (3, N'Secretary')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (4, N'Driver')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (5, N'Cook')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (6, N'Grounds-man')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (7, N'Caretaker')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (8, N'Administrator')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (9, N'Superitendant')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (10, N'Matron')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (11, N'Pastor/Priest')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (12, N'Cook')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (13, N'Test Job Title')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (14, N'Librarian')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (15, N'Examinations Officer')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (16, N'Principal')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (17, N'Tailor')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (18, N'Designer')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (19, N'Cleaner')
INSERT [dbo].[tbl_jobTitles] ([jobTitleId], [jobTitle]) VALUES (20, N'Security')
SET IDENTITY_INSERT [dbo].[tbl_jobTitles] OFF
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Sports', N'Soccer', N'A Team', N'Uniform', N'Kingsport', CAST(0x0000A0AB00000000 AS DateTime), N'Blue and white Soccer Jersies and shorts', 14)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Sports', N'Soccer', N'A Team', N'Uniform', N'Kingsport', CAST(0x0000A0AB00000000 AS DateTime), N'Puma Soccer Boots', 18)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Sports', N'Soccer', N'A Team', N'Equipment', N'Kingsport', CAST(0x0000A0AB00000000 AS DateTime), N'green goal nets', 2)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Sports', N'Soccer', N'B Team', N'Uniform', N'Unknown', CAST(0x0000A0AB00000000 AS DateTime), N'Green jersies, shorts and black boots', 15)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Clubs', N'Computer', N'N/A', N'Equipment', N'Unknown', CAST(0x0000A0AB00000000 AS DateTime), N'compaq laptop computers', 2)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Clubs', N'Scouts', N'N/A', N'Equipment', N'Unknown', CAST(0x0000A07600000000 AS DateTime), N'tents', 4)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Other', N'Choir', N'N/A', N'Uniform', N'Unknown', CAST(0x00009EFE00000000 AS DateTime), N'Blue Dresses', 23)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Other', N'Choir', N'N/A', N'Uniform', N'Unknown', CAST(0x00009EFE00000000 AS DateTime), N'Gray trousers and sky blue shirts', 18)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Other', N'Percussion', N'N/A', N'Equipment', N'Unknown', CAST(0x00009FB700000000 AS DateTime), N'Drum Kit', 1)
INSERT [dbo].[tbl_kits2] ([activityType], [activity], [team], [kitType], [supplier], [dateBought], [itemDescription], [quantity]) VALUES (N'Sports', N'Atheletics', N'4X100m Relay', N'Equipment', N'Unknown', CAST(0x00009EDE00000000 AS DateTime), N'Button Sticks', 2)
SET IDENTITY_INSERT [dbo].[tbl_LevyPayments] ON 

INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1029D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 1, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'xxxxxxxxxx', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 2, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1030D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 3, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1031D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 4, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1032D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 5, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1033D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 6, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1034D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 7, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1035D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 8, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1036D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 9, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F3020', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 10, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1003D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 11, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1008D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 12, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1009D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 13, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1010D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 14, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1015D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 15, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16FI016D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 16, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1017D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 17, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1018D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 18, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1019D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 19, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1020D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 20, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1021D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 21, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1022D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 22, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1023', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 23, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1024D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 24, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1001D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 25, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1002D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 26, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1004D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 27, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1005', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 28, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1006D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 29, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1007D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 30, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1011D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 31, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1012D', 2016, N'First Term          ', 20.0000, 20.0000, 1, 0.0000, 32, N'H0000039')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1013D', 2016, N'First Term          ', 20.0000, 20.0000, 1, 0.0000, 33, N'H0000038')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1014D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 34, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1027D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 35, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1028D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 36, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1025D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 37, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1026D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 38, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1029D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 39, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'xxxxxxxxxx', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 40, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1030D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 41, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1031D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 42, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1032D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 43, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1033D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 44, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1034D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 45, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1035D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 46, N'H0000045')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1036D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 47, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F3020', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 48, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1003D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 49, N'H0000043')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1008D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 50, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1009D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 51, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1010D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 52, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1015D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 53, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16FI016D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 54, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1017D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 55, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1018D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 56, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1019D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 57, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1020D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 58, N'H0000041')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1021D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 59, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1022D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 60, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1023', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 61, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1024D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 62, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1001D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 63, N'H0000042')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1002D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 64, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1004D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 65, N'H0000044')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1005', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 66, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1006D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 67, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1007D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 68, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1011D', 2016, N'First Term          ', 20.0000, 40.0000, 1, 0.0000, 69, N'H0000046')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1012D', 2016, N'First Term          ', 20.0000, 20.0000, 1, 0.0000, 70, N'H0000047')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1013D', 2016, N'First Term          ', 20.0000, 20.0000, 1, 0.0000, 71, N'H0000040')
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1014D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 72, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1027D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 73, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1028D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 74, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1025D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 75, NULL)
INSERT [dbo].[tbl_LevyPayments] ([studentd], [intYear], [strTerm], [expectedAmt], [amountPaid], [termNumber], [penalty], [levyPaymentId], [receiptNumber]) VALUES (N'HCBD16F1026D', 2016, N'First Term          ', 20.0000, 0.0000, 1, 0.0000, 76, NULL)
SET IDENTITY_INSERT [dbo].[tbl_LevyPayments] OFF
INSERT [dbo].[tbl_libraryBookLending] ([bookId], [title], [authour], [serialNumber], [bookType], [borrowerName], [borrowerType], [borrowerIdNumber], [dateLoanedOut], [loanDays], [dueDate], [returnDate], [returnStatus], [penaltyAmt], [numberOfBooks], [comments], [penaltyPaid]) VALUES (N'r444/09', N'', N'Tawanda Zarura', N'556663988766', N'Standard Text Book', N'Mark Masongomayi', N'Student(s)', N'H15F1006HA', CAST(0x0C3C0B00 AS Date), N'2', CAST(0xE73A0B00 AS Date), N'2016-01-14', N'Available', 1.0000, NULL, N'test', 0.0000)
SET IDENTITY_INSERT [dbo].[tbl_libraryBooks] ON 

INSERT [dbo].[tbl_libraryBooks] ([ctr], [bookId], [bookTitle], [authorFirstName], [authorSurname], [subjectId], [level1], [level2], [version], [yearPublished], [availability], [lendingDays], [bookTypeId], [supplierId], [conditionId], [serialNumber], [dateSupplied]) VALUES (1, N'r444/09', N'General Mathematics', N'Tawanda', N'Zarura', 1, 1, 1, N'1', 2009, N'Available', 1, 1, 1, 1, N'556663988766', CAST(0x213A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tbl_libraryBooks] OFF
SET IDENTITY_INSERT [dbo].[tbl_maritalStatuses] ON 

INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (1, N'Single')
INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (2, N'Married')
INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (3, N'Widowed')
INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (4, N'Divorced')
INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (5, N'Separated')
INSERT [dbo].[tbl_maritalStatuses] ([maritalStatusId], [maritalStatus]) VALUES (6, N'Missing')
SET IDENTITY_INSERT [dbo].[tbl_maritalStatuses] OFF
SET IDENTITY_INSERT [dbo].[tbl_occupations] ON 

INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (1, N'Accontant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (2, N'Accountant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (3, N'Accounts clerk')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (4, N'Advocate')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (5, N'Agent')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (6, N'Air Hostess')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (7, N'Airside Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (8, N'Anglo American')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (9, N'Architecture')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (10, N'Army general')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (11, N'Art Painter')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (12, N'Artisan')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (13, N'Ass Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (14, N'Assistant Commisioner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (15, N'Assistant Commissioner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (16, N'Assistant Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (17, N'Audit manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (18, N'Auditor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (19, N'Bank Auditor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (20, N'Bank Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (21, N'Bank teller')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (22, N'Banker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (23, N'Beauty therapist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (24, N'Bookkeeper')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (25, N'Brigadier')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (26, N'Builder')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (27, N'Businessman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (28, N'Businesswoman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (29, N'Bussiness')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (30, N'Bussinessman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (31, N'Bussinesswoman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (32, N'C .operator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (33, N'C.C.C.')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (34, N'C/A')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (35, N'Caretaker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (36, N'Cashier')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (37, N'Central Intelligence Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (38, N'CEO')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (39, N'Chartered A/C')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (40, N'Chartered Accountant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (41, N'Chef')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (42, N'CIS Administrator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (43, N'City Council')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (44, N'Civil servant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (45, N'Civil service (UZ)')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (46, N'Civil sevant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (47, N'Clearing Agent')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (48, N'Clerk')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (49, N'Coach')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (50, N'Commissioner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (51, N'Commodity Broker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (52, N'Constructor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (53, N'Consultant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (54, N'Contractor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (55, N'cook')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (56, N'Cooker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (57, N'Cross border')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (58, N'Deputy  Director of Finance')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (59, N'Deputy Head')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (60, N'Director')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (61, N'Doctor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (62, N'Dressmaker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (63, N'Driver')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (64, N'Electrical engineer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (65, N'Electrician')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (66, N'Eletrician')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (67, N'Engineer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (68, N'Enginner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (69, N'Enterprenuer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (70, N'Environment Agent')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (71, N'Evaluator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (72, N'Exterminator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (73, N'Fabricator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (74, N'Fashion Designer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (75, N'Finance Director')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (76, N'Fire Brigade')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (77, N'Fireman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (78, N'Food World')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (79, N'Freelance cameramen')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (80, N'Fuel Attendant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (81, N'G.M')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (82, N'General manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (83, N'Global Admin')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (84, N'Greenleaf Admin')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (85, N'Guard')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (86, N'Hair dresser')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (87, N'Hairdresser')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (88, N'Headmistress')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (89, N'Hosewife')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (90, N'Housewife')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (91, N'Imports Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (92, N'Insurance Ptactioner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (93, N'ISA manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (94, N'Justice and Legal Dept')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (95, N'Lab Scientist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (96, N'Lawyer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (97, N'Line Assembler (ZESA)')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (98, N'Logistics')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (99, N'Maid')
GO
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (100, N'Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (101, N'Manageress')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (102, N'Managing Director')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (103, N'Mechanic')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (104, N'Member of Parliament')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (105, N'Merchandiser')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (106, N'Messenger')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (107, N'Miner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (108, N'Missing')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (109, N'Motor Engineer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (110, N'N/A')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (111, N'Network engineer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (112, N'Network enginneer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (113, N'Nurse')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (114, N'Nurse Aid')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (115, N'Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (116, N'Operating Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (117, N'Operations Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (118, N'Operator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (119, N'P.A')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (120, N'P.Valuator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (121, N'Painter')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (122, N'Panel beater')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (123, N'Pastor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (124, N'Pensioner')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (125, N'PG Glass')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (126, N'Pharmacist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (127, N'Physiotherapist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (128, N'Pilot')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (129, N'Plumber')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (130, N'Poet man')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (131, N'Police')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (132, N'Police man')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (133, N'Police office')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (134, N'Police officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (135, N'Policeman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (136, N'Politician')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (137, N'Presenter')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (138, N'Presidents office')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (139, N'Principal')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (140, N'Prison Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (141, N'Private nurse')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (142, N'Programmer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (143, N'Project Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (144, N'Prosecutor General')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (145, N'Pubilc worker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (146, N'Public service')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (147, N'Public worker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (148, N'Publisher')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (149, N'Purchasing Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (150, N'PVI')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (151, N'Pysioterapist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (152, N'Receptioniist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (153, N'Receptionist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (154, N'Red cross')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (155, N'Registry Manager')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (156, N'Retired soldier')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (157, N'Sales man')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (158, N'Sales rep')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (159, N'Sales wonan')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (160, N'Scretary')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (161, N'Sculptor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (162, N'Secretary')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (163, N'Security Guard')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (164, N'Security Officer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (165, N'Self emlpoyed')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (166, N'Self employed')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (167, N'Sergeant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (168, N'Shop Assistant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (169, N'Shop attendant')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (170, N'Shopkeeper')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (171, N'Sinage Installer')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (172, N'Social worker')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (173, N'Soldier')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (174, N'Storeman')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (175, N'Supervisor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (176, N'Surveyor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (177, N'Switchboard operator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (178, N'Tailor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (179, N'Tax Driver')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (180, N'Taxi Driver')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (181, N'Teacher')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (182, N'Technician')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (183, N'Till operator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (184, N'Travel agent')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (185, N'Treasure')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (186, N'Truck Driver')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (187, N'Turmer mechanist')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (188, N'UNICEF Admin')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (189, N'Valuator')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (190, N'Vendor')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (191, N'War veteran')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (192, N'ZCTU')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (193, N'Zimbabwe Prisons')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (194, N'ZWF Chairperson')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (195, N'Waiter                                            ')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (196, N'Lecturer                                          ')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (197, N'Housemaid                                         ')
INSERT [dbo].[tbl_occupations] ([occupationId], [occupation]) VALUES (198, N'Medical scientist                                 ')
SET IDENTITY_INSERT [dbo].[tbl_occupations] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_offenderCategories] ON 

INSERT [dbo].[tbl_offenderCategories] ([offenderCategoryId], [offenderCategory]) VALUES (1, N'Student(s)')
INSERT [dbo].[tbl_offenderCategories] ([offenderCategoryId], [offenderCategory]) VALUES (2, N'Staff')
INSERT [dbo].[tbl_offenderCategories] ([offenderCategoryId], [offenderCategory]) VALUES (3, N'Other')
SET IDENTITY_INSERT [dbo].[tbl_offenderCategories] OFF
SET IDENTITY_INSERT [dbo].[tbl_orphanhoodStatuses] ON 

INSERT [dbo].[tbl_orphanhoodStatuses] ([orphanhoodStatusId], [orphanhoodStatus]) VALUES (1, N'None')
INSERT [dbo].[tbl_orphanhoodStatuses] ([orphanhoodStatusId], [orphanhoodStatus]) VALUES (2, N'Maternal')
INSERT [dbo].[tbl_orphanhoodStatuses] ([orphanhoodStatusId], [orphanhoodStatus]) VALUES (3, N'Paternal')
INSERT [dbo].[tbl_orphanhoodStatuses] ([orphanhoodStatusId], [orphanhoodStatus]) VALUES (4, N'Double')
SET IDENTITY_INSERT [dbo].[tbl_orphanhoodStatuses] OFF
SET IDENTITY_INSERT [dbo].[tbl_paymentFrequencies] ON 

INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (1, N'Monthly')
INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (2, N'Bi-Monthly')
INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (3, N'Tri-Monthly')
INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (4, N'Termly')
INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (5, N'Half-Yearly')
INSERT [dbo].[tbl_paymentFrequencies] ([frequencyId], [frequency]) VALUES (6, N'Annually')
SET IDENTITY_INSERT [dbo].[tbl_paymentFrequencies] OFF
INSERT [dbo].[tbl_paymentReceiptCodeNumberGen] ([centerCode], [lastReceiptNumber]) VALUES (N'HA        ', 1)
INSERT [dbo].[tbl_paymentReceiptGenerationNumbers] ([schoolCode], [lastPaymentNumber]) VALUES (N'HA        ', 1)
SET IDENTITY_INSERT [dbo].[tbl_penaltyTypes] ON 

INSERT [dbo].[tbl_penaltyTypes] ([penaltyTypeId], [penaltyType]) VALUES (1, N'Late Tuition')
INSERT [dbo].[tbl_penaltyTypes] ([penaltyTypeId], [penaltyType]) VALUES (2, N'Civics Day - Non Compliance')
INSERT [dbo].[tbl_penaltyTypes] ([penaltyTypeId], [penaltyType]) VALUES (3, N'Tee-Shirt Day - Non Compliance')
SET IDENTITY_INSERT [dbo].[tbl_penaltyTypes] OFF
SET IDENTITY_INSERT [dbo].[tbl_qualificationLevels] ON 

INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (1, N'Degree')
INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (2, N'Diploma')
INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (3, N'Certificate')
INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (4, N'Test Q Level')
INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (5, N'Higher National Diploma')
INSERT [dbo].[tbl_qualificationLevels] ([qualificationLevelId], [qualificationLevel]) VALUES (6, N'HNC')
SET IDENTITY_INSERT [dbo].[tbl_qualificationLevels] OFF
SET IDENTITY_INSERT [dbo].[tbl_qualifications] ON 

INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (1, N'Diploma in Education')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (2, N'Bachelors in Education')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (3, N'Bachelors of Arts')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (4, N'BSc in Science')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (5, N'Bachelors in Economics')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (6, N'Bachelors in Pyschology')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (7, N'Academic')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (8, N'Test qlevel')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (9, N'Designing/Dressmaking/Tailoring')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (10, N'BSc. Special Education')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (11, N'B.Sc Statistics/Maths')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (12, N'B Tech (Hons) - Hospitality and Tourism')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (13, N'B. Eng (Hons) in Chemical Engineering')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (14, N'B.Sc H INFO')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (15, N'HBBS')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (16, N'Certificate in Education')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (17, N'BA (Hons) English and Communication')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (18, N'Diploma in Secretarial Studies')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (19, N'HND - Marketing')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (20, N'HND - Accounting')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (21, N'Bachelors in Business Studies')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (22, N'HNC in Financial Accounting')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (23, N'B. TECH (Hons) Marketing')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (24, N'Unspecified')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (25, N'Certificate in Designing and Cutting')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (26, N'HND- Tourism and Hospitality Management')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (27, N'Diploma in Interior Decor')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (28, N'Ordinary Level')
INSERT [dbo].[tbl_qualifications] ([qualificationId], [qualification]) VALUES (29, N'ZJC')
SET IDENTITY_INSERT [dbo].[tbl_qualifications] OFF
SET IDENTITY_INSERT [dbo].[tbl_reasonForStudentLeaving] ON 

INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (1, N'Completed')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (2, N'Dropped out - Failed to pay fees')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (3, N'Dropped out - Pregnancy')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (4, N'Transferred')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (5, N'Dropped out - Unknown Reason')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (6, N'Deceased')
INSERT [dbo].[tbl_reasonForStudentLeaving] ([reasonForStudentLeavingId], [reasonForStudentLeaving]) VALUES (7, N'N/A')
SET IDENTITY_INSERT [dbo].[tbl_reasonForStudentLeaving] OFF
SET IDENTITY_INSERT [dbo].[tbl_reasonsForAbsence] ON 

INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (1, N'Unknown')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (2, N'Sickness of Student')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (3, N'Sickness of Family Member')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (4, N'Unpaid Fees')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (5, N'Death in Family')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (6, N'Caring for Sibling(s)/Family Member')
INSERT [dbo].[tbl_reasonsForAbsence] ([reasonForAbsenceId], [reasonForAbsence]) VALUES (7, N'Fending for Family')
SET IDENTITY_INSERT [dbo].[tbl_reasonsForAbsence] OFF
SET IDENTITY_INSERT [dbo].[tbl_reasonsForAssetDisposal] ON 

INSERT [dbo].[tbl_reasonsForAssetDisposal] ([disposalReasonId], [disposalReason]) VALUES (1, N'Obsolesce')
INSERT [dbo].[tbl_reasonsForAssetDisposal] ([disposalReasonId], [disposalReason]) VALUES (2, N'Aged')
INSERT [dbo].[tbl_reasonsForAssetDisposal] ([disposalReasonId], [disposalReason]) VALUES (3, N'Broken/Damaged')
SET IDENTITY_INSERT [dbo].[tbl_reasonsForAssetDisposal] OFF
SET IDENTITY_INSERT [dbo].[tbl_reasonsForStaffLeaving] ON 

INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (1, N'Transferred')
INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (2, N'Retired')
INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (3, N'Resigned')
INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (4, N'Absconded')
INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (5, N'Deceased')
INSERT [dbo].[tbl_reasonsForStaffLeaving] ([reasonForStaffLeavingId], [reasonForStaffLeaving]) VALUES (6, N'N/A')
SET IDENTITY_INSERT [dbo].[tbl_reasonsForStaffLeaving] OFF
SET IDENTITY_INSERT [dbo].[tbl_reasonsForTransfers] ON 

INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (1, N'Moving with transferring guardians/parents')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (2, N'Financial Problems')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (3, N'Guardians/Parents Death')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (4, N'Health Problems')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (5, N'Evading Bullying')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (6, N'Seeking better School')
INSERT [dbo].[tbl_reasonsForTransfers] ([reasonId], [reason]) VALUES (7, N'Going to nearer School')
SET IDENTITY_INSERT [dbo].[tbl_reasonsForTransfers] OFF
INSERT [dbo].[tbl_receiptCounter] ([ctr]) VALUES (48)
SET IDENTITY_INSERT [dbo].[tbl_relationships] ON 

INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (1, N'Father')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (2, N'Mother')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (3, N'Brother')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (4, N'Sister')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (5, N'Uncle')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (6, N'Aunt')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (7, N'GrandParent')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (8, N'Guardian')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (9, N'Other')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (10, N'Spouse')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (11, N'Father in Law')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (12, N'Mother in Law')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (13, N'Cousin')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (14, N'Nephew')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (15, N'Niece')
INSERT [dbo].[tbl_relationships] ([relationshipId], [relationship]) VALUES (16, N'Missing')
SET IDENTITY_INSERT [dbo].[tbl_relationships] OFF
SET IDENTITY_INSERT [dbo].[tbl_religions] ON 

INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (1, N'Christianity')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (2, N'Africa Traditional')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (3, N'Muslim')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (4, N'Rastafarian')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (5, N'None')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (6, N'Missing')
INSERT [dbo].[tbl_religions] ([religionId], [religion]) VALUES (7, N'Jew')
SET IDENTITY_INSERT [dbo].[tbl_religions] OFF
SET IDENTITY_INSERT [dbo].[tbl_responsibleAuthourities] ON 

INSERT [dbo].[tbl_responsibleAuthourities] ([authourityId], [authourity]) VALUES (1, N'Government')
INSERT [dbo].[tbl_responsibleAuthourities] ([authourityId], [authourity]) VALUES (2, N'Council')
INSERT [dbo].[tbl_responsibleAuthourities] ([authourityId], [authourity]) VALUES (3, N'Church')
INSERT [dbo].[tbl_responsibleAuthourities] ([authourityId], [authourity]) VALUES (4, N'Private')
SET IDENTITY_INSERT [dbo].[tbl_responsibleAuthourities] OFF
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (1, N'Transport')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (2, N'T-Shirts')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (3, N'Uniforms')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (4, N'Tracksuits')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (5, N'Jerseys')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (6, N'Hats')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (7, N'Blazers')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (8, N'Fees')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (9, N'tgkhymtuk')
INSERT [dbo].[tbl_revenueItemTypes] ([itemTypeID], [itemType]) VALUES (10, N'xxxxxxxxxxxxxx')
INSERT [dbo].[tbl_rooms] ([buildingId], [roomNumber], [roomTypeId], [roomDescription], [chairRowCols], [chairRows]) VALUES (2, N'F1-R1', 1, N'Form 1 red classroom', 5, 6)
INSERT [dbo].[tbl_rooms] ([buildingId], [roomNumber], [roomTypeId], [roomDescription], [chairRowCols], [chairRows]) VALUES (2, N'F1-R2', 1, N'Form 1 green classroom', 6, 6)
INSERT [dbo].[tbl_rooms] ([buildingId], [roomNumber], [roomTypeId], [roomDescription], [chairRowCols], [chairRows]) VALUES (2, N'F2-R1', 1, N'Form 2 red classroom', 5, 4)
SET IDENTITY_INSERT [dbo].[tbl_schoolBuildings] ON 

INSERT [dbo].[tbl_schoolBuildings] ([buildingId], [buildingName]) VALUES (1, N'Administration Block')
SET IDENTITY_INSERT [dbo].[tbl_schoolBuildings] OFF
SET IDENTITY_INSERT [dbo].[tbl_schoolClasses] ON 

INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (1, N'1 Blue', 1)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (2, N'1 Gold', 1)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (3, N'1 Temp', 1)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (4, N'2 Blue', 2)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (5, N'2 Gold', 2)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (6, N'2 Temp', 2)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (7, N'3 Blue', 3)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (8, N'3 Gold', 3)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (9, N'3 Cream', 3)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (10, N'3 Temp', 3)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (11, N'4 Blue', 4)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (12, N'4 Gold', 4)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (13, N'4 Cream', 4)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (14, N'4 Red', 4)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (15, N'4 Temp', 4)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (16, N'L6S', 5)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (17, N'L6A', 5)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (18, N'L6C', 5)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (19, N'L6 Temp', 5)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (20, N'U6S', 6)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (21, N'U6A', 6)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (22, N'U6C', 6)
INSERT [dbo].[tbl_schoolClasses] ([schoolClassId], [schoolClass], [streamId]) VALUES (23, N'U6 Temp', 6)
SET IDENTITY_INSERT [dbo].[tbl_schoolClasses] OFF
INSERT [dbo].[tbl_schoolCoreDetails] ([schoolCode], [schoolName], [physicalAddress], [postalAddress], [telephoneNumber], [cellNumber], [emailAddress], [webAddress], [dateFounded], [responsibleAuthourityId], [schoolHeadName], [position1], [position1Name], [position1ContactNumber], [position2], [position2Name], [position2ContactNumber], [position3], [position3Name], [position3ContactNumber], [responsibleChurch], [missionStatement], [schoolSuffixLetter]) VALUES (N'HA       ', N'Herentals CBD - Harare', N'Robert t
CCCCCCCC                                                                                                                                 ', N'00 P.O Box 00, Harare Post Office
CCCCCCCC                                                                                                                                 ', N'0000000                     ', N'00000000                 ', N'admin@herentals.com                                        ', N'www.herentals.com                                        ', N'SEF                                               ', 2, N'Test Name                                                  ', N'SRGE                          ', N'DBT                                                         ', N'FBDB                          ', N'FD                            ', N'DFNFN                                                       ', N'CNGFGF                        ', N'CNGF                          ', N'CGNFNF                                                      ', N'CGNF                          ', N'CCCCCCC                                           ', N'CCCCCCC                                                                                                                                                                                                                                                   ', N'DGZ       ')
SET IDENTITY_INSERT [dbo].[tbl_schoolFileType] ON 

INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (1, N'Scheme of Work')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (2, N'Syllabus')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (3, N'Policy Guideline')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (4, N'Staff Meeting Minutes')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (5, N'Staff Development Meeting Minutes')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (6, N'Circular')
INSERT [dbo].[tbl_schoolFileType] ([fileTypeId], [fileType]) VALUES (7, N'Transfer Letter')
SET IDENTITY_INSERT [dbo].[tbl_schoolFileType] OFF
SET IDENTITY_INSERT [dbo].[tbl_schoolStaffPositions] ON 

INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (1, N'Principal')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (2, N'Deputy Head')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (3, N'Teacher in Charge')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (4, N'Sports Master/Director')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (5, N'Teacher')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (6, N'Administrator')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (7, N'Superitendant')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (8, N'Matron')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (9, N'Pastor/Priest')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (10, N'Test Staff Position')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (11, N'None')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (12, N'Netball Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (13, N'Soccer Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (14, N'Head of Department - Arts')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (15, N'Head of Department - Commercials')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (16, N'Head of Department - Professionals')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (17, N'Head of Department - Sciences')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (18, N'Head of Department - Hotel & Catering')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (19, N'Rugby Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (20, N'Head of Department - IT')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (21, N'Head of Department - Interior Decor')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (22, N'Volleyball Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (23, N'Examinations Officer')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (24, N'Basketball Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (25, N'Girls Soccer Coach')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (26, N'Examinations Officer')
INSERT [dbo].[tbl_schoolStaffPositions] ([schoolStaffPositionId], [schoolStaffPosition]) VALUES (27, N'Designer')
SET IDENTITY_INSERT [dbo].[tbl_schoolStaffPositions] OFF
SET IDENTITY_INSERT [dbo].[tbl_schoolStudentPositions] ON 

INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (1, N'Head Boy')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (2, N'Deputy Head Boy')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (3, N'Head Girl')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (4, N'Deputy Head Girl')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (5, N'Prefect')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (6, N'Class Representative')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (7, N'None')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (8, N'Councillor')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (9, N'S U Leader')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (10, N'Senior Prefect')
INSERT [dbo].[tbl_schoolStudentPositions] ([schoolStudentPositionId], [schoolStudentPosition]) VALUES (11, N'Class Monitor')
SET IDENTITY_INSERT [dbo].[tbl_schoolStudentPositions] OFF
SET IDENTITY_INSERT [dbo].[tbl_schoolTerms] ON 

INSERT [dbo].[tbl_schoolTerms] ([termId], [term]) VALUES (1, N'Term 1')
INSERT [dbo].[tbl_schoolTerms] ([termId], [term]) VALUES (2, N'Term 2')
INSERT [dbo].[tbl_schoolTerms] ([termId], [term]) VALUES (3, N'Term 3')
INSERT [dbo].[tbl_schoolTerms] ([termId], [term]) VALUES (4, N'All Terms')
INSERT [dbo].[tbl_schoolTerms] ([termId], [term]) VALUES (5, N'N/A')
SET IDENTITY_INSERT [dbo].[tbl_schoolTerms] OFF
SET IDENTITY_INSERT [dbo].[tbl_sectionUnits] ON 

INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (1, 1, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (2, 2, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (3, 3, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (4, 4, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (5, 5, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (6, 6, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (7, 7, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (8, 8, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (9, 9, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (10, 10, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (11, 11, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (12, 12, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (13, 13, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (14, 14, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (15, 15, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (16, 16, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (17, 17, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (18, 18, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (19, 19, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (20, 20, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (21, 21, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (22, 22, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (23, 23, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (24, 24, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (25, 25, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (26, 26, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (27, 27, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (28, 28, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (29, 29, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (30, 30, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (31, 31, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (32, 32, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (33, 33, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (34, 34, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (35, 35, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (36, 36, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (37, 37, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (38, 38, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (39, 39, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (40, 40, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (41, 41, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (42, 42, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (43, 43, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (44, 44, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (45, 45, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (46, 46, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (47, 47, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (48, 48, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (49, 49, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (50, 50, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (51, 51, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (52, 52, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (53, 53, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (54, 54, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (55, 55, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (56, 56, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (57, 57, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (58, 58, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (59, 59, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (60, 60, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (61, 61, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (62, 62, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (63, 63, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (64, 64, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (65, 65, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (66, 66, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (67, 67, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (68, 68, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (69, 69, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (70, 70, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (71, 71, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (72, 72, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (73, 73, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (74, 74, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (75, 75, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (76, 76, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (77, 77, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (78, 78, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (79, 79, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (80, 80, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (81, 81, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (82, 82, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (83, 83, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (84, 84, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (85, 85, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (86, 86, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (87, 87, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (88, 88, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (89, 89, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (90, 90, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (91, 91, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (92, 92, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (93, 93, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (94, 94, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (95, 95, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (96, 96, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (97, 97, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (98, 98, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (99, 99, N'N/A')
GO
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (100, 100, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (101, 101, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (102, 102, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (103, 103, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (104, 104, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (105, 105, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (106, 106, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (107, 107, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (108, 108, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (109, 109, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (110, 110, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (111, 111, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (112, 112, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (113, 113, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (114, 114, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (115, 115, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (116, 116, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (117, 117, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (118, 118, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (119, 119, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (120, 120, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (121, 121, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (122, 122, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (123, 123, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (124, 124, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (125, 125, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (126, 126, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (127, 127, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (128, 128, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (129, 129, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (130, 130, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (131, 131, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (132, 132, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (133, 133, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (134, 134, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (135, 135, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (136, 136, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (137, 137, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (138, 138, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (139, 139, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (140, 140, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (141, 141, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (142, 142, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (143, 143, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (144, 144, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (145, 145, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (146, 146, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (147, 147, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (148, 148, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (149, 149, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (150, 150, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (151, 151, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (152, 152, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (153, 153, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (154, 154, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (155, 155, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (156, 156, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (157, 157, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (158, 158, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (159, 159, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (160, 160, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (161, 161, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (162, 162, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (163, 163, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (164, 164, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (165, 165, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (166, 166, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (167, 167, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (168, 168, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (169, 169, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (170, 170, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (171, 171, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (172, 172, N'N/A')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (173, 173, N'N/A                                               ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (94, 174, N'New Stands                                        ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (122, 175, N'New Stands                                        ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (57, 176, N'Glen View 7                                       ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (23, 177, N'B                                                 ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (174, 178, N'N/A                                               ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (94, 179, N'Old Mabvuku                                       ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (79, 180, N'Lusaka                                            ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (154, 181, N'New Tafara                                        ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (175, 182, N'Unit L                                            ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (176, 183, N'N/A                                               ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (154, 184, N'Old Tafara                                        ')
INSERT [dbo].[tbl_sectionUnits] ([suburbId], [sectionUnitId], [sectionUnit]) VALUES (177, 185, N'N/A                                               ')
SET IDENTITY_INSERT [dbo].[tbl_sectionUnits] OFF
INSERT [dbo].[tbl_setExaminationFees] ([streamId], [examinationBoardId], [centerFee], [stationeryFee], [subjectId], [setExamFee]) VALUES (4, 4, 45.0000, 12.0000, 1, 10.0000)
INSERT [dbo].[tbl_setExaminationFees] ([streamId], [examinationBoardId], [centerFee], [stationeryFee], [subjectId], [setExamFee]) VALUES (1, 1, 5.0000, 5.0000, 1, 10.0000)
INSERT [dbo].[tbl_setExaminationFees] ([streamId], [examinationBoardId], [centerFee], [stationeryFee], [subjectId], [setExamFee]) VALUES (1, 1, 5.0000, 5.0000, 1, 10.0000)
INSERT [dbo].[tbl_setExaminationFees] ([streamId], [examinationBoardId], [centerFee], [stationeryFee], [subjectId], [setExamFee]) VALUES (1, 1, 5.0000, 5.0000, 1, 10.0000)
SET IDENTITY_INSERT [dbo].[tbl_setLevyPaymentsSchedule] ON 

INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (1, 1, 20.0000)
INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (2, 2, 30.0000)
INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (3, 3, 20.0000)
INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (4, 4, 20.0000)
INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (5, 5, 10.0000)
INSERT [dbo].[tbl_setLevyPaymentsSchedule] ([levyPaymentId], [streamId], [amountPerTerm]) VALUES (1002, 6, 20.0000)
SET IDENTITY_INSERT [dbo].[tbl_setLevyPaymentsSchedule] OFF
SET IDENTITY_INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ON 

INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (1, 1, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (2, 2, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (3, 3, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (4, 4, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (5, 5, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (6, 6, 30.0000)
INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] ([PaymentId], [streamId], [amount]) VALUES (7, 7, 50.0000)
SET IDENTITY_INSERT [dbo].[tbl_setRegistrationPaymentsSchedule] OFF
SET IDENTITY_INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ON 

INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (1, 1, 60.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (2, 2, 60.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (3, 3, 70.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (4, 4, 70.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (5, 5, 70.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (6, 6, 80.0000, 0.0000, 0.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule] ([tuitionPaymentId], [streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (7, 7, 70.0000, 0.0000, 0.0000)
SET IDENTITY_INSERT [dbo].[tbl_setTuitionPaymentsSchedule] OFF
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (1, 50.0000, 0.0000, 5.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (2, 50.0000, 0.0000, 5.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (3, 60.0000, 5.0000, 5.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (4, 60.0000, 5.0000, 5.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (5, 60.0000, 5.0000, 5.0000)
INSERT [dbo].[tbl_setTuitionPaymentsSchedule2] ([streamId], [amountPerMonth], [amountPerExtraSubject], [computersFee]) VALUES (6, 60.0000, 5.0000, 5.0000)
SET IDENTITY_INSERT [dbo].[tbl_sex] ON 

INSERT [dbo].[tbl_sex] ([sexId], [sex]) VALUES (1, N'Male')
INSERT [dbo].[tbl_sex] ([sexId], [sex]) VALUES (2, N'Female')
SET IDENTITY_INSERT [dbo].[tbl_sex] OFF
SET IDENTITY_INSERT [dbo].[tbl_sportHouses] ON 

INSERT [dbo].[tbl_sportHouses] ([sportsHouseId], [sportsHouse], [sportsHouseColor]) VALUES (5, N'Zebra', NULL)
INSERT [dbo].[tbl_sportHouses] ([sportsHouseId], [sportsHouse], [sportsHouseColor]) VALUES (6, N'Bushbucks                                     ', NULL)
INSERT [dbo].[tbl_sportHouses] ([sportsHouseId], [sportsHouse], [sportsHouseColor]) VALUES (7, N'Antelope', NULL)
INSERT [dbo].[tbl_sportHouses] ([sportsHouseId], [sportsHouse], [sportsHouseColor]) VALUES (8, N'Cheetah', NULL)
INSERT [dbo].[tbl_sportHouses] ([sportsHouseId], [sportsHouse], [sportsHouseColor]) VALUES (9, N'Missing', NULL)
SET IDENTITY_INSERT [dbo].[tbl_sportHouses] OFF
SET IDENTITY_INSERT [dbo].[tbl_sports] ON 

INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (1, N'Atheletics')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (2, N'Soccer')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (3, N'Volley Ball')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (4, N'Netball')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (5, N'Baseball')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (6, N'Softball')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (7, N'Tennis')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (8, N'Hockey')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (9, N'Rugby')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (10, N'Table Tennis')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (11, N'Basketball')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (12, N'Test Sport')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (13, N'Test Sport 2')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (14, N'Test Sport 3')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (15, N'All Sports')
INSERT [dbo].[tbl_sports] ([sportId], [sport]) VALUES (16, N'Cricket')
SET IDENTITY_INSERT [dbo].[tbl_sports] OFF
SET IDENTITY_INSERT [dbo].[tbl_sportsAccoladeEvents] ON 

INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (15, 1, N'Annual Prize Giving Day')
INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (1, 2, N'School Marathon')
INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (2, 3, N'Zonal Competitions')
INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (2, 4, N'District Competions')
INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (2, 5, N'Provincial Competitions')
INSERT [dbo].[tbl_sportsAccoladeEvents] ([sportId], [eventId], [event]) VALUES (2, 6, N'National Competitions')
SET IDENTITY_INSERT [dbo].[tbl_sportsAccoladeEvents] OFF
SET IDENTITY_INSERT [dbo].[tbl_sportsAccoladeLevels] ON 

INSERT [dbo].[tbl_sportsAccoladeLevels] ([accoladeLevelId], [accoladeLevel]) VALUES (1, N'School Level')
INSERT [dbo].[tbl_sportsAccoladeLevels] ([accoladeLevelId], [accoladeLevel]) VALUES (2, N'Team Level')
INSERT [dbo].[tbl_sportsAccoladeLevels] ([accoladeLevelId], [accoladeLevel]) VALUES (3, N'Individual Level')
SET IDENTITY_INSERT [dbo].[tbl_sportsAccoladeLevels] OFF
SET IDENTITY_INSERT [dbo].[tbl_sportsAccolades] ON 

INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (3, 1, N'Sports Person of the Year', 15)
INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (3, 2, N'Player of the Tournament', 2)
INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (2, 3, N'Best School Team', 15)
INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (3, 4, N'Soccer Star of the Year', 2)
INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (2, 5, N'1st Position', 1)
INSERT [dbo].[tbl_sportsAccolades] ([accoladeLevelId], [accoladeId], [accolade], [sportId]) VALUES (2, 6, N'1st Position', 2)
SET IDENTITY_INSERT [dbo].[tbl_sportsAccolades] OFF
SET IDENTITY_INSERT [dbo].[tbl_sportsTeams] ON 

INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (2, 1, N'A Team')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (2, 2, N'B Team')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (2, 3, N'Under 16')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (1, 4, N'Marathon')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (11, 5, N'First Team')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (11, 6, N'Second Team')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (1, 7, N'4X100m Relay')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (1, 8, N'100m')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (1, 9, N'2X200m Relay')
INSERT [dbo].[tbl_sportsTeams] ([sportId], [sportsTeamId], [sportsTeam]) VALUES (16, 10, N'A-Team')
SET IDENTITY_INSERT [dbo].[tbl_sportsTeams] OFF
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Shiella', N'Manyara', N'Mupunga', N'63-74244Q75', N'HA0001', 2, CAST(0x60640000 AS SmallDateTime), 1, 11, CAST(0xA5140000 AS SmallDateTime), CAST(0x9B8B0000 AS SmallDateTime), N'0735069964', N'4510 Mnyame Park', 2, 0, N'George Mupunga', 1, N'0772888011', N'4510 Manyame Park, Chitungwiza', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 173)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'-', N'-', N'Shumba', N'63-1022965B03', N'HA0002', 1, CAST(0x6EF50000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0x9E6A0000 AS SmallDateTime), N'0777969472', N'House # 11100', 2, 0, N'Brenda Magunje', 1, N'0775692862', N'', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 175)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Vongai', N'-', N'Sibanda', N'14-114012R14', N'HA0003', 2, CAST(0x6D150000 AS SmallDateTime), 1, 5, CAST(0xA0050000 AS SmallDateTime), CAST(0xA0050000 AS SmallDateTime), N'0771585186', N'Hse # 10967', 3, 0, N'Zivanai Museriva', 4, N'0777338466', N'', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'sibandavongai@yahoo.com', 176)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Vivian', N'-', N'Chipashu', N'43-054674H32', N'HA0004', 2, CAST(0x6D090000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9E460000 AS SmallDateTime), N'0772292647', N'2257 Mapereke Road', 2, 0, N'Muchineripi Masawi', 1, N'0773217794', N'2257 Mapereke Road, Marlborough', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'vivianchipashu@yahoo.com', 102)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Sure', N'-', N'Nzema', N'63-1305482-67', N'HA0005', 1, CAST(0x78CE0000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA51A0000 AS SmallDateTime), N'0773256856', N'8577', 2, 0, N'Beula Chinhoyi', 1, N'0772567403', N'8577 Budiriro 5B', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'snzema@yahoo.co.uk', 177)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Learnmore', N'-', N'Ngorima', N'29-2038433D44', N'HA0006', 1, CAST(0x82860000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA4AE0000 AS SmallDateTime), N'0775125004', N'-', 1, 0, N'C Ngorima', 3, N'0712356559', N'1663 Mkoba 12, Gweru', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'lenngtok9@gmail.com', 90)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Collen', N'-', N'Goche', N'63-1335760W70', N'HA0007', 1, CAST(0x7B840000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9E960000 AS SmallDateTime), N'0774838509', N'10/8 Ammwel', 2, 0, N'Patience Msipa', 1, N'0774838509', N'8410 5th Circle, Glen View 8', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'coodza@gmail.com', 163)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Kenneth', N'-', N'Mashiringwani', N'63-1460304V27', N'HA0008', 1, CAST(0x7EA40000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0xA2E30000 AS SmallDateTime), N'0774170279', N'-', 1, 0, N'J Mashiringwani', 3, N'054-255319', N'', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'kmashiringwani@gmail.com', 90)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Victor', N'-', N'Mpofu', N'58-107721Q58', N'HA0009', 1, CAST(0x5F4C0000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA4790000 AS SmallDateTime), N'0774612391', N'10 Southam Road', 2, 0, N'Nomsa Maputsa', 4, N'0772618594', N'', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'None', 71)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Nyaradzai', N'-', N'Mubatsa', N'63-1197053C12', N'HA0010', 2, CAST(0x776D0000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0x9B910000 AS SmallDateTime), N'0772769817', N'21 Chivake', 2, 0, N'Everson Masiyiwa', 1, N'0776376800', N'21 Chivake, New Mabvuku', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'nmubatsa@gmail.com', 122)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Chrispen', N'-', N'Chenyika', N'67-123110B03', N'HA0011', 1, CAST(0x77830000 AS SmallDateTime), 1, 5, CAST(0xA5140000 AS SmallDateTime), CAST(0xA5140000 AS SmallDateTime), N'0714131134', N'Hse # 105107', 2, 0, N'Theresa Mutopa', 1, N'0716310502', N'1185 Shiri Road Chikangwe, Karoi', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'chrysostomcc@gmai.com', 60)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Amanda', N'Muyamuri', N'Antonio', N'70-248524Q70', N'HA0012', 2, CAST(0x7CBC0000 AS SmallDateTime), 1, 5, CAST(0x9F950000 AS SmallDateTime), CAST(0x9F950000 AS SmallDateTime), N'0773259524', N'Hse # 856', 1, 0, N'Patricia Antonio', 3, N'0772355509', N'Hse # 856 New Tafara', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'muyamuria@gmail.com', 178)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Millicent', N'-', N'Ngirazi', N'59-0336246-18', N'HA0013', 2, CAST(0x74750000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0x9EE60000 AS SmallDateTime), N'0773943369', N'1170 Simon Chinyama', 2, 0, N'Asan Farinya', 1, N'0774825442', N'1170 Simon Chinyama Road, Waterfalls', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'ngiraziangie@gmail.com', 163)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Clive', N'-', N'Chari', N'63-117847ECITE', N'HA0014', 1, CAST(0x46C60000 AS SmallDateTime), 15, 26, CAST(0xA5160000 AS SmallDateTime), CAST(0xA3440000 AS SmallDateTime), N'300144', N'4 Woodcote Close', 2, 0, N'Joyce Chari', 1, N'-', N'4 Woodcote Close, Marborough', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 102)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'John', N'-', N'Dhadhi', N'38-087946Q38', N'HA0015', 1, CAST(0x6CCF0000 AS SmallDateTime), 16, 1, CAST(0xA5160000 AS SmallDateTime), CAST(0x9D350000 AS SmallDateTime), N'0772203676', N'9722', 2, 0, N'Kudzayi Dhadhi', 1, N'0712734271', N'9722 New Stands, New Mabvuku', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'jdhadhi@gmail.com', 175)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Evernice', N'Tevedzerai', N'Mamvura-Mutema', N'63-979701C80', N'HA0016', 2, CAST(0x6D630000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9CF10000 AS SmallDateTime), N'0772529407', N'55-16 Crescent', 1, 0, N'Mrs J Mutema', 2, N'0772635659', N'55-16 Crescent Warren Park', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'none', 160)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Julius', N'Freeman', N'Maredza', N'04-105102R04', N'HA0017', 1, CAST(0x717C0000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9D2C0000 AS SmallDateTime), N'0778072206', N'25 Munhondo Street', 2, 0, N'Stella Nhoto', 1, N'-', N'25 Munhondo Street, Mufakose', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'maredzajf@gmail.com', 118)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Elijah', N'-', N'Kawadza', N'42-2242203X42', N'HA0018', 1, CAST(0x7B340000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0x9CF10000 AS SmallDateTime), N'0772200331', N'609 Shambare, Old Mabvuku', 2, 0, N'Thelma Kawadza', 1, N'0775822447', N'609 Shambare, Old Mabvuku', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 179)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Tecla', N'-', N'Phinias', N'75-375726L50', N'HA0019', 2, CAST(0x7B5B0000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0xA2B60000 AS SmallDateTime), N'0772204923', N'3 Hexam Close', 2, 0, N'Richwell Phinias', 1, N'0773222327', N'3 Hexam Close, Hatfield', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'teclakatyora@gmail.com', 77)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Hapaguti', N'-', N'Tamboonei', N'04-128327L04', N'HA0020', 1, CAST(0x75FF0000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0x9AAA0000 AS SmallDateTime), N'0776403773', N'Hse # 6179', 2, 0, N'Aaron Tamborinei', 4, N'0776904965', N'8109 Budiriro 5B', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 177)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Brighton', N'-', N'Munyawiri', N'38-1468112-38', N'HA0021', 1, CAST(0x775C0000 AS SmallDateTime), 1, 5, CAST(0xA5160000 AS SmallDateTime), CAST(0xA1730000 AS SmallDateTime), N'0775082542', N'1316', 2, 0, N'R Munyawiri', 1, N'0777015516', N'1316 Lusaka, Highfield', 0.0000, N'0', CAST(0x80680000 AS SmallDateTime), 6, 3, N'bmunyawiri@gmail.com', 180)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Charles', N'Tawanda', N'Madamombe', N'18-111265G18', N'HA0022', 1, CAST(0x7D200000 AS SmallDateTime), 17, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9EF90000 AS SmallDateTime), N'0773442027', N'Hse # 8069', 1, 0, N'L Madamombe', 4, N'0773273297', N'8069, New Tafara', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'tawandamadaxt@gmail.com', 181)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Venicensia', N'-', N'Nyagwambo', N'63-1342696C42', N'HA0023', 2, CAST(0x79CC0000 AS SmallDateTime), 18, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9D3A0000 AS SmallDateTime), N'07743714274', N'6241', 1, 0, N'Lucia Nyagwambo', 4, N'0772750433', N'1645 Granary', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 165)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Nkosinathi', N'Pretty', N'Tshabalala', N'29-232352Y19', N'HA0024', 2, CAST(0x7A310000 AS SmallDateTime), 18, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9CFB0000 AS SmallDateTime), N'0777901980', N'2331 J Tongogara Road', 2, 0, N'P Tshabalala', 4, N'0774023279', N'2331 J Tongogara Road, Ruwa', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 138)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Tendai', N'-', N'Mushuna', N'07-168420K07', N'HA0025', 2, CAST(0x7EE40000 AS SmallDateTime), 18, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9FCF0000 AS SmallDateTime), N'0776390241', N'6318, 1st Drive', 1, 0, N'K Mushuna', 4, N'0773182057', N'25 Pension Farm, Harare', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 60)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Tsitsi', N'-', N'Chingodza', N'05-109675T05', N'HA0026', 2, CAST(0x80A30000 AS SmallDateTime), 18, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA3420000 AS SmallDateTime), N'0773761369', N'3 Peppermint, Msasa Park', 1, 0, N'N Chingodza', 4, N'0774363158', N'3 Peppermint, Msasa Park', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 114)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (3, N'Paular', N'-', N'Kawadza', N'63-1245724F42', N'HA0027', 2, CAST(0x79500000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA30C0000 AS SmallDateTime), N'0774035613', N'6558', 1, 0, N'Romeo Kawadza', 4, N'0772268430', N'', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'kawadza1985@gmail.com', 54)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Thulani', N'-', N'Chiponda', N'03-091158003', N'HA0028', 2, CAST(0x6E260000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9C9A0000 AS SmallDateTime), N'0772996869', N'12 Steenbok Road', 2, 0, N'S. Chiponda', 1, N'0772839309', N'12 Steenbok Road, Mandara', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 96)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Nomsa', N'Nobuhle', N'Moyo', N'29-2010460Y29', N'HA0029', 2, CAST(0x7F3F0000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA22F0000 AS SmallDateTime), N'0773214744', N'64 Beesten Avenue', 1, 0, N'J Ncube', 2, N'481353', N'64 Beesten Avenue, Mandara', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 96)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Betty', N'-', N'Mundandishe', N'59-133785A75', N'HA0031', 2, CAST(0x82840000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0xA4E20000 AS SmallDateTime), N'-', N'19079', 2, 0, N'Blessed Mugijima', 1, N'0773203183', N'19079 Unit L, Seke Chitungwiza', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 182)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Nyemwerai', N'-', N'Degwa', N'63-1095135X07', N'HA0032', 2, CAST(0x6F090000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9C1B0000 AS SmallDateTime), N'0776986462', N'1400', 1, 0, N'Kevin Jena', 4, N'0774130487', N'', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 19)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (2, N'Prisca', N'-', N'Serima', N'27-071782Z27', N'HA0033', 2, CAST(0x63DF0000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x99AA0000 AS SmallDateTime), N'0773368155', N'1648', 2, 0, N'Rodrick Matingwa', 1, N'0733847116', N'1648 Southly Park', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 145)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Loice', N'-', N'Katanda', N'15-099653P71', N'HA0034', 2, CAST(0xA5160000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x98E60000 AS SmallDateTime), N'0775468530', N'557 Marwede', 1, 0, N'Lespeael Kansi', 2, N'-', N'-', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 183)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Rachel', N'-', N'Matanga', N'59-05440928--', N'HA0035', 2, CAST(0x73230000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x98E60000 AS SmallDateTime), N'0238258690', N'1547', 1, 0, N'Faustina Matunga', 4, N'0738858690', N'', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 184)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Nyasha', N'Lucia', N'Gutu', N'50-087283Y50', N'HA0036', 2, CAST(0x71140000 AS SmallDateTime), 19, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9E5E0000 AS SmallDateTime), N'0773171058', N'1990', 1, 0, N'Michael Gutu', 2, N'0779273894', N'1990 Budiriro 1', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 19)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (4, N'Gawapiwa', N'-', N'Ngwaya', N'18-034906H18', N'HA0037', 2, CAST(0x5FFC0000 AS SmallDateTime), 1, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x9BA60000 AS SmallDateTime), N'0773621390', N'Nenyere Flats B1 B14', 1, 0, N'Enos', 4, N'0773621391', N'Govere School, Box 133', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 105)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'Artwell', N'-', N'Ndoro', N'63-129247Y25', N'HA0038', 1, CAST(0x7BAA0000 AS SmallDateTime), 20, 11, CAST(0xA5160000 AS SmallDateTime), CAST(0x94AA0000 AS SmallDateTime), N'0733860892', N'13 Hunga Street', 2, 0, N'Archford Ndoro', 7, N'0783766926', N'', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 94)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (1, N'-', N'-', N'Magaya', N'-', N'HA0039', 1, CAST(0x73320000 AS SmallDateTime), 1, 5, CAST(0xA4130000 AS SmallDateTime), CAST(0xA4130000 AS SmallDateTime), N'-', N'-', 2, 0, N'-', 7, N'-', N'-', 0.0000, N'-', CAST(0x80680000 AS SmallDateTime), 6, 3, N'-', 7)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Tawanda', N'T', NULL, N'63-1487843D13', N'12345', 1, CAST(0x83B10000 AS SmallDateTime), NULL, NULL, CAST(0xA37A0000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Tawanda', N'T', NULL, N'63-1487843D13', N'12345', 1, CAST(0xA5430000 AS SmallDateTime), NULL, NULL, CAST(0xA4360000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Tawanda', N'T', NULL, N'63-1487843D13', N'12345', 1, CAST(0xA5430000 AS SmallDateTime), NULL, NULL, CAST(0xA4360000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Tawanda', N'T', NULL, N'63-1487843D13', N'12345', 1, CAST(0xA5430000 AS SmallDateTime), NULL, NULL, CAST(0xA4360000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Tawanda', N'T', NULL, N'63-1487843D13', N'12345', 1, CAST(0xA5430000 AS SmallDateTime), NULL, NULL, CAST(0xA4360000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffDetails] ([titleId], [firstName], [secondName], [surname], [natIdNumber], [employmentNumber], [sexId], [dateOfBirth], [jobTitleId], [schoolStaffPositionId], [dateOfInitiation], [dateAppointedToSchool], [contactNumber], [homeAddress], [maritalStatusId], [numberOfDependants], [nextOfKinName], [relationshipId], [nextOfKinContactNumber], [nextOfKinAddress], [salary], [officeNumber], [dateLeft], [reasonForLeavingId], [healthConditionId], [emailAddress], [unitSectionId]) VALUES (0, N'Evernice', N'p0111900y', N'Tayisepi', N'63-1487843D13', N'23456789', 2, CAST(0x83640000 AS SmallDateTime), NULL, NULL, CAST(0xA4360000 AS SmallDateTime), CAST(0xA5430000 AS SmallDateTime), N'0773187808', N'test', 1, 4, N'Lovemore', NULL, N'0773187808', N'test', 500.0000, N'04678896', NULL, NULL, NULL, N'test', NULL)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0001                        ', 10, 1, 5, 2006)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0001                        ', 1, 2, 6, 1992)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0003                        ', 11, 1, 7, 2004)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0004                        ', 12, 1, 8, 2005)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0005                        ', 13, 1, 9, 2010)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0006                        ', 14, 1, 10, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0007                        ', 15, 1, 7, 2010)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0008                        ', 13, 1, 11, 2013)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0009                        ', 2, 1, 12, 2004)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0009                        ', 16, 3, 1, 1991)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0010                        ', 1, 2, 7, 2004)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0011                        ', 17, 1, 10, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0012                        ', 12, 1, 8, 2010)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0013                        ', 18, 2, 13, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0014                        ', 2, 1, 7, 1987)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0015                        ', 19, 5, 14, 2001)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0016                        ', 1, 2, 15, 1997)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0017                        ', 3, 1, 7, 2004)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0018                        ', 20, 2, 16, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0019                        ', 21, 1, 7, 2011)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA                            ', 22, 6, 17, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0021                        ', 23, 1, 8, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0022                        ', 24, 2, 18, 2010)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0023                        ', 24, 2, 19, 2008)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0024                        ', 24, 2, 18, 2009)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0025                        ', 24, 2, 18, 2010)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0026                        ', 25, 3, 19, 2013)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0027                        ', 26, 5, 14, 2011)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0028                        ', 3, 1, 7, 2000)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0029                        ', 27, 2, 19, 2012)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0031                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0032                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0033                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0034                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0035                        ', 29, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0036                        ', 29, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0037                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0038                        ', 28, 3, 20, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'11111', 2, 2, 2, 1905)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'22222', 2, 2, 2, 2012)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'22222', 2, 2, 2, 2012)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0010', 13, 1, 9, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0006', 7, 1, 5, 2015)
INSERT [dbo].[tbl_staffQualifications] ([employmentNumber], [qualificationId], [qualificationLevelId], [collegeId], [yearAttained]) VALUES (N'HA0010', 2, 1, 5, 2015)
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'English Literature', N'HA0009')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'English Language', N'HA0009')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'History', N'HA0009')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Shona', N'HA0020')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'History', N'HA0019')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Business Studies', N'HA0019')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Mathematics', N'HA0019')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Mathematics', N'HA0003')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Shona', N'HA0016')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Religious & Moral Education', N'HA0016')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Accounts', N'HA0034')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Commerce', N'HA0002')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'English Language', N'HA0028')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Religious & Moral Education', N'HA0028')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Shona', N'HA0012')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Science', N'HA0010')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Physical Science', N'HA0010')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Biology', N'HA0010')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Accounts', N'HA0018')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Geography', N'HA0018')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Sociology', N'HA0014')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Physics', N'HA0008')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Science', N'HA0008')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Chemistry', N'HA0008')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Mathematics', N'HA0008')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Science', N'HA0005')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Mathematics', N'HA0005')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Biology', N'HA0005')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Geography', N'HA0004')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Geography', N'HA0011')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'History', N'HA0011')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'History', N'HA0017')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Divinity', N'HA0017')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Commerce', N'HA0017')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Commerce', N'HA0013')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'Religious & Moral Education', N'HA0013')
INSERT [dbo].[tbl_staffSubjects] ([subject], [employmentNumber]) VALUES (N'COPS', N'HA0039')
SET IDENTITY_INSERT [dbo].[tbl_staffToNextOfKinRelationship] ON 

INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (1, N'Spouse')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (2, N'Child')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (3, N'Parent')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (4, N'Sibling')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (5, N'Other Relative')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (6, N'Neighbour')
INSERT [dbo].[tbl_staffToNextOfKinRelationship] ([relationshipId], [relationship]) VALUES (7, N'Other')
SET IDENTITY_INSERT [dbo].[tbl_staffToNextOfKinRelationship] OFF
SET IDENTITY_INSERT [dbo].[tbl_streams] ON 

INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (1, N'Form 1')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (2, N'Form 2')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (3, N'Form 3')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (4, N'Form 4')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (5, N'Form 5')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (6, N'Form 6')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (7, N'Professional')
INSERT [dbo].[tbl_streams] ([streamId], [stream]) VALUES (8, N'N/A')
SET IDENTITY_INSERT [dbo].[tbl_streams] OFF
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 1, 606)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 2, 615)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 3, 626)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 4, 627)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 5, 607)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 6, 600)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, 7, 600)
INSERT [dbo].[tbl_studentIDCodeGen] ([centerCode], [yYear], [streamId], [lastNumber]) VALUES (N'HA        ', 2015, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_students] ON 

INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3203, N'HCBD16F3001D', N'TULSHA', N'CORRINA', N'MATEMA', CAST(0xA3F60000 AS SmallDateTime), CAST(0x906E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'MAIN-WAY', 0, 9, 3, NULL, NULL, 1, 5, 1, N'JANET', N'MATEM', 2, 3, 28, N'1945 MAIN-WAY, WATERFALLS', N'0772595476', NULL, NULL, NULL, N'1945 MAIN-WAY, WATERFALLS', N'1945 MAIN-WAY, WATERFALLS', 1, 1, 1, N'0772595476', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4203, N'HCBD16F6007D', N'SHEILA', N'', N'DZVETA', CAST(0xA4260000 AS SmallDateTime), CAST(0x8AAB0000 AS SmallDateTime), NULL, N'63-1556630X42', 2, NULL, N'NUMBER 8 WARBURRY STREET
', 1, 20, 3, NULL, NULL, 0, 5, 1, N'HILDA', N'MUKUTUMA', 2, 2, 165, N'NUMBER 8 WARBURRY STREET', N'0772726192', NULL, NULL, NULL, N'', N'NUMBER 8 WARBURRY STREET', 1, 2, 0, N'0772726192', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4230, N'HCBD16F3026', N'PANASHE', N'', N'NGAGUMBO', CAST(0xA48F0000 AS SmallDateTime), CAST(0x8F010000 AS SmallDateTime), NULL, N'', 2, NULL, N'6 CAMBRIDGE', 0, 0, 0, NULL, NULL, 0, 5, 1, N'MORRIS', N'NYAGUMBO', 7, 1, 5, N'6 CAMBRIDGE ', N'00000', NULL, NULL, NULL, N'6 CAMBRIDGE ', N'6 CAMBRIDGE ', 1, 2, 1, N'0000000', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4320, N'HCBD16F1029D', N'PANASHE', N'HIGHLANDS', N'MHAKO', CAST(0xA5920000 AS SmallDateTime), CAST(0x902B0000 AS SmallDateTime), NULL, N'', 1, NULL, N'7 LINTON RD MALBOROUGH', 1, 2, 3, NULL, NULL, 0, 5, 1, N'FAITH', N'BASOPO', 2, 2, 178, N'7 LINTON RD MALBOROUGH', N'0772 190 892', NULL, NULL, NULL, N'', N'7 LINTON RD MALBOROUGH', 1, 2, 0, N'0772 145 973', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5203, N'HCBD16F30019D', N'LISA', N'', N'CHAFACHAWORA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90170000 AS SmallDateTime), NULL, N'', 2, NULL, N'1673 MAIN WAY MEADOWS ', 1, 8, 3, NULL, NULL, 0, 5, 1, N'PADDINGTON', N'CHAFACHAWORA', 1, 1, 166, N'1673 MAIN WAY MEADOWS ', N'0772333688', NULL, NULL, NULL, N'N/A', N'1673 MAIN WAY MEADOWS ', 1, 2, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5204, N'HCBD16F30020', N'BRENDA ', N'', N'MAKO', CAST(0xA4130000 AS SmallDateTime), CAST(0x90C00000 AS SmallDateTime), NULL, N'', 2, NULL, N'12 HYTH CLOSE SENTOSA ', 1, 8, 3, NULL, NULL, 0, 5, 1, N'TICHAREVA', N'MAKO', 1, 1, 67, N'12 HYTH CLOSE SENTOSA ', N'0772943699', NULL, NULL, NULL, N'', N'12 HYTH CLOSE SENTOSA ', 1, 2, 0, N'0772943699', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5205, N'HCBD16F30021D', N'DADIRAI ', N'', N'WILSON', CAST(0xA4130000 AS SmallDateTime), CAST(0x90C20000 AS SmallDateTime), NULL, N'', 2, NULL, N'4866 NEW STANDS ', 1, 8, 3, NULL, NULL, 0, 5, 1, N'WILSON ', N'DADIRAI', 0, 1, 0, N'4866 NEW STANDS ', N'0735285115', NULL, NULL, NULL, N'', N'4866 NEW STANDS ', 1, 2, 0, N'0735285115', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5206, N'HCBD16F30023D', N'CHENGETAI', N'', N'CHAKARAWO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8E820000 AS SmallDateTime), NULL, N'', 2, NULL, N'17243 HIPPO CLOSE ', 0, 8, 1, NULL, NULL, 0, 5, 1, N'', N'NYABEZE ', 2, 2, 90, N'17243 HIPPO CLOSE ', N'', NULL, NULL, NULL, N'17243 HIPPO CLOSE ', N'17243 HIPPO CLOSE ', 1, 2, 1, N'0777223449', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5207, N'HCBD16F30023', N'CHENGETAI', N'', N'CHAKARAWO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8E820000 AS SmallDateTime), NULL, N'', 2, NULL, N'17243 HIPPO CLOSE ', 1, 8, 1, NULL, NULL, 0, 5, 1, N'', N'NYABEZE ', 2, 2, 90, N'17243 HIPPO CLOSE ', N'', NULL, NULL, NULL, N'', N'17243 HIPPO CLOSE ', 1, 2, 1, N'0777223449', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5208, N'HCBD16F30025', N'ESNATH', N'', N'TAVAKONZA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8FD80000 AS SmallDateTime), NULL, N'', 2, NULL, N'49 MELFORT PARK ', 1, 0, 3, NULL, NULL, 0, 5, 1, N'MOSES', N'TAVAKONZA', 1, 1, 63, N'49 MELFORT PARK ', N'', NULL, NULL, NULL, N'', N'49 MELFORT PARK ', 1, 2, 1, N'0714166183', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5209, N'HCBD16F30026', N'PANASHE', N'', N'NYAGUMBO', CAST(0xA48F0000 AS SmallDateTime), CAST(0x8F010000 AS SmallDateTime), NULL, N'', 2, NULL, N'6 CAMBRIDGE HARARE DRIVE', 1, 8, 9, NULL, NULL, 0, 5, 1, N'MORRIS', N'NYAGUMBO', 7, 1, 192, N'3 MANZIL ROAD MT PLEASANT ', N'', NULL, NULL, NULL, N'', N'3 MANZIL ROAD MT PLEASANT ', 1, 2, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5210, N'HCBD16F30027', N'DION ', N'PANASHE ', N'BOBO', CAST(0xA3B70000 AS SmallDateTime), CAST(0x9D070000 AS SmallDateTime), NULL, N'', 2, NULL, N'6 CAMBRIDGE R.D KAMFINSA', 1, 8, 3, NULL, NULL, 0, 5, 3, N'CHARITY', N'BOB0', 2, 3, 2, N'6 CAMBRIDGE R.D KAMFINSA', N'0772772135', NULL, NULL, NULL, N'N/A', N'6 CAMBRIDGE R.D KAMFINSA', 1, 3, 1, N'0772772135', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5212, N'HCBD16F30030D', N'ROYAL ', N'', N'CHINGURURU', CAST(0xA4130000 AS SmallDateTime), CAST(0x899E0000 AS SmallDateTime), NULL, N'', 1, NULL, N'ZRP WARREN PARK', 1, 8, 3, NULL, NULL, 0, 5, 1, N'', N'CHINGURURU', 2, 2, 91, N'ZRP WARREN PARK', N'0775412555', NULL, NULL, NULL, N'', N'ZRP WARREN PARK', 1, 2, 0, N'0775412555', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5217, N'HCBD16F30020D', N'BRENDA ', N'', N'MAKO', CAST(0xA4130000 AS SmallDateTime), CAST(0x90C00000 AS SmallDateTime), NULL, N'', 2, NULL, N'12 HYTH CLOSE SENTOSA ', 0, 8, 3, NULL, NULL, 0, 5, 1, N'TICHAREVA', N'MAKO', 1, 1, 67, N'12 HYTH CLOSE SENTOSA ', N'0772943699', NULL, NULL, NULL, N'12 HYTH CLOSE SENTOSA ', N'12 HYTH CLOSE SENTOSA ', 1, 2, 0, N'0772943699', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5218, N'xxxxxxxxxx', N'xxxxxxxxx', N'xxxxxxxxx', N'xxxxxxxxxxx', CAST(0xA63B0000 AS SmallDateTime), CAST(0xA63B0000 AS SmallDateTime), NULL, N'xxxxxxxx', 1, NULL, N'xxxxxxx', 1, 2, 3, NULL, NULL, 1, 5, 1, N'xxxxxxx', N'xxxxxxx', 3, 1, 18, N'xxxxxxx', N'xxxxxxx', NULL, NULL, NULL, N'xxxxxxxx', N'xxxxxxx', 6, 5, 0, N'xxxxxxxxxxxx', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4321, N'HCBD16F1030D', N'MUNASHE', N'CASSIDY', N'MAKAMBE', CAST(0xA5920000 AS SmallDateTime), CAST(0x91F70000 AS SmallDateTime), NULL, N'', 1, NULL, N'123 MHLANGA RD', 1, 2, 3, NULL, NULL, 0, 5, 1, N'VENGESAI', N'MAKOMBE', 1, 1, 63, N'123 MHLANGA RD MBARE', N'', NULL, NULL, NULL, N'', N'123 MHLANGA RD MBARE', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4322, N'HCBD16F1031D', N'SIMBARASHE', N'', N'KATSAMBO', CAST(0xA5920000 AS SmallDateTime), CAST(0x90AA0000 AS SmallDateTime), NULL, N'', 1, NULL, N'2653 SOUTHLEA PARK', 1, 2, 3, NULL, NULL, 0, 5, 1, N'CHIMBETU ', N'KATSAMBO', 1, 1, 182, N'2663 SOUTHLEA PARK', N'0773 390 802', NULL, NULL, NULL, N'', N'2663 SOUTHLEA PARK', 1, 2, 0, N'0773 390 802', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4323, N'HCBD16F1032D', N'PANASHE ', N'PRUDENCE', N'MUKWENA', CAST(0xA5920000 AS SmallDateTime), CAST(0x93520000 AS SmallDateTime), NULL, N'', 2, NULL, N'3842 OLD HIGHFIELDS', 1, 2, 3, NULL, NULL, 0, 5, 1, N'NELIA', N'MUKWENA', 2, 2, 168, N'3842 OLD HIGHFIELDS', N'0776 619 933', NULL, NULL, NULL, N'', N'3842 OLD HIGHFIELDS', 1, 2, 0, N'00776 619 904', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4324, N'HCBD16F1033D', N'MELLISSA', N'JEANINE', N'CHINYANI', CAST(0xA5920000 AS SmallDateTime), CAST(0x93A80000 AS SmallDateTime), NULL, N'', 2, NULL, N'17880 SHAFTSBERRY CLOSE', 1, 2, 3, NULL, NULL, 0, 5, 1, N'SOLDIER', N'CHINYANI', 1, 1, 102, N'17880 SHAFTSBERRY CLOSE', N'0733 677 286', NULL, NULL, NULL, N'', N'17880 SHAFTSBERRY CLOSE', 1, 2, 1, N'0733 677 286', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4325, N'HCBD16F1034D', N'GAMUCHIRAI', N'OWEN', N'HUNDA', CAST(0xA5920000 AS SmallDateTime), CAST(0x92660000 AS SmallDateTime), NULL, N'', 1, NULL, N'15524 7TH CLOSE', 1, 2, 3, NULL, NULL, 0, 5, 1, N'BARNABAS', N'HUNDA', 1, 1, 122, N'15524 7TH CLOSE SUNNINGDALE', N'0777 271 388', NULL, NULL, NULL, N'', N'15524 7TH CLOSE SUNNINGDALE', 1, 2, 0, N'0777 271 388', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4326, N'HCBD16F1035D', N'MARGRET', N'', N'MLAMBO', CAST(0xA5920000 AS SmallDateTime), CAST(0x93D30000 AS SmallDateTime), NULL, N'', 2, NULL, N'5947 MUZHANJE STREET', 1, 2, 3, NULL, NULL, 0, 5, 1, N'MIKE', N'MLAMBO', 1, 1, 126, N'5947 MUZHANJE STREET GLENNORAH B', N'0771214455', NULL, NULL, NULL, N'', N'5947 MUZHANJE STREET GLENNORAH B', 1, 2, 0, N'0771214455', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4327, N'HCBD16F1036D', N'GARAIMUNASHE', N'', N'MARINDIRE', CAST(0xA5920000 AS SmallDateTime), CAST(0x8BB30000 AS SmallDateTime), NULL, N'', 1, NULL, N'15297 MATIZA RD SUNNINGDALE', 1, 2, 3, NULL, NULL, 0, 5, 1, N'ELIAS', N'MARINDIRE', 1, 1, 100, N'15297 MATIZA RD SUNNINGDALE ', N'0772 697 518', NULL, NULL, NULL, N'', N'15297 MATIZA RD SUNNINGDALE ', 1, 2, 0, N'0772 697 518', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4328, N'HCBD16F2001D', N'ASKLEY', N'', N'DHOBHANI', CAST(0xA4130000 AS SmallDateTime), CAST(0x913D0000 AS SmallDateTime), NULL, N'', 2, NULL, N'5527  NKWISI GARDENS', 1, 5, 3, NULL, NULL, 0, 5, 4, N'C', N'TAPFUMANEYI', 7, 2, 165, N'5527 NKWISI GARDEN', N'0772 279 131', NULL, NULL, NULL, N'', N'5527 NKWISI GARDEN', 1, 2, 1, N'0772 279 131', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4329, N'HCBD16F2002D', N'LAVENDAH', N'', N'DOMA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8FB70000 AS SmallDateTime), NULL, N'', 2, NULL, N'1412 SUGAR BUST', 1, 5, 3, NULL, NULL, 0, 5, 1, N'M', N'CHISANGO', 4, 2, 110, N'1412 SUGAR BUST', N'0715 692 886', NULL, NULL, NULL, N'', N'1412 SUGAR BUST', 1, 2, 0, N'0715 692 886', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4330, N'HCBD16F2003D', N'TANYARADZWA ', N'', N'HOZHERE', CAST(0xA4970000 AS SmallDateTime), CAST(0x901F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'47 MEANDER MBARE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'C', N'HOZHERE', 1, 1, 100, N'47 MEANDER', N'', NULL, NULL, NULL, N'', N'47 MEANDER', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4331, N'HCBD16F30046D', N'PRECIOUS', N'', N'HOVE', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8F670000 AS SmallDateTime), NULL, N'', 2, NULL, N'11327 COLD COMFORT', 1, 7, 0, NULL, NULL, 0, 5, 1, N'ALICE', N'HOVE', 2, 2, 89, N'11327 COLD COMFORT', N'0773709920', NULL, NULL, NULL, N'', N'11327 COLD COMFORT', 1, 2, 0, N'0773709920', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4332, N'HCBD16F2004D', N'TINAYEISHE', N'GRACE', N'JENA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90820000 AS SmallDateTime), NULL, N'', 2, NULL, N'18 CANNOCK RD', 1, 5, 3, NULL, NULL, 0, 5, 1, N'B', N'JENA', 1, 1, 165, N'18 CANNOCK RD', N'', NULL, NULL, NULL, N'', N'18 CANNOCK RD', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4333, N'HCBD16F2005D', N'REBBECA', N'', N'MASEYA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8DEC0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2189 HIGHRISE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'R', N'MAZIWE', 1, 1, 165, N'2189 HIGHRISE', N'0733 705 778', NULL, NULL, NULL, N'', N'2189 HIGHRISE', 1, 2, 0, N'0733 705 778', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4334, N'HCBD16F30047D', N'LEONIE', N'ASHLY', N'MLAMBO', CAST(0xA2A60000 AS SmallDateTime), CAST(0x90F50000 AS SmallDateTime), NULL, N'', 2, NULL, N'3734 CRESCENT', 1, 7, 0, NULL, NULL, 0, 5, 1, N'ERICK ', N'MLAMBO', 1, 1, 107, N'3734 CRESCENT', N'0773709920', NULL, NULL, NULL, N'', N'3734 CRESCENT', 1, 1, 1, N'0733754481', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4335, N'HCBD16F2006D', N'ELSIE', N'VHENEKERAI', N'NGWERUME', CAST(0xA4940000 AS SmallDateTime), CAST(0x92D10000 AS SmallDateTime), NULL, N'', 2, NULL, N'30337 MAINWAY MEADOWS', 1, 5, 3, NULL, NULL, 0, 5, 1, N'A', N'NGWERUME', 1, 1, 180, N'30337 MAINWAY MEADOWS', N'0772 242 464', NULL, NULL, NULL, N'', N'30337 MAINWAY MEADOWS', 1, 2, 0, N'0772 542 464', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4336, N'HCBD16F2007D', N'SHANDIRAI', N'SHANTEL', N'RWIZI', CAST(0xA4130000 AS SmallDateTime), CAST(0x91B30000 AS SmallDateTime), NULL, N'', 2, NULL, N'ZRP RHODESVILLE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'J', N'RWIZI', 1, 1, 132, N'ZRP RHODESVILLE', N'0772 326 450', NULL, NULL, NULL, N'', N'ZRP RHODESVILLE', 1, 2, 0, N'0777 326 450', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4337, N'HCBD16F2008D', N'SATI', N'', N'SHAMISO', CAST(0xA4130000 AS SmallDateTime), CAST(0x915A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'1 NHEMA', 1, 5, 3, NULL, NULL, 0, 5, 1, N'S', N'GUTSA', 6, 2, 165, N'1 NHEMA', N'0772 296 270', NULL, NULL, NULL, N'', N'1 NHEMA', 1, 2, 0, N'0772 296 270', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4338, N'HCBD16F2009', N'MEMORY', N'', N'TEMBO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B060000 AS SmallDateTime), NULL, N'', 2, NULL, N'1778 15TH RD', 1, 5, 3, NULL, NULL, 0, 5, 4, N'P', N'GOMO', 4, 2, 165, N'1778 15TH RD', N'', NULL, NULL, NULL, N'', N'1778 15TH RD', 1, 2, 0, N'0772 408 105', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4339, N'HCBD16F2009D', N'MEMORY', N'', N'TEMBO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B060000 AS SmallDateTime), NULL, N'', 2, NULL, N'1778 15TH RD', 1, 5, 3, NULL, NULL, 0, 5, 4, N'P', N'GOMO', 4, 2, 165, N'1778 15TH RD', N'', NULL, NULL, NULL, N'', N'1778 15TH RD', 1, 2, 0, N'0772 408 105', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4340, N'HCBD16F2010D', N'OSCA', N'', N'MAJONI', CAST(0xA4130000 AS SmallDateTime), CAST(0x90870000 AS SmallDateTime), NULL, N'', 1, NULL, N'373', 1, 5, 3, NULL, NULL, 0, 5, 1, N'W', N'MAJONI', 1, 1, 165, N'373', N'0772 359 535', NULL, NULL, NULL, N'', N'373', 1, 1, 0, N'0772 359 535', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4341, N'HCBD16F30048D', N'RATIDZAI', N' DEFINE', N'TARANGENYI', CAST(0xA2A60000 AS SmallDateTime), CAST(0x90910000 AS SmallDateTime), NULL, N'', 2, NULL, N'13269 8TH CLOSE', 1, 7, 3, NULL, NULL, 0, 5, 1, N'RISHON', N'TARANGENYI', 1, 1, 0, N'13269 8TH CLOSE', N'', NULL, NULL, NULL, N'', N'13269 8TH CLOSE', 1, 2, 0, N'0777871133', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4342, N'HCBD16F2012D', N'SHARON', N'NATASHA', N'BUZUZU', CAST(0xA5920000 AS SmallDateTime), CAST(0x8EF10000 AS SmallDateTime), NULL, N'', 2, NULL, N'00', 1, 5, 3, NULL, NULL, 0, 5, 1, N'L.S', N'BUZUZU', 7, 2, 165, N'00', N'0733 038399', NULL, NULL, NULL, N'', N'00', 1, 2, 0, N'0730383927', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5211, N'HCBD16F30028', N'LYNET', N'', N'MASIYENYAMA', CAST(0xA4020000 AS SmallDateTime), CAST(0x90B60000 AS SmallDateTime), NULL, N'', 2, NULL, N'', 1, 8, 5, NULL, NULL, 0, 5, 1, N'JOHNES', N'MASIYENYAMA', 1, 1, 165, N'14695 ZENGEZA 3 CHITUNGWIZA ', N'', NULL, NULL, NULL, N'', N'14695 ZENGEZA 3 CHITUNGWIZA ', 1, 2, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5213, N'HCBD16F30031D', N'KUDZAI ', N'MATTHEW ', N'MAKAMBA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8F130000 AS SmallDateTime), NULL, N'', 1, NULL, N'HARARE HIGHLANDS', 1, 8, 3, NULL, NULL, 0, 5, 1, N'N/A', N'MTEMBA', 1, 1, 96, N'HARARE HIGHLANDS', N'0779570709', NULL, NULL, NULL, N'N/A', N'HARARE HIGHLANDS', 1, 2, 0, N'0779570709', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5214, N'HCBD16F30032', N'MUNASHE', N'THABO', N'CHIMEDZA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8FAB0000 AS SmallDateTime), NULL, N'', 1, NULL, N'HARARE AVENUES', 1, 8, 3, NULL, NULL, 0, 5, 1, N'', N'CHIMEDZA', 2, 3, 1, N'HARARE AVENUES', N'0779565571', NULL, NULL, NULL, N'', N'HARARE AVENUES', 1, 1, 0, N'0779565571', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5215, N'HCBD16F30033', N'DELIGHT', N'ANESU', N'MUZUNGU', CAST(0xA5920000 AS SmallDateTime), CAST(0x8F1D0000 AS SmallDateTime), NULL, N'', 1, NULL, N'2342 HARARE WATERFALLS', 1, 8, 3, NULL, NULL, 0, 5, 1, N'MOCKWELL', N'MUZUNGU', 1, 1, 100, N'2342 HARARE WATERFALLS', N'', NULL, NULL, NULL, N'', N'2342 HARARE WATERFALLS', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (5216, N'HCBD16F30034', N'RODRICK', N'TAKUNDA', N'KAMWARA', CAST(0xA5910000 AS SmallDateTime), CAST(0x90950000 AS SmallDateTime), NULL, N'', 1, NULL, N'15 NHUTA CLOSE', 1, 8, 0, NULL, NULL, 0, 5, 1, N'', N'KAMWARA', 1, 1, 100, N'15 NHUTA CLOSE', N'0772134789', NULL, NULL, NULL, N'N/A', N'15 NHUTA CLOSE', 1, 2, 0, N'0772134780', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4240, N'HCBD16F4001D', N'FAITH', N'N/A', N'MAZINGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8EBE0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'2381 PALLAND VALLEY CLOSE', 1, 13, 3, NULL, NULL, 0, 5, 1, N'NEDDY', N'MAZINGA', 1, 1, 63, N'2381 PALLAND VALLEY CLOSE', N'0714106778', NULL, NULL, NULL, N'N/A', N'2381 PALLAND VALLEY CLOSE', 1, 2, 0, N'0714706778', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4243, N'HCBD16F4004D', N'TATENDA', N'SAMARAYI', N'MABEZA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8DBB0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'7505 DAWNVIEW', 1, 13, 0, NULL, NULL, 0, 5, 1, N'REJOICE', N'MABEZA', 2, 2, 166, N'7505 DAWNVIEW PARK
KUWADZANA', N'0774630575', NULL, NULL, NULL, N'N/A', N'7505 DAWNVIEW PARK
KUWADZANA', 1, 1, 0, N'0774630575', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4244, N'HCBD16F4005D', N'VIOLET', N'ANNASTACIA', N'TSOKO', CAST(0xA4130000 AS SmallDateTime), CAST(0x81C20000 AS SmallDateTime), NULL, N'47-181114 T 47', 2, NULL, N'7 DEON SERMONS
AVENUE', 1, 13, 3, NULL, NULL, 0, 5, 4, N'STEWART', N'KANOTUNGA', 3, 1, 20, N'7 DEON SERMONS
AVENUE
HILLSIDE', N'0772388868', NULL, NULL, NULL, N'N/A', N'7 DEON SERMONS
AVENUE
HILLSIDE', 1, 2, 0, N'0776449901', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4245, N'HCBD16F4006D', N'SITHABILE', N'NATASHA', N'KAMBA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B860000 AS SmallDateTime), NULL, N'29-308780 T 47', 2, NULL, N'39 WOODHALL ROAD
MALBOROUGH', 1, 13, 0, NULL, NULL, 0, 5, 2, N'MARVIN', N'GUBA', 3, 1, 18, N'39 WOODHALL ROAD
MALBOROUGH', N'0772388868', NULL, NULL, NULL, N'N/A', N'39 WOODHALL ROAD
MALBOROUGH', 1, 2, 0, N'0776440808', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4247, N'HCBD16F4008D', N'RUTENDO', N'MERCY', N'CHIKADZINGWA', CAST(0xA1740000 AS SmallDateTime), CAST(0x8E980000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'1332/174 CLOSE', 1, 13, 3, NULL, NULL, 0, 5, 1, N'OBERT', N'CHIKADZINGWA', 1, 1, 110, N'1332/174 CLOSE
BUDIRIRO', N'N/A', NULL, NULL, NULL, N'N/A', N'1332/174 CLOSE
BUDIRIRO', 1, 2, 0, N'0734585966', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4253, N'HCBD16F60099D', N'CHRISTOPHER', N'', N'GANDIZHE', CAST(0xA4130000 AS SmallDateTime), CAST(0x89750000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'19/13TH AVENUE WARREN PARK', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ONISMO', N'GANDIZHE', 1, 1, 58, N'19/13TH AVENUE WARREN PARK', N'0772264962', NULL, NULL, NULL, N'', N'19/13TH AVENUE WARREN PARK', 1, 2, 0, N'0779497376', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4256, N'HCBD16F600102', N'SEAN ', N'', N'MACHINGURA ', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A070000 AS SmallDateTime), NULL, N'63-2004N25', 1, NULL, N'56 WALLIS ROAD MANDARA', 1, 22, 3, NULL, NULL, 0, 5, 1, N'PATRICIA', N'JONGA', 2, 2, 181, N'56 WALLIS ROAD MANDARA ', N'0772332017', NULL, NULL, NULL, N'N/A', N'56 WALLIS ROAD MANDARA ', 1, 2, 1, N'0771769970', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4259, N'HCBD16F600105', N'TINODIWA ', N'', N'TAGUMA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CB20000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'45 STREET BUDIRIRO ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'DORCAS ', N'TAGUMA', 2, 3, 53, N'45 STREET BUDIRIRO ', N'0736794939', NULL, NULL, NULL, N'', N'45 STREET BUDIRIRO ', 1, 4, 0, N'0733042951', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4260, N'HCBD16F600106', N'MICHAEL', N'', N'MAWOKOMAYI ', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BB30000 AS SmallDateTime), NULL, N'63-2328174G43', 1, NULL, N'1613 ZINYENGERE EPWORTH', 1, 22, 3, NULL, NULL, 0, 5, 1, N'TAURAI ', N'HWETE', 2, 2, 90, N'1613 ZINYENGERE EPWORTH', N'0738004989', NULL, NULL, NULL, N'N/A', N'1613 ZINYENGERE EPWORTH', 2, 2, 0, N'0718791775', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4261, N'HCBD16F60025D', N'DELIA', N'', N'KAMBUNDA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8C140000 AS SmallDateTime), NULL, N'', 2, NULL, N'38 TYREL STREET ', 1, 0, 17, NULL, NULL, 0, 5, 1, N'NOREEN ', N'MEMO', 4, 3, 165, N'38 TYREL STREET', N'0778845576', NULL, NULL, NULL, N'', N'38 TYREL STREET', 1, 2, 0, N'0778845576', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4271, N'HCBD16F60031D', N'RUTENDO', N'MITCHELL', N'CHITSONGA', CAST(0xA2C50000 AS SmallDateTime), CAST(0x8D220000 AS SmallDateTime), NULL, N'', 2, NULL, N'17869 SHAFTESBURY CLOSE ', 1, 21, 3, NULL, NULL, 0, 5, 1, N'GRACE ', N'CHITSONGA', 2, 2, 166, N'17869 SHAFTESBURY CLOSE ', N'0772460727', NULL, NULL, NULL, N'', N'17869 SHAFTESBURY CLOSE ', 1, 2, 0, N'0772460727', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4272, N'HCBD16F600111', N'ADOLPH', N'', N'MAWOYO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C6F0000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'1613 HATCLIFF 1', 1, 0, 3, NULL, NULL, 0, 5, 1, N'MEMORY ', N'KUZANGA', 2, 2, 0, N'1613 HATCLIFF 1', N'0772227019', NULL, NULL, NULL, N'N/A', N'1613 HATCLIFF 1', 1, 2, 0, N'0773040432', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4273, N'HCBD16F600112', N'KUMBIRAI', N'', N'TARANGIRENYI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C2F0000 AS SmallDateTime), NULL, N'', 1, NULL, N'1167 SALLY MUGABE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'PHILDA', N'KANYEMBA', 2, 2, 90, N'1167 SALLY MUGABE', N'0775806245', NULL, NULL, NULL, N'N/A', N'1167 SALLY MUGABE', 1, 2, 0, N'0777871133', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4274, N'HCBD16F600113', N'PROSPER ', N'', N'KAMBATE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C950000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'3700 SOUTH GATE HARARE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'FANUEL', N'KAMBATE', 1, 1, 165, N'3700 SOUTH GATE HARARE', N'0772854314', NULL, NULL, NULL, N'N/A', N'3700 SOUTH GATE HARARE', 1, 2, 0, N'0775267258', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4275, N'HCBD16F60032D', N'IYVE ', N'MITCHELL', N'MUCHWA ', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8C1F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'72/2 NATIONAL DEFENCE COLLEGE ', 1, 21, 3, NULL, NULL, 0, 5, 1, N'PHILPE ', N'MUCHWA', 1, 1, 173, N'72/NATIONAL DEFENCE OLLEGE', N'0772835540', NULL, NULL, NULL, N'', N'72/NATIONAL DEFENCE OLLEGE', 1, 2, 1, N'0772835540', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4276, N'HCBD16F60033D ', N'PRIVILEDGE', N'RUTENDO', N'DEKA ', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8AF20000 AS SmallDateTime), NULL, N'', 2, NULL, N'14713 DAMAFALLS', 1, 21, 3, NULL, NULL, 0, 5, 1, N'FLORANCE', N'BARWE', 2, 2, 113, N'14713 DAMAFALLS ', N'0774060857', NULL, NULL, NULL, N'', N'14713 DAMAFALLS ', 1, 2, 0, N'0783124813', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4277, N'HCBD16F600114', N'MAKOMBORERO', N'', N'SONGORA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C130000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'290 COPSHAW ROAD ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ANNA', N'SONGORA', 2, 2, 165, N'290 COPSHAW ROAD ', N'0772405334', NULL, NULL, NULL, N'N/A', N'290 COPSHAW ROAD ', 1, 2, 0, N'0784432409', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4241, N'HCBD16F4002D', N'YVONE', N'N/A', N'MAKAHA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CAA0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'660 GWANDA CRESCENT
DAMAFALLS', 1, 13, 3, NULL, NULL, 0, 5, 1, N'TENDAI', N'MAKAHA', 1, 1, 48, N'660 GWANDA CRESCENT, DAMAFALLS', N'0773995327', NULL, NULL, NULL, N'N/A', N'660 GWANDA CRESCENT, DAMAFALLS', 1, 2, 0, N'0775969456', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4246, N'HCBD16F4007D', N'STORM', N'N/A', N'MUZHEKI', CAST(0xA4970000 AS SmallDateTime), CAST(0x8BB10000 AS SmallDateTime), NULL, N'27-234613P27', 2, NULL, N'28 LEEROUX DRIVE', 1, 13, 3, NULL, NULL, 0, 5, 1, N'FARAI', N'MUTSAMWIRA', 5, 1, 20, N'28 LEEROUX DRIVE
HILLSIDE', N'0772116719', NULL, NULL, NULL, N'faraim@mmbz.co', N'28 LEEROUX DRIVE
HILLSIDE', 1, 2, 0, N'0772116719', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4249, N'HCBD16F60024D', N'GUGULETHU', N'', N'ZINYANE', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8B1C0000 AS SmallDateTime), NULL, N'', 2, NULL, N'NATIONAL DEFENCE COLLEGE', 1, 21, 3, NULL, NULL, 0, 5, 1, N'TAPIWA ', N'ZINYANE', 2, 2, 165, N'21A NATIONAL DEFENCE COLLEGE', N'0773701337', NULL, NULL, NULL, N'', N'21A NATIONAL DEFENCE COLLEGE', 1, 2, 0, N'0782987466', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4250, N'HCBD16F60096D', N'BLESSING', N'', N'KWALAMBA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A8E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'16 GREENDALE AVENUE HARARE', 1, 0, 3, NULL, NULL, 0, 5, 1, N'ANNA', N'SIXPENCE', 2, 2, 90, N'16 GREENDALE AVENUE HARARE', N'0773624811', NULL, NULL, NULL, N'N/A', N'16 GREENDALE AVENUE HARARE', 1, 2, 0, N'0773624811', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4251, N'HCBD16F60097', N'LORRAINE', N'', N'KWASHIRAI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CC50000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'8 SHERWOOD ROAD MALBEREIGHN', 1, 0, 3, NULL, NULL, 0, 5, 1, N'CHIPO', N'KANGALISANI', 2, 2, 90, N'8 SHERWOOD ROAD MALBEREIGHN', N'0772590680', NULL, NULL, NULL, N'N/A', N'8 SHERWOOD ROAD MALBEREIGHN', 1, 2, 0, N'0783151424', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4252, N'HCBD16F60098', N'PHELINDA', N'', N'MARUFU', CAST(0xA4130000 AS SmallDateTime), CAST(0x8AC50000 AS SmallDateTime), NULL, N'', 2, NULL, N'1094 KUWADZANA PHASE 3', 1, 0, 3, NULL, NULL, 0, 5, 1, N'VIOLET ', N'MARUFU', 2, 2, 90, N'1094 KUWADZANA PHASE 3 ', N'0773993810', NULL, NULL, NULL, N'N/A', N'1094 KUWADZANA PHASE 3 ', 1, 2, 0, N'0775968897', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4254, N'HCBD16F600100D', N'KUDAKWASHE ', N'', N'RANGADZVA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C790000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'47 CAMCKERE DRIVE BORROWDALE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'KAINOS', N'RANGADZVA', 1, 1, 27, N'47 CAMCKERE DRIVE BORROWDALE', N'0774128244', NULL, NULL, NULL, N'N/A', N'47 CAMCKERE DRIVE BORROWDALE', 1, 2, 0, N'0777137174', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4255, N'HCBD16F600101', N'LENON', N'', N'TIGERE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B7F0000 AS SmallDateTime), NULL, N'472002466H47', 1, NULL, N'93 ENTERPRISE ROAD HIGHLANDS', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ALLEN ', N'TIGERE', 1, 1, 67, N'93 ENTERPRISE ROAD HIGHLANDS', N'0772405834', NULL, NULL, NULL, N'N/A', N'93 ENTERPRISE ROAD HIGHLANDS', 1, 2, 1, N'0733662590', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4257, N'HCBD16F600103', N'NIGEL ', N'', N'BANDA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A440000 AS SmallDateTime), NULL, N'63-2046385D63', 1, NULL, N'2689 NJIVA ROAD ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'SHINGIRAI', N'BANDA', 1, 1, 67, N'2689 NJIVA ROAD ', N'0772341919', NULL, NULL, NULL, N'N/A', N'2689 NJIVA ROAD ', 1, 2, 0, N'0777109463', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4258, N'HCBD16F600104', N'MUGOVE', N'', N'RURANGO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8AE70000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'8 PASCO AVENUE BELGRAVIA ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'RODGERS ', N'RURANGO', 1, 1, 153, N'8 PASCO AVENUE BELGRAVIA', N'0774166427', NULL, NULL, NULL, N'N/A', N'8 PASCO AVENUE BELGRAVIA', 1, 2, 0, N'0733808470', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4262, N'HCBD16F60026D', N'RUVIMBO', N'CHARMAINE', N'CHANJAYANI', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8BF70000 AS SmallDateTime), NULL, N'', 2, NULL, N'358 HARARE DRIVE ', 1, 21, 3, NULL, NULL, 0, 5, 1, N'SAVIOUR ', N'SHANJAYANI', 2, 2, 165, N'358 HARARE DRIVE ', N'07762149876', NULL, NULL, NULL, N'', N'358 HARARE DRIVE ', 1, 2, 0, N'0776214987', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4263, N'HCBD16F600107', N'PRISCILAH', N'', N'CHIRENDA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B9F0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'L131TG CHIKWIRI ROAD ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'DIANA', N'CHIRENDA', 2, 2, 181, N'L131TG CHIKWIRI ROAD ', N'0772128966', NULL, NULL, NULL, N'N/A', N'L131TG CHIKWIRI ROAD ', 1, 2, 0, N'0779093501', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4264, N'HCBD16F60027D', N'ANNABELL', N'VERONICA ', N'MUROVE', CAST(0xA42F0000 AS SmallDateTime), CAST(0x88FE0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2303 MSASA ROAD NEW MARLBOROUGH ', 1, 21, 3, NULL, NULL, 0, 5, 1, N'STANCE', N'GWAKA', 2, 2, 165, N'358 HARARE DRIVE BORROWDALE ', N'0779292457', NULL, NULL, NULL, N'', N'358 HARARE DRIVE BORROWDALE ', 2, 2, 0, N'0779292457', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4278, N'HCBD16F600115', N'PRECIOUS', N'', N'MUSUKUTWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x89C10000 AS SmallDateTime), NULL, N'', 2, NULL, N'14203 DAMA FALLS PHASE 1', 1, 22, 3, NULL, NULL, 0, 5, 1, N'BLESSING', N'MUSUKUTWA', 0, 1, 67, N'14203 DAMA FALLS PHASE 1', N'0776881264', NULL, NULL, NULL, N'N/A', N'14203 DAMA FALLS PHASE 1', 1, 2, 0, N'0777950445', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4383, N'HCBD16F2048D', N'GERALD', N'TANATSWA', N'CHITSONGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x91280000 AS SmallDateTime), NULL, N'', 1, NULL, N'SHAFTSBURY', 1, 4, 3, NULL, NULL, 0, 5, 1, N'GRACE', N'CHITSONGA', 2, 1, 162, N'17869 SHAFTSBURRY CRANBOURNE', N'0772 460 727', NULL, NULL, NULL, N'', N'17869 SHAFTSBURRY CRANBOURNE', 1, 2, 0, N'0772460727', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4384, N'HCBD16F2049D', N'TATENDA', N'SIMBA', N'MAKOMBE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8FC70000 AS SmallDateTime), NULL, N'', 1, NULL, N'2/24 B FORBS', 1, 4, 3, NULL, NULL, 0, 5, 1, N'LANGTON', N'MAKOMBE', 1, 1, 100, N'2/24 B/FORBES WATERFALLS', N'0773 870 759', NULL, NULL, NULL, N'', N'2/24 B/FORBES WATERFALLS', 1, 2, 0, N'0773 870 759', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4385, N'HCBD16F2050D', N' TRUST', N'', N'MUKUNDWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x91690000 AS SmallDateTime), NULL, N'', 1, NULL, N'16012 SUNNINGDALE 2', 1, 4, 3, NULL, NULL, 0, 5, 2, N'JUSTICE', N'MUKUNDWA', 1, 1, 100, N'16012 SUNNINGDALE 2', N'00', NULL, NULL, NULL, N'', N'16012 SUNNINGDALE 2', 1, 2, 0, N'00', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4386, N'HCBD16F2051D', N'STUART', N'', N'MANYAMBA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90640000 AS SmallDateTime), NULL, N'', 1, NULL, N'83 CHISHAWASHA HILLS', 1, 4, 3, NULL, NULL, 0, 5, 1, N'MARY', N'MANYAMBA', 4, 2, 134, N'83 CHISHAWASHA HILLS', N'0776 173 474', NULL, NULL, NULL, N'', N'83 CHISHAWASHA HILLS', 1, 2, 0, N'0776 173 747', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4387, N'HCBD16F2052D', N'SIMBARASHE', N'', N'SCOPE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8E9E0000 AS SmallDateTime), NULL, N'', 1, NULL, N'2 EAGLE WAY', 1, 4, 3, NULL, NULL, 0, 5, 1, N'SANDRA', N'SCOPE', 2, 2, 134, N'2 EAGLE WAY MT PLEASANT', N'0773 670 254', NULL, NULL, NULL, N'', N'2 EAGLE WAY MT PLEASANT', 1, 2, 0, N'0773 670 254', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4388, N'HCBD16F2053D', N'KUNDAI', N'BRENDON', N'SIYAMYANWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x908F0000 AS SmallDateTime), NULL, N'63-2533667-T-63', 1, NULL, N'7TH CLOSE', 1, 4, 3, NULL, NULL, 0, 5, 1, N'FANUEL', N'SIYANYANWA', 1, 1, 157, N'15192 7TH CLOSE SUNNINGDALE', N'0778564889', NULL, NULL, NULL, N'', N'15192 7TH CLOSE SUNNINGDALE', 1, 2, 0, N'0778 564 889', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4391, N'HCBD16F600120D', N'SAMVURA ', N'', N'STEPHANIE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BE70000 AS SmallDateTime), NULL, N'63-2042122F05', 2, NULL, N'1082 NYAMANDE CLOSE', 0, 22, 3, NULL, NULL, 0, 5, 1, N'EDSON', N'SAMVURA', 1, 1, 0, N'1082 NYAMANDE CLOSE', N'0772246185', NULL, NULL, NULL, N'1082 NYAMANDE CLOSE', N'1082 NYAMANDE CLOSE', 1, 2, 1, N'0777266425', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4392, N'HCBD16F600121D', N'TANAKA', N'', N'MUTEMAJIRI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B0B0000 AS SmallDateTime), NULL, N'63-2303824P80', 2, NULL, N'822 MAINWAY MEADOWS', 1, 22, 3, NULL, NULL, 0, 5, 1, N'TAPIWA', N'MUTEMAJIRI', 1, 1, 2, N'822 MAINWAY MEADOWS', N'0783947174', NULL, NULL, NULL, N'N/A', N'822 MAINWAY MEADOWS', 1, 2, 0, N'0775705905', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4393, N'HCBD16F600122D', N'WAVEE', N'', N'NYAMBUYA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A9B0000 AS SmallDateTime), NULL, N'', 2, NULL, N'894 MANRESA PARK', 0, 22, 3, NULL, NULL, 0, 5, 1, N'SHAKEMORE', N'NYAMBUYA', 1, 1, 2, N'894 MANRESA PARK', N'0773299074', NULL, NULL, NULL, N'', N'894 MANRESA PARK', 1, 2, 0, N'0773299074', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4394, N'HCBD16F600123D', N'ALBERT', N'', N'MADANHIRE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BC20000 AS SmallDateTime), NULL, N'63-2147389B04', 1, NULL, N'2322 MAINWAY MEADOWS', 1, 22, 3, NULL, NULL, 0, 5, 1, N'MONIQUE', N'MADANHIRE', 2, 2, 187, N'2322 MAINWAY MEADOWS', N'0772442342', NULL, NULL, NULL, N'', N'2322 MAINWAY MEADOWS', 1, 2, 0, N'0736298080', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4395, N'HCBD16F600124D', N'TAPIWA', N'', N'GAVHERA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8E510000 AS SmallDateTime), NULL, N'', 1, NULL, N'8775 GLENNORAH C', 1, 22, 3, NULL, NULL, 0, 5, 1, N'PRECIOUS ', N'MAKWARA', 2, 2, 87, N'8775 GLENNORAH C', N'0773295617', NULL, NULL, NULL, N'', N'8775 GLENNORAH C', 1, 2, 0, N'0733044991', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4396, N'HCBD16F600125D', N'WENDY', N'', N'BIZEKI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B7A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'8903 UNIT K SEKE CHITUNGWIZA', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ENOCH', N'BIZEKI', 0, 1, 63, N'8903 UNIT K SEKE CHITUNGWIZA', N'0772364095', NULL, NULL, NULL, N'N/A', N'8903 UNIT K SEKE CHITUNGWIZA', 1, 2, 0, N'0771534333', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4397, N'HCBD16F600126D', N'NELSON', N'', N'MAFOPE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A6D0000 AS SmallDateTime), NULL, N'63-2500156T63', 1, NULL, N'667 SEKE R.D HATFIELD ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'THOMAS', N'MAFOPE', 0, 1, 100, N'667 SEKE R.D HATFIELD ', N'0772281004', NULL, NULL, NULL, N'', N'667 SEKE R.D HATFIELD ', 1, 2, 0, N'0773095077', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4398, N'HCBD16F600127D', N'NIGEL', N'', N'CHANGATO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CCE0000 AS SmallDateTime), NULL, N'', 1, NULL, N'7662 BUDIRIRO 4 ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'SIMBA', N'CHANGATO', 1, 1, 2, N'7662 BUDIRIRO 4', N'0773266037', NULL, NULL, NULL, N'N/A', N'7662 BUDIRIRO 4', 1, 2, 0, N'0772479213', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4399, N'HCBD16F600128D', N'TATENDA', N'', N'TAFIRENYIKA', CAST(0xA4130000 AS SmallDateTime), CAST(0x86A10000 AS SmallDateTime), NULL, N'', 1, NULL, N'5 CYPRUS R.D ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'SPIWE ', N'TAFIRENYIKA ', 2, 2, 162, N'5 CYPRUS R.D', N'0772331988', NULL, NULL, NULL, N'N/A', N'5 CYPRUS R.D', 1, 2, 0, N'0775295833', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4400, N'HCBD16F600129D', N'HILARY', N'', N'MHAKA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A1B0000 AS SmallDateTime), NULL, N'63-2797053H71', 1, NULL, N'7 LYNTON DRIVE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'GAMUCHIRAI ', N'MHAKA', 2, 2, 90, N'7 LYNTON DRIVE ', N'0779198490', NULL, NULL, NULL, N'N/A', N'7 LYNTON DRIVE ', 1, 2, 0, N'0774852797', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4401, N'HCBD16F600130D', N'RAPHEL', N'', N'GWANZURA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B450000 AS SmallDateTime), NULL, N'', 1, NULL, N'19 MARLVIN R.D ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'RONALD', N'GWANZURA', 1, 1, 187, N'19 MARLVIN R.D', N'0772712163', NULL, NULL, NULL, N'', N'19 MARLVIN R.D', 1, 2, 0, N'0733307461', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4402, N'HCBD16F600131D', N'MELISSA', N'', N'CHITEWERE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C970000 AS SmallDateTime), NULL, N'', 2, NULL, N'6796 WESTLEA', 1, 22, 3, NULL, NULL, 0, 5, 1, N'IRVIN ', N'CHITEWERE', 1, 1, 173, N'6796 WESTLEA', N'077954533', NULL, NULL, NULL, N'N/A', N'6796 WESTLEA', 1, 2, 0, N'0782829224', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4403, N'HCBD16F600132D', N'EVER', N'', N'DANI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C810000 AS SmallDateTime), NULL, N'', 2, NULL, N'1083 HATCLIFF', 1, 22, 3, NULL, NULL, 0, 5, 1, N'DANIEL', N'DANI', 1, 1, 27, N'1083 HATCLIFF', N'O772491714', NULL, NULL, NULL, N'N/A', N'1083 HATCLIFF', 1, 2, 0, N'0784467732', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4404, N'HCBD16F600133D', N'BRANDON', N'', N'KUVUTA ', CAST(0xA4130000 AS SmallDateTime), CAST(0x89600000 AS SmallDateTime), NULL, N'', 1, NULL, N'15 COWSHAK R.D', 1, 22, 3, NULL, NULL, 0, 5, 1, N'REDGE', N'KUVUTA', 1, 1, 109, N'15 COWSHAK R.D', N'0773448721', NULL, NULL, NULL, N'N/A', N'15 COWSHAK R.D', 1, 2, 0, N'0773448721', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4405, N'HCBD16F600134D', N'SHEPHERD', N'', N'JASENTO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B1A0000 AS SmallDateTime), NULL, N'', 1, NULL, N'138 CROW HILL ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ALICE ', N'SIMON', 2, 2, 90, N'138 CROW HILL ', N'0777650597', NULL, NULL, NULL, N'N/A', N'138 CROW HILL ', 1, 2, 0, N'0783629563', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4406, N'HCBD16F600135D', N'TEDDY', N'', N'MUTAMBIRWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x897C0000 AS SmallDateTime), NULL, N'', 1, NULL, N'1178 MAINWAY MEADOWS', 1, 22, 3, NULL, NULL, 0, 5, 1, N'STANFORD', N'MUTAMBIRWA', 1, 1, 65, N'1178 MAINWAY MEADOWS', N'0774189404', NULL, NULL, NULL, N'', N'1178 MAINWAY MEADOWS', 1, 2, 0, N'0782470407', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4407, N'HCBD16F600136D', N'MELISSA2', N'', N'MUNEMO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A250000 AS SmallDateTime), NULL, N'', 2, NULL, N'5205 HATCLIFF ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'MONICA ', N'MARINGE', 2, 2, 0, N'5205 HATCLIFF ', N'0777782506', NULL, NULL, NULL, N'N/A', N'5205 HATCLIFF ', 1, 2, 0, N'0779223573', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4408, N'HCBD16F6001376D', N'FARAI', N'', N'KATSIYE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8AFF0000 AS SmallDateTime), NULL, N'', 1, NULL, N'77 ZRP MSASA', 1, 22, 3, NULL, NULL, 0, 5, 1, N'LAIZA', N'MAGIDI ', 2, 2, 118, N'77 ZRP MSASA', N'0777782506', NULL, NULL, NULL, N'N/A', N'77 ZRP MSASA', 1, 2, 1, N'0776803463', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4390, N'HCBD16F2055D', N'SHELLY', N'', N'CHAMUNOGWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90500000 AS SmallDateTime), NULL, N'', 2, NULL, N'11214 SUNNINGDALE 2', 1, 4, 3, NULL, NULL, 0, 5, 1, N'DORICA', N'FUZE', 2, 2, 0, N'11214 SUNNINGDALE 2', N'0713 922 322', NULL, NULL, NULL, N'', N'11214 SUNNINGDALE 2', 1, 2, 0, N'0713 922 332', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4287, N'HCBD16F60039D', N'MELANIA ', N'', N'JONAH', CAST(0x94610000 AS SmallDateTime), CAST(0x8DE20000 AS SmallDateTime), NULL, N'', 2, NULL, N'5 ZAMBEZI', 1, 7, 0, NULL, NULL, 0, 5, 1, N'NETSAI', N'MANYIKA', 6, 2, 131, N'5 ZAMBEZI TOMLISON', N'0772738583', NULL, NULL, NULL, N'', N'5 ZAMBEZI TOMLISON', 1, 1, 1, N'0772738583', NULL, NULL, NULL)
GO
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4423, N'HCBD16F600153D', N'RAPHAEL', N'', N'MUPENDA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A200000 AS SmallDateTime), NULL, N'', 1, NULL, N'64 MUNRO R.D CRANBORNE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'FRANCISCA', N'RENDESAU', 2, 2, 173, N'64 MUNRO R.D CRANBORNE', N'00772404988', NULL, NULL, NULL, N'N/A', N'64 MUNRO R.D CRANBORNE', 1, 2, 0, N'0783525414', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4231, N'HCBD16F3028', N'LYNET', N'', N'MASIYENYAMA', CAST(0xA58E0000 AS SmallDateTime), CAST(0x92230000 AS SmallDateTime), NULL, N'', 2, NULL, N'WATERFALLS RETREAT', 1, 0, 0, NULL, NULL, 0, 5, 1, N'JOHANNES', N'MASIYENYAMA', 1, 1, 0, N'14695 ZENGEZA CHITUNGWIZA', N'', NULL, NULL, NULL, N'', N'14695 ZENGEZA CHITUNGWIZA', 1, 0, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4232, N'HCBD16F3029', N'TRUST', N'TENDAI', N'MAKAMBA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8D730000 AS SmallDateTime), NULL, N'', 1, NULL, N'SALLY MUGABE ', 1, 0, 0, NULL, NULL, 0, 5, 1, N'MAKAMBA', N'MAKAMBA', 2, 0, 99, N'SALLY MUGABE', N'', NULL, NULL, NULL, N'', N'SALLY MUGABE', 1, 2, 0, N'0775412555', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4233, N'HCBD16F3030', N'ROYAL', N'', N'CHINGURURU', CAST(0xA2C50000 AS SmallDateTime), CAST(0x8DE50000 AS SmallDateTime), NULL, N'', 1, NULL, N'WARREN PARK', 1, 0, 0, NULL, NULL, 0, 5, 1, N'CHINGURURU', N'CHINGURURU', 2, 2, 134, N'WARREN PARK', N'0775412553', NULL, NULL, NULL, N'', N'WARREN PARK', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4234, N'HCBD16F3031', N'KUDZAI', N'MATHEW', N'MATEMBA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8F130000 AS SmallDateTime), NULL, N'', 1, NULL, N'HIGHLANDS PACKHAM', 1, 8, 0, NULL, NULL, 0, 5, 1, N'MATEMBA', N'MATEMBA', 1, 1, 96, N'HIGHLANDS PACKHAM', N'00000', NULL, NULL, NULL, N'', N'HIGHLANDS PACKHAM', 1, 1, 0, N'0000', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4235, N'HCBD16F3032', N'MUNASHE', N'', N'CHIMEDZA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8FAB0000 AS SmallDateTime), NULL, N'', 1, NULL, N'AVENUES ', 1, 0, 0, NULL, NULL, 0, 5, 1, N'CHIMEDZA', N'CHIMEDZA', 2, 2, 0, N'AVENUES', N'', NULL, NULL, NULL, N'', N'AVENUES', 1, 1, 0, N'0779565571', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4236, N'HCBD16F3033', N'DELIGHT', N'ANESU', N'MUZUNGU', CAST(0xA5920000 AS SmallDateTime), CAST(0x8F1D0000 AS SmallDateTime), NULL, N'', 1, NULL, N'WATERFALLS', 1, 0, 0, NULL, NULL, 0, 5, 1, N'MOCKWELL', N'MUZUNGU', 1, 2, 100, N'WATERFALLS', N'0772872342', NULL, NULL, NULL, N'', N'WATERFALLS', 1, 2, 1, N'0772872342', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4237, N'HCBD16F3034', N'RODRICK', N'TAKUNDA', N'KOMWARA', CAST(0xA5910000 AS SmallDateTime), CAST(0x90950000 AS SmallDateTime), NULL, N'', 1, NULL, N'15 NHUKA CLOSE MUFAKOSE', 1, 8, 0, NULL, NULL, 0, 5, 1, N'KOMWARA', N'KOMWARA', 1, 1, 100, N'15 NHUKA CLOSE MUFAKOSE', N'0772134789', NULL, NULL, NULL, N'', N'15 NHUKA CLOSE MUFAKOSE', 1, 2, 0, N'0772134780', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4238, N'HCBD16F60023D', N'DIANA', N'BELINDA', N'MUKWINDA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x86F50000 AS SmallDateTime), NULL, N'63-2078551C63', 2, NULL, N'72 CAMBRIDGE', 1, 21, 3, NULL, NULL, 0, 5, 1, N'STEPHEN ', N'MUKWINDA', 1, 1, 165, N'72 CRAMBRIDGE', N'0773983354', NULL, NULL, NULL, N'', N'72 CRAMBRIDGE', 1, 2, 0, N'0782987466', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4239, N'HCBD16F3035', N'PADDINGTON', N'', N'LINTON', CAST(0xA5910000 AS SmallDateTime), CAST(0x90280000 AS SmallDateTime), NULL, N'', 1, NULL, N'MASOTCHA NDLOVU', 1, 8, 0, NULL, NULL, 0, 5, 1, N'CHIVENDE', N'CHIVENDE', 4, 2, 100, N'MASOTCHA NDLOVU', N'0775487242', NULL, NULL, NULL, N'', N'MASOTCHA NDLOVU', 1, 2, 0, N'0775287242', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4242, N'HCBD16F4003D', N'SHANILLAH', N'N/A', N'MARUTA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8D170000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'198 SMUTS ROAD,WATERFALLS', 1, 13, 3, NULL, NULL, 0, 5, 3, N'CHENGETAI', N'MARUTA', 2, 2, 166, N'198 SMUTS ROAD,WATERFALLS', N'0773062456', NULL, NULL, NULL, N'N/A', N'198 SMUTS ROAD,WATERFALLS', 1, 3, 0, N'0774158836', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4248, N'HCBD16F60095D', N'KAYLA', N'NONE', N'MACCULARY', CAST(0xA3F60000 AS SmallDateTime), CAST(0x8AA70000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'30 GLAMIS ROAD HATFIELD HARARE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ISABEL', N'MACCULARY', 2, 3, 162, N'30 GLAMIS ROAD HATFIELD HARARE', N'07333610664', NULL, NULL, NULL, N'N/A', N'30 GLAMIS ROAD HATFIELD HARARE', 1, 4, 0, N'0777092414', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4265, N'HCBD16F60028D', N'NYASHA', N'HEDWICK', N'CHIGUTSA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x89110000 AS SmallDateTime), NULL, N'63-2030729X77', 2, NULL, N'', 1, 21, 3, NULL, NULL, 0, 5, 1, N'PARTRICK', N'CHIGUTSA ', 1, 1, 156, N'ASPINDALE', N'0733376604', NULL, NULL, NULL, N'', N'ASPINDALE', 1, 2, 1, N'0777698825', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4266, N'HCBD16F600108', N'TADIWANASHE', N'', N'KASEKE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BA70000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'1159 SIMON CHINYAMA ROAD UPLANDS', 1, 0, 3, NULL, NULL, 0, 5, 1, N'TIMOTHY', N'KASEKE', 1, 1, 100, N'1159 SIMON CHINYAMA ROAD UPLANDS', N'0772973816', NULL, NULL, NULL, N'N/A', N'1159 SIMON CHINYAMA ROAD UPLANDS', 1, 2, 0, N'0733277774', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4267, N'HCBD16F60029D ', N'VONGAI', N'', N'CHIPUNZA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8AAE0000 AS SmallDateTime), NULL, N'', 2, NULL, N'497 CARRICK CREAGH HELENSVALE', 1, 21, 3, NULL, NULL, 0, 5, 1, N'ALFAS ', N'CHIPUNZA', 1, 1, 94, N'497 CARRICK CREAGH HELESVALE', N'0772806436', NULL, NULL, NULL, N'', N'497 CARRICK CREAGH HELESVALE', 1, 1, 0, N'0773291153', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4268, N'HCBD16F600109', N'PRIVILEDGE', N'', N'MANHOMBO ', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A030000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'11 HWATA MUFAKOSE ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'GEORGE ', N'MANHOMBO ', 1, 1, 67, N'11 HWATA MUFAKOSE ', N'0775509001', NULL, NULL, NULL, N'N/A', N'11 HWATA MUFAKOSE ', 1, 2, 0, N'0771424353', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4269, N'HCBD16F60030D', N'BUHLEBENKOSI ', N'LINDA', N'NKALA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8B210000 AS SmallDateTime), NULL, N'', 2, NULL, N'15 ADINGTON LANE BORROWDALE ', 1, 21, 3, NULL, NULL, 0, 5, 1, N'LISIWE', N'NCUBE', 2, 2, 166, N'15 ADINGTON LANE BORROWDALE ', N'0772938346', NULL, NULL, NULL, N'', N'15 ADINGTON LANE BORROWDALE ', 1, 2, 0, N'0774362047', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4270, N'HCBD16F600110', N'JOYLEEN', N'', N'MAPONGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B8A0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'10 MORTMA CLOSE CHISIPITE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ELIZABETH', N'MURWIRA', 2, 2, 119, N'10 MORTMA CLOSE CHISIPITE ', N'0775524987', NULL, NULL, NULL, N'N/A', N'10 MORTMA CLOSE CHISIPITE ', 1, 2, 0, N'0774185329', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4424, N'HCBD16F600154D', N'CHIRENDA', N'', N'ANDREW', CAST(0xA4130000 AS SmallDateTime), CAST(0x88950000 AS SmallDateTime), NULL, N'63-2210869B70', 1, NULL, N'23 HILLS R.D ST MARTINS ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'VIVIAN', N'MUKUMBA', 2, 2, 0, N'23 HILLS R.D ST MARTINS ', N'0027728464762', NULL, NULL, NULL, N'N/A', N'23 HILLS R.D ST MARTINS ', 1, 2, 0, N'0778409930', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4425, N'HCBD16F600155D', N'KUDAKWASHE', N'', N'ZAMBEZI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A980000 AS SmallDateTime), NULL, N'63-1363768F48', 1, NULL, N'33 MFENJE R.D MUFAKOSE ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'CAROLINE', N'MAORERA', 2, 2, 134, N'33 MFENJE R.D MUFAKOSE ', N'0773603543', NULL, NULL, NULL, N'', N'33 MFENJE R.D MUFAKOSE ', 1, 2, 0, N'0715763575', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4426, N'HCBD16F60078D', N'PRINCE', N'', N'MAPOSA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8AB30000 AS SmallDateTime), NULL, N'', 1, NULL, N'10956 GLENVIEW 7', 1, 22, 3, NULL, NULL, 0, 5, 1, N'MONICA', N'MAPOSA', 2, 2, 0, N'10956 GLENVIEW 7', N'0776789320', NULL, NULL, NULL, N'', N'10956 GLENVIEW 7', 1, 2, 1, N'0782895586', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4427, N'HCBD16F60079D', N'DILLAN ', N'', N'KANYONGO', CAST(0xA4130000 AS SmallDateTime), CAST(0x89A90000 AS SmallDateTime), NULL, N'', 1, NULL, N'9718  MKOTA CRESCENT GLENNORAH ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'RODNEY', N'KANYONGO', 1, 2, 118, N'9718 MKOTA CRESCENT GLENNORAH ', N'0733895383', NULL, NULL, NULL, N'N/A', N'9718 MKOTA CRESCENT GLENNORAH ', 2, 2, 0, N'0782989271', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4204, N'HCBD16F6009D', N'RUTENDO ', N'', N'NGOSHI', CAST(0xA4260000 AS SmallDateTime), CAST(0x8A090000 AS SmallDateTime), NULL, N'05-126361F25', 2, NULL, N'2300 MSASA ROAD NEW MALBROUGH', 1, 20, 0, NULL, NULL, 0, 0, 3, N'ANGELLA ', N'CHIWARA', 4, 2, 165, N'2300 MSASA ROAD NEW MALBROUGH ', N'0773024336', NULL, NULL, NULL, N'', N'2300 MSASA ROAD NEW MALBROUGH ', 1, 2, 0, N'0773024336', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4205, N'HCBD16F60010D', N'MICHELLE', N'TAKUDZWA', N'MUJURU', CAST(0xA4260000 AS SmallDateTime), CAST(0x8C330000 AS SmallDateTime), NULL, N'63-206808R43', 2, NULL, N'1281 TYNWALD  SOUTH ', 1, 20, 0, NULL, NULL, 0, 5, 1, N'ABIGAIL', N'MUJURU', 2, 2, 113, N'1281 TYNWALD SOUTH', N'0773090396', NULL, NULL, NULL, N'', N'1281 TYNWALD SOUTH', 1, 2, 0, N'0773090396', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4227, N'HCBD16F60020D', N'MELLISA ', N'', N'MAJONI', CAST(0xA4270000 AS SmallDateTime), CAST(0x8D270000 AS SmallDateTime), NULL, N'', 2, NULL, N'676 CROWBOROUGH', 1, 21, 3, NULL, NULL, 0, 5, 1, N'LONA', N'MAJONI', 2, 2, 165, N'676 CROWBOROUGH 


































































', N'0772293029', NULL, NULL, NULL, N'', N'676 CROWBOROUGH 


































































', 1, 2, 0, N'0772293029', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4228, N'HCBD16F60021D', N'NYASHA', N'ETHEL', N'JAISI', CAST(0xA4270000 AS SmallDateTime), CAST(0x8B150000 AS SmallDateTime), NULL, N'', 2, NULL, N'08 VALCAN CLOSE ', 1, 21, 0, NULL, NULL, 0, 5, 1, N'SHYLET ', N'JAISI', 2, 2, 166, N'08 VALCAN CLOSE ', N'0737201147', NULL, NULL, NULL, N'', N'08 VALCAN CLOSE ', 1, 2, 0, N'0737201477', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4229, N'HCBD16F60022D', N'SHYLEEN ', N'', N'MAZIRIRI', CAST(0xA4270000 AS SmallDateTime), CAST(0x8B310000 AS SmallDateTime), NULL, N'', 2, NULL, N'C555BLOCKS MBARE FLATS', 1, 21, 0, NULL, NULL, 0, 5, 1, N'CECILIA ', N'MAZIPIRI', 2, 2, 86, N'C555 BLOCKS MBARE FLATS', N'0774165000', NULL, NULL, NULL, N'', N'C555 BLOCKS MBARE FLATS', 1, 2, 0, N'0776454251', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4343, N'HCBD16F2011D', N'NYASHA ', N'', N'MASVOSVA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8DF60000 AS SmallDateTime), NULL, N'', 1, NULL, N'1022 MAKOMO', 1, 5, 3, NULL, NULL, 0, 5, 2, N'E', N'MAZIVEI', 2, 2, 165, N'1022 MAKOMO', N'00', NULL, NULL, NULL, N'', N'1022 MAKOMO', 1, 2, 0, N'00', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4344, N'HCBD16F213D', N'LYDIA', N'', N'MAWOZA', CAST(0xA4320000 AS SmallDateTime), CAST(0x91450000 AS SmallDateTime), NULL, N'', 2, NULL, N'1084 LUSAKA', 0, 5, 3, NULL, NULL, 0, 5, 1, N'M', N'KARUTSVA', 1, 1, 165, N'1084 LUSAKA', N'0778 454 097', NULL, NULL, NULL, N'', N'1084 LUSAKA', 1, 2, 0, N'0778 454 097', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4345, N'HCBD16F2014D', N'NYASHA ', N'', N'SIZE', CAST(0xA4130000 AS SmallDateTime), CAST(0x915E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2104 MAKOMO', 1, 5, 3, NULL, NULL, 0, 5, 1, N'T', N'SIZE', 1, 1, 165, N'2104 MAKOMO', N'0773 217194', NULL, NULL, NULL, N'', N'2104 MAKOMO', 1, 2, 0, N'0773 217 194', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4346, N'HCBD16F2015D', N'SHADRECK', N'', N'MURINGAPASI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8FD50000 AS SmallDateTime), NULL, N'', 1, NULL, N'20 11TH AVE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'S', N'MARINGAPASI', 1, 1, 165, N'20 11TH AVE', N'0772 689 028', NULL, NULL, NULL, N'', N'20 11TH AVE', 1, 2, 0, N'0772 689 028', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4347, N'HCBD16F2016D', N'QUEEN', N'', N'TAURO', CAST(0xA4130000 AS SmallDateTime), CAST(0x91A10000 AS SmallDateTime), NULL, N'', 2, NULL, N'2 M FERN RD', 1, 5, 3, NULL, NULL, 0, 5, 1, N'H', N'TAURO', 1, 1, 165, N'2 M FERN RD', N'0779 773 675', NULL, NULL, NULL, N'', N'2 M FERN RD', 1, 2, 0, N'0779 773 675', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4348, N'HCBD16F30050D', N'BRENDON', N'', N'MATAMBO', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8EF30000 AS SmallDateTime), NULL, N'', 2, NULL, N'165 MUCHENJE DRIVE', 1, 0, 0, NULL, NULL, 0, 5, 1, N'CATHRINE', N'MATAMBO', 6, 2, 181, N'165 MUCHENJE DRIVE', N'', NULL, NULL, NULL, N'', N'165 MUCHENJE DRIVE', 1, 2, 1, N'0773686411', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4349, N'HCBD16F2017D', N'RUFARO', N'TABETH', N'CHIRAYI', CAST(0xA4130000 AS SmallDateTime), CAST(0x905C0000 AS SmallDateTime), NULL, N'', 2, NULL, N'6002 AIRPORT', 1, 5, 3, NULL, NULL, 0, 5, 1, N'W', N'CHIRAYI', 1, 1, 165, N'6002 AIRPORT', N'0772 422 193', NULL, NULL, NULL, N'', N'6002 AIRPORT', 1, 2, 0, N'0772 422 193', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4350, N'HCBD16F20018D', N'RYAN', N'TINOTENDA', N'BANDA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8F2C0000 AS SmallDateTime), NULL, N'', 1, NULL, N'00', 1, 5, 3, NULL, NULL, 0, 5, 2, N'L', N'BANDA', 1, 1, 63, N'00', N'0772 610 991', NULL, NULL, NULL, N'', N'00', 1, 2, 0, N'0772 610 991', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4351, N'HCBD16F2019D', N'PARDON', N'', N'CHIPUPIRO', CAST(0xA4130000 AS SmallDateTime), CAST(0x91BC0000 AS SmallDateTime), NULL, N'', 1, NULL, N'497 HATCLIFFE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'T', N'CHIPUPIRO', 1, 1, 166, N'497 HATCLIFFE', N'0773 775 925', NULL, NULL, NULL, N'', N'497 HATCLIFFE', 1, 2, 1, N'0773 775 925', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4352, N'HCBD16F2020D', N'TINOTENDA', N'NICK', N'GUKWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90E20000 AS SmallDateTime), NULL, N'', 1, NULL, N'6 BEVEN RD', 1, 5, 5, NULL, NULL, 0, 5, 1, N'T', N'GUKWA', 1, 1, 165, N'6 BEVEN RD', N'0773 016 377', NULL, NULL, NULL, N'', N'6 BEVEN RD', 1, 2, 1, N'0773 016 377', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4206, N'HCB16F60011D', N'MERCY', N'SIBUSISIWE', N'NDINGINDWAYO', CAST(0xA4260000 AS SmallDateTime), CAST(0x8D060000 AS SmallDateTime), NULL, N'', 2, NULL, N'195 SMURTS ROAD', 1, 22, 0, NULL, NULL, 0, 5, 1, N'MARRY', N'NDINGINDWAYO', 2, 2, 165, N'195 SMURTS ROAD WATERFALLS PROSPECT ', N'0782469117', NULL, NULL, NULL, N'', N'195 SMURTS ROAD WATERFALLS PROSPECT ', 1, 2, 0, N'0782469117', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4207, N'HCBD16F6008D', N'FADZI', N'', N'MUNYUKI', CAST(0xA4260000 AS SmallDateTime), CAST(0x8A300000 AS SmallDateTime), NULL, N'63-1582558022', 2, NULL, N'1 LABES  FLATS CHIREMBA ', 1, 21, 3, NULL, NULL, 0, 5, 0, N'CHIEDZA ', N'GOMO', 4, 2, 0, N'1 LABES FLATS CHIREMBA ', N'0772222722', NULL, NULL, NULL, N'', N'1 LABES FLATS CHIREMBA ', 1, 2, 0, N'0772222722', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4208, N'HCBD16F3008', N'MUNASHE', N'', N'KAMICHO', CAST(0x94820000 AS SmallDateTime), CAST(0x90020000 AS SmallDateTime), NULL, N'', 2, NULL, N'6813 RETREAT PARK', 1, 9, 0, NULL, NULL, 0, 5, 1, N'RODRECK', N'KAMICHO', 1, 1, 103, N'6813 RETREAT PARK', N'0778871222', NULL, NULL, NULL, N'', N'6813 RETREAT PARK', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4209, N'HCBD16F60013D', N'TAFADZWA ', N'', N'CHIDUKU', CAST(0xA4260000 AS SmallDateTime), CAST(0x8A930000 AS SmallDateTime), NULL, N'', 2, NULL, N'', 1, 21, 0, NULL, NULL, 0, 5, 0, N'LOICE', N'MIGODHI', 2, 2, 113, N'', N'0782820861', NULL, NULL, NULL, N'', N'', 1, 2, 0, N'0782820861', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4210, N'HCBD16F3017', N'ALEX', N'USHE', N'CHILILA', CAST(0xA2E40000 AS SmallDateTime), CAST(0xA2A90000 AS SmallDateTime), NULL, N'', 1, NULL, N'ST MARTINS 57 CHUMMYPITCH', 1, 9, 0, NULL, NULL, 0, 5, 1, N'VIGINIA', N'NYANGONI', 7, 2, 165, N'ST MARTINS CHUMMYPITCH', N'0772681259', NULL, NULL, NULL, N'', N'ST MARTINS CHUMMYPITCH', 1, 0, 0, N'0772681259', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4211, N'HCBD16F60014D', N'JAMES ', N'', N'NCUBE ', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A430000 AS SmallDateTime), NULL, N'25-119802G28', 1, NULL, N'649 MAKOMO R.D', 1, 22, 3, NULL, NULL, 0, 0, 0, N'FAITH', N'NCUBE', 2, 2, 90, N'649 MAKOMO R.D EPWORTH', N'0739140843', NULL, NULL, NULL, N'', N'649 MAKOMO R.D EPWORTH', 1, 2, 0, N'0774969204', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4212, N'HCBD16F60015D', N'GRACIOS ', N'KUDZAI', N'MANDEVHANA', CAST(0xA4260000 AS SmallDateTime), CAST(0x8AD10000 AS SmallDateTime), NULL, N'', 2, NULL, N'132 VALLEYVIEVLANE ', 1, 0, 0, NULL, NULL, 0, 5, 1, N'KUDZAI', N'MANDEVHANA', 2, 2, 166, N'132 VALLEYVIEWLANE ', N'0772491614', NULL, NULL, NULL, N'', N'132 VALLEYVIEWLANE ', 1, 2, 0, N'0779204716', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4213, N'HCBD16F3018', N'MUNASHE', N'', N'KUNAKA', CAST(0xA2A80000 AS SmallDateTime), CAST(0x916A0000 AS SmallDateTime), NULL, N'', 1, NULL, N'2377 UPLANDS', 1, 0, 0, NULL, NULL, 0, 5, 1, N'CHRISTOPHER', N'KUNAKA', 1, 1, 165, N'2377 UPLANDS', N'0772916451', NULL, NULL, NULL, N'', N'2377 UPLANDS', 1, 2, 1, N'0772916451', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4214, N'HCBD16F60016D', N'TANAKA', N'EVELYN', N'KADENGE', CAST(0xA4260000 AS SmallDateTime), CAST(0x8A790000 AS SmallDateTime), NULL, N'', 2, NULL, N'132 VALLEYVIEWLANE ', 1, 21, 0, NULL, NULL, 0, 5, 1, N'', N'KADENGE', 2, 2, 113, N'132 VALLEYVIEWLANE ', N'', NULL, NULL, NULL, N'', N'132 VALLEYVIEWLANE ', 1, 2, 0, N'0784815640', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4215, N'HCBD16F60017D', N'LAURA ', N'DEISIREE', N'SITHOLE', CAST(0xA4260000 AS SmallDateTime), CAST(0x8C610000 AS SmallDateTime), NULL, N'', 2, NULL, N'22and 15A MBARE', 1, 21, 0, NULL, NULL, 0, 5, 1, N'PRECIOUS', N'KASEKE', 2, 2, 165, N'22and 15A  MBARE
', N'0738225161', NULL, NULL, NULL, N'', N'22and 15A  MBARE
', 1, 2, 0, N'0738225161', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4216, N'HCBD16F3008D', N'MUNASHE', N'', N'KAMICHO', CAST(0x94820000 AS SmallDateTime), CAST(0x90020000 AS SmallDateTime), NULL, N'', 2, NULL, N'6813 RETREAT PARK', 0, 9, 0, NULL, NULL, 0, 5, 1, N'RODRECK', N'KAMICHO', 1, 1, 103, N'6813 RETREAT PARK', N'0778871222', NULL, NULL, NULL, N'6813 RETREAT PARK', N'6813 RETREAT PARK', 1, 2, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4217, N'HCBD16F3009D', N'TADIWANASHE', N'DENZEL', N'MUDZENGERE', CAST(0xA2A90000 AS SmallDateTime), CAST(0x95580000 AS SmallDateTime), NULL, N'', 1, NULL, N'57 EVES CRESCENT', 0, 9, 0, NULL, NULL, 0, 5, 1, N'SYLVIA', N'SANGO', 2, 2, 165, N'57 EVES CRESCENT ', N'0775077520', NULL, NULL, NULL, N'57 EVES CRESCENT ', N'57 EVES CRESCENT ', 1, 2, 1, N'0775077520', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4218, N'HCBD16F60018D', N'TINOTENDA', N'', N'CHIGORA', CAST(0xA4260000 AS SmallDateTime), CAST(0x8B600000 AS SmallDateTime), NULL, N'', 2, NULL, N'28 14TH AVENUE ', 1, 21, 0, NULL, NULL, 0, 5, 1, N'SHEILAH ', N'CHIGORA', 2, 2, 28, N'28 14TH AVENUE ', N'0772558871', NULL, NULL, NULL, N'', N'28 14TH AVENUE ', 1, 2, 0, N'0772558871', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4219, N'HCBD16F3019', N'LISA', N'', N'CHAFACHAWORA', CAST(0xA3F40000 AS SmallDateTime), CAST(0x90170000 AS SmallDateTime), NULL, N'', 2, NULL, N'1673 MAINWAY  WATERFALLS', 0, 0, 0, NULL, NULL, 0, 5, 2, N'PADDINGTONTON', N'CHAFACHAWORA', 1, 1, 0, N'1673 MAINWAY WATERFALLS', N'0772333688', NULL, NULL, NULL, N'1673 MAINWAY WATERFALLS', N'1673 MAINWAY WATERFALLS', 1, 0, 1, N'0772533688', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4220, N'HCB16F60019D', N'TADIWA ', N'ANNIE ', N'MUNZARA', CAST(0xA4260000 AS SmallDateTime), CAST(0x8C0D0000 AS SmallDateTime), NULL, N'', 2, NULL, N'41 SECTION C ', 1, 0, 0, NULL, NULL, 0, 5, 1, N'JAQUILINE ', N'MAKWARA', 2, 2, 175, N'41 SECTION C HATFIELD ', N'0772925729', NULL, NULL, NULL, N'', N'41 SECTION C HATFIELD ', 1, 2, 0, N'0777755419', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4221, N'HCBD16F3020', N'BRENDA', N'', N'MAKO', CAST(0xA4130000 AS SmallDateTime), CAST(0x90C00000 AS SmallDateTime), NULL, N'', 2, NULL, N'12 HYTHA SENTOSA', 1, 2, 0, NULL, NULL, 0, 5, 1, N'TICHAREVA', N'MAKO', 1, 1, 67, N'12 HYTHIA SENTOSA', N'', NULL, NULL, NULL, N'', N'12 HYTHIA SENTOSA', 1, 2, 1, N'0772943699', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4222, N'HCBD16F3021', N'DADIRAI', N'', N'WILSON', CAST(0xA35B0000 AS SmallDateTime), CAST(0x90C20000 AS SmallDateTime), NULL, N'', 2, NULL, N'4866 HATCLIFF', 0, 0, 0, NULL, NULL, 0, 5, 1, N'WILSON', N'WILLON', 1, 1, 63, N'4866 HATCLIFF', N'0735285115', NULL, NULL, NULL, N'', N'4866 HATCLIFF', 0, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4223, N'HCBD16F3022', N'TALENT', N'', N'MUZUNGUZE', CAST(0xA6CF0000 AS SmallDateTime), CAST(0x8FFB0000 AS SmallDateTime), NULL, N'', 2, NULL, N'NYABIRA NEWSTANDS', 1, 0, 0, NULL, NULL, 0, 5, 1, N'SABINA', N'MUZUNGUZE', 7, 2, 165, N'NYABIRA NEWSTANDS
CHUNHOYI', N'0778214203', NULL, NULL, NULL, N'', N'NYABIRA NEWSTANDS
CHUNHOYI', 1, 2, 0, N'0778214203', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4224, N'HCBD16F3023', N'CHENGETAI', N'', N'CHAKARAWO', CAST(0xA6CF0000 AS SmallDateTime), CAST(0x8E820000 AS SmallDateTime), NULL, N'', 2, NULL, N'17243
HIPPO CLOSE', 1, 0, 0, NULL, NULL, 0, 5, 1, N'NYABEZA', N'CHAKARAWO', 2, 2, 89, N'17243
HIPPO CLOSE', N'0777223449', NULL, NULL, NULL, N'', N'17243
HIPPO CLOSE', 1, 2, 0, N'0777223449', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4225, N'HCBD16F304', N'VONGAISHE', N'', N'GOVERA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x90010000 AS SmallDateTime), NULL, N'', 2, NULL, N'975 HEIGHTS, MT PLEASANT', 1, 0, 0, NULL, NULL, 0, 5, 1, N'EMELDA', N'GOVERA', 2, 2, 0, N'975 HEIGHTS, MT PLEASANT', N'0772315865', NULL, NULL, NULL, N'', N'975 HEIGHTS, MT PLEASANT', 1, 2, 1, N'0772315865', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4226, N'HCBD16F3025', N'ESNATH', N'', N'TAVAKONZA', CAST(0xA0DD0000 AS SmallDateTime), CAST(0x8FD80000 AS SmallDateTime), NULL, N'', 2, NULL, N'49 MELFORT PARK ', 1, 0, 0, NULL, NULL, 0, 5, 1, N'MOSES', N'TAVAKONZA', 1, 1, 157, N'49 MELFORT PARK ', N'0714166183', NULL, NULL, NULL, N'', N'49 MELFORT PARK ', 1, 2, 1, N'0714166183', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4389, N'HCBD16F2054D', N'MICHAEL', N'MUNASHE', N'GOGWE', CAST(0xA4130000 AS SmallDateTime), CAST(0x92160000 AS SmallDateTime), NULL, N'63-2265036-D-26', 1, NULL, N'54 MARTIN''S RD', 1, 4, 3, NULL, NULL, 0, 5, 1, N'MODESTER', N'MUCHADA', 2, 2, 86, N'54 19TH STREET MARTIN''S RD HATFIELD', N'0775 106 848', NULL, NULL, NULL, N'', N'54 19TH STREET MARTIN''S RD HATFIELD', 1, 4, 0, N'0775106848', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4353, N'HCBD16F30052D', N'LOVEMORE', N'DARLINGTON', N'KALONDO', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8D140000 AS SmallDateTime), NULL, N'', 1, NULL, N'10 CHIRUDDI', 1, 7, 1, NULL, NULL, 0, 5, 1, N'HANNAH', N'PHIRI', 6, 2, 89, N'10 CHIRUDDI', N'', NULL, NULL, NULL, N'', N'10 CHIRUDDI', 1, 2, 1, N'0775900704', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4354, N'HCBD16F2021D', N'MICHAEL', N'RASHAAN', N'JEFFEREY', CAST(0xA5920000 AS SmallDateTime), CAST(0x90E20000 AS SmallDateTime), NULL, N'', 1, NULL, N'37 THORNCROFT', 1, 5, 3, NULL, NULL, 0, 5, 1, N'G', N'JEFFEREY', 1, 1, 165, N'37 THORNCROFT', N'0777 711 870', NULL, NULL, NULL, N'', N'37 THORNCROFT', 1, 2, 0, N'0777 711 870', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4355, N'HCBD16F2022D', N'NYIKA', N'COSTA', N'NYIKA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8EF20000 AS SmallDateTime), NULL, N'', 1, NULL, N'3007 CONCITION', 1, 5, 3, NULL, NULL, 0, 5, 1, N'P', N'NYIKA', 1, 1, 165, N'3007 CONCITIOM', N'0772 107 151', NULL, NULL, NULL, N'', N'3007 CONCITIOM', 1, 2, 0, N'0772 107 151', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4356, N'HCBD16F2023D', N'ERNEST', N'', N'MTETWA', CAST(0xA4320000 AS SmallDateTime), CAST(0x92730000 AS SmallDateTime), NULL, N'', 1, NULL, N'5460 MUHACHA', 1, 5, 3, NULL, NULL, 0, 5, 1, N'M', N'MTETWA', 1, 1, 165, N'5460 MUHACHA', N'0776 366 556', NULL, NULL, NULL, N'', N'5460 MUHACHA', 1, 2, 1, N'0776 366 556', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4357, N'HCBD16F2024D', N'BLESSING', N'KUNDAI', N'NYIKADZINO', CAST(0xA4130000 AS SmallDateTime), CAST(0x91410000 AS SmallDateTime), NULL, N'', 1, NULL, N'12976', 1, 5, 3, NULL, NULL, 0, 5, 3, N'J', N'NYIKADZINO', 2, 2, 110, N'12976', N'0771 771 512', NULL, NULL, NULL, N'', N'12976', 1, 2, 1, N'0771 771 512', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4358, N'HCBD16F30053', N'TAWANDA', N'JONAH', N'CHAWATAMA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8F580000 AS SmallDateTime), NULL, N'', 1, NULL, N' 21 AVONDALE RED ROOFS', 1, 7, 0, NULL, NULL, 0, 5, 1, N'ALICE', N'CHAWATAMEI', 2, 2, 181, N' 21 AVONDALE RED ROOFS', N'0775202074', NULL, NULL, NULL, N'', N' 21 AVONDALE RED ROOFS', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4359, N'HCBD16F2025D', N'TATENDA', N'', N'MANYAWI', CAST(0xA4130000 AS SmallDateTime), CAST(0x90450000 AS SmallDateTime), NULL, N'', 1, NULL, N'18045 GELFAND RD', 1, 5, 1, NULL, NULL, 0, 5, 1, N'T', N'MANYAWI', 1, 1, 166, N'18045 GELFAND RD', N'0772 570 592', NULL, NULL, NULL, N'', N'18045 GELFAND RD', 1, 2, 1, N'0772 570 592', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4360, N'HCBD16F2026D', N'SIMBA', N'SIMON', N'MAZAWI', CAST(0xA5920000 AS SmallDateTime), CAST(0x91690000 AS SmallDateTime), NULL, N'', 1, NULL, N'108 GROEVENOR CNR 3RD & 5TH AVENUE', 1, 5, 3, NULL, NULL, 0, 5, 1, N'S', N'MAZAWI', 1, 1, 166, N'108 GROEVENOR CNR 3RD & 5TH AVENUE', N'0772 400 875', NULL, NULL, NULL, N'', N'108 GROEVENOR CNR 3RD & 5TH AVENUE', 1, 2, 0, N'0772 400 875', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4366, N'HCBD16F2031D', N'BRIDGET', N'', N'MAPANI', CAST(0xA5430000 AS SmallDateTime), CAST(0x978E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'G HORNINGSTON', 1, 5, 3, NULL, NULL, 0, 5, 1, N'A', N'CHINHARA', 1, 1, 165, N'G HORNINGSTON', N'0771 470 696', NULL, NULL, NULL, N'', N'G HORNINGSTON', 1, 2, 0, N'0771 470 696', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4367, N'HCBD16F2032D', N'PAIDAMOYO', N'FAITH', N'ALISON', CAST(0xA4130000 AS SmallDateTime), CAST(0x91180000 AS SmallDateTime), NULL, N'', 2, NULL, N'59 NEW STANDS', 1, 4, 1, NULL, NULL, 0, 5, 1, N'RUTH', N'NENGUKE', 7, 2, 162, N'59 NEW STANDS', N'0733 049 465/04 300494', NULL, NULL, NULL, N'', N'59 NEW STANDS', 1, 2, 0, N'0733 049 465', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4368, N'HCBD16F2033D', N'CHENAI ', N'ELSEA', N'CHIKOSHA', CAST(0xA4130000 AS SmallDateTime), CAST(0x92EE0000 AS SmallDateTime), NULL, N'', 2, NULL, N'BORROWDALE', 1, 4, 3, NULL, NULL, 0, 5, 1, N'EDMORE', N'CHIKOSHA', 1, 1, 157, N'BORROWDALE', N'0784 430 337', NULL, NULL, NULL, N'', N'BORROWDALE', 1, 2, 0, N'O784 430 337', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4376, N'HCBD16F2041D', N'ALEEYA', N'RUMBIDZO', N'SHOKO', CAST(0xA4130000 AS SmallDateTime), CAST(0x91200000 AS SmallDateTime), NULL, N'', 2, NULL, N'564 KUYEDZA', 1, 4, 1, NULL, NULL, 1, 5, 4, N'MARVELOUS', N'CHIKONZO', 2, 2, 113, N'564 KUYEDZA RD KAMBUZUMA', N'0778 428 696', NULL, NULL, NULL, N'', N'564 KUYEDZA RD KAMBUZUMA', 1, 3, 0, N'0778 428 696', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4377, N'HCBD16F2042D', N'MOLYN', N'', N'TAMBUKANI', CAST(0xA4130000 AS SmallDateTime), CAST(0x91760000 AS SmallDateTime), NULL, N'', 2, NULL, N'7 FORTHINGHILL CLOSE', 0, 4, 3, NULL, NULL, 0, 5, 1, N'ERINI', N'MWANYANGARA', 2, 2, 168, N'7 FORTHING HILL CLOSE BALLANTYNE PARK', N'0714 033 557', NULL, NULL, NULL, N'', N'7 FORTHING HILL CLOSE BALLANTYNE PARK', 1, 4, 0, N'0714 033 557', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4378, N'HCBD16F2043D', N'TSVAKAI', N'JOEY', N'ZINDOGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x909A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'6788 TYNWALD LOT MARANATHA', 1, 4, 1, NULL, NULL, 0, 5, 4, N'MUSLIN', N'CHIZAH', 6, 2, 101, N'6788 TYNWALD LOT MARANATHA', N'0772 185 563', NULL, NULL, NULL, N'muslinchizah@zwnestle.com', N'6788 TYNWALD LOT MARANATHA', 1, 2, 1, N'0772 185 563', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4379, N'HCBD16F2044D', N'NATASHA', N'', N'MUZVONDIWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x91DC0000 AS SmallDateTime), NULL, N'63-225180-S-86', 2, NULL, N'43 MARON STREET', 1, 4, 11, NULL, NULL, 0, 5, 1, N'MEEKNESS', N'MUZONDIWA', 2, 2, 153, N'43 MARON STREET CRANBORNE', N'0773794792', NULL, NULL, NULL, N'mickymuzvondiwa@gmail.com', N'43 MARON STREET CRANBORNE', 1, 2, 0, N'0773 986 613', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4380, N'HCBD16F2045D', N'HAZEL', N'RUVARASHE', N'CHINYAMA', CAST(0xA4130000 AS SmallDateTime), CAST(0x90FA0000 AS SmallDateTime), NULL, N'63-2325606-H-45', 2, NULL, N'27202 UNIT G SEKE CHITUNGWIZA', 1, 4, 3, NULL, NULL, 0, 5, 1, N'JOHN', N'CHINYAMA', 1, 1, 110, N'27202 UNIT G SEKE CHITUNWIZA', N'0773 986 613', NULL, NULL, NULL, N'johnchinyama77@gmail.com', N'27202 UNIT G SEKE CHITUNWIZA', 1, 2, 0, N'0773 986 613', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4381, N'HCBD16F2046D', N'ELAIN', N'RUVARASHE', N'TARUWONA', CAST(0xA4130000 AS SmallDateTime), CAST(0x902C0000 AS SmallDateTime), NULL, N'', 2, NULL, N'17869 SHAFBURRY', 1, 4, 6, NULL, NULL, 0, 5, 1, N'PETRONELLA', N'TARUWONA', 2, 2, 61, N'17869 SHAFBURRY AVE CRANBOURNE', N'0772460727', NULL, NULL, NULL, N'', N'17869 SHAFBURRY AVE CRANBOURNE', 1, 2, 0, N'0772 460 727', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4382, N'HCBD16F2047D', N'MUNASHE', N'', N'CHIKWAVA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8EFC0000 AS SmallDateTime), NULL, N'', 1, NULL, N'23 HILLARY', 1, 4, 3, NULL, NULL, 0, 5, 3, N'CATHERINE', N'MABAYA', 2, 3, 166, N'23 HILLARY MBARE', N'0774 423995', NULL, NULL, NULL, N'', N'23 HILLARY MBARE', 1, 3, 0, N'0774 423 995', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4361, N'HCBD16F2027D', N'PROUD', N'', N'MAZAMBANI', CAST(0xA4130000 AS SmallDateTime), CAST(0x911C0000 AS SmallDateTime), NULL, N'', 1, NULL, N'BORROWDALE RACE COURSE', 1, 5, 6, NULL, NULL, 0, 5, 1, N'C', N'MAZAMBANI', 2, 2, 165, N'BORROWDALE RACE COURSE', N'0733 722 165', NULL, NULL, NULL, N'', N'BORROWDALE RACE COURSE', 1, 2, 0, N'0733 722 165', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4362, N'HCBD16F2028D', N'JACOB', N'JOHN', N'MUSHANINGWA', CAST(0xA5920000 AS SmallDateTime), CAST(0x8DFC0000 AS SmallDateTime), NULL, N'', 1, NULL, N'8 PLEW CREASANT', 1, 5, 3, NULL, NULL, 0, 5, 2, N'C', N'MUSHANINGA', 1, 1, 165, N'8 PLEW CREASANT', N'0772 762 439', NULL, NULL, NULL, N'', N'8 PLEW CREASANT', 1, 2, 0, N'0772 762 439', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4363, N'HCBD16F2029D', N'SOLOMON', N'TADIWA', N'ZIMUTO', CAST(0xA4130000 AS SmallDateTime), CAST(0x909F0000 AS SmallDateTime), NULL, N'', 1, NULL, N'24 6TH CREASANT', 1, 5, 3, NULL, NULL, 0, 5, 1, N'A', N'ZIMUTO', 1, 1, 166, N'24 6TH CREASANT', N'0773 274 484', NULL, NULL, NULL, N'', N'24 6TH CREASANT', 1, 2, 0, N'0773 274 484', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4364, N'HCBD16F2030D', N'MCDONALD', N'', N'MAKAWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x912B0000 AS SmallDateTime), NULL, N'', 1, NULL, N'1328', 1, 5, 3, NULL, NULL, 0, 5, 1, N'M', N'MAKAKA', 1, 1, 165, N'1328', N'0774 782 626', NULL, NULL, NULL, N'', N'1328', 2, 2, 0, N'0774 782 626', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4365, N'HCBD16F30054D', N'TINASHE', N'', N'GAHADZA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x915F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'6900 BUDIRIRO', 1, 7, 6, NULL, NULL, 0, 5, 1, N'GRACE', N'GAHADZA', 2, 2, 90, N'6900 BUDIRIRO', N'000000', NULL, NULL, NULL, N'', N'6900 BUDIRIRO', 1, 2, 0, N'0777857796', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4369, N'HCBD16F2034D', N'TRISH ', N'', N'CHIMBIRO', CAST(0xA4130000 AS SmallDateTime), CAST(0x90990000 AS SmallDateTime), NULL, N'', 2, NULL, N'15 CRESCENT', 1, 4, 6, NULL, NULL, 0, 5, 1, N'RICHARD', N'CHIMBIRO', 1, 1, 103, N'735 15TH CRESCENT', N'0739 824 256', NULL, NULL, NULL, N'', N'735 15TH CRESCENT', 1, 2, 0, N'0739 201 267', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4370, N'HCBD16F2035D', N'KARREN', N'', N'MAKWEMBERE', CAST(0xA4130000 AS SmallDateTime), CAST(0x91710000 AS SmallDateTime), NULL, N'', 2, NULL, N'WATERFALLS REFUGEE CAMP', 1, 4, 3, NULL, NULL, 0, 5, 1, N'FLORENCE', N'CHAPANDUKA', 16, 2, 110, N'WATERFALLS REFUGE CAMP', N'0733 953 022', NULL, NULL, NULL, N'', N'WATERFALLS REFUGE CAMP', 1, 6, 0, N'0733 953 022', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4371, N'HCBD16F2036D', N'NETSAI', N'', N'MANYIKA', CAST(0xA4130000 AS SmallDateTime), CAST(0x91F10000 AS SmallDateTime), NULL, N'', 2, NULL, N'WHITE HOUSE', 1, 4, 3, NULL, NULL, 0, 5, 1, N'NETSAI', N'MANYIKA', 6, 2, 134, N'MORRIS DEPOT WHITE HOUSE', N'0772 738 583', NULL, NULL, NULL, N'', N'MORRIS DEPOT WHITE HOUSE', 1, 1, 0, N'0772 738 583', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4372, N'HCBD16F2037D', N'HAZEL', N'KIMBERLY ', N'MAPHOSA', CAST(0xA4130000 AS SmallDateTime), CAST(0x91A20000 AS SmallDateTime), NULL, N'', 2, NULL, N'1204 HILTON RD', 0, 4, 3, NULL, NULL, 0, 5, 4, N'NETERTUA', N'MOYO', 6, 3, 110, N'1204 HILTON', N'0773 454 330', NULL, NULL, NULL, N'1204 HILTON', N'1204 HILTON', 1, 1, 1, N'0773 454 330', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4373, N'HCBD16F2038D', N'ROSEMARRY', N'SHANTEL', N'MUCHEKESI', CAST(0xA4130000 AS SmallDateTime), CAST(0x926B0000 AS SmallDateTime), NULL, N'63-2276028 B15', 2, NULL, N'22 MUSHAYANDEBVU', 1, 4, 3, NULL, NULL, 0, 5, 1, N'SHAMISO', N'MUCHEKESI', 2, 2, 167, N'22 MUSHAYANDEBVU', N'0733 325 914', NULL, NULL, NULL, N'', N'22 MUSHAYANDEBVU', 1, 2, 0, N'0733 325 914', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4374, N'HCBD16F2039D', N'CLEMENTINE', N'BRENDA', N'MUGWATI', CAST(0xA4130000 AS SmallDateTime), CAST(0x916B0000 AS SmallDateTime), NULL, N'', 2, NULL, N' 5357/98 MUSHAYANDEBVU', 1, 4, 6, NULL, NULL, 0, 5, 1, N'SENZENI', N'MANGWENDE', 2, 2, 86, N'5357/98 MUSHAYANDEBVU MBARE', N'0779 749 914', NULL, NULL, NULL, N'', N'5357/98 MUSHAYANDEBVU MBARE', 1, 2, 0, N'0779 749 914', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4375, N'HCBD16F2040D', N'NATASHA', N'SARAIMUNASHE', N'MUNERI', CAST(0xA4130000 AS SmallDateTime), CAST(0x922A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2317 BUROMBO', 1, 4, 8, NULL, NULL, 0, 5, 1, N'DIANA', N'MUNERI/ FOYA', 2, 2, 48, N'2317 BUROMBO ROAD LUSAKA HIGHFIELDS', N'0772 942 084', NULL, NULL, NULL, N'', N'2317 BUROMBO ROAD LUSAKA HIGHFIELDS', 1, 4, 0, N'0733 612 512', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3220, N'HCBD16F1003D', N'HELENA', N'', N'NUGUIANE', CAST(0xA5920000 AS SmallDateTime), CAST(0x933E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'99 4TH AVENUE ', 1, 2, 0, NULL, NULL, 0, 5, 1, N'FERISI', N'MDOKA', 2, 2, 178, N'99 4TH AVENUE MBARE', N'', NULL, NULL, NULL, N'', N'99 4TH AVENUE MBARE', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3221, N'HCB16F6004D', N'MOLLY', N'', N'TEMBO', CAST(0xA4250000 AS SmallDateTime), CAST(0x8C0B0000 AS SmallDateTime), NULL, N'63-2580661Z49', 2, NULL, N'2990 ZINYENGERE', 1, 20, 3, NULL, NULL, 0, 5, 0, N'BRIDGET', N'', 2, 2, 165, N'2990 ZINYENGERE EPWORTH', N'0773288023', NULL, NULL, NULL, N'', N'2990 ZINYENGERE EPWORTH', 1, 2, 0, N'0777743856', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4279, N'HCBD16F60034D', N'RUNGANO ', N'BENEDICT', N'CHIMUNDA', CAST(0xA42F0000 AS SmallDateTime), CAST(0x8B800000 AS SmallDateTime), NULL, N'63-2403860234', 2, NULL, N'5 HUMBA CLOSE MASASA PARK', 1, 21, 3, NULL, NULL, 0, 5, 1, N'RUTH ', N'CHIMUNDA ', 2, 2, 181, N'5 HUMBA CLOSE ', N'0778069278', NULL, NULL, NULL, N'', N'5 HUMBA CLOSE ', 1, 2, 0, N'0777684149', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4409, N'HCBD16F600138D', N'BRENDON', N'', N'TERERA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BBA0000 AS SmallDateTime), NULL, N'', 1, NULL, N'36 CHAPUNGU AVE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'HAZVINEI', N'SHONGA', 2, 2, 28, N'36 CHAPUNGU AVE', N'0773323864', NULL, NULL, NULL, N'', N'36 CHAPUNGU AVE', 1, 2, 0, N'0772637809', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4410, N'HCBD16F600139D', N'PRIVILEDGE', N'', N'MTEMASHINGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B120000 AS SmallDateTime), NULL, N'05-134900M61', 1, NULL, N'17 HILLS AVE CATSWOOD ', 1, 22, 3, NULL, NULL, 0, 5, 0, N'PATRICIA', N'KAZINGIZI', 2, 2, 90, N'17 HILLS AVE CATSWOOD ', N'0773655787', NULL, NULL, NULL, N'N/A', N'17 HILLS AVE CATSWOOD ', 1, 2, 1, N'0777425254', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4411, N'HCBD16F600140D', N'TATENDA ', N'', N'KAMBANGA', CAST(0xA4130000 AS SmallDateTime), CAST(0x895B0000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'7/TH STREET ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'KNENETH', N'KAMBANGA', 1, 1, 65, N'7/TH STREET ', N'0772591200', NULL, NULL, NULL, N'N/A', N'7/TH STREET ', 1, 2, 0, N'0783896199', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4412, N'HCBD16F600141D', N'MELINDA', N'', N'FICHANI', CAST(0xA4130000 AS SmallDateTime), CAST(0x89410000 AS SmallDateTime), NULL, N'', 2, NULL, N'112 ZATA STREET', 1, 22, 3, NULL, NULL, 0, 5, 1, N'TAFIREYI ', N'FICHANI', 0, 1, 102, N'112 ZATA STREET', N'0772807951', NULL, NULL, NULL, N'N/A', N'112 ZATA STREET', 1, 2, 0, N'0776172458', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4413, N'HCBD16F600142D', N'MELISSA', N'', N'MPANDE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BCA0000 AS SmallDateTime), NULL, N'N/A', 2, NULL, N'2134 RETREAT FARM WATERFALLS', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ADMIRE', N'MUPANDE', 1, 1, 166, N'2134 RETREAT FARM WATERFALLS', N'0772497177', NULL, NULL, NULL, N'', N'2134 RETREAT FARM WATERFALLS', 1, 2, 0, N'0772497177', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4414, N'HCBD16F600143D', N'JUNIOUR', N'', N'CHIZENGEYA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8BC30000 AS SmallDateTime), NULL, N'63-1477358F15', 1, NULL, N'951 MUKOTE CRESCENT', 1, 22, 3, NULL, NULL, 0, 5, 1, N'NEVERMIND', N'CHIMWARA', 1, 1, 0, N'951 MUKOTE CRESCENT', N'0773203613', NULL, NULL, NULL, N'N/A', N'951 MUKOTE CRESCENT', 1, 2, 0, N'0778035953', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4415, N'HCBD16F600144D', N'DIANA', N'', N'MAKIWA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B310000 AS SmallDateTime), NULL, N'18-133054618', 2, NULL, N'297 PROSPECT CHURCH HILL R.D ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'GEORGE', N'MAKIWA', 1, 1, 166, N'297 PROSPECT CHURCH HILL R.D ', N'0774260190', NULL, NULL, NULL, N'N/A', N'297 PROSPECT CHURCH HILL R.D ', 1, 2, 0, N'0777273527', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4416, N'HCBD16F600145D', N'THINKWELL', N'', N'SAINI ', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A950000 AS SmallDateTime), NULL, N'', 1, NULL, N'14 CORONATION AVE ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'NDOWA ', N'SAINI', 0, 1, 156, N'14 CORONATION AVE ', N'0774999529', NULL, NULL, NULL, N'N/A', N'14 CORONATION AVE ', 1, 2, 0, N'', NULL, NULL, NULL)
GO
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4417, N'HCBD16F600147D', N'LEEROY ', N'', N'MAKORE', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CB30000 AS SmallDateTime), NULL, N'', 1, NULL, N'14 LELTON STREET ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'PORTIA', N'MAKORE', 2, 2, 182, N'14 LELTON STREET ', N'0772425772', NULL, NULL, NULL, N'N/A', N'14 LELTON STREET ', 1, 2, 0, N'0776295861', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4418, N'HCBD16F600148D', N'ARTHUR ', N'JUNIOUR ', N'MATONGO', CAST(0xA4130000 AS SmallDateTime), CAST(0x8B710000 AS SmallDateTime), NULL, N'63-2017183Y42', 1, NULL, N'2346 GOLDEN CITY MT PLEASANT', 1, 22, 3, NULL, NULL, 0, 5, 1, N'ARTHUR ', N'MATONGO', 1, 1, 27, N'2346 GOLDEN CITY MT PLEASANT', N'0773616627', NULL, NULL, NULL, N'N/A', N'2346 GOLDEN CITY MT PLEASANT', 1, 2, 0, N'0778849907', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4419, N'HCBD16F600149D', N'CHARLES', N'', N'MACHIWANA', CAST(0xA4130000 AS SmallDateTime), CAST(0x88FC0000 AS SmallDateTime), NULL, N'63-23100266X50', 1, NULL, N'14 STORE FLAT HARARE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'MAVIS ', N'MABIKA', 2, 2, 90, N'14 STORE FLAT HARARE', N'0776381797', NULL, NULL, NULL, N'N/A', N'14 STORE FLAT HARARE', 1, 2, 0, N'0737777489', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4420, N'HCBD16F600150D', N'OLYWIN', N'', N'KANKUNI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8CAC0000 AS SmallDateTime), NULL, N'', 2, NULL, N'12 CLYDE R.D HARARE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'PASCA', N'MUSHUNGE ', 2, 2, 6, N'12 CLYDE R.D HARARE', N'0716176744', NULL, NULL, NULL, N'N/A', N'12 CLYDE R.D HARARE', 1, 2, 0, N'0738557220', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4421, N'HCBD16F600151D', N'MUNYARADZI ', N'', N'RAZUWIKA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8AB30000 AS SmallDateTime), NULL, N'', 1, NULL, N'300 ENTERPRISE HARARE ', 1, 22, 3, NULL, NULL, 0, 5, 1, N'SANIE ', N'CHIUTSI', 2, 2, 190, N'300 ENTERPRISE HARARE ', N'0773267819', NULL, NULL, NULL, N'', N'300 ENTERPRISE HARARE ', 1, 2, 0, N'0783384272', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4422, N'HCBD16F600152D', N'PRINCE', N'RUTENDO', N'KAMUNDA', CAST(0xA4130000 AS SmallDateTime), CAST(0x8A070000 AS SmallDateTime), NULL, N'', 1, NULL, N'5 EARL''S COURT HARARE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'VERONICA ', N'SAMUSHONGA ', 2, 2, 156, N'5 EARL''S COURT  HARARE', N'0774258612', NULL, NULL, NULL, N'', N'5 EARL''S COURT  HARARE', 1, 2, 0, N'0777258612', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4293, N'HCBD16F1008D', N'SHANTEL', N'NOKHUTHULA', N'MHERE', CAST(0xA5920000 AS SmallDateTime), CAST(0x935E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'1080 OVERSPILL', 0, 2, 0, NULL, NULL, 0, 5, 1, N'CHIDO', N'MHERE', 2, 2, 103, N'1080 OVERSPILL', N'0775 268 736', NULL, NULL, NULL, N'', N'1080 OVERSPILL', 1, 2, 0, N'0775 268 096', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4294, N'HCBD16F1009D', N'PRIVILEDGE', N'TARIRO', N'MUCHABAYIWA', CAST(0xA5920000 AS SmallDateTime), CAST(0x93130000 AS SmallDateTime), NULL, N'', 2, NULL, N'HATFIELD POLICE CAMP', 1, 2, 0, NULL, NULL, 0, 5, 1, N'ABIGAIL ', N'MASIIWA', 2, 2, 110, N'HATFIELD POLICE CAMP', N'0772 718 471', NULL, NULL, NULL, N'', N'HATFIELD POLICE CAMP', 1, 2, 0, N'0772 718 471', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4295, N'HCBD16F1010D', N'SHEILLAH', N'', N'JAMES', CAST(0xA5920000 AS SmallDateTime), CAST(0x907E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'137 H/CHITEPO ', 1, 2, 0, NULL, NULL, 0, 5, 1, N'OZIAS', N'JAMES', 3, 1, 63, N'137 H/CHITEPO RUWA', N'0773 424 966', NULL, NULL, NULL, N'', N'137 H/CHITEPO RUWA', 1, 2, 0, N'0773 424 966', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4300, N'HCBD16F1015D', N'CHARITY', N'', N'KWADOKA', CAST(0xA5920000 AS SmallDateTime), CAST(0x914E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'94 NEHANDA DZIVARASEKWA', 1, 2, 3, NULL, NULL, 0, 5, 1, N'MUDAU', N'KWADOKA', 1, 1, 165, N'94 NEHANDA DZIVARASEKWA', N'', NULL, NULL, NULL, N'', N'94 NEHANDA DZIVARASEKWA', 1, 2, 0, N'0773 726 270', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4301, N'HCBD16FI016D', N'MITCHEL', N'', N'NYAMANDE', CAST(0xA5920000 AS SmallDateTime), CAST(0x90570000 AS SmallDateTime), NULL, N'', 2, NULL, N'NEWSTANDS', 1, 2, 3, NULL, NULL, 0, 5, 1, N'PATSON', N'NYAMANDE', 1, 1, 63, N'DAMAFALLS NEW STANDS', N'0775 393 739', NULL, NULL, NULL, N'', N'DAMAFALLS NEW STANDS', 1, 2, 0, N'07755 393 739', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4302, N'HCBD16F60040D', N'CAREN', N'', N'KUREYA', CAST(0x94610000 AS SmallDateTime), CAST(0x8CF90000 AS SmallDateTime), NULL, N'', 2, NULL, N'05 KNOWLES CLOSE', 1, 7, 0, NULL, NULL, 0, 5, 1, N'ISRAEL', N'KUREYA', 1, 1, 181, N'05 KNOWLES', N'0775005357', NULL, NULL, NULL, N'', N'05 KNOWLES', 1, 2, 1, N'0775909669', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4303, N'HCBD16F1017D', N'BRIGHTON ', N'BILLY', N'FORE', CAST(0xA5920000 AS SmallDateTime), CAST(0x93A80000 AS SmallDateTime), NULL, N'', 1, NULL, N'5423 WATERFALLS', 1, 2, 3, NULL, NULL, 0, 5, 1, N'DEAN', N'FORE', 1, 1, 100, N'5423 WATERFALLS', N'0772316824', NULL, NULL, NULL, N'', N'5423 WATERFALLS', 1, 2, 0, N'0772 316 824', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4304, N'HCBD16F1018D', N'MATHEW', N'CLAYTON', N'NYIRENDA', CAST(0xA5920000 AS SmallDateTime), CAST(0x91420000 AS SmallDateTime), NULL, N'', 1, NULL, N'12 MELROSE BORROWDALE', 1, 2, 3, NULL, NULL, 0, 5, 0, N'RAPHAT', N'NYIRENDA', 5, 1, 165, N'12 MELROSE BORROWDALE', N'0772 742 885', NULL, NULL, NULL, N'', N'12 MELROSE BORROWDALE', 1, 2, 1, N'0772 742 805', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4305, N'HCBD16F1019D', N'TADIWANASHE', N'AURTHUR', N'MILANZI', CAST(0xA5920000 AS SmallDateTime), CAST(0x93890000 AS SmallDateTime), NULL, N'', 1, NULL, N'8 RICHMOND HIGHLANDS', 1, 2, 3, NULL, NULL, 0, 5, 1, N'VIGINIA', N'MILANZI', 2, 2, 110, N'8 RICHMOND HIGHLANDS', N'0772 202 355', NULL, NULL, NULL, N'', N'8 RICHMOND HIGHLANDS', 1, 2, 0, N'0772 202 355', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4306, N'HCBD16F1020D', N'TINOTENDA', N'WALTER', N'CHILAKATA', CAST(0xA5920000 AS SmallDateTime), CAST(0x93CC0000 AS SmallDateTime), NULL, N'', 1, NULL, N'55 MUBVEE STREET', 1, 2, 3, NULL, NULL, 0, 5, 1, N'WONDER', N'CHILAKATA', 1, 1, 157, N'55 MUMVEE STREET MUFAKOSE', N'0774 941 851', NULL, NULL, NULL, N'', N'55 MUMVEE STREET MUFAKOSE', 1, 2, 0, N'0774 941 851', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4307, N'HCBD16F1021D', N'KUDAKWASHE ', N'', N'HERRY', CAST(0xA5920000 AS SmallDateTime), CAST(0x92750000 AS SmallDateTime), NULL, N'', 1, NULL, N'', 1, 2, 3, NULL, NULL, 0, 5, 1, N'RIBNOS', N'HARRY', 1, 1, 132, N'13 AREA D TOMSON DEPOT HARARE', N'0775 679 389', NULL, NULL, NULL, N'', N'13 AREA D TOMSON DEPOT HARARE', 1, 2, 0, N'0775 679 389', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4308, N'HCBD16F30041D', N'ALICE', N'', N'CHIKOKO', CAST(0x94610000 AS SmallDateTime), CAST(0x89A30000 AS SmallDateTime), NULL, N'', 2, NULL, N'5 CAMBRIDGE GREENDALE', 1, 7, 0, NULL, NULL, 0, 5, 1, N'LOVENESS ', N'MWATA', 2, 2, 181, N'5 CAMBRIDGE GREENDALE', N'', NULL, NULL, NULL, N'', N'5 CAMBRIDGE GREENDALE', 1, 0, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4309, N'HCBD16F1022D', N'NIGEL', N'', N'NYIKADZINO', CAST(0xA5920000 AS SmallDateTime), CAST(0x91EB0000 AS SmallDateTime), NULL, N'', 1, NULL, N'12976 KUWADZANA', 1, 2, 3, NULL, NULL, 0, 5, 1, N'SUSAN', N'PASCO', 2, 2, 110, N'12976 KUWADZANA', N'0772 938 507', NULL, NULL, NULL, N'', N'12976 KUWADZANA', 1, 2, 0, N'0771 771 512', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4310, N'HCBD16F30042', N'CRYSENSE', N'', N'MACHEKA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x881A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'814 NEWSTANDS', 1, 0, 0, NULL, NULL, 0, 5, 1, N'N/A', N'N/A', 9, 1, 81, N'814 NEWSTANDS', N'N/A', NULL, NULL, NULL, N'', N'814 NEWSTANDS', 1, 6, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4311, N'HCBD16F1023', N'MARTIN', N'', N'KALULU', CAST(0xA5920000 AS SmallDateTime), CAST(0x92750000 AS SmallDateTime), NULL, N'', 1, NULL, N'40 JIRI STREET MUFAKOSE', 1, 2, 3, NULL, NULL, 0, 5, 1, N'SUSAN', N'PASCO', 2, 2, 110, N'40 JIRI MUFAKOSE', N'0772 938 507', NULL, NULL, NULL, N'', N'40 JIRI MUFAKOSE', 1, 2, 0, N'0772 938 507', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4312, N'HCBD16F60043D', N'TASHA', N'TAFADZWA', N'MASIMBE', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8F6A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'16 WOOD LANE', 1, 0, 0, NULL, NULL, 0, 5, 1, N'CHARLES', N'MASIMBE', 1, 1, 128, N'16 WOOD LANE', N'0772237791', NULL, NULL, NULL, N'', N'16 WOOD LANE', 1, 0, 1, N'0772237791', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4313, N'HCBD16F1024D', N'ANTONETTE', N'CHIPO', N'CHEMHURU', CAST(0xA5920000 AS SmallDateTime), CAST(0x8FFA0000 AS SmallDateTime), NULL, N'', 2, NULL, N'1002 PROSPECT PARK', 1, 2, 3, NULL, NULL, 0, 5, 1, N'TENDAI', N'CHOGA', 6, 2, 165, N'1002 PROSPECT PARK WATERFALLS', N'', NULL, NULL, NULL, N'', N'1002 PROSPECT PARK WATERFALLS', 1, 2, 0, N'00', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4314, N'HCD16F30044D', N'LISA', N'JORIAL', N'SIHLANGU', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8EB80000 AS SmallDateTime), NULL, N'', 2, NULL, N'34 MADZIMA', 1, 7, 0, NULL, NULL, 0, 5, 1, N'GLADYS ', N'SIHLANGU', 2, 2, 190, N'34 MADZIMA', N'', NULL, NULL, NULL, N'', N'34 MADZIMA', 1, 1, 0, N'0738614816', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3204, N'HCBD16F3002D', N'KUDZAISHE', N'EVIDENCE', N'SATANDE', CAST(0xA3F60000 AS SmallDateTime), CAST(0x90700000 AS SmallDateTime), NULL, N'', 2, NULL, N'NHORO', 0, 9, 3, NULL, NULL, 0, 5, 1, N'GOODLUCK', N'SATANDE', 1, 1, 27, N'117 NHORO, DZIVARASEKWA', N'0774436989', NULL, NULL, NULL, N'117 NHORO, DZIVARASEKWA', N'117 NHORO, DZIVARASEKWA', 1, 2, 1, N'0774436', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3205, N'HCBD16F3003', N'YOLANDA', N'RUMBIDZAI', N'MLAMBO', CAST(0xA3F60000 AS SmallDateTime), CAST(0x8FC20000 AS SmallDateTime), NULL, N'', 2, NULL, N'2 FAIRFIELD', 1, 9, 8, NULL, NULL, 0, 5, 1, N'FLOYD', N'WASTERFALL', 1, 1, 165, N'2 FAIRFIELD,HATFIELD', N'0773975967', NULL, NULL, NULL, N'', N'2 FAIRFIELD,HATFIELD', 1, 2, 0, N'0733930478', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3206, N'HCBD16F3004', N'COUGHTNEY', N'', N'MADIRO', CAST(0xA3F60000 AS SmallDateTime), CAST(0x8F560000 AS SmallDateTime), NULL, N'', 2, NULL, N'1300 CRAWHILL', 0, 9, 0, NULL, NULL, 0, 5, 1, N'ELIAS', N'MADIRO', 7, 1, 157, N'1300 CRAWHILL', N'0712000155', NULL, NULL, NULL, N'1300 CRAWHILL', N'1300 CRAWHILL', 1, 2, 1, N'0712000155', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3207, N'HCBD16F3005', N'ENIFA', N'', N'MUKOCHE', CAST(0xA3F60000 AS SmallDateTime), CAST(0x8EBA0000 AS SmallDateTime), NULL, N'', 2, NULL, N'53 SCOTT ROAD', 0, 9, 0, NULL, NULL, 0, 5, 1, N'SHINGIRAI', N'MUKOCHE', 1, 1, 165, N'53 SCOTT ROAD HATFIELD', N'0773085642', NULL, NULL, NULL, N'53 SCOTT ROAD HATFIELD', N'53 SCOTT ROAD HATFIELD', 1, 2, 1, N'0733656566', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3208, N'HCBD16F3006', N'MUSAWENKOSI', N'', N'DUBE', CAST(0xA2B30000 AS SmallDateTime), CAST(0x90200000 AS SmallDateTime), NULL, N'', 2, NULL, N'17419 FLANAGUN ROAD', 0, 9, 0, NULL, NULL, 1, 5, 2, N'OBERT', N'DUBE', 1, 1, 165, N'17419 FLANAGUN', N'0777258921', NULL, NULL, NULL, N'17419 FLANAGUN', N'17419 FLANAGUN', 1, 2, 1, N'0777058921', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3209, N'HCBD16F3007', N'SHAMISO', N'ALTHEA', N'GOZHO', CAST(0xA3F60000 AS SmallDateTime), CAST(0xA2AA0000 AS SmallDateTime), NULL, N'', 2, NULL, N'84 NYABIRA', 0, 9, 0, NULL, NULL, 0, 5, 1, N'N/A', N'GOZHO', 1, 1, 165, N'84 NYABIRA', N'0000', NULL, NULL, NULL, N'84 NYABIRA', N'84 NYABIRA', 1, 2, 1, N'N/A', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3210, N'', N'PADDINGTON', N'N/A', N'LINTON', CAST(0xA5800000 AS SmallDateTime), CAST(0x8BB30000 AS SmallDateTime), NULL, N'', 1, NULL, N'MASOTSHA NDLOVU WAY', 1, 8, 3, NULL, NULL, 0, 5, 1, N'', N'CHIVENDE', 4, 2, 100, N'MASOTSHA NDLOVU WAY', N'0775487242', NULL, NULL, NULL, N'N/A', N'MASOTSHA NDLOVU WAY', 1, 2, 1, N'0775287', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3211, N'HCBD16F3010', N'MARTIN ', N'TAPIWA', N'CHIBESA', CAST(0xA2A90000 AS SmallDateTime), CAST(0x8ECA0000 AS SmallDateTime), NULL, N'', 2, NULL, N'999 OFF FRAZER', 0, 9, 0, NULL, NULL, 0, 5, 1, N'JACQUELINE', N'NYAKUENDA', 2, 2, 165, N'999 OFF FRAZER', N'0733252566', NULL, NULL, NULL, N'999 OFF FRAZER', N'999 OFF FRAZER', 1, 2, 1, N'0733252566', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3212, N'HCBD16F3011', N'TADIWANASHE', N'', N'MUDUNGWE', CAST(0xA2A90000 AS SmallDateTime), CAST(0x90860000 AS SmallDateTime), NULL, N'', 2, NULL, N'382 RETREAT PK', 0, 9, 0, NULL, NULL, 0, 5, 1, N'LOVEMORE', N'MUDUNGWE', 1, 1, 22, N'382 RETREAT PARK', N'0773147083', NULL, NULL, NULL, N'382 RETREAT PARK', N'382 RETREAT PARK', 1, 2, 1, N'0773147083', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3213, N'HCBD16F3012', N'MUNASHE', N'PATRICK', N'DICHA', CAST(0xA2A90000 AS SmallDateTime), CAST(0x90EE0000 AS SmallDateTime), NULL, N'', 2, NULL, N'22 SELOUS ROAD', 0, 9, 0, NULL, NULL, 0, 5, 1, N'CLEMENTS', N'DICHA', 5, 1, 63, N'22 SELOUS ROAD', N'', NULL, NULL, NULL, N'22 SELOUS ROAD', N'22 SELOUS ROAD', 1, 2, 1, N'0772363401', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3214, N'HCBD16F3013', N'TAKUNDA', N'', N'CHARINDAPANZE', CAST(0xA3460000 AS SmallDateTime), CAST(0x910A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2225 7TH STREET', 0, 9, 0, NULL, NULL, 0, 5, 1, N'WILSON', N'CHARINDAPANZE', 1, 1, 166, N'2225 7TH STREET DZ', N'0772717206', NULL, NULL, NULL, N'2225 7TH STREET DZ', N'2225 7TH STREET DZ', 1, 2, 1, N'0772717206', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3215, N'HCBD16F3014', N'PASMORE', N'', N'CHIUMIA', CAST(0xA2CD0000 AS SmallDateTime), CAST(0x8F110000 AS SmallDateTime), NULL, N'', 0, NULL, N'2696 WATERFALLS', 0, 9, 0, NULL, NULL, 0, 5, 1, N'PULLEN', N'CHIUMIA', 1, 1, 103, N'2696 WATERFALLS', N'0772382313', NULL, NULL, NULL, N'2696 WATERFALLS', N'2696 WATERFALLS', 1, 2, 1, N'0772382313', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3216, N'HCBD16F3015', N'TINASHE ', N'', N'MURAMBIWA', CAST(0x94820000 AS SmallDateTime), CAST(0x904A0000 AS SmallDateTime), NULL, N'', 2, NULL, N'37 APPEL AVE', 0, 9, 0, NULL, NULL, 0, 5, 1, N'TAWANDA', N'MURAMBIWA', 1, 1, 174, N'37 APPEL AVE ST MARTINS', N'0772394026', NULL, NULL, NULL, N'37 APPEL AVE ST MARTINS', N'37 APPEL AVE ST MARTINS', 1, 2, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3217, N'HCBD16F3016', N'FARAI', N'', N'MACHAKA', CAST(0xA2E40000 AS SmallDateTime), CAST(0x8D8E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'9 BLATHERICK ROAD', 0, 9, 0, NULL, NULL, 0, 5, 1, N'NEMERAI ', N'MACHAKA', 2, 2, 190, N'9 BLATHERICK', N'0773992920', NULL, NULL, NULL, N'9 BLATHERICK', N'9 BLATHERICK', 1, 2, 1, N'0773992', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4280, N'HCBD16F600116', N'SHARON ', N'', N'DZVETA', CAST(0xA4130000 AS SmallDateTime), CAST(0x87D00000 AS SmallDateTime), NULL, N'', 2, NULL, N'8 WARBURY', 1, 22, 3, NULL, NULL, 0, 5, 1, N'HILDA ', N'KUTUMA', 2, 3, 28, N'8 WARBURY', N'0775133494', NULL, NULL, NULL, N'N/A', N'8 WARBURY', 1, 1, 0, N'0779198617', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4281, N'HCBD16F600117', N'MOREBLESSING', N'', N'MASAITI', CAST(0xA4130000 AS SmallDateTime), CAST(0x8C340000 AS SmallDateTime), NULL, N'N/A', 1, NULL, N'15853 BUDIRIRO 5B', 1, 22, 3, NULL, NULL, 0, 5, 1, N'CLYSON', N'MASAITI', 1, 1, 2, N'15853 BUDIRIRO 5B', N'0773281824', NULL, NULL, NULL, N'N/A', N'15853 BUDIRIRO 5B', 1, 2, 1, N'0782885709', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4282, N'HCBD16F600118', N'CHARNICE ', N'', N'CHIYANIKE', CAST(0xA4130000 AS SmallDateTime), CAST(0x882F0000 AS SmallDateTime), NULL, N'63-293456T80', 2, NULL, N'2913 SENGWA AVENUE', 1, 22, 3, NULL, NULL, 0, 5, 1, N'LOYNAH', N'SHAWARIRA', 2, 3, 0, N'2913 SENGWA AVENUE', N'0772732853', NULL, NULL, NULL, N'N/A', N'2913 SENGWA AVENUE', 1, 1, 0, N'0774750649', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4283, N'HCBD16F600119', N'ALICE', N'', N'NYAMANDE', CAST(0xA4130000 AS SmallDateTime), CAST(0x89FC0000 AS SmallDateTime), NULL, N'32-204694B18', 2, NULL, N'2856 PHEASANT ROAD', 1, 22, 3, NULL, NULL, 0, 5, 1, N'CHIPO', N'MAGAYO', 2, 2, 182, N'2856 PHEASANT ROAD ', N'0772364492', NULL, NULL, NULL, N'N/A', N'2856 PHEASANT ROAD ', 1, 2, 0, N'0783405322', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4284, N'HCBD16F30036', N'CAROLINE', N'VIMBAI', N'MAKONDORA', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8FB80000 AS SmallDateTime), NULL, N'', 2, NULL, N'581 MAKOMO EXTATION', 1, 7, 0, NULL, NULL, 0, 5, 1, N'LUCIA', N'MAKONDORA', 2, 1, 190, N'581 MAKOMO', N'0774227082', NULL, NULL, NULL, N'', N'581 MAKOMO', 1, 2, 0, N'0774227082', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4285, N'HCBD16F60038D', N'VIMBAI', N'LOCADIA', N'CHOGORANYIKA', CAST(0x94610000 AS SmallDateTime), CAST(0x91040000 AS SmallDateTime), NULL, N'', 2, NULL, N'15 CAMBELTON
', 1, 7, 0, NULL, NULL, 0, 5, 1, N'ALBERT', N'CHIGORANYIKA', 1, 1, 66, N'15 CAMBELTON', N'0776686453', NULL, NULL, NULL, N'', N'15 CAMBELTON', 1, 0, 0, N'0776686453', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4286, N'HCBD16F1001D', N'TALENT', N'', N'CHINYANYA', CAST(0xA5910000 AS SmallDateTime), CAST(0x91BB0000 AS SmallDateTime), NULL, N'', 2, NULL, N'2422 MASASA PARK', 1, 2, 3, NULL, NULL, 0, 5, 1, N'KELVIN', N'ZIFODYA', 5, 1, 1, N'2422 MASASA PARK', N'', NULL, NULL, NULL, N'', N'2422 MASASA PARK', 1, 2, 0, N'0774018799', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4288, N'HCBD16F1002D', N'NATALIA', N'TAMISA', N'MUZVONDIWA', CAST(0xA5920000 AS SmallDateTime), CAST(0x933E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'43 MANROW ROAD', 0, 2, 0, NULL, NULL, 0, 5, 1, N'MICKNESS', N'MUZVONDIWA', 2, 2, 99, N'43 MONROW ROAD CRANBORNE', N'0773794792', NULL, NULL, NULL, N'', N'43 MONROW ROAD CRANBORNE', 1, 2, 0, N'0773794792', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4289, N'HCBD16F1004D', N'HANNAH', N'', N'KOLONDO', CAST(0xA5920000 AS SmallDateTime), CAST(0x915D0000 AS SmallDateTime), NULL, N'', 2, NULL, N'9 CHIRUNDU COURT', 1, 2, 0, NULL, NULL, 0, 5, 1, N'DEMETRIA', N'MUCHENJE', 6, 2, 61, N'9 CHIRUNDU COURT HIGHLANDS', N'', NULL, NULL, NULL, N'', N'9 CHIRUNDU COURT HIGHLANDS', 1, 3, 1, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4290, N'HCBD16F1005', N'BRITNEY', N'CONCILLIA', N'PHIRI', CAST(0xA5920000 AS SmallDateTime), CAST(0x91940000 AS SmallDateTime), NULL, N'', 2, NULL, N'33 KENSINGTON ROAD', 1, 2, 0, NULL, NULL, 0, 5, 1, N'SAUDA', N'OFFFICE', 2, 2, 181, N'33 KENSINGTON HIGHLANDS', N'', NULL, NULL, NULL, N'', N'33 KENSINGTON HIGHLANDS', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4291, N'HCBD16F1006D', N'TANYARADZWA', N'MILDRED', N'TAKAEDZA', CAST(0xA5920000 AS SmallDateTime), CAST(0x944A0000 AS SmallDateTime), NULL, N'', 1, NULL, N'7 HOWMAN', 1, 2, 0, NULL, NULL, 0, 5, 1, N'EMMA', N'PURANA', 2, 2, 165, N'7 HOWMAN MBARE', N'0782260103', NULL, NULL, NULL, N'', N'7 HOWMAN MBARE', 1, 2, 0, N'0782260103', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4292, N'HCBD16F1007D', N'ANGELINE', N'TANAKA', N'MTEMA', CAST(0xA5920000 AS SmallDateTime), CAST(0x942E0000 AS SmallDateTime), NULL, N'', 2, NULL, N'1 WESTGATE', 1, 2, 0, NULL, NULL, 0, 5, 1, N'TIME', N'MTEMA', 1, 1, 165, N'1 WESTGATE', N'0773 646 096', NULL, NULL, NULL, N'', N'1 WESTGATE', 1, 2, 1, N'0773646096', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4296, N'HCBD16F1011D', N'CYNTHIA ', N'ALISHA', N'CHAKARAWO', CAST(0xA5920000 AS SmallDateTime), CAST(0x909F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'17243 BORROWDALE ROAD', 1, 2, 8, NULL, NULL, 0, 5, 4, N'NYEMUDZAI', N'NYABEZE', 2, 2, 99, N'17243 BORROWDALE', N'0733 557 372', NULL, NULL, NULL, N'', N'17243 BORROWDALE', 1, 2, 0, N'0777 223 449', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4297, N'HCBD16F1012D', N'NATASHA', N'RUVIMBO ', N'BENSON', CAST(0xA5920000 AS SmallDateTime), CAST(0x933F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'119 MADZIMA CLOSE', 1, 2, 0, NULL, NULL, 0, 5, 0, N'PRIMROSE ', N'BENSON', 4, 2, 183, N'119 MADZIMA MBARE', N'0779 455 605', NULL, NULL, NULL, N'', N'119 MADZIMA MBARE', 1, 1, 0, N'0733 557 372', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4298, N'HCBD16F1013D', N'TANISHA ', N'', N'DUBE', CAST(0xA5920000 AS SmallDateTime), CAST(0x92600000 AS SmallDateTime), NULL, N'', 2, NULL, N'19 MADZIMA MBARE', 1, 2, 3, NULL, NULL, 0, 5, 1, N'CATHERINE', N'MADZIMA', 2, 2, 110, N'119 MADZIMA MBARE', N'', NULL, NULL, NULL, N'', N'119 MADZIMA MBARE', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4299, N'HCBD16F1014D', N'TANIA', N'TADIWANASHE', N'MANGOMA', CAST(0xA5920000 AS SmallDateTime), CAST(0x933F0000 AS SmallDateTime), NULL, N'', 2, NULL, N'13652 RUWA', 1, 2, 3, NULL, NULL, 0, 5, 1, N'SENZENI', N'MADENGA', 2, 2, 90, N'13652 RUWA', N'0772 840 178', NULL, NULL, NULL, N'', N'13652 RUWA', 1, 2, 0, N'0772 849 178', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4318, N'HCBD16F1027D', N'PANASHE', N'TINOTENDA', N'MCHABAYIWA', CAST(0xA5920000 AS SmallDateTime), CAST(0x90D90000 AS SmallDateTime), NULL, N'', 1, NULL, N'HATFIELD POLICE CAMP', 1, 2, 3, NULL, NULL, 0, 5, 1, N'ABIGIRL', N'MASIIWA', 2, 2, 90, N'HATFIELD POLICE CAMP', N'0772 718 471', NULL, NULL, NULL, N'', N'HATFIELD POLICE CAMP', 1, 2, 0, N'0772 718 471', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4319, N'HCBD16F1028D', N'PRIDE ', N'', N'MATORE', CAST(0xA5920000 AS SmallDateTime), CAST(0x90AA0000 AS SmallDateTime), NULL, N'', 1, NULL, N'451 DAVIS RD HATFIELD', 1, 2, 3, NULL, NULL, 0, 5, 1, N'ROBSON', N'MATORE', 1, 1, 165, N'451 DAVIS RD HATFIELD', N'0737 477 166', NULL, NULL, NULL, N'', N'451 DAVIS RD HATFIELD', 1, 2, 0, N'0737 477 166', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3218, N'HCBD16F6001D', N'FADZAI', N'MICHAEL', N'MANGWANA', CAST(0xA4250000 AS SmallDateTime), CAST(0x8EDF0000 AS SmallDateTime), NULL, N'22-2058160P54', 1, NULL, N'16 MAUSHE', 1, 20, 3, NULL, NULL, 0, 5, 1, N'JESSICA', N'', 2, 2, 181, N'16 MAUSHA , ATHLONE', N'0777971908', NULL, NULL, NULL, N'', N'16 MAUSHA , ATHLONE', 1, 3, 0, N'0777971908', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3219, N'HCBD16F6002D', N'BRAIN', N'', N'MBAIMBAI', CAST(0xA4250000 AS SmallDateTime), CAST(0x8B6E0000 AS SmallDateTime), NULL, N'75-2020368514', 1, NULL, N'63 MBADA', 1, 20, 3, NULL, NULL, 0, 5, 0, N'ANNAH', N'', 2, 2, 123, N'63MBADA, MARIMBA', N'0772974862', NULL, NULL, NULL, N'', N'63MBADA, MARIMBA', 1, 3, 0, N'0783904429', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3222, N'HCBD16F6005D', N'LESLIE', N'', N'MUPETI', CAST(0xA4250000 AS SmallDateTime), CAST(0x8C750000 AS SmallDateTime), NULL, N'', 1, NULL, N'4292 DALLAS', 1, 20, 3, NULL, NULL, 0, 5, 0, N'ITAI', N'', 1, 1, 157, N'4292 DALLAS ', N'0733336512', NULL, NULL, NULL, N'', N'4292 DALLAS ', 1, 2, 0, N'0737570814', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (3223, N'HCBD16F6006D', N'TOBIAS', N'MARVELOUS', N'MUSVIPA', CAST(0xA4250000 AS SmallDateTime), CAST(0x8BD30000 AS SmallDateTime), NULL, N'', 1, NULL, N'', 1, 20, 3, NULL, NULL, 0, 5, 0, N'NGWARAI', N'', 0, 1, 178, N'', N'0773225889', NULL, NULL, NULL, N'', N'', 1, 2, 0, N'', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4315, N'HCBD16F1025D', N'MUNASHE', N'', N'CHARUMBIRA', CAST(0xA5920000 AS SmallDateTime), CAST(0x92710000 AS SmallDateTime), NULL, N'', 1, NULL, N'7655 HATCLIFFE BORROWDALE', 0, 2, 3, NULL, NULL, 0, 5, 1, N'STELLA', N'GOMO', 2, 2, 110, N'7655 HATCLIFFE BORROWDALE', N'0773 938 696', NULL, NULL, NULL, N'', N'7655 HATCLIFFE BORROWDALE', 1, 2, 0, N'0734 238 938', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4316, N'HCBD16F60045D', N'TINOTENDA', N'', N'GOMO', CAST(0xA2A60000 AS SmallDateTime), CAST(0x8EC10000 AS SmallDateTime), NULL, N'', 2, NULL, N'NDC 1534 CAUSEWAY', 1, 7, 0, NULL, NULL, 0, 5, 1, N'TINASHE', N'GOMO', 3, 1, 0, N'NDC 1534 CAUSEWAY', N'0771061096', NULL, NULL, NULL, N'', N'NDC 1534 CAUSEWAY', 1, 0, 1, N'0771061096', NULL, NULL, NULL)
INSERT [dbo].[tbl_students] ([ctr], [studentId], [firstName], [secondName], [surname], [registrationDate], [dateOfBirth], [birthNumber], [nationalIdNumber], [sexId], [studentPicture], [homeAddress], [hostelId], [schoolClassId], [healthConditionId], [religionId], [schoolPositionId], [boardingStatusId], [disabilityId], [orphanhoodStatusId], [guardianFirstname], [guardianSurname], [relationshipToStudentId], [guardianTitleId], [guardianOccupationId], [guardianAddress], [guardianContactNumber], [sportsHouseId], [dateLeft], [reasonForStudentLeavingId], [emailAddress], [guardianEmailAddress], [studentMaritalStatusId], [guardianMaritalStatusId], [requiresTransportation], [studentContactNumber], [contractEndDate], [registeredBy], [status]) VALUES (4317, N'HCBD16F1026D', N'DENZEL', N'TANYARADZWA', N'SANYIKA', CAST(0xA5920000 AS SmallDateTime), CAST(0x91D80000 AS SmallDateTime), NULL, N'', 1, NULL, N'451 DAVIS1522 MAINWAY MEADOWS', 1, 2, 3, NULL, NULL, 0, 5, 1, N'FEROZA', N'CHISOKOCHEVANA', 2, 2, 165, N'1511 MAINWAY MEADOWS', N'0734 238 997', NULL, NULL, NULL, N'', N'1511 MAINWAY MEADOWS', 1, 2, 0, N'0734238997', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_students] OFF
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F3001D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1029D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1029D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1029D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1029D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1029D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1030D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1030D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1030D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1030D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1030D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1031D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1031D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1031D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1031D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1031D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1032D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1032D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1032D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1032D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1032D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F30020', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F30020', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F30020', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F30020', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F30020', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1035D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1035D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1035D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1035D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1035D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F2010D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F2010D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F2010D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F2010D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F2010D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F3001D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F3001D', N'History')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F3001D', N'Art')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F3001D', N'Science')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'Commerce')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1009D', N'History')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1020D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1020D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1020D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1020D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1020D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'Commerce')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1014D', N'History')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'Shona')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'Commerce')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1028D', N'History')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'Mathematics')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'English Language')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'Geography')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'Accounts')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'Commerce')
INSERT [dbo].[tbl_studentSubjects] ([studentId], [subjectId]) VALUES (N'HCBD16F1024D', N'History')
SET IDENTITY_INSERT [dbo].[tbl_subjects] ON 

INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (1, N'Mathematics')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (2, N'English Language')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (3, N'Shona')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (4, N'Geography')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (5, N'Accounts')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (6, N'Commerce')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (7, N'History')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (8, N'Fashion and Fabrics')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (9, N'Food and Nutrition')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (10, N'Computers')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (11, N'Art')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (12, N'Building')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (13, N'Technical Drawing')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (14, N'Agriculture')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (15, N'Science')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (16, N'Physical Science')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (17, N'Biology')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (18, N'Physics')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (19, N'Chemistry')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (20, N'English Literature')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (21, N'Religious & Moral Education')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (22, N'Human & Social Biology')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (23, N'Bible Knowledge')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (24, N'Business Studies')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (25, N'Economics')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (26, N'Sociology')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (27, N'Divinity')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (28, N'General Paper')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (29, N'Sub-Editing Journalism')
INSERT [dbo].[tbl_subjects] ([subjectId], [subject]) VALUES (30, N'COPS')
SET IDENTITY_INSERT [dbo].[tbl_subjects] OFF
SET IDENTITY_INSERT [dbo].[tbl_subjectTopics] ON 

INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (1, N'Soil Erosion', 4)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (2, N'Pollution', 4)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (3, N'Weathering', 4)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (4, N'Transport', 4)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (5, N'Nhetembo', 3)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (6, N'Grammar', 3)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (7, N'Sets', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (8, N'Shapes', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (9, N'Area', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (10, N'Volume', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (11, N'Quadratic Equations', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (12, N'Simultaneous Equations', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (13, N'Circle Geometry', 1)
INSERT [dbo].[tbl_subjectTopics] ([subjectTopicId], [subjectTopic], [subjectId]) VALUES (14, N'Locus', 1)
SET IDENTITY_INSERT [dbo].[tbl_subjectTopics] OFF
SET IDENTITY_INSERT [dbo].[tbl_suburbs] ON 

INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 1, N'Adbernie')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 2, N'Airport')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 3, N'Alex Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 4, N'Arcadia')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 5, N'Ashdown')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 6, N'Avenues')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 7, N'Avondale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 8, N'Avondale West')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 9, N'Belgravia')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 10, N'Belvedere')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 11, N'Bluffhill')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 12, N'Borrowdale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 13, N'Borrowdale Brooke')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 14, N'Borrowdale West')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 15, N'Braeside')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 16, N'Broadlands')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 17, N'BTD')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 18, N'Budiriro')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 19, N'Budiriro 1')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 20, N'Budiriro 2')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 21, N'Budiriro 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 22, N'Budiriro 4')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 23, N'Budiriro 5')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 24, N'Callaway')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 25, N'Camp')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 26, N'Chadcombe')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 27, N'Chartsworth')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 28, N'Chihota')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 29, N'Chikurubi Prison')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 30, N'Chishawasha Hills')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 31, N'Chisipite')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 32, N'Cold Comfort')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 33, N'Cranborne')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 34, N'Crowhill')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 35, N'Crowhill View')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 36, N'Crowrobough')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 37, N'Damofalls')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 38, N'Dawnville')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 39, N'Dzivarasekwa')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 40, N'Dzivarasekwa 2')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 41, N'Dzivarasekwa 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 42, N'Dzivarasekwa Extension')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 43, N'Eastlea')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 44, N'Eastview')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 45, N'Emerald Hill')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 46, N'Epworth')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 47, N'Fairfied')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 48, N'Flates')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 49, N'Gardens')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 50, N'Glamis')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 51, N'Glaudina')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 52, N'Glen Lorne')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 53, N'Glen Norah')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 54, N'Glen Norah A')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 55, N'Glen Norah B')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 56, N'Glen Norah C')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 57, N'Glen View')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 58, N'Glen View 1')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 59, N'Glen View 2')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 60, N'Glen View 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 61, N'Glen View 7')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 62, N'Glen View 8')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 63, N'Glenara Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 64, N'Glendale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 65, N'Glenforest')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 66, N'Glenhood Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 67, N'Glenwood')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 68, N'Goromonzi')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 69, N'Greencroft')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 70, N'Greendale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 71, N'Greystone Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 72, N'Gwebi College')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 73, N'Haig Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 74, N'Harare')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 75, N'Hatcliffe')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 76, N'Hatcliffe Extension')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 77, N'Hatfield')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 78, N'Helensvale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 79, N'Highfields')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 80, N'Highlands')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 81, N'Hillside')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 82, N'Houghton Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 83, N'Irvines')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 84, N'Kambuzuma')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 85, N'Kufakose')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 86, N'Kuwadzana')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 87, N'Kuwadzana 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 88, N'Kuwadzana 5')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 89, N'Kuwadzana 7')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 90, N'Kuwadzana Extension')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 91, N'Kuwadzana Phase 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 92, N'Lenana Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 93, N'Lockingva')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 94, N'Mabvuku')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 95, N'Mainway Meadows')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 96, N'Mandara')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 97, N'Manyame Airbase')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 98, N'Manyame Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 99, N'Manyame Training Centre')
GO
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 100, N'Maranatha Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 101, N'Marlbereign')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 102, N'Marlborough')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 103, N'Masasa')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 104, N'Masvingo')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 105, N'Mbare')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 106, N'Mbare Police Camp')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 107, N'Melbourne')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 108, N'Melfort Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 109, N'Merryic Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 110, N'Milton Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 111, N'Missing')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 112, N'Monavale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 113, N'Msasa')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 114, N'Msasa Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 115, N'Mt Hampden')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 116, N'Mt Pleasant')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 117, N'Mt Pleasant Heights')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 118, N'Mufakose')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 119, N'National Defence College')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 120, N'New Ceney Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 121, N'New Flats')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 122, N'New Mabvuku')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 123, N'New Marlborough')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 124, N'Newcene Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 125, N'Norton')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 126, N'Norton Jeffrey')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 127, N'Old Mazowe Road')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 128, N'Parktown')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 129, N'Pilanike')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 130, N'Prospect')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 131, N'Queen Elizabeth School')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 132, N'Queensdale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 133, N'Rhodesville Police Camp')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 134, N'Ridgeview')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 135, N'RoadWaterfalls')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 136, N'Rugare')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 137, N'Rusununguko')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 138, N'Ruwa')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 139, N'Sally Mugabe')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 140, N'Sam Levy')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 141, N'Section C Agriculture')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 142, N'Sentosa')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 143, N'Shevert')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 144, N'Southerton')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 145, N'Southlea Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 146, N'Souyhlands Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 147, N'St Martins')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 148, N'Stoneyridge Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 149, N'Strathaven')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 150, N'Sunningdale')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 151, N'Sunningdale 2')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 152, N'Sunningdale 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 153, N'Sunridge')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 154, N'Tafara')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 155, N'Tombli Flats')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 156, N'Tynwald')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 157, N'Tynwald South')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 158, N'Vainona')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 159, N'Warren')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 160, N'Warren Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 161, N'Warren Park 1')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 162, N'Warren Park D')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 163, N'Waterfalls')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 164, N'Westgate')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 165, N'Westlea')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 166, N'Westwood')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 167, N'Whitecliff')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 168, N'Zimre Park')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 169, N'Chitungwiza')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 170, N'St Marys')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 171, N'Zengeza 3')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 172, N'Zengeza 4')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 173, N'Manyame                       ')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 174, N'New Tafara                    ')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (2, 175, N'Seke                          ')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (1, 176, N'Snake Park                    ')
INSERT [dbo].[tbl_suburbs] ([cityId], [suburbId], [suburb]) VALUES (10, 177, N'Norton                        ')
SET IDENTITY_INSERT [dbo].[tbl_suburbs] OFF
SET IDENTITY_INSERT [dbo].[tbl_suppliers] ON 

INSERT [dbo].[tbl_suppliers] ([supplierId], [supplier], [address], [contactNumber], [contactPerson]) VALUES (1, N'Kingstones', N'12 Union Ave, Harare', N'04-5232762', N'Jonathan Tambo')
SET IDENTITY_INSERT [dbo].[tbl_suppliers] OFF
SET IDENTITY_INSERT [dbo].[tbl_systemModules] ON 

INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (1, N'Core Details')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (2, N'Staff Details')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (3, N'Classes')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (4, N'Assets')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (5, N'Library')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (6, N'Examination')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (7, N'Coarse Work')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (8, N'Extra-curricula Activities')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (9, N'School Administration')
INSERT [dbo].[tbl_systemModules] ([sysModuleId], [sysModule]) VALUES (10, N'System Administration')
SET IDENTITY_INSERT [dbo].[tbl_systemModules] OFF
SET IDENTITY_INSERT [dbo].[tbl_systemModuleSections] ON 

INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (1, N'Core Details', 1)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (2, N'Personal Details', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (3, N'Qualifications', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (4, N'Next of Kins', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (5, N'Subjects', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (6, N'Time-Tables', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (7, N'Exta-curricula Activities', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (8, N'Library', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (9, N'Assets', 2)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (10, N'Social Records', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (11, N'Enrolment', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (12, N'Regsiters', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (13, N'Subjects', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (14, N'Attendance', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (15, N'Teachers', 3)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (16, N'Inventory', 4)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (17, N'Disposed Assets', 4)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (18, N'Books List', 5)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (19, N'Lent out Books', 5)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (20, N'Returns', 5)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (21, N'Lost Books', 5)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (22, N'Examination Papers', 6)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (23, N'Examination Questions', 6)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (24, N'Examination Processing', 6)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (25, N'Examination Results', 6)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (26, N'Extra-curricula Activities', 8)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (27, N'Payments', 9)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (28, N'Behaviour Monitoring', 9)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (29, N'Scheduling', 9)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (30, N'Duty Roster', 9)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (31, N'Front Office', 9)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (32, N'System Parameters', 10)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (33, N'System Users', 10)
INSERT [dbo].[tbl_systemModuleSections] ([sysSectionId], [sysSection], [sysModuleId]) VALUES (34, N'Audit Trail', 10)
SET IDENTITY_INSERT [dbo].[tbl_systemModuleSections] OFF
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'admin', N'Leslie', N'Nyakudya', 1, N'123', 7, 1)
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'user1', N'Pauline ', N'Benza', 1, N'@User1', 1, 2)
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'xxxx', N'xxxx', N'xxxx', 1, N'777', 1, NULL)
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'viyugo', N'jboihpo', N'g08g08', 1, N'pp', 1, NULL)
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'mmmmm', N'mmmmm', N'Admin', 1, N'mmm', 1, NULL)
INSERT [dbo].[tbl_systemUsers] ([userId], [firstName], [lastName], [active], [password], [userGroupId], [id]) VALUES (N'sssssssss', N'ssssssssss', N'ssssssssss', 1, N'sss', 1, NULL)
SET IDENTITY_INSERT [dbo].[tbl_teams] ON 

INSERT [dbo].[tbl_teams] ([teamId], [team]) VALUES (1, N'Team A')
INSERT [dbo].[tbl_teams] ([teamId], [team]) VALUES (2, N'Team B')
SET IDENTITY_INSERT [dbo].[tbl_teams] OFF
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1009D', 33, 82, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1029D', 33, 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1030D', 22, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1031D', 23, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1032D', 26, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1035D', 54, 67, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1020D', 35, 43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1014D', 11, 82, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1028D', 67, 83, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'hrehrtt', N'HCBD16F1024D', 72, 90, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1029D', 56, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1030D', 35, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1031D', 67, 67, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1032D', 45, 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1035D', 88, 88, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1009D', 66, 65, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1020D', 87, 87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1014D', 56, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_testMarks] ([testId], [studentId], [markObtained], [percentage], [grade], [classPosition], [streamPosition], [positionDeviation], [testLevel], [stream_], [class_], [selected]) VALUES (N'X0001', N'HCBD16F1028D', 67, 67, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_testQuestionTypes] ON 

INSERT [dbo].[tbl_testQuestionTypes] ([testQtnTypeId], [testQtnType]) VALUES (1, N'Multiple Choice')
INSERT [dbo].[tbl_testQuestionTypes] ([testQtnTypeId], [testQtnType]) VALUES (2, N'Non-Multiple Choice')
SET IDENTITY_INSERT [dbo].[tbl_testQuestionTypes] OFF
SET IDENTITY_INSERT [dbo].[tbl_tests] ON 

INSERT [dbo].[tbl_tests] ([ctr], [testId], [subject], [testName], [stream], [dtDate], [highestPossibleMark], [description], [schClass]) VALUES (1, N'sdhtreh', N'Mathematics', N'[testName]', N'Form 1', CAST(0xA61F0000 AS SmallDateTime), 70, N'dfbdbgtn', N'1 Blue')
INSERT [dbo].[tbl_tests] ([ctr], [testId], [subject], [testName], [stream], [dtDate], [highestPossibleMark], [description], [schClass]) VALUES (2, N'hrehrtt', N'Mathematics', N'[testName]', N'Form 1', CAST(0xA61D0000 AS SmallDateTime), 80, N'thtrhjtrsjr', N'1 Blue')
INSERT [dbo].[tbl_tests] ([ctr], [testId], [subject], [testName], [stream], [dtDate], [highestPossibleMark], [description], [schClass]) VALUES (3, N'X0001', N'Shona', N'[testName]', N'Form 1', CAST(0xA6190000 AS SmallDateTime), 100, N'awgewgewg', N'1 Gold')
SET IDENTITY_INSERT [dbo].[tbl_tests] OFF
SET IDENTITY_INSERT [dbo].[tbl_titles] ON 

INSERT [dbo].[tbl_titles] ([titleId], [title]) VALUES (1, N'Mr')
INSERT [dbo].[tbl_titles] ([titleId], [title]) VALUES (2, N'Mrs')
INSERT [dbo].[tbl_titles] ([titleId], [title]) VALUES (3, N'Ms')
INSERT [dbo].[tbl_titles] ([titleId], [title]) VALUES (4, N'Miss')
INSERT [dbo].[tbl_titles] ([titleId], [title]) VALUES (5, N'Missing')
SET IDENTITY_INSERT [dbo].[tbl_titles] OFF
SET IDENTITY_INSERT [dbo].[tbl_transportSetAmounts] ON 

INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (1, N'January             ', 45.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (2, N'February            ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (3, N'March               ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (4, N'April               ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (5, N'May                 ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (6, N'June                ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (7, N'July                ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (8, N'August              ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (9, N'September           ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (10, N'October             ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (11, N'November            ', 20.0000, 2015)
INSERT [dbo].[tbl_transportSetAmounts] ([ctr], [mmonth], [amount], [yYear]) VALUES (12, N'December            ', 20.0000, 2015)
SET IDENTITY_INSERT [dbo].[tbl_transportSetAmounts] OFF
SET IDENTITY_INSERT [dbo].[tbl_tuitionPayments] ON 

INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1029D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 1, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'xxxxxxxxxx', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 2, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1030D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 3, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1031D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 4, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1032D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 5, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1033D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 6, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1034D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 7, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1035D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 8, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1036D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 9, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F3020', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 10, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1003D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 11, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1008D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 12, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1009D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 13, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1010D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 14, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1015D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 15, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16FI016D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 16, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1017D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 17, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1018D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 18, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1019D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 19, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1020D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 20, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1021D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 21, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1022D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 22, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1023', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 23, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1024D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 24, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1001D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 25, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1002D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 26, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1004D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 27, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1005', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 28, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1006D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 29, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1007D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 30, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1011D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 31, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1012D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 32, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1013D', 2016, N'May                 ', 60.0000, 180.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 33, N'H0000037')
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1014D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 34, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1027D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 35, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1028D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 36, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1025D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 37, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1026D', 2016, N'May                 ', 60.0000, 0.0000, 5, CAST(0xA641036F AS SmallDateTime), 0.0000, 38, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1029D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 39, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'xxxxxxxxxx', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 40, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1030D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 41, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1031D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 42, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1032D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 43, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1033D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 44, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1034D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 45, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1035D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 46, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1036D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 47, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F3020', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 48, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1003D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 49, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1008D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 50, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1009D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 51, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1010D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 52, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1015D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 53, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16FI016D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 54, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1017D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 55, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1018D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 56, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1019D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 57, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1020D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 58, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1021D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 59, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1022D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 60, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1023', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 61, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1024D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 62, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1001D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 63, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1002D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 64, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1004D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 65, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1005', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 66, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1006D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 67, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1007D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 68, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1011D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 69, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1012D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 70, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1013D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 71, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1014D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 72, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1027D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 73, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1028D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 74, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1025D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 75, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1026D', 2016, N'Jun                 ', 60.0000, 0.0000, 6, CAST(0xA641036F AS SmallDateTime), 0.0000, 76, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1029D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 77, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'xxxxxxxxxx', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 78, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1030D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 79, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1031D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 80, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1032D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 81, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1033D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 82, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1034D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 83, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1035D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 84, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1036D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 85, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F3020', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 86, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1003D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 87, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1008D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 88, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1009D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 89, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1010D', 2016, N'Jul                 ', 60.0000, 180.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 90, N'H0000048')
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1015D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 91, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16FI016D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 92, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1017D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 93, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1018D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 94, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1019D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 95, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1020D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 96, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1021D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 97, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1022D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 98, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1023', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 99, NULL)
GO
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1024D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 100, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1001D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 101, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1002D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 102, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1004D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 103, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1005', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 104, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1006D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 105, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1007D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 106, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1011D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 107, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1012D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 108, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1013D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 109, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1014D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 110, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1027D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 111, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1028D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 112, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1025D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 113, NULL)
INSERT [dbo].[tbl_tuitionPayments] ([studentId], [intYear], [strMonth], [expectedAmt], [amountPaid], [monthNumber], [date], [penalty], [tuitionPaymentId], [receiptNumber]) VALUES (N'HCBD16F1026D', 2016, N'Jul                 ', 60.0000, 0.0000, 7, CAST(0xA641036F AS SmallDateTime), 0.0000, 114, NULL)
SET IDENTITY_INSERT [dbo].[tbl_tuitionPayments] OFF
INSERT [dbo].[tbl_tuitionPenaltyRates] ([range], [fromDayNumber], [toDayNumber], [penaltyAmount]) VALUES (N'Range 1   ', 2, 8, 10.0000)
INSERT [dbo].[tbl_tuitionPenaltyRates] ([range], [fromDayNumber], [toDayNumber], [penaltyAmount]) VALUES (N'Range 2   ', 9, 15, 20.0000)
INSERT [dbo].[tbl_tuitionPenaltyRates] ([range], [fromDayNumber], [toDayNumber], [penaltyAmount]) VALUES (N'Range 3   ', 16, 22, 30.0000)
INSERT [dbo].[tbl_tuitionPenaltyRates] ([range], [fromDayNumber], [toDayNumber], [penaltyAmount]) VALUES (N'Range 4   ', 23, 31, 40.0000)
SET IDENTITY_INSERT [dbo].[tbl_uniformItems] ON 

INSERT [dbo].[tbl_uniformItems] ([uniformItemId], [uniformItem], [price]) VALUES (1, N'Shirt                         ', 20.0000)
INSERT [dbo].[tbl_uniformItems] ([uniformItemId], [uniformItem], [price]) VALUES (2, N'Trousers                      ', 20.0000)
INSERT [dbo].[tbl_uniformItems] ([uniformItemId], [uniformItem], [price]) VALUES (1002, N'jersy                         ', 20.0000)
INSERT [dbo].[tbl_uniformItems] ([uniformItemId], [uniformItem], [price]) VALUES (2002, N'Blazers                       ', 80.0000)
INSERT [dbo].[tbl_uniformItems] ([uniformItemId], [uniformItem], [price]) VALUES (2003, N'Track Suits                   ', 80.0000)
SET IDENTITY_INSERT [dbo].[tbl_uniformItems] OFF
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (1, N'T-shirts                      ', 10.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (2, N'Tie                           ', 7.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (3, N'Trousers                      ', 10.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (4, N'Shirt                         ', 10.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (5, N'Skirt                         ', 10.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (6, N'Charlie Pleat Skirt           ', 15.0000)
INSERT [dbo].[tbl_uniformItems2] ([uniformItemId], [uniformItem], [price]) VALUES (7, N'Report Book                   ', 4.0000)
SET IDENTITY_INSERT [dbo].[tbl_uniformSales] ON 

INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (1, CAST(0x0000A5A700000000 AS DateTime), N'0         ', N'HCBD16F3001D', N'Shirt               ', 20.0000, 2, 40.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (2, CAST(0x0000A5A700000000 AS DateTime), N'0         ', N'HCBD16F3001D', N'Shirt               ', 20.0000, 1, 20.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (3, CAST(0x0000A5A700000000 AS DateTime), N'0         ', N'HCBD16F3001D', N'jersy               ', 20.0000, 3, 60.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (4, CAST(0x0000A5A700000000 AS DateTime), N'0         ', N'HCBD16F3001D', N'Shirt               ', 20.0000, 1, 20.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (5, CAST(0x0000A60400000000 AS DateTime), N'0         ', N'gugghi', N'Shirt               ', 20.0000, 90, 1800.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (6, CAST(0x0000A60400000000 AS DateTime), N'1         ', N'bihiojo', N'Shirt               ', 20.0000, 90, 1800.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (7, CAST(0x0000A60400000000 AS DateTime), N'1         ', N'bihiojo', N'Shirt               ', 20.0000, 90, 1800.0000)
INSERT [dbo].[tbl_uniformSales] ([saleId], [dtDate], [receiptNumber], [studentId], [uniformItem], [unitPrice], [quantity], [totalPrice]) VALUES (8, CAST(0x0000A60400000000 AS DateTime), N'1         ', N'bihiojo', N'Shirt               ', 20.0000, 90, 1800.0000)
SET IDENTITY_INSERT [dbo].[tbl_uniformSales] OFF
SET IDENTITY_INSERT [dbo].[tbl_userGroups] ON 

INSERT [dbo].[tbl_userGroups] ([userGroupId], [userGroup]) VALUES (1, N'Admin')
INSERT [dbo].[tbl_userGroups] ([userGroupId], [userGroup]) VALUES (2, N'SystemUser')
SET IDENTITY_INSERT [dbo].[tbl_userGroups] OFF
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (1, N'Developer')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (2, N'System Administrator')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (3, N'CEO')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (4, N'Principal')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (5, N'Adminstration')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (6, N'Front Office')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (7, N'Teacher')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (8, N'Librarian')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (9, N'Student')
INSERT [dbo].[tbl_userGroups2] ([userGroupId], [userGroup]) VALUES (10, N'Guardian')
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 1, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 4, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 10, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 11, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 12, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 13, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 15, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 19, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 20, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 22, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 23, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 24, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 25, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 26, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 29, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 32, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 33, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (2, 34, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (6, 10, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (6, 11, -1, 0)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (6, 31, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 1, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 10, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 11, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 12, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 13, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 14, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 15, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 22, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 23, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 24, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 25, -1, -1)
INSERT [dbo].[tbl_userGroupSysPermissions2] ([userGroupId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (7, 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'admin', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1018C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1018C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1018C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1018C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1019C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1020C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1021C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1022C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1023C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1024C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1025C', 26, -1, -1)
GO
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1026C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1027C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1028C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1029C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1030C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1031C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1032C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1033C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 12, -1, -1)
GO
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1034C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1035C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1037C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 1, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 11, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 12, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 14, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'H1038C', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA10', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA10', 11, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA10', 31, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA11', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA11', 11, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA11', 31, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 1, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 2, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 3, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 4, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 6, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 7, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 8, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 9, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 11, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 12, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 13, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 14, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 15, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 16, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 17, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 18, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 19, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 20, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 22, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 23, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 24, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 25, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 26, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 28, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 29, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 31, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 32, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 33, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'HA12', 34, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 2, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 4, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 6, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 7, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 8, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 9, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 10, -1, -1)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 11, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 13, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 15, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 16, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 17, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 18, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 19, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 20, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 23, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 25, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 26, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 27, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 28, -1, 0)
GO
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 29, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 30, -1, 0)
INSERT [dbo].[tbl_userSysPermissions2] ([userId], [sysModuleSectionId], [sysRead], [sysWrite]) VALUES (N'XX005', 31, -1, -1)
SET IDENTITY_INSERT [dbo].[tblReports] ON 

INSERT [dbo].[tblReports] ([ReportID], [Code], [Description], [LeftValue], [RightValue], [ParentID], [TreeID], [ReportName], [IsContainerOnly], [IsSingleSelectionTree], [IsSearchable], [Mem2000Match], [XMLString], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsSubscriptionBased], [ReportActionsXML], [ReportData], [IsEditable], [HasParameters], [DisplayGroupTree]) VALUES (1, NULL, N'Reports', 1, 2, NULL, 1, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'<ReportActions>   <ReportAction>    <Text>Email Report</Text>    <value>Email</value>   </ReportAction>   <ReportAction>    <Text>Save As Excel</Text>    <value>SaveExcel</value>   </ReportAction>   <ReportAction>    <Text>Save As PDF</Text>    <value>Save</value>   </ReportAction>   <ReportAction>    <Text>Save As Word</Text>    <value>SaveWord</value>   </ReportAction>  </ReportActions>', NULL, 0, 0, 0)
INSERT [dbo].[tblReports] ([ReportID], [Code], [Description], [LeftValue], [RightValue], [ParentID], [TreeID], [ReportName], [IsContainerOnly], [IsSingleSelectionTree], [IsSearchable], [Mem2000Match], [XMLString], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsSubscriptionBased], [ReportActionsXML], [ReportData], [IsEditable], [HasParameters], [DisplayGroupTree]) VALUES (3, NULL, N'Tuition Receipts', 3, 4, 1, 1, N'Reports\Receipt', 0, NULL, 0, NULL, N'<ReportCriteria>
  <UserInputFields>
	<UserInputField>
    <ControlName>{vwStudentReports.studentId}</ControlName>
    <DBField>{vwStudentReports.studentId}</DBField>
    <ControlType>text</ControlType>
    <Label>Student Number</Label>
    </UserInputField>
    <UserInputField>
	<ControlName>{vwStudentReports.tuitionPaymentId}</ControlName>
      <DBField>{vwStudentReports.tuitionPaymentId}</DBField>
      <ControlType>text</ControlType>
      <Label>Receipt No</Label>
    </UserInputField>
  </UserInputFields>
  <Cookies>
  </Cookies>
</ReportCriteria>', NULL, NULL, NULL, NULL, NULL, N'<ReportActions>   <ReportAction>    <Text>Email Report</Text>    <value>Email</value>   </ReportAction>   <ReportAction>    <Text>Save As Excel</Text>    <value>SaveExcel</value>   </ReportAction>   <ReportAction>    <Text>Save As PDF</Text>    <value>Save</value>   </ReportAction>   <ReportAction>    <Text>Save As Word</Text>    <value>SaveWord</value>   </ReportAction>  </ReportActions>', NULL, 0, 0, 0)
INSERT [dbo].[tblReports] ([ReportID], [Code], [Description], [LeftValue], [RightValue], [ParentID], [TreeID], [ReportName], [IsContainerOnly], [IsSingleSelectionTree], [IsSearchable], [Mem2000Match], [XMLString], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsSubscriptionBased], [ReportActionsXML], [ReportData], [IsEditable], [HasParameters], [DisplayGroupTree]) VALUES (4, NULL, N'Levy Receipts', 5, 6, 1, 1, N'Reports\LevyReceipt', 0, NULL, 0, NULL, N'<ReportCriteria>
  <UserInputFields>
	<UserInputField>
    <ControlName>{vwLevyReceipt.studentd}</ControlName>
    <DBField>{vwLevyReceipt.studentd}</DBField>
    <ControlType>text</ControlType>
    <Label>Student Number</Label>
    </UserInputField>
    <UserInputField>
	<ControlName>{vwLevyReceipt.levyPaymentId}</ControlName>
      <DBField>{vwLevyReceipt.levyPaymentId}</DBField>
      <ControlType>text</ControlType>
      <Label>Receipt No</Label>
    </UserInputField>
  </UserInputFields>
  <Cookies>
  </Cookies>
</ReportCriteria>', NULL, NULL, NULL, NULL, NULL, N'<ReportActions>   <ReportAction>    <Text>Email Report</Text>    <value>Email</value>   </ReportAction>   <ReportAction>    <Text>Save As Excel</Text>    <value>SaveExcel</value>   </ReportAction>   <ReportAction>    <Text>Save As PDF</Text>    <value>Save</value>   </ReportAction>   <ReportAction>    <Text>Save As Word</Text>    <value>SaveWord</value>   </ReportAction>  </ReportActions>', NULL, 0, 0, 0)
INSERT [dbo].[tblReports] ([ReportID], [Code], [Description], [LeftValue], [RightValue], [ParentID], [TreeID], [ReportName], [IsContainerOnly], [IsSingleSelectionTree], [IsSearchable], [Mem2000Match], [XMLString], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [IsSubscriptionBased], [ReportActionsXML], [ReportData], [IsEditable], [HasParameters], [DisplayGroupTree]) VALUES (5, NULL, N'Payments by Cashier', 7, 8, 1, 1, N'Reports\paymentsByCashier', 0, NULL, 0, NULL, N'<ReportCriteria>
  <UserInputFields>
        <UserInputField>           
		<ControlName>vwAllPayments_Date</ControlName>      
		<DBField>{vwProjects.StartDate}</DBField>       
		<ControlType>daterange</ControlType>           
		<Label>Payment Date</Label>     
        </UserInputField> 
	<UserInputField>          
		<ControlName>vwAllPayments_Cashier</ControlName>          
		<DBField>{vwAllPayments.cashier}</DBField>          
		<ControlType>combo</ControlType>          
		<Label>Cashier</Label>          
		<DBQuery>SELECT [firstName] + '' '' + [lastName] AS [Name] FROM [tbl_systemUsers]</DBQuery><UseQuotes>1</UseQuotes>        
	</UserInputField>        
  </UserInputFields>
  <Cookies>
  </Cookies>
</ReportCriteria>', NULL, NULL, NULL, NULL, NULL, N'<ReportActions>   <ReportAction>    <Text>Email Report</Text>    <value>Email</value>   </ReportAction>   <ReportAction>    <Text>Save As Excel</Text>    <value>SaveExcel</value>   </ReportAction>   <ReportAction>    <Text>Save As PDF</Text>    <value>Save</value>   </ReportAction>   <ReportAction>    <Text>Save As Word</Text>    <value>SaveWord</value>   </ReportAction>  </ReportActions>', NULL, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[tblReports] OFF
ALTER TABLE [dbo].[tblFiles] ADD  CONSTRAINT [DF_tblFiles_ApplySecurity]  DEFAULT ((0)) FOR [ApplySecurity]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[25] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_allPayments"
            Begin Extent = 
               Top = 6
               Left = 8
               Bottom = 212
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_students"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 211
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwAllPayments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwAllPayments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[11] 4[50] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -1217
      End
      Begin Tables = 
         Begin Table = "tbl_allPayments"
            Begin Extent = 
               Top = 18
               Left = 23
               Bottom = 247
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_students"
            Begin Extent = 
               Top = 19
               Left = 491
               Bottom = 209
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tbl_schoolClasses"
            Begin Extent = 
               Top = 16
               Left = 779
               Bottom = 129
               Right = 949
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_streams"
            Begin Extent = 
               Top = 89
               Left = 1014
               Bottom = 185
               Right = 1184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_LevyPayments"
            Begin Extent = 
               Top = 16
               Left = 255
               Bottom = 242
               Right = 451
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLevyReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1800
         Table = 3015
         Output = 1665
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLevyReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwLevyReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[13] 2[48] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2280
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStudentReports'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStudentReports'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[17] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_schoolClasses"
            Begin Extent = 
               Top = 13
               Left = 261
               Bottom = 126
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_students"
            Begin Extent = 
               Top = 17
               Left = 469
               Bottom = 251
               Right = 702
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tbl_streams"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3630
         Alias = 1755
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTotalEnrolmentByClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTotalEnrolmentByClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[24] 2[38] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "derivedtbl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTotalEnrolmentByClassBySex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwTotalEnrolmentByClassBySex'
GO
USE [master]
GO
ALTER DATABASE [SchoolAd] SET  READ_WRITE 
GO
