USE [HayneExample]
GO

SELECT top 100000 [AuctionID]
      ,[ObjectID]
      ,[WinBid]
      --,[StartDate]
      --,[EndDate]
      ,[FirstBid]
      --,[TotalBids]
      ,[TakeItOrLeaveIt]  -- *
      ,[BuyItNow]		 -- *
      --,[BuyItNowPrice]
      --,[BuyItNowEnd]
      --,[BuyItNowLowered]
      --,[ReserveNotMet]
      --,[ReserveLowered]
      --,[SellerID]
      --,[SellerRating]
      --,[SellerFeedback]
      --,[InputDate]
      ,[Category]
      --,[SiteCountry]
      ,[VIN]
      --,[RelistAuctionID]
      --,[Shipping]
  FROM [dbo].[Summary]
  order by [ObjectID],[AuctionID],[WinBid] asc
GO 


SELECT distinct [BuyItNow]
FROM [dbo].[Summary]
order by [WinBid] asc
 
SELECT [ObjectID],count([AuctionID]) as co
FROM [dbo].[Summary]
group by [ObjectID]
order by co desc
 
SELECT [ObjectID],count([WinBid]) as co
FROM [dbo].[Summary]
where [WinBid] is not null
group by [ObjectID]
order by co desc
------------------


SELECT [ObjectID],cast((count([AuctionID])/count([WinBid])) as decimal(5,2)) as ratio

	SELECT
	   test.[ObjectID],descr.Description,wins,(auc/wins) as ratio
	FROM
		(
			SELECT [ObjectID],count([AuctionID]) as auc,count([WinBid]) as wins
			FROM [dbo].[Summary]
			group by [ObjectID]
			--order by wins desc
		) as test,
		Objects as descr
	where wins <> 0
	and test.[ObjectID] = descr.[ObjectID]
--[ObjectID] = 87329
--and [WinBid] is not null

order by ratio desc