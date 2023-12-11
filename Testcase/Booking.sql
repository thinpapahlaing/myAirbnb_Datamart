SELECT Booking.BookingID, Guest.GuestID, Property.PropertyID, Users.First_Name AS Guest_FirstName, Users.Last_Name AS Guest_LastName, Property.Property_Name, 
		Property.Property_Type, Property.Room_Numbers, Property.Price_Per_Night, Booking.Start_Date, Booking.End_Date, Booking.Cost, Booking.Booking_Made_Date, 
        Booking.Booking_Status
FROM Users INNER JOIN Guest ON Users.UserID = Guest.UserID INNER JOIN Booking ON Guest.GuestID = Booking.GuestID INNER JOIN Property ON Booking.PropertyID = Property.PropertyID
WHERE Users.First_Name = 'Georgie' AND Users.Last_Name = 'Ivanishev';