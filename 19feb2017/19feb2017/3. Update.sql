USE Bakery
UPDATE Ingredients 
SET DistributorId=35
WHERE Id IN (SELECT Id 
                          FROM Ingredients
						  WHERE [Name] IN('Bay Leaf', 'Paprika', 'Poppy')) 

	UPDATE Ingredients
	SET OriginCountryId=14
	WHERE OriginCountryId=8