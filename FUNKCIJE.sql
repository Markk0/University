



sp_help 'nastavnik'

CREATE FUNCTION FN_lijepo_spoji 
(@str1  nvarchar (50) , @str2 nvarchar (50))
RETURNS nvarchar (50) 
BEGIN 
	RETURN LTRIM (RTRIM (@str1)) +' '+ LTRIM (RTRIM(@str1))
END 


USE Fakultet
SELECT dbo.FN_lijepo_spoji (imenastavnik,prezNastavnik), koef
FROM nastavnik 


CREATE FUNCTION FN_formatiraj_datum
(@datum datetime , @separator char(1) )
RETURNS nchar (20)
BEGIN 
RETURN CONVERT(nvarchar (20) , datepart (dd,@datum))
		+ @separator
		+CONVERT (NVARCHAR(20), datepart (mm,@datum))
		+@separator
		+CONVERT (NVARCHAR(20) , datepart (yyyy,@datum))
END 



USE Fakultet
SELECT imeStud,dbo.FN_formatiraj_datum(datRodStud, '-')
FROM stud



CREATE FUNCTION FN_Nastavnici 
(@vrsta nvarchar (6) )
RETURNS @nastavnik TABLE (ID_nastavnik INT PRIMARY KEY NOT NULL , Nastavnik nvarchar (60) NOT NULL ) 
AS 
BEGIN 
	IF @vrsta='kratko'
	INSERT @nastavnik SELECT sifNastavnik,prezNastavnik
	FROM nastavnik
	ELSE IF @vrsta='dugo'
	INSERT @nastavnik
	SELECT nastavnik.sifNastavnik,
	(RTRIM(imenastavnik) +' '+ RTRIM(preznastavnik))
	FROM nastavnik
RETURN
END



SELECT * FROM dbo.FN_Nastavnici ('kratko')
SELECT * FROM dbo.FN_Nastavnici ('dugo')


CREATE FUNCTION FN_Mjesta_Zupanija
(@sifZupanije INT)
RETURNS TABLE 
AS
RETURN
(SELECT pbr AS 'Pozivni broj',nazMjesto AS 'Naziv mjesta'
FROM mjesto
WHERE sifZupanija=@sifZupanije)


SELECT * FROM dbo.FN_Mjesta_Zupanija(3)




CREATE FUNCTION 
FN_Placa (@STR1 decimal (10),@baz decimal (10))
RETURNS decimal (20)
	BEGIN 
		RETURN @STR1*@baz
	END


SELECT  dbo.FN_Placa (koef,1000) , imeNastavnik,prezNastavnik
FROM	nastavnik

DROP FUNCTION FN_Placa


CREATE FUNCTION FN_grupe_nastavnik
(@koef decimal (3,2))
RETURNS char(4)
BEGIN
RETURN CAST (FLOOR (@koef) AS char (1))+' '+ CAST (FLOOR (@koef)+1 AS char (2))
END 


SELECT koef,dbo.FN_grupe_nastavnik(koef)
FROM nastavnik
SELECT dbo.FN_grupe_nastavnik(koef), COUNT(sifnastavnik)
FROM nastavnik 
GROUP BY dbo.FN_grupe_nastavnik(koef)


CREATE FUNCTION FN_Nastavnik  (@vvrsta nvarchar(6))
RETURNS @nastavnici TABLE 
(
sifra INT PRIMARY KEY  NOT NULL ,
Nastavnik nvarchar (60) NOT NULL 
)
AS 
BEGIN  if @vvrsta='kratko'
	INSERT @nastavnici 
	SELECT sifNastavnik,prezNastavnik
	FROM nastavnik 
	ELSE IF @vvrsta='dugo'
	INSERT @nastavnici
	SELECT sifNastavnik,dbo.FN_lijepo_spoji(imeNastavnik,prezNastavnik)
	FROM nastavnik
RETURN
END


SELECT * 
FROM dbo.FN_nastavnik ('dugo')




USE Fakultet
GO 
CREATE VIEW Parni_predmeti
AS 
SELECT sifPred AS 'Sifra' , kratPred AS 'Kratica' , nazPred AS ' Naziv'
FROM pred 
WHERE sifPred%2 = 0 
GO


SELECT *
FROM Parni_predmeti


USE Fakultet
GO
CREATE VIEW Studenti_ispiti
AS 
SELECT stud.imeStud,stud.mbrStud,ispit.sifPred, ispit.ocjena
FROM ispit RIGHT OUTER JOIN stud ON ispit.mbrStud=stud.mbrStud
WITH CHECK OPTION 
GO 


SELECT * 
FROM Studenti_ispiti


PRINT left ('Baze podataka', 4)
PRINT LEN ('Baze podataka')
PRINT LOWER ('BAZE PODATAKA')
PRINT REPLICATE ('base' , 2)
PRINT LTRIM ('            Baze podataka')
PRINT REVERSE ('Base') 
PRINT SUBSTRING ('Baze podataka', 6,7) ---form 6th place in string to next 7 places in string podatak is the valuse we get 


USE Fakultet
SELECT RTRIM(imestud)+' '+ RTRIM(prezstud) + 'ima maticni broj' + CAST (mbrstud AS nvarchar)
FROM stud 
GO 


EXEC sp_help Stud



USE Fakultet
SELECT RTRIM(imestud)+' '+ RTRIM(prezstud) + ' je roden(a) ' + CONVERT (nvarchar, datRodStud,104)
FROM stud 
GO 


USE Fakultet
SELECT RTRIM(imestud)+ ' ' + RTRIM(prezstud) AS 'ime i prezime studenta' , DATENAME (m, datRodStud) AS 'mjesec rodjenja'
FROM stud 


SELECT imeNastavnik, prezNastavnik
FROM nastavnik JOIN mjesto ON nastavnik.pbrStan=mjesto.pbr
WHERE SUBSTRING (nazmjesto, 3,1)='Z'