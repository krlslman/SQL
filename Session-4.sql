/* BURAYA DERS İÇERİĞİ EKLE*/

/* Q1 : araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
bilgilerini  listeleyen bir sorgu yaziniz.*/
SELECT markalar.marka_id, markalar.marka_adi, siparisler.siparis_adedi, siparisler.siparis_tarihi
FROM markalar
INNER JOIN siparisler
ON markalar.marka_id = siparisler.marka_id


/* Q2 : Markalar ve Siparisler tablolarındaki tüm araç markalarının siparis bilgilerini
(marka_id,marka_adi,siparis_adedi,siparis_tarihi) listeleyen bir sorgu yaziniz.*/
SELECT m.marka_id, m.marka_adi, s.siparis_adedi, s.siparis_tarihi
FROM markalar m
LEFT JOIN siparisler s
ON m.marka_id = s.marka_id;

/* Q3 : Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türünü listeleyiniz */
SELECT 	t.name, g.name
FROM tracks t
JOIN genres g
ON t.GenreId = g.GenreId;

/* Q4 : invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
soyadını (lastName), fatura tarihini (InvoiceDate) ve fatura meblağını (total) 
listeleyen sorguyu yazınız */
SELECT c.FirstName, c.LastName, i.InvoiceDate, sum(i.total)
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId
GROUP BY c.FirstName
ORDER BY sum(i.total) ASC;

 /* Q5 : invoice tablosundaki faturaların her birinin müşteri adını 
(FirstName),soyadını(lastName) ve fatura meblağlarının 
toplamının(total) 40 dolardan fazla olanlarını azalan sırada
listeleyen sorguyu yazınız */
SELECT c.FirstName, c.LastName,sum(i.total) as total_amount
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId
GROUP BY c.FirstName
HAVING total_amount > 40
ORDER BY total_amount DESC;

--Alternatif olarak (CustomerId'ye gruplandırırsak)
SELECT c.CustomerId, c.FirstName, c.LastName,sum(i.total) as total_amount
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId
HAVING total_amount > 40
ORDER BY total_amount DESC;


/*===================================================
 SUBQUERIES
====================================================*/

/*  Q6 : albums tablosundaki Title sutunu 'Faceless' olan kaydın albumid'si elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. */
SELECT trackid, name, albumid
FROM tracks t
WHERE t.AlbumId = (
	SELECT a.albumid
	FROM albums a
	WHERE a.Title = 'Faceless');
-- JOIN li çözüm:
SELECT t.TrackId,
	   t.name,
	   t.AlbumId
FROM tracks t
JOIN albums a
ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Faceless';
--and li çözüm:
SELECT t.TrackId,
	   t.name,
	   t.AlbumId
FROM tracks t
JOIN albums a
ON t.AlbumId = a.AlbumId AND a.Title = 'Faceless';

/* HOMEWORK 1 : albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
SUBQUERY kullanarak listeyiniz. Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */	

/* HOMEWORK 2 :  albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
JOIN kullanarak listeyiniz.Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */		