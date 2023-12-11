SELECT Host.HostID, Users.First_Name AS Host_First_Name, Users.Last_Name AS Host_Last_Name, Users.Email AS Host_Email, Users.Registration_Date AS Host_Active_Date, 
		Property.PropertyID, Property.Property_Name, Property.Property_Description, Property.Room_Numbers, Property.Price_Per_Night, 
        Property.Is_There_Kitchen, Property.Is_There_Bathroom, Property.Max_Guests_Allowed
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID INNER JOIN Property ON Host.HostID = Property.HostID 
WHERE Users.Registration_Date < '2023-03-01 09:00:00' ORDER BY Users.Registration_Date DESC;