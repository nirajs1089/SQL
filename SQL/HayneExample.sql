---what is VIN

Use HayneExample

SELECT * from Objects
where [Description] like '%1967%Ford%Mustang'
order by [Description] asc

SELECT ObjectID,SellerRating,SellerFeedback from Summary
Where ObjectID = 3792892
or ObjectID = 836235
--SELECT top 3000 WinBid,ReserveNotMet,RelistAuctionID from Summary
where 
	ReserveNotMet = 'Y' -- (-,- -> +) (Did the bidder meet the reserve price for it tol sell)
				and WinBid is not null
				and RelistAuctionID is null -- if Relisted then Not sold  
order by ReserveNotMet asc

SELECT distinct ReserveNotMet from Summary
where Category like '%Car%'
order by Category asc

---**********************1****************************************
---------by Qty-----------------

		SELECT model.ObjectID,model.[Description],mostSold.CountSold
		from Objects as model,
		---------------------------------------
		(
				SELECT ObjectID,count(ObjectID) as CountSold 
				from Summary 
				where Category like '%PassengerVehicle%'
						and ReserveNotMet = 'N' -- (-,- -> +) (Did the bidder meet the reserve price for it tol sell)
						and WinBid is not null
						and RelistAuctionID is null -- if Relisted then Not sold  
						group by ObjectID			
		)
		---------------------------------------		 
				as mostSold
		where model.[Description] like '%1970%'
		and model.ObjectID = mostSold.ObjectID
		order by mostSold.CountSold desc
		--order by most.CountO asc

		-----by Max/Min $ 

		SELECT top 5 model.ObjectID,model.[Description],Sold.HighestRate
		--SELECT top 5 model.ObjectID,model.[Description],Sold.LowestRate
		from Objects as model
		,(
				SELECT ObjectID,max(WinBid) as HighestRate 
				--SELECT ObjectID,min(WinBid) as LowestRate 
				from Summary 
						where Category like '%PassengerVehicle%'
						and ReserveNotMet = 'N' -- (-,- -> +) (Did the bidder meet the reserve price for it tol sell)
						and WinBid is not null
						and RelistAuctionID is null -- if Relisted then Not sold  
						group by ObjectID
			
				) 
				as Sold
		where model.[Description] like '%1970%'
		and model.ObjectID = Sold.ObjectID
		order by Sold.HighestRate desc
		--order by Sold.LowestRate asc

-------------2-----------------

---**********************3**********************
--------------ratio-----------------

drop table CIS655_Shah_N.dbo.TotalAuction_T

SELECT [ObjectID],count([AuctionID]) as auc   ---- DELETE THE TABLE BEFORE SUBMITTING
into CIS655_Shah_N.dbo.TotalAuction_T
FROM [dbo].[Summary]						
group by [ObjectID]


drop table CIS655_Shah_N.dbo.TotalSold_T

	SELECT [ObjectID],count([WinBid]) as wins ---- DELETE THE TABLE BEFORE SUBMITTING
	into CIS655_Shah_N.dbo.TotalSold_T
	from [Summary]
			where ReserveNotMet = 'N' -- (-,- -> +) (Did the bidder meet the reserve price for it to sell)
			and WinBid is not null
			and RelistAuctionID is null -- if Relisted then Not sold  
	group by [ObjectID]
	order by wins desc


		SELECT
			   descr.[ObjectID],
			   descr.Description,
			   auc,
			   wins,
			   (cast(auc as decimal)/cast(wins as decimal(6,2))) as ratio
				FROM

					Objects as descr,
					CIS655_Shah_N.dbo.TotalAuction_T as TotalAuction,
					CIS655_Shah_N.dbo.TotalSold_T as TotalSold		
											
				where 
				--wins <> 0
				TotalAuction.[ObjectID] = TotalSold.[ObjectID]
				and TotalAuction.[ObjectID] = descr.[ObjectID]

			order by ratio desc

			---------------4-------------------------
			select LastLevel.ObjectID,LastLevel.MinEndDate,LastLevel.MaxEndDate
			from Summary,
			(

				select BidMaxTab.ObjectID,EndDate as MinEndDate,MaxEndDate,minB,maxB
				from Summary,
				 (
					select top 200000 BidTab.ObjectID,
							EndDate as MaxEndDate,
							--EndDate as MinEndDate,
							maxB,
							minB
					from Summary,
					(
						select ObjectID,avg(WinBid) as AvgBid,Max(WinBid) as maxB,min(WinBid) as minB,(Max(WinBid)-min(WinBid))/2 as RangeBid,(avg(WinBid)-((Max(WinBid)-min(WinBid))/2)) as diff,count(WinBid) as NumBids
						from Summary
						group by ObjectID
						having ((Max(WinBid)-min(WinBid))/2) < = avg(WinBid)
						and count(WinBid) > 100
						--order by diff,NumBids desc
					) as BidTab
					where maxB = Summary.WinBid
					--where minB = Summary.WinBid
				)
				as BidMaxTab
				where minB = Summary.WinBid			
			)
			as LastLevel
			where LastLevel.MaxEndDate < LastLevel.MinEndDate



			select ObjectID,EndDate,(WinBid)  --DATEPART(YEAR,EndDate) as EndDate
			from Summary
			where ObjectID = 849930
			and WinBid is not null
			order by EndDate asc

		  select ObjectID,Description
		  from Objects
		  where ObjectID = 939666
			--avio
			--elkamino


			939666 --- 1 ans
			 849930 ----- ford Mustang
			 87324

			 -- 2 









87324