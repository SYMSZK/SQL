--DDL - DATA DEFINITION LANG.
--CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler
(
	ogrenci_no char(7)
	isim varchar(20)
	soyisim varchar(25)
	not_ort real, --ondalikli sayilar icin kullanilir(double gibi)
	kayit_tarih date
);

--VAROLAN TABLODAN YENİ BİR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
as --benzer tablodaki basliklarla data tipleriyle yeni bir tablo olusturmak icin
--normş bir tablo olustururken ki paranteler yerine as kullanip select komutuyla
--almak istedigimiz verileri aliriz 
select isim,soyisim,not_ort from ogrenciler;


--DML _ DATA MANUPULATION LAG
--INSERT (Database e veri ekleme)
insert into ogrenciler values('1234567','Said','ILHAN',85.5,now());
insert into ogrenciler values('1234567','Said','ILHAN',85.5,'2020-12-11');

--bir tabloya parcali veri ekemek istersek

insert into ogrenciler (isim,soyisim) values('seyma','suzuk');

--DQL - DATA QUERY LANG
--SELECT
select * from ogrenciler;


