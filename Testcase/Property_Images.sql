SELECT Property.PropertyID, Property.Property_Name, Property.Room_Numbers, Property.Price_Per_Night, Property.Max_Guests_Allowed, Property_Image.Property_Image,
        Address.Country_Name, Address.City, Address.Street
FROM Address INNER JOIN Property ON Address.PropertyID = Property.PropertyID INNER JOIN Property_Image ON Property_Image.PropertyID = Property.PropertyID
WHERE Address.Country_Name = 'United Kingdom' AND Property.Max_Guests_Allowed >= 7;