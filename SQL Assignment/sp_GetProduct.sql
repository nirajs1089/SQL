USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProduct]    Script Date: 4/24/2016 6:19:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetProduct]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@id varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @id2 int;
	DECLARE @err int;
	
	if(len(@id) = 0)
			RAISERROR('ProductID is null or malformed.',16,1);	
			

			BEGIN TRY
				 --Generate a constraint violation error.

				 


				 set @id2 =cast(@id as int)
				--set @id ='0%20or%201=1';
				--exec @err = [dbo].[sp_TestGetProduct] @id;
				
				--print @err;
				select prodName
				from products
				where id = @id2--cast(@id as int);
			END TRY
			BEGIN CATCH
				--print 'ERROR: ProductID is null or malformed.';
				--select @ErrorSeverity,@ErrorState;
				DECLARE @ErrorState INT = ERROR_STATE();
				DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
				--print @ErrorState;
				--print @ErrorSeverity;
				RAISERROR('ProductID is null or malformed.',@ErrorSeverity,@ErrorState);
				--THROW;
			END CATCH;


    -- Insert statements for procedure here
	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END
