USE [CIS_ZZZ]
GO
/****** Object:  StoredProcedure [dbo].[sp_insertCC]    Script Date: 5/8/2016 12:20:06 PM ******/
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
	@clientID varchar(16),
	@CC varchar(20), 
	@expDate varchar(10)
AS
BEGIN



     declare @clientCount as int
	 declare @CCcount as int
	 declare @errMsg as nvarchar(30)


-------------------------------------------------------------------------------

	 --set @CCcount = (select count(*) from CreditCard
		--			where [Hash] = CIS_ZZZ.dbo.HashCC(@CC))

    
--	-------------------------------------------------------------------------------

	 --if((isnumeric(@clientID)=1) ) 
		-- BEGIN
			 
						if(cast(@clientID as int) < 0)							
							BEGIN
										set @errMsg = 'negativeClientID'
										goto errsection
							END
				
		-- END
	 --else
		-- BEGIN
		--	RAISERROR('Client ID IS MALFORMED',16,1);
		--	RETURN 
			  
		-- END
            
------------------------------------------------------------------------------------------------------
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

		--------------------------------------------------------------------------------------------	
			--if((isnumeric(@CC)=1)) 
			--	BEGIN
			--		print '---numeric -----'
			--	END   -- isnumeric
			--else      -- isnumeric
			--	BEGIN
			--		--print 'malformed'
			--		RAISERROR('Credit Card is non numeric null or malformed.',16,1);	
			--		RETURN
			--	END

			--------------------------------------------------------------------------------------------
				BEGIN TRY
								if(cast(@CC as numeric(20,0)) > 0 and (@CC NOT LIKE '%' + '.' + '%'))  --
									BEGIN
										--print '---positive-----'
										
											if((left(@CC,1)='4') and (len(@CC)=13 or len(@CC)=16 or len(@CC)=19))   -- 
												BEGIN
													--print 'Done!'
														
														set @clientCount = (select count(*) from CreditCard
																								where ClientID = @clientID
																								and [Hash]= CIS_ZZZ.dbo.HashCC(@CC))

																			if (@clientCount = 1)
																				BEGIN
																
																				update CreditCard
																				set ExpirationDate = @expDate
																				where ClientID = @clientID																																													
																				and [Hash]= CIS_ZZZ.dbo.HashCC(@CC)

																				END
																			else
																				BEGIN
																					 set @errMsg = 'notexistClientID'
																					goto errsection	
																			  
																				END
															
												END

											else    --LESS OR BIGGER LENGTH
												BEGIN

												--if(len(@CC) < 11) 
												--	BEGIN
													   --print '< 11'
													  set @errMsg = 'smallerLength'
													  goto errsection
												--	END
												--else if(len(@CC) > 20)
												--	BEGIN
												--		--print '> 20'
												--		set @errMsg = 'biggerLength'	
												--		goto errsection
												--	END
									
										END						   
									END
								else
									BEGIN
										--print 'negative'
										set @errMsg = 'negative'
										goto errsection
									END
					END TRY
			BEGIN CATCH	  

			
				DECLARE @ErrorState INT = ERROR_STATE();
				DECLARE @ErrorSeverity INT = ERROR_SEVERITY();

				RAISERROR('Credit Card is non numeric null or malformed.',@ErrorSeverity,@ErrorState);
						RETURN
				
				
			END CATCH;	
			--------positive  integer 
			-------------length----------

errsection: 

				if(@errMsg = 'smallerLength')
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
				else if(@errMsg = 'negativeClientID')
					BEGIN
						RAISERROR('Client ID and CreditCard is invalid',16,1);
						RETURN	
					END
				else if(@errMsg = 'notexistClientID')
					BEGIN
						RAISERROR('Client ID does not exist',16,1);
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