SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.Gender, Users.Date_of_Birth,
		Host.Host_Description, Host.HostID
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID 
WHERE Users.Gender = 'Female' AND Users.Date_Of_Birth > '1990.01.01' ORDER BY Users.Date_Of_Birth ASC;