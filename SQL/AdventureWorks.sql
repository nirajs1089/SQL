use AdventureWorks

select top 10 * from Sales.Customer

select ContactID from Sales.Individual --top 10 
order by ContactID asc

select EmployeeID,ContactID,ManagerID
select distinct Title
from HumanResources.Employee
--where EmployeeID = 275
order by ContactID asc

select * from Sales.Store

select *
from Sales.SalesOrderHeader

--select distinct CustomerID,SalesPersonID 
select CustomerID, ContactID
from Sales.SalesOrderHeader
--where SalesPersonID  is not null
order by ContactID asc

-----selling price -------
select top 20 UnitPrice,OrderQty,LineTotal
from Sales.SalesOrderDetail
where ProductID  = 750

-----cost price -------
select  
top 20 StandardCost--ListPrice,Size
from Production.Product
where ProductID  = 750
order by ListPrice desc


--****************************5a****************************

--DROP TABLE CIS655_Shah_N.dbo.SalesCustomer

	Select Cust.CustomerID,
				Person.ContactID,
				Person.FirstName,
				Person.LastName
				into CIS655_Shah_N.dbo.SalesCustomer ---- DELETE TABLE BEFORE YOU RUN THE QUERY
				from Sales.Customer as Cust,
					Sales.SalesOrderHeader as Sale,
					Person.Contact as Person
				where Cust.CustomerID = Sale.CustomerID
				and Person.ContactID = Sale.ContactID

--DROP TABLE CIS655_Shah_N.dbo.EmployeeContact

select emp.EmployeeID,   
	   Person.FirstName,
	   Person.LastName,
	   emp.Title
	   into CIS655_Shah_N.dbo.EmployeeContact   ----DELETE TABLE BEFORE YOU RUN THE QUERY
		from Person.Contact as Person,
		HumanResources.Employee as emp
		where emp.ContactID = Person.ContactID

select distinct 
	EC.EmployeeID,
	SC.FirstName,SC.LastName,
	EC.Title
	from CIS655_Shah_N.dbo.SalesCustomer as SC,
	CIS655_Shah_N.dbo.EmployeeContact as EC
	where SC.FirstName = EC.FirstName
	and SC.LastName = EC.LastName
	ORDER BY SC.LastName


	-------corect ------

	select EmployeeID,	
	emp.Title,
	(pc.FirstName + ' ' + pc.LastName) as FullName
	from HumanResources.Employee as emp,
	Person.Contact as pc
	where emp.Title like '%Buyer%'
	and emp.ContactID = pc.ContactID
	order by pc.LastName asc

		--select emp.EmployeeID,
		--		emp.Title,
		--		salesCust.Fullname
		--		from HumanResources.Employee as emp,
		--			( 
		--				select distinct c.ContactID,(c.LastName + ' ' + c.FirstName) as Fullname
		--				from Sales.SalesOrderHeader as s,
		--				 Person.Contact as c
		--				 where s.ContactID = c.ContactID
		--			) 
		--			as salesCust
		 
		--where emp.ContactID = salesCust.ContactID	
		--	order by salesCust.Fullname
		
---------------------------------------

select emp.ContactID
	from Sales.SalesOrderHeader as s,
		 HumanResources.Employee as emp
		 where s.ContactID = emp.ContactID

--****************************5b****************************

	select 
		ThirdLevel.EmployeeID,
		FirstName+ ' ' + LastName as FullName,
		ThirdLevel.Title,
		CONVERT(VARCHAR(10),ThirdLevel.HireDate,110) as DateHired
		from Person.Contact,
				---------------------------------------------------------------------
				(
					select ContactID,EmployeeID,Title,HireDate ---ThirdLevel
					from HumanResources.Employee,
					----------------------------------------------
					(
								select ManagerID ---SecondLevel
								from HumanResources.Employee,						
								--------------------------
								(
									select ContactID       ---Firstlevel
									from Person.Contact
									where FirstName = 'Dan'
									and LastName ='Wilson'
								) 
								--------------------------
								as Firstlevel
								where HumanResources.Employee.ContactID = Firstlevel.ContactID
					
					) 		
					----------------------------------
					as SecondLevel
					where EmployeeID = SecondLevel.ManagerID
				)
				as ThirdLevel
				---------------------------------------------------------------------
		where ThirdLevel.ContactID = Person.Contact.ContactID


--****************************-6****************************

--select SalesPersonID,count(CustomerID) as CountCust
--from Sales.SalesOrderHeader
--group by SalesPersonID
--order by CountCust desc

--select distinct Sales.SalesPersonID,Sales.ContactID,person.FirstName
--from Sales.SalesOrderHeader as Sales
--,Person.Contact as person
--where Sales.ContactID = person.ContactID
--order by Sales.ContactID asc

--select 
--	contact.ContactID,
--	contact.FirstName,
--	SalesOrder.SalesPersonID,
--	count(SalesOrder.CustomerID) as CountCust
--	from Person.Contact as contact,
--		 Sales.SalesOrderHeader as SalesOrder
--		 where contact.ContactID in 
--			(select distinct emp.ContactID
--				from HumanResources.Employee as emp
--				,Sales.SalesOrderHeader as sales
--				where emp.EmployeeID = sales.SalesPersonID)

--			group by SalesOrder.SalesPersonID,contact.FirstName,contact.ContactID


    select FirstName + ' ' + LastName as Name,
			emp2.Title,
			emp2.countCust
	  from Person.Contact as pc,
	  -------------------------------------------------
			(
				 select emp.EmployeeID,
				        emp.ContactID,
						 emp.Title,
						 sales.countCust
				 from HumanResources.Employee as emp,
				 -------------------------------------------------
					(
						select SalesPersonID,
							   COUNT(distinct CustomerID) as countCust
						from Sales.SalesOrderHeader
						group by SalesPersonID
					)
				-------------------------------------------------
					 as sales
				  where sales.SalesPersonID = emp.EmployeeID
				  and emp.Title like '%Sales Rep%'
			) 
		-------------------------------------------------
			as emp2
   where emp2.ContactID = pc.ContactID
   order by emp2.countCust desc

--*****************************6 bonus*****************************
 
 drop table CIS655_Shah_N.DBO.TerritoryCust
 drop table CIS655_Shah_N.DBO.TerritorySalesCust

 select *
 from Sales.SalesTerritory

 -------------------------------------------------
		  select TerritoryID,min(countCust) as MinCust
		        into CIS655_Shah_N.DBO.TerritoryCust -- delete the Table before run
				from 
				-------------------------------------------------
							(
								select TerritoryID,SalesPersonID,COUNT(CustomerID) as countCust
								into CIS655_Shah_N.DBO.TerritorySalesCust  -- delete the Table before run
								from Sales.SalesOrderHeader 
								where TerritoryID is not null and 
									  SalesPersonID is not null
								group by TerritoryID,SalesPersonID
							    --order by TerritoryID,countCust asc
							) 
				-------------------------------------------------
							as Twise
							
				group by TerritoryID
-------------------------------------------------	
		


    select 
		   --tc.TerritoryID,
		   st.Name as TtyName,
				--SalesPersonID,
				--emp.ContactID as ContactID,
				pc.FirstName,
					MinCust
				

			from CIS655_Shah_N.DBO.TerritorySalesCust as tsc,
				 CIS655_Shah_N.DBO.TerritoryCust as tc,

				 Sales.SalesTerritory as st,

				 HumanResources.Employee as emp,
				 Person.Contact as pc

						 where tsc.TerritoryID = tc.TerritoryID
						 and tc.MinCust = tsc.countCust

						 and st.TerritoryID = tc.TerritoryID
				 
						 and emp.EmployeeID = tsc.SalesPersonID
						 and pc.ContactID = emp.ContactID
								order by MinCust asc


------------- 6 double bonus -------


begin

	select 			
			(pc.FirstName + ' ' + pc.LastName) as SalesManager,
			ManCount.SalesByManager
	from HumanResources.Employee as emp2,
		 Person.Contact as pc,
		 ----------------------------
		  (
		   
			select ManEmpCount.ManagerID as ManagerID,
					sum(countOrder1) as SalesByManager
			from 
			----------------------------------
					(			
						select emp.ManagerID, 
								emp.EmployeeID,
								Orders.countOrder as countOrder1
						from 
								HumanResources.Employee as emp,
								---------------------------------------------
								(
								
								   select SalesPersonID,
										   COUNT(SalesOrderID) as countOrder
										--into CIS655_Shah_N.DBO.TerritorySalesCust
										from Sales.SalesOrderHeader				
										where SalesPersonID is not null			 
										group by SalesPersonID
								--end;
								) 
								-----------------------------------------------
								as Orders	
						where
						emp.EmployeeID = Orders.SalesPersonID
					) 
					----------------------------------------------------
					as ManEmpCount
					
				group by ManEmpCount.ManagerID
			)
			----------------------------------------------------
			as ManCount
	where 
	ManCount.ManagerID = emp2.EmployeeID
	and emp2.ContactID = pc.ContactID
	order by ManCount.SalesByManager asc

end;


 ----*************************7*************************
 -----ASK WHICH IS THE UNIT COST ---------
 --DROP ON LESS PROFIT
	--	 LESS QTY SOLD
 -----selling price -------
	SELECT top 10 costing.ProductID,costing.Name,
			costing.StandardCost as UnitCost,selling.avgSoldPrice,
			selling.soldQty,
			(costing.StandardCost*selling.soldQty) as costValue,selling.sellValue
			,((selling.sellValue-(costing.StandardCost*selling.soldQty))/((costing.StandardCost*selling.soldQty)))*100 as 'Profit%'
		from Production.Product as costing,
			-------------------------------------
			(
			
					select ProductID,
					(sum(LineTotal)/sum(OrderQty)) as avgSoldPrice,
					 sum(OrderQty) as soldQty,
					 sum(LineTotal) as sellValue
						from Sales.SalesOrderDetail
						group by ProductID
						--having ProductID  = 873
			) 
			-------------------------------------
			as selling 

		where 
			--costing.ProductID  = 873 and
			--(costing.StandardCost*selling.soldQty) <> 0
			selling.ProductID = costing.ProductID
				order by 'Profit%' asc

--*************************-8-*****************************

---employee -----
--pay frequency * pay rate to get the monthly wage 

SELECT 
        --Pay.EmployeeID,
		details.Gender,avg(Rate) as AveragePayRate
		--RateChangeDate
		from HumanResources.EmployeePayHistory as Pay,
		-------------------------------------
			( 
				SELECT EmployeeID,StartDate 
				from HumanResources.EmployeeDepartmentHistory 
				where EndDate is null
				--and EmployeeID = 1
			) 
			-------------------------------------
			as Dept,
			-------------------------------------
			(
				 select EmployeeID,Gender 
				 from HumanResources.Employee
				 --where EmployeeID = 1
			)
			-------------------------------------
			 as details

		where RateChangeDate >= StartDate
		--and Pay.EmployeeID = 1
		and Pay.EmployeeID = Dept.EmployeeID
		and Pay.EmployeeID = details.EmployeeID

			group by details.Gender






