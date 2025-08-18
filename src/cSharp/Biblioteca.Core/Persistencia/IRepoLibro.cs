namespace Biblioteca.Core.Persistencia;

public interface IRepoLibro
{
    IEnumerable<Genero> GetGeneros();
    void AltaGenero(Genero genero);
    Genero? DetalleGenero(byte idGenero);

    IEnumerable<Autor> GetAutores();
    void AltaAutor(Autor autor);
    Autor? DetalleAutor(uint idAutor);
}