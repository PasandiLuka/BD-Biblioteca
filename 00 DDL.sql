DROP DATABASE IF EXISTS bd_biblioteca;
CREATE DATABASE bd_biblioteca;
USE bd_biblioteca;

CREATE TABLE Genero(
    idGenero TINYINT UNSIGNED,
    genero VARCHAR(45) NOT NULL,
    CONSTRAINT PK_Genero PRIMARY KEY (idGenero)
);

CREATE TABLE Bibliotecario(
    idBibliotecario INT UNSIGNED,
    nombre VARCHAR(45) NOT NULL,
    inicioHoraLaboral TIME NOT NULL,
    finHoraLaboral TIME NOT NULL,
    CONSTRAINT PK_Genero PRIMARY KEY (idBibliotecario)
);

CREATE TABLE Autor(
    idAutor INT UNSIGNED,
    nombre VARCHAR(45) NOT NULL,
    bibliografia VARCHAR(500) NOT NULL,
    nacimiento DATE NOT NULL,
    fallecimiento DATE,
    CONSTRAINT PK_Genero PRIMARY KEY (idAutor)
);

CREATE TABLE Cliente(
    DNI INT UNSIGNED,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (DNI)
);

CREATE TABLE Libro(
    ISBN INT UNSIGNED,
    idAutor INT UNSIGNED,
    idGenero TINYINT UNSIGNED,
    titulo VARCHAR(45) NOT NULL,
    publicacion DATE NOT NULL,
    calificacion TINYINT UNSIGNED NOT NULL,
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
    fechaEntrega DATE NOT NULL,
    fechaDevolucion DATE NOT NULL,
    CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo),
    CONSTRAINT FK_Prestamo_Bibliotecario FOREIGN KEY (idBibliotecario)
        REFERENCES Bibliotecario (idBibliotecario),
    CONSTRAINT FK_Prestamo_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN)
);

CREATE TABLE Sancion(
    idSancion INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    DNI INT UNSIGNED,
    fechaEmision DATE NOT NULL, 
    multa DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Genero PRIMARY KEY (idSancion),
    CONSTRAINT FK_Sancion_Cliente FOREIGN KEY (idBibliotecario) 
        REFERENCES Bibliotecario (idBibliotecario)
);

CREATE TABLE Libro_Autor(
    ISBN INT UNSIGNED,
    idAutor INT UNSIGNED,
    PRIMARY KEY(ISBN,idAutor),
    CONSTRAINT FK_Libro_Autor_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN),
    CONSTRAINT FK_Libro_Autor_Autor FOREIGN KEY (idAutor)
        REFERENCES Autor (idAutor)
);