USE UNIVERlab4
SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM ON AUDITORIUM_TYPE.AUDITORIUM_TYPENAME LIKE '%���������%'