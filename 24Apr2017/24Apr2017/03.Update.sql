Use WMS

UPDATE Jobs
SET Status='In Progress', MechanicId=(SELECT MechanicId 
                                        FROM Mechanics 
										where FirstName='Ryan ' and LastName='Harnos ')
WHERE Status='Pending '