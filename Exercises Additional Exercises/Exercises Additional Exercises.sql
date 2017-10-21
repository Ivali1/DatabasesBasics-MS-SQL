Use Diablo

---- Problem 1.	Number of Users for Email Provider
SELECT RIGHT(Email, len(Email)-CHARINDEX('@',Email))
        as [Email Provider],
       count(*) as [Number Of Users]
 FROM Users
group by RIGHT(Email, len(Email)-CHARINDEX('@',Email))
order by  [Number Of Users] desc, [Email Provider]



--Problem 2.	All User in Games
select g.Name as Game,
       gt.Name as [Game Type],
	   u.Username as [Username],
	   ug.Level as [Level],
	   ug.Cash as [Cash],
	   c.Name as [Character]
   from Users as u
   join UsersGames as ug
     on ug.UserId=u.Id
   join Games as g
     on g.Id=ug.GameId
   join Characters as c
	  on c.Id=ug.CharacterId
   join GameTypes as gt
     on gt.Id=g.GameTypeId
order by ug.Level desc,u.Username,g.Name

--Problem 3.	Users in Games with Their Items
select u.Username,
       g.Name,
	   count(i.Name) as [Items Count],
	   SUM(i.Price) as [Items Price]
 from Users as u
 join UsersGames as ug
   on ug.UserId=u.Id
 join Games as g
   on g.Id=ug.GameId
 join UserGameItems as ugi
   on ugi.UserGameId=ug.Id
 join Items as i
   on i.Id=ugi.ItemId
   group by u.Username,g.Name
   HAVING   count(i.Name)>=10
   order by [Items Count] desc, [Items Price] desc, u.Username

--Problem 4.	* User in Games with Their Statistics



--Problem 5.	All Items with Greater than Average Statistics
SELECT i.Name, 
	   i.Price,
	   i.MinLevel,
	   s.Strength,
	   s.Defence,
	   s.Speed,
	   s.Luck,
	   s.Mind
FROM Items AS i
JOIN [Statistics] as s
  on s.Id=i.StatisticId
where s.Mind>(select AVG(Mind) from [Statistics]) and
      s.Luck > (select AVG(Luck) from [Statistics])  and
	  s.Speed >( select avg(Speed) from [Statistics]
order by i.Name
go
--Problem 6.	Display 
-- All Items with Information about Forbidden Game Type
SELECT i.Name as [Item],
       i.Price,
	   i.MinLevel , gt.Name as [Forbidden Game Type]
FROM Items AS i
join  GameTypeForbiddenItems as gti
  on gti.ItemId=i.Id
left join GameTypes as gt
  on gt.Id=gti.GameTypeId
order by [Forbidden Game Type] desc, i.Name
  


--Problem 7.	Buy Items for User in Game

--Problem 8.	Peaks and Mountains
 Use Geography
 SELECT p.PeakName,
        m.MountainRange as[Mountain],
		p.Elevation as [Elevation]
   FROM Mountains as m
    JOIN Peaks AS p
	  ON p.MountainId=m.Id
	  ORDER BY P.Elevation DESC,
	           p.PeakName

--Problem 9.	Peaks with Their Mountain, Country and Continent
SELECT p.PeakName,
       m.MountainRange AS Mountain,
	   C.CountryName,
	   con.ContinentName
  FROM Mountains AS m
  JOIN Peaks AS p
    ON p.MountainId=m.Id
  JOIN MountainsCountries AS mc
    ON mc.MountainId=m.Id
  JOIN Countries AS c
    ON c.CountryCode=mc.CountryCode
  JOIN Continents as con
    ON con.ContinentCode=c.ContinentCode
ORDER BY p.PeakName,c.CountryName
--Problem 10.	Rivers by Country
SELECT c.CountryName,
       con.ContinentName,
	   COUNT(r.Id) AS RiversCount,
	  ISNULL(SUM(r.Length),0) AS TotalLength
  FROM Countries AS c
 LEFT   JOIN Continents AS con
    ON con.ContinentCode=c.ContinentCode
 LEFT JOIN CountriesRivers AS cr
    ON cr.CountryCode=c.CountryCode
 LEFT JOIN Rivers AS r
    ON r.Id=cr.RiverId
GROUP BY c.CountryName,con.ContinentName
ORDER BY RiversCount DESC,TotalLength DESC,c.CountryName

--Problem 11.	Count of Countries by Currency

SELECT cur.CurrencyCode,
       cur.Description as Currency,
	   COUNT(cou.CountryCode) AS NumberOfCountries
FROM Currencies AS cur 
LEFT JOIN Countries AS cou
  on cou.CurrencyCode=cur.CurrencyCode
group by cur.CurrencyCode,cur.Description
order by NumberOfCountries desc,Currency

 select* from Countries
--Problem 12.	Population and Area by Continent
SELECT c.ContinentName, 
       SUM(co.AreaInSqKm) as CountriesArea,
	   SUM(cast(co.Population as bigint)) as CountriesPopulation
 FROM Continents as c
 JOIN Countries AS co
  on co.ContinentCode=c.ContinentCode
 GROUP BY c.ContinentName
 ORDER BY CountriesPopulation DESC
  
--Problem 13.	Monasteries by Country
 CREATE TABLE Monasteries(
 Id INT PRIMARY KEY IDENTITY,
 Name VARCHAR(50) NOT NULL,
 CountryCode char(2) FOREIGN KEY REFERENCES 
 Countries(CountryCode) NOT NULL
  )
  INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

UPDATE Countries
SET IsDeleted = 0
WHERE CountryCode IN
( select c.CountryCode 
   from(
		SELECT c.CountryCode, count(cr.RiverId) as countRiver
		from Countries as c
		join CountriesRivers as cr
		 on cr.CountryCode=c.CountryCode
   group by c.CountryCode
     having count(cr.RiverId)>3)
	as c
)

	select m.Name as Monastery ,
	     c.CountryName as  Country
	   from Countries as c
	   join Monasteries as  m
	     on m.CountryCode=c.CountryCode
	 where c.IsDeleted=0
	 order by m.Name 

--Problem 14.	Monasteries by Continents and Countries

UPDATE Countries
SET CountryName='Burma'
WHERE CountryName='Myanmar'

INSERT INTO Monasteries (Name,CountryCode)
(SELECT 'Hanga Abbey', CountryCode 
FROM Countries 
 WHERE CountryName='Tanzania')

 INSERT INTO Monasteries (Name,CountryCode)
 (SELECT 'Myin-Tin-Daik',CountryCode 
    FROM Countries 
	WHERE CountryName='Myanmar')

SELECT c.ContinentName,
		cou.CountryName,
		COUNT(m.Id) as MonasteriesCount
  FROM Continents as c
  join Countries as cou
    on cou.ContinentCode=c.ContinentCode
LEFT join Monasteries as m
    on m.CountryCode=cou.CountryCode
  where IsDeleted=0
 GROUP BY c.ContinentName,cou.CountryName
 ORDER BY MonasteriesCount DESC, cou.CountryName
