USE Fakultet
 
 
 SELECT COUNT (*) AS 'Ukupno predmeta'
 FROM pred


 SELECT nazPred, SUM (upisanoStud) AS 'Broj upisanih studenata'
 FROM pred 
 GROUP BY nazPred


 SELECT nazMjesto
 FROM stud JOIN mjesto ON stud.pbrStan=mjesto.pbr
 GROUP BY nazMjesto


 SELECT nazMjesto, COUNT (*) AS 'Broj Studenata'
 FROM stud JOIN mjesto ON stud.pbrStan=mjesto.pbr
 GROUP BY nazMjesto


 SELECT COUNT (stud.mbrstud) AS 'Nisu izasli'
 FROM stud LEFT OUTER JOIN ispit ON stud.mbrStud=ispit.mbrStud
 WHERE ocjena IS NULL


 SELECT COUNT(pred.nazPred) AS 'Nisu izasli'
 FROM dbo.pred
 WHERE upisanoStud > 5


 SELECT COUNT (nazPred) AS 'Neama studenata upisanih'
 FROM pred 
 WHERE upisanoStud = 0 


 SELECT COUNT(nazPred) AS 'Upisano izmedu 2 i 5 studenata'
 FROM pred 
 WHERE upisanoStud BETWEEN 2 AND 5 


SELECT COUNT(nazPred) AS 'Bez izlaska na ispit'
FROM pred LEFT OUTER JOIN ispit ON pred.sifPred=ispit.sifPred
WHERE ocjena IS NULL 


SELECT COUNT (DISTINCT sifPred) AS 'Netko izasao na ispit'
FROM ispit 



SELECT MAX(koef)
FROM dbo.nastavnik



SELECT MAX(koef),pbrStan,nazMjesto
FROM nastavnik JOIN mjesto ON  nastavnik.pbrStan=mjesto.pbr
GROUP BY pbrStan,nazMjesto


SELECT AVG (CAST(ocjena AS FLOAT)) AS 'Prosjecna ocjena' ,
		sifPred AS 'Sifra predmeta',
		datIspit AS 'Datum ispita'
FROM ispit
GROUP BY sifPred,datIspit
ORDER BY sifPred,datIspit



SELECT stud.imeStud,stud.prezStud,stud.mbrStud,
	AVG (CAST (ocjena AS FLOAT)) AS 'Prosjecna ocjena'
FROM stud JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE ispit.ocjena>1
GROUP BY stud.imeStud,stud.prezStud,stud.mbrStud



SELECT stud.prezStud,AVG (CAST(ispit.ocjena AS FLOAT)) AS 'Prosjek',stud.mbrStud,stud.imeStud
FROM stud JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE stud.prezStud LIKE 'K%'
GROUP BY stud.prezStud,stud.mbrStud,stud.imeStud
HAVING AVG (CAST (ispit.ocjena AS FLOAT)) > 2 


SELECT stud.imeStud, stud.prezStud, stud.mbrStud,
	AVG (CAST (ocjena AS FLOAT)) AS ' Prosjecna ocjena'
FROM stud JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE ispit.ocjena>1 
GROUP BY stud.imeStud,stud.prezStud,stud.mbrStud
ORDER BY 4 DESC 



SELECT mbrStud
FROM ispit
WHERE ocjena>1 
GROUP BY mbrStud
HAVING AVG(CAST (ocjena AS FLOAT )) >2.5


SELECT	DISTINCT nazOrgjed
FROM orgjed JOIN nastavnik ON orgjed.sifOrgjed=nastavnik.sifOrgjed


SELECT TOP 3 imeNastavnik,prezNastavnik,koef
FROM nastavnik 
ORDER BY koef asc 



SELECT FLOOR (koef) AS 'Grupa',
		COUNT (sifnastavnik) AS 'Broj nastavnika',
		 AVG (koef) AS 'Prosjek'
FROM nastavnik
GROUP BY FLOOR (koef) 



SELECT sifNadorgjed,
	COUNT(siforgjed) AS 'Broj podredenih jednica'
FROM orgjed
GROUP BY sifNadorgjed



SELECT orgjed.nazOrgjed,orgjed.sifOrgjed,
		SUM (pred.upisanoStud) AS 'Broj upisanih studenata',
		COUNT (*) AS 'Broj predmeta'
FROM orgjed JOIN pred ON orgjed.sifOrgjed=pred.sifOrgjed
GROUP BY orgjed.sifOrgjed, orgjed.nazOrgjed





SELECT imeNastavnik,prezNastavnik
FROM nastavnik
WHERE koef=(SELECT MAX(koef) FROM nastavnik )


SELECT imeNastavnik,prezNastavnik,sifNastavnik
FROM nastavnik
WHERE koef> (SELECT MAX(koef) FROM nastavnik) /2


SELECT imeStud, prezStud
FROM stud
WHERE datRodStud = (SELECT MAX (datRodStud) FROM stud)


SELECT *
FROM nastavnik
WHERE sifOrgjed IN (SELECT sifOrgjed 
						FROM orgjed 
							WHERE nazOrgjed LIKE 'Prirodoslovno%')


SELECT * 
FROM nastavnik
WHERE pbrStan= (SELECT pbr
				FROM mjesto
				 where nazMjesto= 'Zagreb')


SELECT * 
FROM nastavnik
WHERE pbrStan= (SELECT pbr
				FROM mjesto
				 where pbr= 10000)


SELECT *	
FROM stud 
WHERE pbrRod= (SELECT pbrRod
				FROM stud
				 WHERE mbrStud = 1172)


SELECT *
FROM dbo.stud
WHERE datRodStud > (SELECT datRodStud
					 FROM dbo.stud
					  WHERE imeStud='Tibor'
						AND prezStud='Poljanec')


SELECT *
FROM dvorana
WHERE kapacitet > ( SELECT AVG (CAST (kapacitet AS FLOAT)) FROM dvorana)


SELECT ISPIT.sifPred,PRED.nazPred
FROM ispit JOIN pred ON ispit.sifPred=pred.sifPred
WHERE ocjena > (SELECT  AVG ( CAST (ocjena AS FLOAT )) FROM ispit WHERE sifPred= 98 )


SELECT pred.sifOrgjed, orgjed.nazOrgjed,AVG (upisanoStud) AS 'Prosjek upisanih', MAX (brojSatiTjedno) AS 'Max sati tjedno'
FROM pred JOIN orgjed ON pred.sifOrgjed=orgjed.sifOrgjed
GROUP BY pred.sifOrgjed, orgjed.nazOrgjed



SELECT DISTINCT nastavnik.sifNastavnik, nastavnik.imeNastavnik, nastavnik.prezNastavnik
FROM dbo.nastavnik JOIN dbo.ispit ON nastavnik.sifNastavnik=ispit.sifNastavnik
					JOIN dbo.stud ON stud.mbrStud=ispit.mbrStud
WHERE nastavnik.pbrStan<>stud.pbrStan
ORDER BY 1 



USE Fakultet
CREATE CLUSTERED INDEX CL_student 
on stud(mbrStud)


USE Fakultet
DROP INDEX stud.CL_student



USE Fakultet
CREATE NONCLUSTERED INDEX NCL_prezime
ON stud(prezStud) 



USE FakulteT	
CREATE NONCLUSTERED INDEX NCL_ime_prezime
ON stud(imeStud, prezStud)



USE Fakultet
EXEC sp_helpindex stud 



USE Fakultet
CREATE NONCLUSTERED INDEX NCL_mjesto
ON mjesto(nazMjesto)
WITH PAD_INDEX,FILLFACTOR=85



BEGIN TRANSACTION PromjenaPredmeta 
GO 
USE Fakultet
GO 
UPDATE pred SET brojSatiTjedno=2
	WHERE nazPred ='Radiokomunikacije'
GO
COMMIT TRANSACTION PromjenaPredameta 


USE Fakultet
SELECT brojSatiTjedno
FROM pred 
WHERE nazPred = 'Radiokomunikacije'




CREATE VIEW NisuIzlazili
AS 
SELECT stud. *
FROM stud LEFT JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE ocjena IS NULL 



CREATE VIEW NadOrgje_Orgjed
WITH ENCRYPTION 
AS 
SELECT sifNadorgjed,sifOrgjed,nazOrgjed
FROM dbo.orgjed 

SELECT * FROM NadOrgje_Orgjed



CREATE VIEW Nisu_polozili
WITH ENCRYPTION 
AS 
SELECT DISTINCT imeStud,prezStud
FROM stud LEFT JOIN ispit ON stud.mbrStud=ispit.mbrStud
	WHERE ocjena=1 

SELECT * FROM Nisu_polozili


CREATE VIEW ProsjekOcjena
AS 
SELECT stud.imeStud, stud.prezStud, stud.mbrStud,
AVG (CAST (ocjena AS FLOAT)) AS 'Prosjek ocjena'
FROM stud JOIN ispit ON stud.mbrStud=ispit.mbrStud
WHERE ocjena >1 
GROUP BY stud.imeStud, stud.prezStud, stud.mbrStud



SELECT * FROM ProsjekOcjena



SELECT * FROM sys.all_objects
WHERE TYPE ='U'


USE Fakultet
CREATE TYPE tel
FROM nvarchar(20) NULL



USE Fakultet
ALTER TABLE nastavnik 
	 ADD Telefon tel




USE Fakultet
EXEC sp_addtype grad , 'nvarchar(20)' , null 


USE Fakultet
GO 
CREATE PROCEDURE ispit_na_dan
@dan smalldatetime 
AS 
	SELECT mbrStud
	FROM ispit
	WHERE datIspit = @dan 
	ORDER BY mbrStud


	EXEC ispit_na_dan '2007-11-02'


EXEC sp_configure 'show advanced option' , '1'
RECONFIGURE WITH OVERRIDE 
EXEC SP_CONFIGURE 




CREATE PROCEDURE Zadnje_polagao
@mbr int 
AS 
SELECT nazPred,datIspit
FROM pred JOIN ispit ON pred.sifPred=ispit.sifPred
WHERE mbrStud=@mbr
AND datIspit IN (SELECT MAX (datispit) FROM ispit WHERE mbrStud=@mbr)

	EXEC Zadnje_polagao 1172



CREATE PROCEDURE Polozeni_ispiti
@mbr int 
AS 
SELECT COUNT (*) AS 'Polozeni ispiti'
FROM ispit
WHERE ocjena>1 
AND mbrStud=@mbr


EXEC Polozeni_ispiti  1172



CREATE TRIGGER Podsjetnik 
ON orgjed
INSTEAD OF UPDATE , DELETE 
AS PRINT 'Ne mjenjati podatke'



CREATE TRIGGER Novi_student_dodan
ON stud 
AFTER INSERT 
AS 
PRINT 'Dodan novi student'


CREATE TRIGGER Nema_dodavanja_tablice 
ON DATABASE  
FOR CREATE_TABLE 
AS 
PRINT  'Ne mozete kreirati tablicu' 
ROLLBACK




CREATE TRIGGER Provjera_datuma 
ON ispit
FOR INSERT 
AS 
 IF (SELECT datispit  FROM  inserted ) BETWEEN GETDATE () 
 AND (GETDATE () + 30)
 BEGIN 
 ROLLBACK 
 END 