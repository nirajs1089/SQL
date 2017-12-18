USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_deleteCC]    Script Date: 5/8/2016 11:36:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
		ALTER PROCEDURE [dbo].[sp_updateCC] 
			-- Add the parameters for the stored procedure here
			@clientID int,
			@CC varchar(20),
			@expDate varchar(10)

		AS
				BEGIN

				declare @clientCount as int
				declare @CCcount as int
				declare @errMsg as nvarchar(30)


-------------------------------------------------------------------------------

	 set @CCcount = (select count(*) from CreditCard
					where [Hash] = CIS_ZZZ.dbo.HashCC(@CC))

					---------------------------------------------------------------


		if(cast(@clientID as int) > 0)
			BEGIN
				print '+ve Client ID'
			END
		else
			BEGIN
						set @errMsg = 'negativeClientID'
						goto errsection
			END


       if((isdate(@expDate)=1))  --and len(@expDate) = 10
		 BEGIN	
		      if (DATEDIFF(day, GETDATE(),@expDate) <= 0)
				BEGIN
						set @errMsg = 'pastDate'
						goto errsection 
				END	
		 END
		else
			BEGIN
						set @errMsg = 'malformedDate'
						goto errsection
			END



		BEGIN TRY
			if(cast(@CC as numeric(20,0)) > 0 and (@CC NOT LIKE '%' + '.' + '%'))  ----2
						BEGIN
						     if((left(@CC,1)='4') and (len(@CC)=13 or len(@CC)=16 or len(@CC)=19))   -- VISA
									BEGIN
											if @CCcount = 0  -- DUPLICATE CC
													BEGIN
															if(@clientID > 0)
																		BEGIN  -----1
																			set @clientCount = (select count(*) from CreditCard
																								where ClientID = @clientID
																								and ExpirationDate = @expDate)

																			if @clientCount = 1
																				BEGIN
																				
																					update CreditCard
																							set ExpirationDate = @expDate																																														
																							where ClientID = @clientID
																								and CIS_ZZZ.dbo.HashCC(@CC) = @CC
																				

																				END
																			else
																				BEGIN
																					 set @errMsg = 'notexistClientID'
																					goto errsection	
																			  
																				END


																		END  -----1
															else
																		BEGIN  ----1
																					set @errMsg = 'negativeClientID'
																					goto errsection
																		END    -----1
													 END  -- DUPLICATE CC
												else
													BEGIN
														set @errMsg = 'duplicateCC'
															goto errsection
													END -- DUPLICATE CC
									END
								 else    -- VISA
									BEGIN

											set @errMsg = 'smallerLength'
											goto errsection												
									
									END		

						END ----2
			else
					BEGIN  ----2
								set @errMsg = 'negativeCreditCard'
								goto errsection
					END ----2



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
						RAISERROR('Invalid combination of ClientID and ExpiryDate',16,1);
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
				else if(@errMsg = 'smallerLength')
					BEGIN
						RAISERROR('Invalid VISA Credit Card',16,1);
						RETURN
					END
				else if(@errMsg = 'biggerLength')
					BEGIN
						RAISERROR('Invalid VISA Credit Card',16,1);
						RETURN
					END
				else if(@errMsg = 'negative')
					BEGIN
						RAISERROR('Credit Card is -ve null or malformed.',16,1);
						RETURN	
					END
				else if(@errMsg = 'duplicateCC')
					BEGIN
						RAISERROR('Duplicate CreditCard',16,1);
						RETURN
					END		
			   else if(@errMsg = 'malformedDate')
					BEGIN
						RAISERROR('Date is malformed',16,1);
						RETURN	
					END
				else if(@errMsg = 'pastDate')
					BEGIN
						RAISERROR('Date is expired',16,1);
						RETURN	
					END	

				 
END
