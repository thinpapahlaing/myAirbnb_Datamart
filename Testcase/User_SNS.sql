SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.User_Type, Users.Registration_Date, 
		User_Social_Network.Social_Platform, User_Social_Network.Social_URL
FROM Users INNER JOIN User_Social_Network ON Users.UserID = User_Social_Network.UserID 
WHERE Users.First_Name = 'Curry' And Users.Last_Name = 'Pollins';