SELECT Users.UserID, Users.First_Name, Users.Last_Name, Users.Email, Users.Phone_Number, Languages.Language, Users_Languages.Spoken_Ability 
FROM Users INNER JOIN Users_Languages ON Users.UserID = Users_Languages.UserID INNER JOIN Languages ON Users_Languages.LanguageID = Languages.LanguageID 
WHERE Languages.Language = 'German' AND Users_Languages.Spoken_Ability = 'First Language';