-- GROUP BY
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel
delete from personel

--Isme gore toplam maaslari bulun
SELECT isim,sum(maas) FROM personel
GROUP BY isim

-- Personel tablosundaki isimleri gruplayınız
SELECT isim,count(sehir) FROM personel
GROUP BY isim

-- HAVING KULLANIMI
/*
Having komutu yanlızca group by komutu ile kullanılır. 
Eğer gruplamadan sonra bir şart varsa having komutu kullanılır
Where kullanımı ile aynı mantıkta çalışır
*/
-- 1) Her sirketin MIN	maaslarini eger 4000’den buyukse goster
SELECT sirket,MIN(maas) AS en_dusuk_maas FROM personel
GROUP BY sirket 
HAVING MIN(maas)>4000

-- Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi  ve toplam maasi gosteren sorgu yaziniz
SELECT isim,sum(maas) AS toplam_maas
FROM personel 
GROUP BY isim
HAVING sum(maas)>10000

-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir,COUNT(isim) AS toplam_personel_sayisi
FROM personel 
GROUP BY sehir
HAVING COUNT(isim)>1


-- Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir,max(maas) AS en_yuksek_maas FROM personel
GROUP BY sehir
HAVING max(maas)<5000

-- UNION KULLANIMI
--iki farkli sorgulamanin sonucunu birlestiren islemdir

--Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan  sehirleri	gosteren sorguyu yaziniz
SELECT sehir AS isci_veya_sehir_ismi,maas FROM personel
WHERE maas>5000
UNION
SELECT isim AS isci_veya_sehir_ismi,maas FROM personel
WHERE maas>4000

-- Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
SELECT isim AS isim_ve_sehir,maas FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir AS isim_ve_sehir,maas FROM personel WHERE sehir='Istanbul'
ORDER BY maas

CREATE TABLE personel1
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
INSERT INTO personel1 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel1 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel1 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel1 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel1 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel1 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel1 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel1
select * from personel_bilgi

-- id’si 123456789 olan personelin	Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir as sehir_ve_tel,maas AS maas_ve_cocuk_sayisi FROM personel1 WHERE id=123456789
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id=123456789

-- UNION ALL
/*
Union tekrarli verileri teke düşürür ve bize o şekilde sonuç verir
Union All ise tekrarli verilerle birlikte tün sorguları getirir
*/
--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
SELECT isim,maas FROM personel1 WHERE maas<5000
UNION
SELECT isim,maas FROM personel1 WHERE maas<5000
--iki sorguyu birden calistirdim tek duser birden fazla olanlar

SELECT isim,maas FROM personel1 WHERE maas<5000
UNION all
SELECT isim,maas FROM personel1 WHERE maas<5000
--aynisini tekrar tekrar yazdirdi

-- INTERSECT (Kesişim)
/*
Farkli iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz
*/

--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel1 WHERE sehir IN('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN(2,3)

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel1 WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel1 WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel1 WHERE sirket='Tofas'


-- EXCEPT(MINUS(HARİC)) KULLANIMI
/*
İki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanılır
*/

-- 5000’den az maas alip Honda’da calismayanlari yazdirin

SELECT isim,sirket FROM personel1 WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel1 WHERE sirket='Honda'

