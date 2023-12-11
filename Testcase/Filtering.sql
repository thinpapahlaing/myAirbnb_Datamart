SELECT Property.PropertyID, Property.Property_Name, Property.Property_Type, Property.Room_Numbers, Property.Price_Per_Night, Property.Max_Guests_Allowed, 
		Available_Periods.Start_Date AS Start_Available_Date, Available_Periods.End_Date AS End_Available_Date, Available_Periods.Immediate_Availability, 
        Address.Country_Name, Address.City
FROM Address INNER JOIN Property ON Address.PropertyID = Property.PropertyID INNER JOIN Available_Periods ON Property.PropertyID = Available_Periods.PropertyID
WHERE Property.Is_There_Kitchen = 1 AND Property.Is_There_Bathroom = 1 AND Property.Max_Guests_Allowed >=4;