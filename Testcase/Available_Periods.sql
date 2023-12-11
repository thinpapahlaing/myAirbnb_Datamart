SELECT Property.PropertyID, Property.Property_Name, Property.Property_Type, Property.Price_Per_Night, Property.Max_Guests_Allowed, 
		Available_Periods.Start_Date AS Start_Available_Date, Available_Periods.End_Date AS End_Available_Date, Address.Country_Name, Address.City
FROM Address INNER JOIN Property ON Address.PropertyID = Property.PropertyID INNER JOIN Available_Periods ON Property.PropertyID = Available_Periods.PropertyID
WHERE Address.Country_Name = 'Canada';