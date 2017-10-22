SELECT FirstName, Age, PhoneNumber
 FROM Customers
 WHERE (Age>=21 AND FirstName like '%an%')or
      (PhoneNumber like '%38' and CountryId <>(select Id
	                                           from Countries
											   where [Name]='Greece'))
order by FirstName, age desc