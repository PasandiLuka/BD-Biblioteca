DELIMITER $$
DROP FUNCTION IF EXISTS sumaMultas $$
CREATE FUNCTION SumaMultas (unDNI INT UNSIGNED, minFecha DATE, maxFecha DATE)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
   DECLARE sumaMultas DECIMAL(10,2);
   SELECT SUM(multa) INTO sumaMultas
   FROM Prestamo
   JOIN Sancion USING (idPrestamo)
   WHERE unDNI = DNI
   AND fechaEmision BETWEEN minFecha AND maxFecha;
   RETURN sumaMultas;
END $$

DELIMITER $$
DROP FUNCTION IF EXISTS LibrosAutor $$
CREATE FUNCTION LibrosAutor (unIdAutor INT UNSIGNED)
RETURNS INT
READS SQL DATA
BEGIN
   DECLARE LibrosAutor INT;
   SELECT COUNT(*) INTO LibrosAutor
   FROM Libro
   WHERE idAutor = unIdAutor;
   RETURN LibrosAutor;
END $$

DELIMITER $$
DROP FUNCTION IF EXISTS DiasRestantes $$
CREATE FUNCTION DiasRestantes (unIdPrestamo INT UNSIGNED)
RETURNS INT
READS SQL DATA
BEGIN
   DECLARE DiasRestantes INT;
   SELECT DATEDIFF(fechaDevolucion, fechaEntrega) INTO DiasRestantes
   FROM Prestamo
   WHERE idPrestamo = unIdPrestamo;
   RETURN DiasRestantes;
END $$

DELIMITER $$
DROP FUNCTION IF EXISTS CantPrestamos $$
CREATE FUNCTION CantPrestamos (unISBN INT UNSIGNED)
RETURNS INT
READS SQL DATA
BEGIN
   DECLARE CantPrestamos INT;
   SELECT COUNT(*) INTO CantPrestamos
   FROM Prestamo
   WHERE ISBN = unISBN;
   RETURN CantPrestamos;
END $$