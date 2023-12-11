SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.Gender, Host_Review.Rating, Host_Review.Comment, Host_Review.Reviewed_Date, Host.HostID
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID INNER JOIN Host_Review ON Host.HostID = Host_Review.HostID 
WHERE Host_Review.Rating = 5 AND Users.Gender = 'Female' ORDER BY Host_Review.Reviewed_Date ASC;