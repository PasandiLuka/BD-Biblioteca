USE bd_biblioteca;
DELIMITER $$
DROP TRIGGER IF EXISTS aftInsCalificacion $$
CREATE TRIGGER aftInsCalificacion AFTER INSERT ON Calificacion
FOR EACH ROW
BEGIN
    UPDATE Libro
    SET calificacion = (SELECT AVG(calificacion)
                       FROM Calificacion
                       WHERE ISBN = NEW.ISBN)
    WHERE ISBN = NEW.ISBN;
END $$

-- Realizar un trigger befInsPrestamo donde el cliente haga un prestamo si es que no tiene mas de 3 sanciones.

DELIMITER $$
DROP TRIGGER IF EXISTS befInsPrestamo $$
CREATE TRIGGER befInsPrestamo BEFORE INSERT ON Prestamo
FOR EACH ROW
BEGIN
    IF(3 < (SELECT COUNT(*) 
       FROM Sancion 
       JOIN Prestamo USING (idPrestamo) 
       WHERE DNI = NEW.DNI))
    THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "No se puede hacer un prestamo debido a que el Cliente que lo solita posee mas de tres sanciones";

    ELSE IF(FALSE = (SELECT disponible
                     FROM Libro
                     WHERE ISBN = NEW.ISBN))
    THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "No se puede efectuar un prestamo sobre un libro que no se encuentra disponible (Libro.disponible = 0)";
    END IF;
END $$

-- No se puede hacer un prestamo si el libro no esta disponible:

DELIMITER $$
DROP TRIGGER IF EXISTS befInsPrestamo $$
CREATE TRIGGER befInsPrestamo BEFORE INSERT ON Prestamo
FOR EACH ROW
BEGIN
    IF (!(SELECT disponible
          FROM Libro
          WHERE ISBN = NEW.ISBN))
    THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "El libro que se quiere utilizar no se encuentra disponible";
    END IF;
END $$