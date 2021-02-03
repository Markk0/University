USE Fakultet 

 SELECT imeNastavnik, prezNastavnik
 FROM nastavnik


 SELECT imeStud +' '+ prezStud AS 'Ime i prezime', mbrStud
 FROM stud 


 SELECT Distinct imeStud
 FROM stud
 ORDER BY imeStud DESC 


 SELECT mbrStud
 FROM ispit
 WHERE sifPred=146


 SELECT imeNastavnik,prezNastavnik, (koef+ 0.4) *800 AS 'Placa'
 FROM nastavnik


 SELECT imeNastavnik, prezNastavnik, (koef+0.4)*800 AS 'Placa'
 FROM nastavnik
 WHERE ((koef +0.4) * 800<3500)
 OR ((koef+0.4) * 800>8000)


 SELECT *
 FROM stud
 WHERE imeStud LIKE '[aeiou]%[aeiou]'


 SELECT *
 FROM stud
 WHERE  RTRIM (imeStud)
 LIKE '[AEIOU]%[AEIOU]'


 SELECT *
 FROM stud
 WHERE imeStud LIKE '[^aeiou]%[^aeiou]' 


 SELECT *
 FROM stud
 WHERE imeStud LIKE '[aeiou]%' 
 OR imeStud LIKE '%[aeiou]'


 SELECT imeStud, prezStud
 FROM stud JOIN ispit ON stud.mbrStud=ispit.mbrStud
 WHERE ocjena=1 
 AND (sifPred BETWEEN 220 AND 240)



 SELECT DISTINCT imeStud,prezStud 
 FROM stud JOIN ispit ON 
 stud.mbrStud=ispit.mbrStud
 WHERE ocjena=3



 SELECT nazPred
 FROM pred LEFT JOIN ispit ON
 pred.sifPred=ispit.sifPred
 WHERE datIspit IS NULL 
 ORDER BY nazPred


 SELECT nazPred,oznDvorana
 FROM pred LEFT JOIN rezervacija ON
 pred.sifPred=rezervacija.sifPred
 WHERE brojSatiTjedno>2
 AND oznDvorana IS NOT NULL



 SELECT nazOrgjed,nazPred
 FROM pred JOIN orgjed ON 
 pred.sifOrgjed=orgjed.sifOrgjed
 WHERE upisanoStud>20


 SELECT DISTINCT nazMjesto
 FROM mjesto JOIN stud ON
 mjesto.pbr=stud.pbrStan



 SELECT imeStud,prezStud, nazPred, ocjena
 FROM ispit 
 JOIN stud ON ispit.mbrStud=stud.mbrStud
 JOIN pred ON ispit.sifPred=pred.sifPred


 SELECT nazPred,oznDvorana,nazOrgjed
 FROM pred JOIN rezervacija ON 
 pred.sifPred=rezervacija.sifPred
 JOIN orgjed ON orgjed.sifOrgjed=pred.sifOrgjed


 SELECT DISTINCT imeStud,prezStud,nazMjesto
 FROM stud JOIN mjesto ON stud.pbrStan=mjesto.pbr
 JOIN ispit ON stud.mbrStud=ispit.mbrStud
 JOIN pred ON pred.sifPred=ispit.sifPred
 WHERE nazPred = 'Osnove baza podataka' 
 AND ocjena=1



 SELECT imeNastavnik,prezNastavnik,nazMjesto,nazZupanija, nazPred, ocjena 
 FROM nastavnik	
 JOIN mjesto ON mjesto.pbr =nastavnik.pbrStan
 JOIN zupanija ON zupanija.sifZupanija=mjesto.sifZupanija
 JOIN ispit ON ispit.sifNastavnik=nastavnik.sifNastavnik
 JOIN pred ON pred.sifPred=ispit.sifPred
 WHERE ocjena=2 OR ocjena=3 
 ORDER BY nazPred



 SELECT imeStud, prezStud, m.nazMjesto AS 'Mjesto rodenja',z.nazZupanija AS  'Zupanija rodjenja',m2.nazMjesto AS 'Mjesto boravka', z2.nazZupanija AS 'Zupanija boravka'
 FROM stud s
 JOIN mjesto m ON m.pbr=s.pbrRod
 JOIN zupanija z ON Z.sifZupanija=M.sifZupanija
 JOIN mjesto m2 ON s.pbrStan=m2.pbr
 JOIN zupanija z2 ON z2.sifZupanija=m2.sifZupanija


 
 SELECT DISTINCT nazMjesto
 FROM mjesto JOIN stud ON mjesto.pbr=stud.pbrStan
 WHERE pbrRod=pbrStan



 SELECT imeNastavnik,prezNastavnik
 FROM nastavnik
 JOIN ispit ON ispit.sifNastavnik=nastavnik.sifNastavnik
 JOIN stud ON stud.mbrStud=ispit.mbrStud
 JOIN mjesto m1 ON m1.pbr=stud.pbrStan
 JOIN mjesto m2 ON m2.pbr=nastavnik.pbrStan
 WHERE m1.sifZupanija=m2.sifZupanija



 SELECT imeStud,prezStud
 FROM stud 
 JOIN mjesto m1 ON stud.pbrStan=m1.pbr
 JOIN mjesto m2 ON stud.pbrRod=m1.pbr
 WHERE pbrRod<>pbrStan and 
 m1.sifZupanija=m2.sifZupanija



 CREATE VIEW Stanovanje 
 AS 
 SELECT imeNastavnik,prezNastavnik,nazMjesto
 FROM nastavnik JOIN mjesto ON nastavnik.pbrStan=mjesto.pbr

 SELECT * FROM Stanovanje


 CREATE VIEW Prolaznost_ispita
 AS 
 SELECT imeStud,prezStud,imeNastavnik,prezNastavnik,nazPred,ocjena
 FROM stud 
 JOIN ispit ON stud.mbrStud=ispit.mbrStud
 JOIN nastavnik ON nastavnik.sifNastavnik=ispit.sifNastavnik
 JOIN pred ON pred.sifPred=ispit.sifPred

 SELECT *  FROM Prolaznost_ispita



 SELECT imeStud, prezStud, nazMjesto
 FROM stud JOIN mjesto ON stud.pbrRod=mjesto.pbr
 WHERE imeStud LIKE 'F%' 


 SELECT imeNastavnik,prezNastavnik
 FROM nastavnik JOIN mjesto ON mjesto.pbr=nastavnik.pbrStan
 WHERE SUBSTRING (nazMjesto,3,1)='Z'



 SELECT 
 FROM stud 
 JOIN ispit ON stud.mbrStud=ispit.mbrStud
 JOIN nastavnik ON ispit.sifNastavnik=nastavnik.sifNastavnik
 WHERE
 SUBSTRING (imeNastavnik,5,1)=(imeStud,5,1)


 SELECT nazZupanija
 FROM zupanija
 WHERE LEN(nazZupanija) BETWEEN 13 AND 20



 SELECT imeStud,prezStud
 FROM stud 
 WHERE MONTH (datRodStud) = 5 



 SELECT imeNastavnik,prezNastavnik, m1.nazMjesto, m2.nazMjesto, imeStud,prezStud
 FROM nastavnik
 JOIN ispit ON ispit.sifNastavnik=nastavnik.sifNastavnik
 JOIN mjesto m1 on m1.pbr=nastavnik.pbrStan
 JOIN stud ON stud.mbrStud=ispit.mbrStud
 JOIN mjesto m2 ON m2.pbr=stud.pbrRod
 WHERE MONTH(datIspit)=6 
 AND  m1.nazMjesto=m2.nazMjesto
