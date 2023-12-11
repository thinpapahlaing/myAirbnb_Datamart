SELECT Property.PropertyID, Property.Property_Name, Property.Property_Type, Property.Property_Description, Property.Max_Guests_Allowed, 
        Address.Country_Name, Address.City, Address.Street, Rules.Rule_Description
FROM Address INNER JOIN Property ON Address.PropertyID = Property.PropertyID INNER JOIN Property_Rules ON Property.PropertyID = Property_Rules.PropertyID
INNER JOIN Rules ON Property_Rules.RuleID = Rules.RuleID
WHERE Property.Property_Type = 'Cabin' AND Address.Country_Name = 'United States';