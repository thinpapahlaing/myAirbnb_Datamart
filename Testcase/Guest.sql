SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.Gender, Users.Email, Users.Registration_Date,
		Guest.Guest_Description, Guest.GuestID
FROM Users INNER JOIN Guest ON Users.UserID = Guest.UserID 
WHERE Users.Gender = 'Male' AND TIMESTAMPDIFF(MONTH, Users.Registration_Date, NOW()) < 4
ORDER BY Users.Registration_Date DESC;