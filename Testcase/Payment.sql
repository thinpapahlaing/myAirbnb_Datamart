SELECT Payment.PaymentID, Booking.BookingID, Host.HostID, Property.PropertyID, Users.First_Name AS Host_FirstName, Users.Last_Name AS Host_LastName, Property.Property_Name, 
		Property.Property_Type, Property.Price_Per_Night, Booking.Booking_Made_Date, Payment.Currency, Payment.Total_Amount, Booking.Start_Date AS Rent_Start_Date, 
        Payment.Payment_Date AS Payment_Date_To_Host, Payment.Payment_Status
FROM Users INNER JOIN Host ON Users.UserID = Host.UserID INNER JOIN Property ON Host.HostID = Property.HostID 
INNER JOIN Booking ON Property.PropertyID = Booking.PropertyID INNER JOIN Payment ON Booking.BookingID = Payment.BookingID
WHERE Booking.Booking_Made_Date > '2023-10-15 02:00:00';