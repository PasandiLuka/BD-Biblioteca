DROP VIEW IF EXISTS promCalificacionLibrosxAutor;
CREATE VIEW promCalificacionLibrosxAutor AS
SELECT nombre, AVG(calificacion) AS 'PromedioCalificacion'
FROM Autor
JOIN Libro USING (idAutor)
GROUP BY nombre;