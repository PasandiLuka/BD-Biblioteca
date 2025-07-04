-- Crear los SP necesarios para dar de alta en todas las tablas:

DELIMITER $$
DROP PROCEDURE IF EXISTS altaBibliotecario $$
CREATE PROCEDURE altaBibliotecario (unIdBibliotecario INT, unNombre VARCHAR(45), unInicioHoraLaboral TIME, unFinHoraLaboral TIME)
BEGIN
   INSERT INTO Bibliotecario (idBibliotecario, nombre, inicioHoraLaboral, finHoraLaboral)
       VALUES (unIdBibliotecario, unNombre, unInicioHoraLaboral, unFinHoraLaboral);
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS altaGenero $$
CREATE PROCEDURE altaGenero (unIdGenero TINYINT UNSIGNED, unGenero VARCHAR(45))
BEGIN
   INSERT INTO Genero (idGenero, genero)
       VALUES (unIdGenero, unGenero);
END $$




DELIMITER $$
DROP PROCEDURE IF EXISTS altaAutor $$
CREATE PROCEDURE altaAutor (unIdAutor INT UNSIGNED, unNombre VARCHAR(45), unaBibliografia VARCHAR(500), unNacimiento DATE, unFallecimiento DATE)
BEGIN
   INSERT INTO Autor (idAutor, nombre, bibliografia, nacimiento, fallecimiento)
       VALUES( unIdAutor, unNombre, unaBibliografia, unNacimiento, unFallecimiento);
END $$




DELIMITER $$
DROP PROCEDURE IF EXISTS altaCliente $$
CREATE PROCEDURE altaCliente (unDNI INT UNSIGNED, unNombre VARCHAR(45), unApellido VARCHAR(45))
BEGIN
   INSERT INTO Cliente (DNI, nombre, apellido)
       VALUES (unDNI, unNombre, unApellido);
END $$


/* DELIMITER $$
DROP PROCEDURE IF EXISTS altaLibro $$
CREATE PROCEDURE altaLibro (unISBN INT, unIdAutor INT, unIdOtroAutor INT, unIdGenero TINYINT UNSIGNED, unTitulo VARCHAR(45), unaPublicacion DATE, unaCalificacion Decimal(10-2), taDisponible BOOL)
BEGIN
    INSERT INTO Libro (ISBN, idAutor, idOtroAutor, idGenero, Titulo, Publicacion, calificacion, disponible)
        VALUES(unISBN, unIdAutor, unIdOtroAutor, unIdGenero, unTitulo, unaPublicacion, unaCalificacion, taDisponible);
END $$ */


DELIMITER $$
DROP PROCEDURE IF EXISTS altaPrestamo $$
CREATE PROCEDURE altaPrestamo (unIdPrestamo INT, unIdBibliotecario INT, unISBN INT, unDNI INT, unaFechaEntrega DATE, unaFechaDevolucion DATE)
BEGIN
    INSERT INTO Prestamo (idPrestamo, idBibliotecario, ISBN, DNI, FechaEntrega, FechaDevolucion)
    VALUES(unIdPrestamo, unIdBibliotecario, unISBN, unDNI, unaFechaEntrega, unaFechaDevolucion);
END $$


DELIMITER $$
DROP PROCEDURE IF EXISTS altaSancion $$
CREATE PROCEDURE altaSancion (unIdSancion INT UNSIGNED, unIdBibliotecario INT UNSIGNED, idPrestamo INT UNSIGNED,  unaFechaEmision DATE, unaMulta DECIMAL(10,2))
BEGIN
    INSERT INTO Sancion (idSancion, idBibliotecario, idPrestamo, fechaEmision, Multa)
    VALUES(unIdSancion, unIdBibliotecario, idPrestamo,  unaFechaEmision, unaMulta);
END $$


DELIMITER $$
DROP PROCEDURE IF EXISTS altaCalificacion $$
CREATE PROCEDURE altaCalificacion (unIdCalificacion INT UNSIGNED, unISBN INT UNSIGNED, unDNI INT UNSIGNED, unaCalificacion TINYINT UNSIGNED)
BEGIN
    INSERT INTO Calificacion (idCalificacion, ISBN, DNI, calificacion)
    VALUES(unIdCalificacion, unISBN, unDNI, unaCalificacion);
END $$




-- Hacer un procedimiento para ver cuantos prestamos se hicieron en tal mes.


DELIMITER $$
DROP PROCEDURE IF EXISTS prestamosEn $$
CREATE PROCEDURE prestamosEn(unMes INT, unAnio INT)
BEGIN
    SELECT P.idPrestamo, L.Titulo, CL.nombre, CL.apellido, BI.nombre 'Bibliotecario', P.fechaEntrega, P.fechaDevolucion
    FROM Prestamo P
    JOIN Libro L using (ISBN)
    JOIN Cliente CL using (DNI)
    JOIN Bibliotecario BI using (idBibliotecario)
    WHERE MONTH(Prestamo.fechaEntrega) = unMes
    AND YEAR(Prestamo.fechaEntrega) = unAnio
    ORDER BY Prestamo.fechaEntrega ASC;
END $$


-- Eliminar un libro si no está en un prestamo activo.


DELIMITER $$
CREATE PROCEDURE bajaLibroSiNoPrestado (unISBN INT)
BEGIN
    DECLARE libroEnPrestamo INT;

    SELECT COUNT(*) INTO libroEnPrestamo
    FROM Prestamo
    JOIN Prestamo_Libro using (idPrestamo)
    WHERE Prestamo_Libro.ISBN = unISBN
    AND NOT Prestamo.devuelto;

    IF libroEnPrestamo > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el libro; está activo en uno o mas prestamos.';
    ELSE
        DELETE FROM calificacion
        WHERE ISBN = unISBN;

        DELETE sancion
        FROM sancion
        JOIN prestamo using (idPrestamo)
        JOIN prestamo_libro PL using (idPrestamo)
        WHERE `Prestamo_Libro`.`ISBN` = unISBN;

        DELETE FROM Prestamo_Libro
        WHERE ISBN = unISBN;

        UPDATE Libro
        SET disponible = FALSE  
        WHERE ISBN = unISBN;

    END IF;
END $$