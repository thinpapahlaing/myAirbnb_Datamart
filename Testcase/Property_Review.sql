SELECT Guest.GuestID, Users.First_Name AS Guest_FirstName, Users.Last_Name AS Guest_LastName, Property.PropertyID, Property.Property_Name, 
		Property_Review.Rating, Property_Review.Comment, Property_Review.Reviewed_Date
FROM Users INNER JOIN Guest ON Users.UserID = Guest.UserID INNER JOIN Property_Review ON Guest.GuestID = Property_Review.GuestID 
INNER JOIN Property ON Property_Review.PropertyID = Property.PropertyID
WHERE Users.First_Name = 'Dallas' AND Users.Last_Name = 'Hayes';