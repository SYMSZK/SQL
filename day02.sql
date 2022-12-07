create table ogrenciler2
(
    ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date
);

--var olan bir tablodan yeni bir tablo olusturma
create table notlar
as
select isim,not_ort from ogrenciler;

select * from notlar;

--TABLO İCİNE VERİ EKLEME

INSERT INTO notlar values ('hanife',89.5);

--CONSTRAINT
--UNIQUE
--NOT NULL
create table ogrenciler3
(
    ogrenci_no char(7) unique,--ayni noyu tekrar kullanamam
	isim varchar(20) not null,
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date
);

select * from ogrenciler3;
insert into ogrenciler3 values('1234567','seyma','suzuk',96.5,now());
insert into ogrenciler3 values('1234568','hanife','suzuk',86.5,now());
insert into ogrenciler3 (ogrenci_no,soyisim,not_ort) values ('1234569','mustafa',98.5);--not null kisitlamasi 
--oldugu icin bu veri eklenemez

--PRIMARY KEY atamasi
create table ogrenciler4
(
    ogrenci_no char(7) PRIMARY KEY,
	isim varchar(20),
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date
);

--PRIMARY KEY ATAMASI 2.YOL
--eger constraınt ismini kendimiz vermek istersek
create table ogrenciler5
(
    ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date,
	CONSTRAINT ogr PRIMARY KEY (ogrenci_no)
);
--PRIMARY KEY ATAMASI 3.YOL
create table ogrenciler6
(
    ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date,
	PRIMARY KEY (ogrenci_no)
);
create table ogrenci
(
    ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date,
	CONSTRAINT org1 PRIMARY KEY (ogrenci_no,isim)--conposite pk 
	                                    --bir tabloda bi tane pk olur bbirden fazlyi bu sekilde yapabilirim
	CONSTRAINT org2 unique (soyisim,not_ort)
);

-- FOREIGN KEY 

/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,  
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
create table tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
	tedarikci_ismi varchar(20),
	iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)  
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)  
);
select * from tedarikciler3;
select * from urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”  
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın. 
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve 
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int NOT NULL,
ise_baslama date    
);

CREATE TABLE adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)    
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- INT / STRING bsoluk int sen string grmeye calısıyorsun
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');--ilk hcligi kabul etti
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY ikici kez hiclik gireye calıstım
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY 
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY null kabul etmez

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
   
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;
SELECT * FROM adresler;

-- CHECK CONSTRAINT

CREATE TABLE calisanlar1
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000) NOT NULL,--check ile not null beraber kabul etti
ise_baslama date    
);
INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14'); 
SELECT * FROM calisanlar1;

-- DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;--sadece tablodaki isimleri goruyorum

-- Calisanlar tablosundan maası 5000 den buyuk olan isimleri listeleyiniz
select isim,maas from calisanlar where maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan tüm verileri listeleyiniz
select * from calisanlar where isim='Veli Han';--tumu dedigi icin * dan yazdık

-- Calisanlar tablosundan maası 5000 olan tüm verileri listeleyiniz
SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar; -- Eğer parent tablo başka bir child tablo ile iliskili ise önce child tablo silinmelidir
DELETE FROM adresler;
SELECT * FROM adresler;

--Adresler tablosundan sehri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir = 'Antep';

