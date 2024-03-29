USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_retrieveCC]    Script Date: 5/8/2016 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
		ALTER PROCEDURE [dbo].[sp_retrieveCC] 
			-- Add the parameters for the stored procedure here
			@clientID int
		AS
				BEGIN

				declare @clientCount as int
				declare @errMsg as nvarchar(30)

		BEGIN TRY

				if(cast(@clientID as int) > 0)
							BEGIN
								set @clientCount = (select count(*) from Client
													where ClientID = @clientID)

								if @clientCount <= 0 
									begin
										set @errMsg = 'notexistClientID'
										goto errsection
									end
								else
								    BEGIN
										 SELECT Hash,convert (varchar, DecryptByKeyAutoCert(cert_id('CreditCardCert'), NULL, Encrypted)) 
										  as DecryptedCC, ExpirationDate
										  from CreditCard where clientID = @clientID;

									END

							END
				else
							BEGIN
										set @errMsg = 'negativeClientID'
										goto errsection
							END
			END TRY
			BEGIN CATCH	  

			
				DECLARE @ErrorState INT = ERROR_STATE();
				DECLARE @ErrorSeverity INT = ERROR_SEVERITY();

				RAISERROR('Client ID is non numeric null or malformed.',@ErrorSeverity,@ErrorState);
				RETURN
				
				
			END CATCH;	

			errsection: 

				if(@errMsg = 'notexistClientID')
					BEGIN
						RAISERROR('ClientID does not exist',16,1);
						RETURN
					END
				else if(@errMsg = 'negativeClientID')
					BEGIN
						RAISERROR('ClientID is negative',16,1);
						RETURN
					END


				 
END
