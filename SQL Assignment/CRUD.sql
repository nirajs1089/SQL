SELECT CAST(GETDATE() AS DATE) > '2016-05-04'

declare @dt as varchar(10)

set @dt = '2020-05-05'
select  DATEDIFF(year, GETDATE(),@dt) 

select cast(isnumeric('f5f5') as bit)

select len('5555555555555550000')

select (cast('2' as int) > 0)

select cast('-kj' as bigint)

USE [CIS_ZZZ]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_insertCC]
		@clientID = '2',
		@CC = N'555555555555555555555555555555',
		@expDate = N'2016-05-22',
		@lastFour = N'5555'

SELECT	'Return Value' = @return_value

GO


select left('4545',2)

if ('11256565655655' NOT LIKE '%' + '.' + '%')
   print 'dsd'

   