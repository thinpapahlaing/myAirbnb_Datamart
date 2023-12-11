SELECT Host.HostID, Users.First_Name AS Host_First_Name, Users.Last_Name AS Host_Last_Name, Payment.Currency,
		SUM(Payment.Total_Amount) AS Total_Earnings, Payment.Payment_Date AS Payment_Received_Date
FROM Payment INNER JOIN Host ON Payment.HostID = Host.HostID INNER JOIN Users ON Host.UserID = Users.UserID
WHERE MONTH(Payment.Payment_Date) = 10 AND YEAR(Payment.Payment_Date) = 2023 AND Payment.Payment_Status = 'Success'
GROUP BY Host.HostID, Users.First_Name, Users.Last_Name
ORDER BY Total_Earnings ASC;