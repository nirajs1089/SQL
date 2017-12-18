USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieveCC]    Script Date: 5/8/2016 10:46:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
		ALTER PROCEDURE [dbo].[sp_deleteCC] 
			-- Add the parameters for the stored procedure here
			@clientID int,
			@CC varchar(20)
		AS
				BEGIN

				declare @clientCount as int
				declare @errMsg as nvarchar(30)

		BEGIN TRY
			if(cast(@CC as numeric(20,0)) > 0)  --
						BEGIN
										if(@clientID > 0)
													BEGIN
														set @clientCount = (select count(*) from CreditCard
																			where ClientID = @clientID
																			and CIS_ZZZ.dbo.HashCC(@CC) = [Hash])

														if @clientCount > 0 
															begin

																Delete from CreditCard
																			where ClientID = @clientID
																			and CIS_ZZZ.dbo.HashCC(@CC) = [Hash]
															end
														else
															BEGIN
																 set @errMsg = 'notexistClientID'
																goto errsection	
																			  
															END


													END
										else
													BEGIN
																set @errMsg = 'negativeClientID'
																goto errsection
													END
						END
			else
													BEGIN
																set @errMsg = 'negativeCreditCard'
																goto errsection
													END



			END TRY
			BEGIN CATCH	  

			
				DECLARE @ErrorState INT = ERROR_STATE();
				DECLARE @ErrorSeverity INT = ERROR_SEVERITY();

				RAISERROR('CreditCard is non numeric null or malformed.',@ErrorSeverity,@ErrorState);
				RETURN
				
				
			END CATCH;	

			errsection: 

				if(@errMsg = 'notexistClientID')
					BEGIN
						RAISERROR('Invalid combination of ClientID and CreditCard',16,1);
						RETURN
					END
				else if(@errMsg = 'negativeClientID')
					BEGIN
						RAISERROR('ClientID is negative',16,1);
						RETURN
					END
				else if(@errMsg = 'negativeCreditCard')
					BEGIN
						RAISERROR('CreditCard is negative',16,1);
						RETURN
					END


				 
END
