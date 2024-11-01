-- Active: 1730050857382@@127.0.0.1@3306@bd_biblioteca
DROP DATABASE IF EXISTS bd_biblioteca;
CREATE DATABASE bd_biblioteca;
USE bd_biblioteca;

CREATE TABLE Genero(
    idGenero TINYINT UNSIGNED,
    genero VARCHAR(45),
    CONSTRAINT PK_Genero PRIMARY KEY (idGenero)
);

CREATE TABLE Bibliotecario(
    idBibliotecario INT UNSIGNED,
    inicioHoraLaboral DATETIME,
    finHoraLaboral DATETIME,
    CONSTRAINT PK_Genero PRIMARY KEY (idBibliotecario)
);

CREATE TABLE Autor(
    idAutor INT UNSIGNED,
    bibliografia VARCHAR(500),
    nacimiento DATETIME,
    fallecimiento DATETIME,
    CONSTRAINT PK_Genero PRIMARY KEY (idAutor)
);

CREATE TABLE Libro(
    ISBN INT UNSIGNED,
    idAutor INT UNSIGNED,
    idGenero TINYINT UNSIGNED,
    titulo VARCHAR(45),
    publicacion DATE,
    calificacion TINYINT UNSIGNED,
    CONSTRAINT PK_Libro PRIMARY KEY (ISBN),
    CONSTRAINT FK_Libro_Autor FOREIGN KEY (idAutor)
        REFERENCES Autor (idAutor),
    CONSTRAINT FK_Libro_Genero FOREIGN KEY (idGenero)
        REFERENCES Genero (idGenero)
);

CREATE TABLE Prestamo(
    idPrestamo INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    ISBN INT UNSIGNED,
    fechaEntrega DATE,
    fechaDevolucion DATE,
    CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo),
    CONSTRAINT FK_Prestamo_Bibliotecario FOREIGN KEY (idBibliotecario)
        REFERENCES Bibliotecario (idBibliotecario),
    CONSTRAINT FK_Prestamo_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN)
);

CREATE TABLE Cliente(
    DNI INT UNSIGNED,
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    CONSTRAINT PK_Cliente PRIMARY KEY (DNI)
);

CREATE TABLE Sancion(
    idSancion INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    DNI INT UNSIGNED,
    fechaEmision DATE, 
    multa DECIMAL(10,2),
    CONSTRAINT PK_Genero PRIMARY KEY (idSancion),
    CONSTRAINT FK_Sancion_Cliente FOREIGN KEY (idBibliotecario) 
        REFERENCES Bibliotecario (idBibliotecario)
);

CREATE TABLE Prestamo(
    idPrestamo INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    ISBN INT UNSIGNED,
    fechaEntrega DATE,
    fechaDevolucion DATE,
    CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo),
    CONSTRAINT FK_Prestamo_Bibliotecario FOREIGN KEY (idBibliotecario)
        REFERENCES Bibliotecario (idBibliotecario),
    CONSTRAINT FK_Prestamo_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN)
);


CREATE TABLE Libro-Autor(
    ISBN INT UNSIGNED,
    idAutor INT UNSIGNED,
    CONSTRAINT PK_Libro-Autor PRIMARY KEY (ISBN),
    CONSTRAINT PK_Libro-Autor PRIMARY KEY (idAutor),
    CONSTRAINT FK_Libro-Autor_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN),
    CONSTRAINT FK_Libro-Autor_Autor FOREIGN KEY (idAutor)
        REFERENCES Autor (idAutor)
);