USE UNIVERlab4
--zad1
SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
FROM AUDITORIUM, AUDITORIUM_TYPE 
WHERE AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
--zad2
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
FROM AUDITORIUM_TYPE, AUDITORIUM
WHERE AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%���������%'