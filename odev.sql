--ODEV
--ankara da calisani olan markalarin marka id lerini ve 
--calisan sayilarini hesaplayiniz

SELECT marka_id AS ankaradacalisanid,calisan_sayisi FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara')

select * from calisanlar2
select * from markalar

