USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_insertCC]    Script Date: 5/5/2016 9:22:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_insertCC] 
	-- Add the parameters for the stored procedure here
	@clientID varchar(16), @CC varchar(20), @expDate varchar(10), @lastFour varchar(4)
AS
BEGIN

     declare @clientCount as int

	 if((isnumeric(@clientID)=1) ) 
		 BEGIN
			 
						if(cast(@clientID as int) > 0)
							BEGIN
								set @clientCount = (select count(*) from Client
													where ClientID = @clientID)

								if @clientCount <= 0 
									begin
										RAISERROR('Invalid Client ID',16,1);
										RETURN 
									end

							END
						else
							BEGIN
										RAISERROR('Invalid Client ID',16,1);
										RETURN 
							END
				
		 END
	 else
		 BEGIN
			RAISERROR('Client ID IS MALFORMED',16,1);
			RETURN 
			  
		 END
            

		 if((isdate(@expDate)=1) ) 
		 BEGIN	
			if (DATEDIFF(day, GETDATE(),@expDate) <= 0)
				BEGIN
					RAISERROR('Expiry date is in the past.',16,1);
					RETURN 
				END
		END
		else
			BEGIN
					RAISERROR('Expiry date is MALFORMED.',16,1);
					RETURN 
			END

			
			if((isnumeric(@CC)=1)) 
				BEGIN
				print '---numeric -----'
								if(cast(@CC as numeric(20,0)) > 0) 
									BEGIN
										print '---positive-----'
											if((len(@CC) > 11) and (len(@CC) < 21)) 
												BEGIN
													print 'Done!'

															OPEN SYMMETRIC KEY CreditCardKey DECRYPTION BY certificate CreditCardCert;
																																															--   OPEN SYMMETRIC KEY CreditCardKey DECRYPTION BY certificate CreditCardCert;

															INSERT INTO CreditCard VALUES (CIS_ZZZ.dbo.HashCC(@CC),  -- Hash
																							EncryptByKey(Key_GUID('CreditCardKey'), @CC), --Encrypted
																							@CC, --PlainText
																							@lastFour,  --LastFour
																							1,  --ServiceCode
																							cast(@expDate as date),  --ExpirationDate
																							cast(@clientID as int)); --ClientID

															IF @@ERROR <> 0 
															  BEGIN
																CLOSE SYMMETRIC KEY CreditCardKey;
																RETURN(1)
															  END
															ELSE
															  BEGIN
																CLOSE SYMMETRIC KEY CreditCardKey;
														--		RETURN(0)
															  END
												END

											else    --LESS OR BIGGER LENGTH
												BEGIN

												if(len(@CC) < 11) 
													BEGIN
													   print '< 11'
													   RAISERROR('Credit Card is null or malformed.',16,1);	
													END
												else if(len(@CC) > 20)
													BEGIN
														print '> 20'
														RAISERROR('Credit Card is null or malformed.',16,1);	
													END
									
										END						   
									END
								else
									BEGIN
										print 'negative'
										RAISERROR('Credit Card is null or malformed.',16,1);	
									END
						   
				END
			else
				BEGIN
					print 'malformed'
					RAISERROR('Credit Card is null or malformed.',16,1);	
				END
						--RAISERROR('ProductID is null or malformed.',16,1);	
			--------positive  integer 
			-------------length----------




			
								  

				
END
