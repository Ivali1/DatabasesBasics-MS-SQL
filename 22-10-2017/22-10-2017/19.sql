use ReportService

GO
create trigger tr_Status on Reports after UPDATE
AS
BEGIN
  UPDATE Reports
  SET StatusId=3
  WHERE EmployeeId=5 
  IF(@@ROWCOUNT<>1)
  begin 
    rollback
	return
  end
END

