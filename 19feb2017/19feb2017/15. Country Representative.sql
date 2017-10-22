 use Bakery
SELECT  CountryName,DisributorName
 from
 (
 SELECT c.[Name] as CountryName,
         d.[Name] as DisributorName,  
        count(i.Id) AS CountIngredients,
		DENSE_RANK() OVER(PARTITION BY c.[Name] ORDER BY  count(i.Id) DESC) as [Rank]
FROM Distributors as d
join Ingredients as i
  on i.DistributorId=d.Id
join Countries AS  c
  on c.Id=d.CountryId
group by c.Name, d.Name
) as g
where [Rank]=1
order by CountryName,DisributorName

