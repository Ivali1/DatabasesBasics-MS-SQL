Use WMS
SELECT m.ModelId, 
       m.Name, 
      CAST( AVG(DATEDIFF(DAY,j.IssueDate ,j.FinishDate )) as varchar(10))+
	  ' days'
as [Average Service Time]
  FROM Models  AS m
  JOIN Jobs AS j
    on j.ModelId=m.ModelId
 group by m.ModelId,m.Name
 order by AVG(DATEDIFF(DAY,j.IssueDate ,j.FinishDate ))