DELIMITER $$
DROP VIEW IF EXISTS vistaPromedioCalificacionLibrosxAutor $$
CREATE VIEW vistaPromedioCalificacionLibrosxAutor AS
    SELECT nombre, AVG(calificacion) AS 'Calificacion promedio'
    FROM Autor
    JOIN Libro USING (idAutor)
    GROUP BY nombre;
DELIMITER $$
DROP VIEW IF EXISTS vistaLibrosNoDisponibles $$
CREATE VIEW vistaLibrosNoDisponibles AS
    SELECT ISBN, Titulo, A.nombre 'Autor', G.genero, disponible
    FROM Libro
    JOIN autor A using (idAutor)
    JOIN genero G using (idGenero)
    WHERE disponible = FALSE;
DELIMITER $$
DROP VIEW IF EXISTS vistaCantidadPrestamos $$
CREATE VIEW vistaCantidadPrestamos AS
    SELECT C.DNI, C.nombre, C.apellido, COUNT(P.idPrestamo) 'CantidadPrestamos'
    FROM Cliente C
    JOIN Prestamo P using (DNI)
    GROUP BY C.DNI, C.nombre, C.apellido
    ORDER BY CantidadPrestamos DESC;
DROP VIEW IF EXISTS vistaGeneral;
CREATE VIEW vistaGeneral AS
    SELECT P.idPrestamo, CL.nombre 'Cliente', GROUP_CONCAT(DISTINCT L.titulo SEPARATOR ', ') 'Libros', B.nombre 'Bibliotecario', P.fechaEntrega, P.fechaDevolucion, P.devuelto, GROUP_CONCAT(DISTINCT CA.calificacion SEPARATOR ', ') 'Calificaciones', GROUP_CONCAT(S.multa) 'Multa', GROUP_CONCAT(S.fechaEmision) 'FechaDeEmision'
    FROM Prestamo P
    JOIN Cliente CL using (DNI)
    JOIN Libro L ON P.ISBN = L.ISBN
    JOIN Bibliotecario B using (idBibliotecario)
    LEFT JOIN Calificacion CA ON CA.ISBN = L.ISBN AND CA.DNI = P.DNI
    LEFT JOIN Sancion S ON S.idPrestamo = P.idPrestamo
    GROUP BY idPrestamo;