select [Description], OpenDate
from Reports
where EmployeeId is null
order by OpenDate, Description