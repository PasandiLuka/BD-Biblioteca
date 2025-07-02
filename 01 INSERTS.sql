USE bd_biblioteca;

INSERT INTO Genero(idGenero, genero)
    VALUES (1, "Terror"),
           (2, "Aventura"),
           (3, "Informativo"),
           (4, "Romance"),
           (5, "Ciencia Ficcion"),
           (6, "Fantasia"),
           (7, "Humor")
    ;

INSERT INTO Bibliotecario(idBibliotecario, nombre, inicioHoraLaboral,finHoraLaboral)
    VALUES (1, "Federico", "9:30:00", "17:00:00"),
           (2, "Juan", "17:00:00", "20:00:00"),
           (3, "Rigoberto", "20:00:00", "23:30:00"),
           (4, "Sebando", "01:30:00", "03:00:00")
    ;

INSERT INTO Autor(idAutor, nombre, bibliografia, nacimiento, fallecimiento)
    VALUES (1, "Luis", "Una gran persona", "2000-10-05", NULL),
           (2, "Hernan", "Le sabe", "1990-05-27", NULL),
           (3, "Isaias", "Copado", "2003-02-24", NULL),
           (4, "Alina", "Mala gente y se trago una radio", "2008-02-14", NULL),
           (5, "Fabrizzio", "El jajas", "2007-06-15", NULL),
           (6, "Rodolfa", "Naci en San Petesburgo, y vole unos aviones que se estrellaron", "2007-01-05", NULL)
    ;

INSERT INTO Cliente (DNI, nombre, apellido)
    VALUES (12345678, "Luka", "Pasandi"),
           (87654321, "Diego", "Algañaras"),
           (23145678, "Angel", "Lopez"),
           (78235164, "Leonel", "Fernandez")
    ;

INSERT INTO Libro(ISBN, idAutor,idOtroAutor, idGenero, titulo, publicacion)
    VALUES (1, 1, NULL, 3, "Introduccion SQL", "2021-07-12"),
           (2, 1, NULL, 3, "Introduccion MERMAID", "2021-07-17"),
           (3, 1, NULL, 1, "Historias Salteñas", "2015-04-12"),
           (4, 2, NULL, 3, "Teorema de Bool", "2000-07-25"),
           (5, 2, NULL, 3, "Compuertas Logicas", "2012-04-26"),
           (6, 2, NULL, 3, "Hay una Ley...", "2016-02-28"),
           (7, 4, NULL, 2, "Secreto de la Montaña", "2014-07-28"),
           (8, 4, NULL, 4, "El Javi", "2023-06-25")

    ;

INSERT INTO Prestamo (idPrestamo, idBibliotecario, ISBN, DNI, fechaEntrega, fechaDevolucion)
    VALUES (1, 4, 4, 78235164, "2021-05-14", "2021-06-14"),
           (2, 2, 3, 23145678, "2021-05-14", "2021-06-14"),
           (3, 3, 8, 23145678, "2021-06-28", "2021-07-28"),
           (4, 4, 1, 78235164, "2021-07-25", "2021-08-25"),
           (5, 4, 2, 87654321, "2021-07-28", "2021-08-28"),
           (6, 4, 1, 78235164, "2022-02-11", "2022-03-11"),
           (7, 4, 8, 78235164, "2022-03-29", "2022-04-29"),
           (8, 3, 3, 87654321, "2022-08-08", "2022-09-08"),
           (9, 3, 5, 87654321, "2022-10-31", "2022-11-30"),
           (10, 2, 3, 78235164, "2023-01-21", "2023-02-21"),
           (11, 1, 7, 12345678,"2023-04-01", "2023-05-01"),
           (12, 1, 6, 23145678,"2023-04-17", "2023-05-17"),
           (13, 1, 1, 87654321, "2023-07-14", "2023-08-14"),
           (14, 1, 1, 87654321, "2023-08-14", "2023-09-14"),
           (15, 1, 1, 87654321, "2023-10-14", "2023-11-14"),
           (16, 3, 6, 12345678, "2024-11-01", "2024-12-01")
    ;

INSERT INTO Sancion (idSancion, idBibliotecario, idPrestamo, fechaEmision, multa)
    VALUES (1, 3, 2 , "2021-06-14", 5000.00),
           (2, 2, 5 , "2021-08-28", 7500.00),
           (3, 4, 8 , "2022-09-08", 5000.00),
           (4, 1, 16 ,"2024-12-01", 10000.00)
    ;

INSERT INTO Calificacion (idCalificacion, ISBN, DNI, calificacion)
    VALUES (1, 1, 78235164, 1),
           (2, 2, 12345678, 10),
           (3, 1, 87654321, 4.1),
           (4, 1, 78235164, 6),
           (5, 1, 87654321, 3),
           (6, 1, 12345678, 4),
           (7, 1, 87654321, 2.5),
           (8, 1, 12345678, 9.9),
           (9, 1, 87654321, 7.3);

INSERT INTO Prestamo_Libro (idPrestamo, ISBN)
    SELECT idPrestamo, L.ISBN
    FROM Prestamo P
    INNER JOIN Libro L ON L.ISBN=P.ISBN