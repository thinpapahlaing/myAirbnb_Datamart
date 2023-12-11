SELECT Host.HostID, Property.PropertyID, Property.Property_Name, Property.Room_Numbers, Property.Price_Per_Night, 
		Property.Is_There_Kitchen, Property.Is_There_Bathroom, Property.Max_Guests_Allowed, 
		Address.Country_name, Address.City, Address.Postal_Code, Address.Street, Address.Building_Number
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID INNER JOIN Property ON Host.HostID = Property.HostID INNER JOIN Address ON Property.PropertyID = Address.PropertyID 
WHERE Users.First_name = 'Cosme' AND Users.Last_Name = 'Norwood';