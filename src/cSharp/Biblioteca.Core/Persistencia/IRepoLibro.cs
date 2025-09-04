namespace Biblioteca.Core.Persistencia;

public interface IRepoLibro
{
    IEnumerable<Genero> GetGeneros();
    void AltaGenero(Genero genero);
    Genero? DetalleGenero(byte idGenero);

    IEnumerable<Autor> GetAutores();
    void AltaAutor(Autor autor);
    Autor? DetalleAutor(uint idAutor);

    IEnumerable<Calificacion> GetCalificaciones();
    void AltaCalificacion(Calificacion calificacion);
    Calificacion? DetalleCalificacion(uint idCalificacion);

    IEnumerable<Libro> GetLibros();
    void AltaLibro(Libro libro);
    Libro? DetalleLibro(uint ISBN);
}