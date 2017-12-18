USE [CIS_ZZZ]
GO

							select 
								([Cid]) as WrongNameID,
									  --,[F]
									  --,[L],
								count([Cid]) as numWrongNames
						from 
								(SELECT 
										([ClientID]) as Cid
									  ,[First] as F
									  ,[Last] as L
									  --[CreditCard]
									  --,[Expiration]
								  FROM [dbo].[CC_Data]
								  --Where len([CreditCard])  = 16
								  --order by [ClientID]

								  group by [ClientID]
										  ,[First]
										  ,[Last]) as one
						group by ([Cid])
									  --,[F]
									  --,[L]
									  having count([Cid]) > 1
									  
		   --HAVING COUNT(ClientID) > 1
GO


update [CC_Data] 
set [Last]='Busey'
Where ClientID = 3


update [CC_Data] 
set [Last]='Velasquez'
Where ClientID = 8



----------distinct of id,f,n---count of id >  1  and CC count > 1
SELECT distinct  
		([ClientID])
      ,[First]
      ,[Last],
      --[CreditCard]
      --,[Expiration],
	  count([ClientID])
  FROM [dbo].[CC_Data]
  Where len([CreditCard])  = 16
  group by [ClientID]
		  ,[First]
		  ,[Last]
----------lookup 



OPEN SYMMETRIC KEY CreditCardKey DECRYPTION BY certificate CreditCardCert;

			INSERT INTO CreditCard VALUES (CIS_ZZZ.dbo.HashCC(SELECT [CreditCard] FROM [dbo].[CC_Data]),  -- Hash
											EncryptByKey(Key_GUID('CreditCardKey'), ), --Encrypted
											SELECT [CreditCard] FROM [dbo].[CC_Data], --PlainText
											@lastFour,  --LastFour
											1,  --ServiceCode
											@expDate,  --ExpirationDate
											@clientID); --ClientID

				CLOSE SYMMETRIC KEY CreditCardKey;
		


OPEN SYMMETRIC KEY CreditCardKey DECRYPTION BY certificate CreditCardCert;

INSERT INTO CreditCard ([Hash],Encrypted,PlainText,LastFour,ServiceCode,ExpirationDate, [ClientID])
								SELECT CIS_ZZZ.dbo.HashCC([CreditCard]) as [Hash],
									   EncryptByKey(Key_GUID('CreditCardKey'),[CreditCard]) as Encrypted,
									   [CreditCard] as PlainText,
									   RIGHT([CreditCard],4) as LastFour,
									   1 as ServiceCode,
									  [Expiration] as ExpirationDate, 
									  [ClientID]
								  FROM [dbo].[CC_Data]

								  CLOSE SYMMETRIC KEY CreditCardKey;
							  
GO
