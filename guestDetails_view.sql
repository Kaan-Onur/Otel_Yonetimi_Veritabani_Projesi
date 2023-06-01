-- misafirlerin detaylı bilgilerini almak için hotel_guests adlı bir görünüm oluştur.
CREATE OR REPLACE VIEW hotel_guests AS
SELECT guest_first_name AS 'First Name', guest_last_name AS 'Last Name', guest_email_address AS 'Email Address', guest_contact_number AS 'Contact Number',country,state,zipcode
FROM guests
JOIN addresses ON addresses.address_id = guests.addresses_address_id
WHERE guests.guest_id IN
		(SELECT distinct guests_guest_id 	
		FROM bookings
		WHERE hotel_hotel_id = 1);			

		