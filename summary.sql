SELECT NOW() /*timezone*/

string, integer
SELECT 1/2::real /*permet de changer le type de donnée*/

(a AND b) OR (d AND c) XON
NOT c

FONCTION(...)

'xx' || 'yy'

constantes: numériques(1234), text('Azerty','L"orient'), date('yyyy-mm-dd'), heure('HH-mm'),
Bool(True, False), NULL, (<,>,<=,>=,=,<>(différent),!(différent))

SELECT '2019-10-25'::date +3
SELECT 'Test',now(),3

SELECT 'Test',now(),3,nom_per
FROM personne

Select to_date('05 dec 2000','dd mon yyyy')

DD = day of month
DDD = day of the year (31-12-2019 => 365 jours)
MM = month number
MON = month 3 lettres
mon = ""
MONTH = MOIS
Month = Mois
...

SELECT to_char (date, string)
SELECT to_char(now(), 'DD RM CC HH12')

SELECT nom_per,prenom
FROM personne
WHERE date_naissance <'1950-01-01'

FROM personne
WHERE date_naissance < '1950-01-01'
OR date_naissance IS NULL

SELECT prenom||' '||nom_per
FROM personne

SELECT coalesce(prenom||' ','')||nom_per
FROM personne

SELECT coalesce(prenom||' ','')||nom_per AS personne, date_naissance AS "date de naissance"
FROM personne AS p

WHERE personne IS NULL AND date_naissance IS NOTNULL

WHERE to_char(date_naissance,'yyyy') = '1950'
	  date_naissance <'1951-01-01' AND date_naissance > '1945-12-31'

	  date_naissance BETWEEN '1950-01-01' AND '1950-12-31'

	  date_part('year',date_naissance)=1950
--------------------------------------------------------
LIKE 'Du %' => recherche mots commençant par Du

SELECT nom_per,prenom,date_naissance
FROM personne
WHERE nom_per LIKE 'DUP%' => ILIKE

 ===> prenom LIKE 'JEAN-%'

 SELECT titre
 FROM document
 WHERE titre LIKE '%Eglise%'

 SELECT titre
 FROM document
 WHERE titre ILIKE '%église%'
 OR titre ILIKE '%eglise%'

SELECT nom_per
FROM personne
WHERE nom_per = 'DUP%'
ORDER BY nom_per

SELECT nom_per,prenom,date_naissance
FROM personne
WHERE nom_per LIKE 'DUP%'
ORDER BY nom_per DESC,prenom ASC,date_naissance DESC

SELECT nom_per,prenom,date_naissance
FROM personne
WHERE nom_per LIKE 'DUP%'
ORDER BY nom_per,prenom NULLS FIRST,date_naissance

SELECT nom_per,prenom,date_naissance 
FROM personne
WHERE nom_per LIKE 'DUP%'
ORDER BY date_naissance DESC NULLS LAST
LIMIT 10

SELECT nom_per
FROM personne
WHERE nom_per LIKE 'DUP%'
GROUP BY nom_per

SELECT nom_per,count(*)
FROM personne
WHERE nom_per LIKE 'DUP%'
GROUP BY nom_per
ORDER BY count(*) DESC

SELECT nom_per,prenom,count(*) AS compte
FROM personne
WHERE nom_per LIKE 'DU%'
GROUP BY nom_per,prenom
ORDER BY prenom,nom_per

count(*), count(nom colonne)
sum(nom colonne)
avg(nom colonne)
min(nom colonne)

	SELECT nom_per,count(*)
1	FROM personne				Selectionné la table
2	WHERE nom_per LIKE 'DU%'    condition
3	GROUP BY nom_per            Filtre 
4	HAVING count(*)>1			regroupe
5	ORDER BY count(*) DESC

SELECT nom_per,prenom,count(*)
FROM personne
WHERE prenom IS NOT NULL
GROUP BY nom_per,prenom
HAVING count(*)>1
ORDER BY count(*) DESC
date_naissance

SELECT count(prenom)
FROM personne
WHERE nom_per LIKE 'DU%'

SELECT substr(nom_per,1,1), min(date_naissance)
FROM personne
WHERE genre = 'M'
GROUP BY substr(nom_per,1,2)	substr(nom_per,4) => chaine de caractère
HAVING count (*) >5
ORDER BY substr(nom_per,1,1)

SELECT substr(nom_per,1,1), min(date_naissance),count(*)
FROM personne
GROUP BY substr(nom_per,1,1)
ORDER BY substr(nom_per,1,1)

SELECT nom_per,prenom
FROM personne
WHERE date_naissance='0972-10-29'

Subquery (sub Select) => 1 ligne + 1 colonne
SELECT nom_per,prenom
FROM personne
WHERE genre='M' AND date_naissance=(SELECT min(date_naissance) FROM personne WHERE genre='M')

SELECT nom_per,prenom,date_naissance,genre
FROM personne
WHERE date_naissance=(SELECT min(date_naissance) FROM personne WHERE genre='M') OR date_naissance=(SELECT min(date_naissance) FROM personne WHERE genre='F')

SELECT nom_per,prenom,date_naissance,genre
FROM personne p1
WHERE date_naissance=(SELECT min(date_naissance) FROM personne p2 WHERE p2.genre=p1.genre)

SELECT nom_per,prenom,date_naissance,date_naissance-(SELECT min(date_naissance) FROM personne p2 WHERE p1.genre=p2.genre)
FROM personne p1

liste personne même prenom + de 100 fois

SELECT nom_per,prenom
FROM personne
WHERE prenom IN(SELECT prenom FROM personne GROUP BY prenom HAVING count(*)>300)

EXISTS(Subquery) True => si Subquery renvoie au moins une ligne
				  False => si renvoie 0 ligne
SELECT 1
FROM table
WHERE condition

SELECT nom_per,prenom,date_naissance
FROM personne p1
WHERE EXISTS(SELECT 1 FROM personne p2 WHERE p2.date_naissance=p1.date_naissance)

SELECT nom_per,prenom,date_naissance
FROM personne
WHERE personne='1967-01-25'

SELECT nom_per,prenom,date_naissance
WHERE EXISTS
FROM personne p1
ORDER BY

SELECT nom_per,prenom,date_naissance
FROM personne p1
WHERE date_naissance=(SELECT DISTINCT date_naissance FROM personne p2 WHERE p2.date_naissance=p1.date_naissance+3)

SELECT nom_per,prenom,date_naissance 
FROM personne p1
WHERE EXISTS(SELECT 1 FROM personne p2 WHERE p2.date_naissance=p1.date_naissance+3)

SELECT nom_per,prenom,date_naissance
FROM personne p1
WHERE EXISTS(SELECT 1 FROM personne WHERE date_naissance=p1.date_naissance+3)

Rappel DISTINCT

nom prenom en double ou plus
SELECT COUNT(*) AS nom_per,prenom
FROM personne
GROUP BY nom_per,prenom
HAVING count(*)>1
ORDER BY nom_per,prenom

SELECT nom_per,prenom
FROM personne p
WHERE EXISTS (SELECT DISTINCT 1 FROM personne ps WHERE p.nom_per=ps.nom_per AND p.prenom=ps.prenom AND p.noid<>ps.noid)

pas d'adresse//'
SELECT nom_per,prenom
FROM personne p
WHERE NOT EXISTS (SELECT 1 FROM adresse_per a WHERE a.no_personne=p.noid)

Jointure

SELECT nom_per,prenom,type_adr,rue,numero,code_postal,localite
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%'AND type_adr='Domicile'
ORDER BY nom_per,prenom

JOIN
LEFT JOIN
----------------------------------
SELECT personne.noid,nom_per,prenom,adresse_per.noid,type_adr,rue,numero,code_postal,localite
FROM personne LEFT JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%'
ORDER BY nom_per,prenom
----------------------------------
SELECT personne.noid,nom_per,prenom,adresse_per.noid,type_adr,rue,numero,code_postal,localite
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%'
ORDER BY nom_per,prenom

Rappel DISTINCT + DOUBLE

SELECT nom_per,type_adr,localite
FROM personne LEFT JOIN adresse_per
		ON peronne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%' AND adresse_per.noid IS NULL
ORDER BY nom_per,prenom


Pour les Jointure voir page 122
*Liste personne nom prenom + de 3 adresses

SELECT count(*),nom_per,prenom
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
GROUP BY personne.noid
HAVING count(*)>3
ORDER BY count(*) DESC

*Personne sans adresses

SELECT nom_per,prenom
FROM personne LEFT JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%' AND no_personne IS NULL


courrier => Boolean
*personne sans adresse courrier

0-nombre de personne commençant par D -3019
SELECT nom_per,prenom
FROM personne
WHERE nom_per LIKE 'D%'

1-Pas d'adresse'
SELECT nom_per,prenom,courrier
FROM personne LEFT JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%' AND no_personne IS NULL

2-au moins 1 adresse
SELECT nom_per,prenom,courrier
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%' AND courrier=TRUE

3-toutes les personne avec adresse
SELECT nom_per,prenom
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE nom_per LIKE 'D%' AND courrier=TRUE
GROUP BY personne.noid


*personne plus que 1 adresse courrier(attention exam)
SELECT nom_per,prenom
FROM personne JOIN adresse_per
	ON personne.noid=adresse_per.no_personne
WHERE courrier=TRUE
GROUP BY personne.noid
HAVING count(*) > 1

*Double Jointure
Liaison n à n 
LDD => lien-document-dossier
nom_dos = 'voirie'

SELECT nom_dos,classement,titre
FROM document JOIN lien_document_dossier ON document.noid=lien_document_dossier.no_document
			  JOIN dossier ON dossier.noid=lien_document_dossier.no_dossier
WHERE nom_dos='Voirie'

*classement = 46167
SELECT nom_dos,classement,titre
FROM document JOIN lien-document-dossier ON document.noid=lien-document-dossier.no_document
			  JOIN dossier ON dossier.noid=lien-document-dossier.no_dossier
WHERE classement=46167
ORDER BY classement

*Classement plus petit que 10000
SELECT nom_dos,classement,titre
FROM document JOIN lien_document_dossier ON document.noid=lien_document_dossier.no_document
			  JOIN dossier ON dossier.noid=lien_document_dossier.no_dossier
WHERE nom_dos='Voirie' AND classement<100000
ORDER BY classement

SELECT document,dossier,count(*)
FROM dossier JOIN lien_document_dossier ON dossier.noid=no_dossier
GROUP BY dossier.noid
ORDER BY 

SELECT type_doc,count(*)
FROM dossier JOIN lien_document_dossier ON dossier.noid=no_dossier
  	JOIN document ON document.noid=no_document
WHERE nom_dos='Prêt de matériel'
GROUP BY type_doc
ORDER BY count(*) DESC


SELECT type_doc,count(*)
FROM dossier JOIN lien_document_dossier ON dossier.noid=no_dossier
  	JOIN document ON document.noid=no_document
WHERE type_dos < 
GROUP BY type_doc
ORDER BY count(*) DESC

SELECT type_doc,count(*)
FROM dossier p JOIN lien_document_dossier ON dossier.noid=no_dossier
  	JOIN document ON document.noid=no_document
WHERE type_dos =(SELECT dossier.noid FROM nom_dos JOIN GROUP BY LIMIT 1) => Attention pas complet 
GROUP BY type_doc
ORDER BY count(*) DESC
----------------------------

TABLE personne == SELECT * FROM personne
DROP TABLE personne

CREATE TABLE xxx AS query

CREATE TABLE xyz AS TABLE personne

CREATE TABLE xyz AS TABLE personne WITH NO DATA (sans données dans les tables)

CREATE TABLE personne.bis AS SELECT noid,nom_per FROM personne WHERE nom_per LIKE 'D%'
VALUES('a',12,NULL),('b',13,'2019-12-24')

INSERT INTO personne

INSERT INTO personne(noid,nom_per,prenom,date_naissance)
VALUES(DEFAULT,'Dupont','Jules','2000-01-01') => doit correspondre à lordre de la ligne INSERT INTO
RETURNING noid,date_naissance,...

SELECT exp1,exp2,exp3 FROM ...
DEFAULT VALUES

DELETE FROM personne
[WHERE nom_per LIKE 'DU%'] (Subselect)
WHERE NOT EXISTS(SELECT 1 FROM adresse_per WHERE no_personne=adresse_per)
RETURNING noid,nom_per,personne

------------------------------

INSERT,UPDATE,DELETE.

INSERT INTO table-nom
UPDATE table-name
DELETE FROM table-name

INSERT INTO table-name(liste) SELECT VALUES(liste)

INSERT INTO personne(nom_per,prenom,date_naissance,noid) SELECT VALUES('Durant','Jules',NULL,DEFAULT)

INSERT INTO table-name(liste) SELECT VALUES(liste)
RETURNING noid

(TRUNCATE personne)

DELETE FROM personne
	   WHERE nom_per LIKE 'D%'
RETURNING noid,nom_per

noid DEFAULT VALUES uuid-generate-v4()


UPDATE table-name
SET champ = expression
	(liste) = (exp1,exp2,exp3)

UPDATE table-name
SET collumn = expression
	(liste) = (exp1,exp2,exp3)
WHERE condition

UPDATE personne
SET salaire=1.02*salaire+100
WHERE departement'Comptable'

UPDATE personne
SET (nom_per,prenom)=('Dupont','Jules')    salaire=(SELECT......)
WHERE noid='abc...'	

'(UPDATE personne
SET salaire=bareme_noid
FROM bareme
WHERE departement='x')'

10
7 SELECT
1 Jointure double 
CREATE TABLE AS


 
---------------------------------------------------------

CREATE TABLE Voiture(
Marque VARCHAR(50),
Essence VARCHAR(100),
Depart DATE);

INSERT INTO Voiture (marque,)


