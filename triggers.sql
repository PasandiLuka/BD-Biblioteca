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