# ***BD_BIBLIOTECA***
# *By CiverAbentureros*

## Integrantes

- Algañaras Diego
- Lopez Angel
- Pasandi Luka

# DER

<div align="center">

```mermaid
erDiagram
Genero{
    tinyIntUnsigned idGenero PK
    varchar(45) genero
}


Bibliotecario{
    intUnsigned idBibliotecario PK
    varchar(45) nombre
    Time inicioHorarioLaboral
    Time finHorarioLaboral
}


Autor{
    intUnsigned idAutor PK
    varchar(45) nombre
    varchar(500) bibliografia
    Date nacimiento
    Date fallecimiento
}

Cliente{
    intUnsigned DNI PK
    varchar(45) nombre
    varchar(45) apellido
}

Libro{
    intUnsigned ISBN PK
    intUnsigned idAutor FK
    intUnsigned idOtroAutor FK
    tinyIntUnsigned idGenero FK
    varchar(45) Titulo
    Date Publicacion
    Decimal(10-2) calificacion
}


Sancion{
    intUnsigned idSancion PK
    intUnsigned idBibliotecario FK
    intUnsigned idPrestamo FK
    Date fechaEmision
    Decimal(10-2) multa    
}

Prestamo{
    intUnsigned idPrestamo PK
    intUnsigned idBibliotecario FK
    intUnsigned ISBN FK
    intUnsigned DNI FK
    Date fechaEntrega
    Date fechaDevolucion
}

Calificacion{
    intUnsigned idCalificacion PK
    intUnsigned ISBN FK
    intUnsigned DNI FK
    tinyIntUnsigned calificacion
}

Prestamo_Libro{
    intUnsigned idPrestamo PK, FK
    intUnsigned ISBN PK, FK
}

Genero||--o{Libro:""
Bibliotecario||--o{Sancion:""
Bibliotecario||--o{Prestamo:""
Cliente||--o{Prestamo:""
Prestamo||--o|Sancion:""
Libro||--o{Prestamo_Libro:""
Prestamo||--o{Prestamo_Libro:""
Autor||--o{Libro:""
Calificacion ||--o{ Libro:""
Calificacion ||--o{ Cliente:""
```
</div>

# Consultas

- ### Obtener el número total de libros por género, incluyendo géneros sin libros, la cantidad de libros renombrarla como "TotalLibros", ordenar por cantidad de libros de mayor a menor.

```sql
SELECT genero, COUNT(ISBN) AS TotalLibros
FROM Genero G
LEFT JOIN Libro L ON G.idGenero = L.idGenero
GROUP BY genero
ORDER BY COUNT(ISBN) DESC;
```

- ### Mostrar los géneros que tienen más de un libro.

```sql
SELECT genero, COUNT(L.ISBN) AS TotalLibros
FROM Genero G
INNER JOIN Libro L ON G.idGenero = L.idGenero
GROUP BY genero
HAVING TotalLibros > 1;
```

- ### Mostrar el nombre de los bibliotecarios y su cantidad de prestamos, solo si han emitido mas de 4, ordenar de mayor a menor por cantidad de prestamos.

```sql
SELECT nombre, COUNT(idPrestamo) AS TotalPrestamos
FROM Bibliotecario B
INNER JOIN Prestamo P ON B.idBibliotecario = P.idBibliotecario
GROUP BY nombre
HAVING TotalPrestamos > 4
ORDER BY COUNT(idPrestamo);
```

-  ### Obtener el nombre y la fecha de nacimiento de aquellos autores que hayan emitido 2 o mas libros, ordenar de menor a mayor por año de nacimiento. 

```sql
SELECT nombre, nacimiento
FROM Autor A
INNER JOIN Libro L ON L.idAutor = A.idAutor
GROUP BY nombre, nacimiento
HAVING COUNT(*) > 2
ORDER BY nacimiento ASC;
```

- ### Mostrar el nombre del bibliotecario, la cantidad de sanciones que emitio y el destinatario de las sanciones, solo si la multa supera los 5000, ordenar por el nombre de los bibliotecarios de menor a mayor.

```sql
SELECT B.nombre, COUNT(*) AS TotalSanciones, C.nombre
FROM Bibliotecario B###
INNER JOIN Sancion S ON B.idBibliotecario = S.idBibliotecario
INNER JOIN Prestamo P ON P.idPrestamo = S.idPrestamo
INNER JOIN Cliente C ON C.DNI = P.DNI 
WHERE multa > 5000
GROUP BY B.nombre, C.nombre
ORDER BY B.nombre;
```

# Funciones

- ### Realizar una función que reciba como parametros, un DNI y dos fechas, con el fin de que muestre la suma total de todas las multas correspondientes a un cliente entre dichas fechas:

```sql
DELIMITER $$
DROP FUNCTION IF EXISTS sumaMultas $$
CREATE FUNCTION SumaMultas (unDNI INT UNSIGNED, minFecha DATE, maxFecha DATE)
RETURNS DECIMAL
READS SQL DATA
BEGIN
    DECLARE sumaMultas DECIMAL;
    SELECT SUM(multa) INTO sumaMultas
    FROM Prestamo
    JOIN Sancion USING (idPrestamo)
    WHERE unDNI = DNI
    AND fechaEmision BETWEEN minFecha AND maxFecha;
    RETURN sumaMultas;
END $$
```

- ### Crear una función que reciba como parametro un idAutor y que muestre la cantidad de libros que posee el mismo:

```sql
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
```

- ### Crear una funcion que reciba como parametro un idPrestamo, con el fin de calcular la cantidad de días restantes antes del vencimiento del mismo:

```sql
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
```

- ### Crear una función que reciba como parametro un ISBN (PK de libro) y que en base a eso me muestre la cantidad total de veces que fue alquilado:

```sql
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
```