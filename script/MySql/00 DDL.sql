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
    CONSTRAINT PK_Genero PRIMARY KEY (idAutor),
    CONSTRAINT CHK_Autor CHECK (fallecimiento IS NULL OR fallecimiento > nacimiento)
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
    idOtroAutor INT UNSIGNED,
    idGenero TINYINT UNSIGNED,
    titulo VARCHAR(45) NOT NULL,
    publicacion DATE NOT NULL,
    calificacion DECIMAL(10,2) NOT NULL DEFAULT 0,
    disponible BOOLEAN DEFAULT 1,
    CONSTRAINT PK_Libro PRIMARY KEY (ISBN),
    CONSTRAINT FK_Libro_Autor FOREIGN KEY (idAutor)
        REFERENCES Autor (idAutor),
    CONSTRAINT FK_Libro_OtroAutor FOREIGN KEY (idOtroAutor)
        REFERENCES Autor (idAutor),
    CONSTRAINT FK_Libro_Genero FOREIGN KEY (idGenero)
        REFERENCES Genero (idGenero)
);

CREATE TABLE Prestamo(
    idPrestamo INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    ISBN INT UNSIGNED,
    DNI INT UNSIGNED,
    fechaEntrega DATE NOT NULL,
    fechaDevolucion DATE NOT NULL,
    devuelto BOOLEAN DEFAULT 0,
    CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo),
    CONSTRAINT FK_Prestamo_Bibliotecario FOREIGN KEY (idBibliotecario)
        REFERENCES Bibliotecario (idBibliotecario),
    CONSTRAINT FK_Prestamo_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN),
    CONSTRAINT FK_Prestamo_Cliente FOREIGN KEY (DNI)
        REFERENCES Cliente (DNI)
);

CREATE TABLE Sancion(
    idSancion INT UNSIGNED,
    idBibliotecario INT UNSIGNED,
    idPrestamo INT UNSIGNED,
    fechaEmision DATE NOT NULL, 
    multa DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Genero PRIMARY KEY (idSancion),
    CONSTRAINT FK_Sancion_Bibliotecario FOREIGN KEY (idBibliotecario) 
        REFERENCES Bibliotecario (idBibliotecario),
    CONSTRAINT FK_Sancion_Prestamo FOREIGN KEY (idPrestamo)
        REFERENCES Prestamo (idPrestamo)
);

CREATE TABLE Calificacion(
    idCalificacion INT UNSIGNED,
    ISBN INT UNSIGNED,
    DNI INT UNSIGNED,
    calificacion TINYINT UNSIGNED,
    CONSTRAINT PK_Calificacion PRIMARY KEY (idCalificacion),
    CONSTRAINT FK_Calificacion_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN),
    CONSTRAINT FK_Calificacion_Cliente FOREIGN KEY (DNI)
        REFERENCES Cliente (DNI),
    CONSTRAINT CHK_Calificacion CHECK (calificacion BETWEEN 0 AND 10)
);

CREATE TABLE Prestamo_Libro(
    idPrestamo INT UNSIGNED,
    ISBN INT UNSIGNED,
    PRIMARY KEY (idPrestamo, ISBN),
    CONSTRAINT FK_Prestamo_Libro_Prestamo FOREIGN KEY (idPrestamo)
        REFERENCES Prestamo (idPrestamo),
    CONSTRAINT FK_Prestamo_Libro_Libro FOREIGN KEY (ISBN)
        REFERENCES Libro (ISBN)
);