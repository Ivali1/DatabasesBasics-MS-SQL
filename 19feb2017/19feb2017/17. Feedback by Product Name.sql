Use Bakery
create function udf_GetRating(@ProducName NVARCHAR(25))
returns  VARCHAR(10)
as
begin
declare @Rate DECIMAL(4,2)= (SELECT avg(f.Rate) 
                                FROM Products as p
                                JOIN Feedbacks as f
							      on p.Id=f.ProductId
								  where p.Name=@ProducName)
declare @result VARCHAR(10)=
case
    when @Rate<5 then 'Bad'
	when @Rate between 5 and 8 then 'Average'
	when @Rate>=8 then 'Good'
	else  'No rating'
end

return @result
end
SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name) as f
  FROM Products
 ORDER BY Id
