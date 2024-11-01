<h1 align= "center">BD_Biblioteca</h1>
<br>

## Integrantes

<pre>
    Algañaras Diego
    Fernandez Leonel
    Pasandi Luka
</pre>

## DER

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
    varchar(500) autoBiografia
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
    tinyIntUnsigned calificacion
}


Sancion{
    intUnsigned idSancion PK
    intUnsigned idBibliotecario FK
    intUnsigned DNI FK
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

Prestamo_Libro{
    intUnsigned idPrestamo PK, FK
    intUnsigned ISBN PK, FK
}

Genero||--o{Libro:""
Bibliotecario||--o{Sancion:""
Bibliotecario||--o{Prestamo:""
Libro||--o|Prestamo:""
Cliente||--o{Prestamo:""
Prestamo||--o|Sancion:""
Libro||--o{Prestamo_Libro:""
Prestamo||--o{Prestamo_Libro:""
Autor||--o{Libro:""


```

## Consultas

