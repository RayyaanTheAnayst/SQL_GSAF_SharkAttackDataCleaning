/* Cleanning and Analysing Global Shark Attack File*/ 

SELECT*
FROM Shark..GSAF$

/* 1.Format Date*/


--1. Date Colmn

SELECT Date
FROM Shark..GSAF$

UPDATE Shark..GSAF$
SET [Date Formated]= FORMAT(Date, 'yyyy.MM.dd')

/*SELECT Date, [date formated]
FROM Shark..GSAF$
*/


--1.2 Get rid of NULL's in Date by using Case Number then removing the letters in 1.3

		SELECT [Case Number], Date, [date formated]
			FROM Shark..GSAF$


			SELECT COALESCE([Case Number], [date formated])
			FROM Shark..GSAF$
				WHERE [date formated] IS NULL

					UPDATE Shark..GSAF$ 
						SET [date formated] =COALESCE([Case Number], [date formated])
							FROM Shark..GSAF$
								WHERE [date formated] IS NULL


--1.3 cleaned date removing unwanted stuff

	SELECT LEFT([Date Formated],10)
		FROM Shark..GSAF$

			UPDATE Shark..GSAF$ 
				SET [Date Formated]= LEFT([Date Formated],10) 
					FROM Shark..GSAF$




-- Add Colmn for the month of Attack using Date and left and right cleaning 


ALTER TABLE 	Shark..GSAF$
ADD Month NVARCHAR(255)

	SELECT LEFT([Date Formated],7) AS Month
	  FROM Shark..GSAF$
			UPDATE Shark..GSAF$
				SET Month=LEFT([Date Formated],7)

SELECT Month
FROM Shark..GSAF$

	SELECT RIGHT((Month),2) AS Month
	  FROM Shark..GSAF$
			UPDATE Shark..GSAF$
				SET Month=RIGHT((Month),2)

SELECT Month
FROM Shark..GSAF$


--2. Remove NULLS in Type

	SELECT Type
	FROM Shark..GSAF$
	WHERE Type IS NULL 

		DELETE FROM Shark..GSAF$
		WHERE Type IS NULL

--3.1 Country/Area and Location fill or dellete nulls

	
	SELECT*
	FROM Shark..GSAF$
	
	SELECT CONCAT (Country,',',' ', Area,',',' ', Location) AS [Location Details]
	FROM Shark..GSAF$

		ALTER TABLE Shark..GSAF$
		ADD [Location Details] NVARCHAR(255)
			UPDATE Shark..GSAF$
				SET [Location Details]= CONCAT (Country,',',' ', Area,',',' ', Location)

	SELECT [Location Details]
	FROM Shark..GSAF$
		WHERE 	[Location Details] IS NULL --No Nulls after Concatenating

-- 4 Activity Column fill nulls with Type

	
	SELECT*
	FROM Shark..GSAF$
	
	SELECT COALESCE (Activity, Type)
	FROM Shark..GSAF$
		WHERE Activity IS NULL 
	
			ALTER TABLE Shark..GSAF$
			ADD Activity2 NVARCHAR(255)

			UPDATE Shark..GSAF$
			SET Activity2 = COALESCE (Activity, Type) 

--CHECK 	
		SELECT Activity, Activity2 -- 
		FROM Shark..GSAF$

--5 Name colmn fill nulls with Anonomouse


	SELECT COUNT(ISNULL(Name,0))
	FROM Shark..GSAF$
	WHERE Name IS NULL
	
	SELECT Name,
		CASE
			WHEN Name IS NULL THEN 'Anonymous' ELSE Name END
	FROM Shark..GSAF$

		UPDATE Shark..GSAF$
		SET Name = CASE
			WHEN Name IS NULL THEN 'Anonymous' ELSE Name END

-- CHECK 
SELECT Name
FROM Shark..GSAF$


-- 6 AGE where null enter AVERAGE age
	SELECT Age
	FROM Shark..GSAF$
		WHERE Age is null


	SELECT ROUND(AVG(Age),0)
	FROM Shark..GSAF$
		WHERE AGE IS NULL

		SELECT CONVERT(INT,Age),
			CASE
				WHEN Age IS NULL THEN '28' ELSE Age END
		FROM Shark..GSAF$
		GROUP BY Age

			UPDATE Shark..GSAF$
				SET Age = CASE
							WHEN Age IS NULL THEN '28' ELSE Age END

--CHECK

SELECT Age
FROM Shark..GSAF$

-- Change Fatal to yes or no

	SELECT [Fatal (Y/N)],
		CASE
			WHEN [Fatal (Y/N)] = 'Y' THEN 'YES' 
			WHEN [Fatal (Y/N)] = 'N' THEN 'NO' 
			ELSE Injury END

	FROM  Shark..GSAF$

	UPDATE Shark..GSAF$
	SET [Fatal (Y/N)]= CASE
			WHEN [Fatal (Y/N)] = 'Y' THEN 'YES' 
			WHEN [Fatal (Y/N)] = 'N' THEN 'NO' 
			ELSE Injury END
--CHECK 	

SELECT [Fatal (Y/N)]
FROM Shark..GSAF$

-- INJURIES

	SELECT Injury
	FROM Shark..GSAF$
	WHERE Injury IS NULL

		DELETE FROM Shark..GSAF$
		WHERE Injury IS NULL

-- CHECK Injury 

SELECT Injury
FROM Shark..GSAF$


-- TIME 

	SELECT Time,
	
		CASE
			WHEN Time IS NULL THEN 'NA' 
			ELSE Time END
	FROM Shark..GSAF$

		UPDATE Shark..GSAF$
		SET Time= CASE
					WHEN Time IS NULL THEN 'NA' 
					ELSE Time END

-- CHECK TIME

SELECT Time
FROM SHARK..GSAF$


--Spicies

	SELECT [Species ],
		CASE
		WHEN [Species ] is null THEN 'Unknown'
		ELSE [Species ] END
			
	FROM SHARK..GSAF$

		UPDATE Shark..GSAF$
		SET [Species ]= CASE
						WHEN [Species ] is null THEN 'Unknown'
						ELSE [Species ] END

-- CHECK
SELECT [Species ]
FROM Shark..GSAF$


-- DELETE COLUMNS F17. F18, F19 

	 ALTER TABLE Shark..GSAF$
	 DROP COLUMN [F17], [F18], [F19]


-- VIEW TABLE CLEANED
-- 

SELECT*
FROM Shark..GSAF$

 