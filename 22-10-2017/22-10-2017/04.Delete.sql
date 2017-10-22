delete from Reports
where StatusId in (select Id 
                   from Status
				   where Label='blocked' )