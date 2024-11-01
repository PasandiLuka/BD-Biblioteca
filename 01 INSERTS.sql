-- Active: 1730394017360@@127.0.0.1@3306@bd_biblioteca
INSERT INTO Genero(idGenero, genero)
    VALUES (1,"Terror"),
           (2,"Aventura"),
           (3,"Inforativo"),
           (4,"Interactivo")
    ;

INSERT INTO Bibliotecario(idBibliotecario, nombre, inicioHoraLaboral,finHoraLaboral)
    VALUES (1, "Federico", "9:30:00", "17:00:00"),
           (2, "Juan", "17:00:00", "20:00:00"),
           (3,"Rigoberto", "20:00:00", "23:30:00")
    ;

INSERT INTO Autor(idAutor, nombre, bibliografia, nacimiento, fallecimiento)
    VALUES (1, "Luis", "Una gran persona", "2000-10-05", NULL),
           (2, "", "Le sabe", "1990-05-27", NULL),
           (3, "Isaias", "Copado", "2005-02-24", NULL)
    ;

INSERT INTO Cliente (DNI, nombre, apellido)
    VALUES (12345678, "Luka", "Pasandi"),
           (87654321, "Diego", "Algañaras"),
           (23145678, "Angel", "Lopez"),
           (78235164, "Leonel", "Fernandez")
    ;

INSERT INTO Libro(ISBN, idAutor,idOtroAutor, idGenero, titulo, publicacion, calificacion)
    VALUES (1, 1, NULL, 3, "Introduccion SQL", "2023-07-12", 7),
           (2, 1,NULL, 3, "Introduccion MERMAID", "2021-07-17", 6),
           (3, 2, NULL, 3, "Teorema de Bool", "2000-07-25", 9),
           (4, 2, NULL, 3, "Compuertas Logicas", "2012-04-26", 5),
           (5, 1, 2, 3, "Las Leyes en la Institucion", "2016-02-28", 1)
    ;

INSERT INTO Sancion (idSancion, idBibliotecario, DNI, fechaEmision, multa)
    VALUES (1, 1, 87654321, "2023-11-14", 10000.00)
    ;

INSERT INTO Libro_Autor (ISBN, idAutor)
    SELECT ISBN, A.idAutor
    FROM Libro L
    INNER JOIN Autor A ON A.idAutor=L.idAutor
    ;

INSERT INTO Prestamo (idPrestamo, idBibliotecario, ISBN, DNI, fechaEntrega, fechaDevolucion)
    VALUES (1, 1, 1, 87654321, "2023-07-14", "2023-08-14"),
           (2, 1, 1, 87654321, "2023-08-14", "2023-09-14"),
           (3, 1, 1, 87654321, "2023-10-14", "2023-11-14"),
           (4, 3, 5, 12345678, "2024-11-01", "2024-12-01")
    ;