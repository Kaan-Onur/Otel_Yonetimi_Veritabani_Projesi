-- Belirli bir ay için kaç farklı misafir rezervasyon yaptı?
	SELECT guest_first_name, guest_last_name,guest_contact_number
	FROM guests
	WHERE guest_id IN 
		( SELECT distinct guests_guest_id 		-- Farklı misafirleri al
		  FROM bookings
		  WHERE MONTH(check_in_date) = 8);		-- Ağustos ayı rezervasyonları
	
-- Belirli bir tarihte belirli bir otelde kaç tane müsait oda var?
	SELECT h.hotel_room_capacity AS 'Total Rooms', SUM(total_rooms_booked) AS 'Total Rooms Booked' , h.hotel_room_capacity - SUM(b.total_rooms_booked) 	AS 'Available Rooms'	-- Uygun odaları al
	FROM `bookings` b JOIN hotel h
    	ON b.hotel_hotel_id = h.hotel_id
	WHERE booking_date LIKE '2018-08-14%' AND hotel_hotel_id = 1	-- Verilen tarih ve otel(King George Inn & Suites) için
	
-- Bir otel zincirinde kaç otel var?
	SELECT count(*) AS 'Total Hotels' 		-- toplam otel sayısı
	FROM hotel_chain_has_hotel 
	WHERE hotel_chains_hotel_chain_id = 1;  
	
-- Bir müşteri bir yılda kaç rezervasyon yaptırdı?
	SELECT count(*) AS 'Total Bookings' 		-- toplam rezervasyon sayısı		
	FROM bookings
	WHERE YEAR(booking_date) = 2018 AND guests_guest_id = 1;		
	
-- Belirli bir tarihte belirli bir otelde kaç oda rezerve edildi?
	SELECT SUM(total_rooms_booked) AS 'Total Rooms Booked' 		
	FROM `bookings` 
	WHERE booking_date LIKE '2018-06-08%' AND hotel_hotel_id = 1;	

-- Otellerin bulunduğu tüm benzersiz ülkeleri listele.
	SELECT DISTINCT country					
	FROM addresses
	WHERE address_id IN 					
		( SELECT  addresses_address_id		
		  FROM hotel);
	
	
-- Uygun bir otelde kaç oda mevcuttur?

	SELECT  h.hotel_room_capacity - SUM(b.total_rooms_booked) 	AS 'Available Rooms'	
	FROM `bookings` b JOIN hotel h
    	ON b.hotel_hotel_id = h.hotel_id
	WHERE booking_date LIKE '2018-06-08%' AND hotel_hotel_id = 1	

-- Kullanılabilir bir URL'ye sahip tüm otelleri listele.
	SELECT * 
	FROM `hotel` 
	WHERE hotel_website IS NOT NULL;	
	
-- Yıl boyunca belirli bir zamanda bir odanın fiyatını listele.
	SELECT ROUND((r_type.room_cost - ((r_dis.discount_rate * r_type.room_cost)/100)), 2) AS 'Room Rate' 
	FROM room_rate_discount r_dis JOIN room_type r_type 		
	ON r_dis.room_type_room_type_id = r_type.room_type_id
    WHERE r_type.room_type_id 
	IN ( Select rooms_type_rooms_type_id from rooms where room_id = 1)	
    AND MONTH(NOW()) BETWEEN r_dis.start_month AND r_dis.end_month;		
	
