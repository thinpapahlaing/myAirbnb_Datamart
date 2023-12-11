SELECT Property.PropertyID, Property.Property_Name, Property.Property_Type, Property.Room_Numbers, Property.Price_Per_Night, 
		Property_Image.Property_Image, Facility.Item AS Included_Amenities, Facility.Quantity
FROM Property_Image INNER JOIN Property ON Property_Image.PropertyID = Property.PropertyID 
INNER JOIN Property_Facility ON Property.PropertyID = Property_Facility.PropertyID INNER JOIN Facility ON Property_Facility.FacilityID = Facility.FacilityID
WHERE Facility.Item = 'Wi-Fi';