go
create function udf_GetReportsCount(@employeeId int , @statusId int) 
returns int
as
begin 
    declare @result int=(select COUNT(Id)
	                    from Reports 
						where EmployeeId=@employeeId AND StatusId= @statusId)
	return @result

end

SELECT Id, FirstName, Lastname, dbo.udf_GetReportsCount(Id, 2) AS ReportsCount
FROM Employees
ORDER BY Id
