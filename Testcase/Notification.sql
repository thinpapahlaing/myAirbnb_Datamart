SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.Email, Users.User_Type, Notification.Notification_Text, Notification.Is_Read
FROM Users INNER JOIN Notification ON Users.UserID = Notification.UserID 
WHERE Users.UserID = 11;