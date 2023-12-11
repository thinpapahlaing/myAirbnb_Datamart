SELECT Host.HostID, Users.First_Name, Users.Last_Name, Property.PropertyID, Property.Property_Name, Property.Property_Type, Property.Price_Per_Night, 
		Available_Periods.Start_Date AS Start_Available_Date, Available_Periods.End_Date AS End_Available_Date,
        DATEDIFF(Available_Periods.End_Date, Available_Periods.Start_Date) AS Num_Days_in_Each_Available_Period,
		DATEDIFF(Available_Periods.End_Date, Available_Periods.Start_Date) * Property.Price_Per_Night AS Potential_Income_in_Each_Available_Period
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID INNER JOIN Property ON Host.HostID = Property.HostID 
INNER JOIN Available_Periods ON Property.PropertyID = Available_Periods.PropertyID;