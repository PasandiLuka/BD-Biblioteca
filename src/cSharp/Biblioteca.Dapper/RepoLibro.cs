using System.Data;
using System.Data.Common;
using System.Runtime.CompilerServices;
using Biblioteca.Core.Persistencia;
using Dapper;

namespace Biblioteca.Dapper;

public class RepoLibro : Repo, IRepoLibro
{
    public RepoLibro(IDbConnection conexion) : base(conexion) { }

    #region Genero


    private static readonly string _queryGeneros
        = "SELECT idGenero, genero FROM Genero";
    public IEnumerable<Genero> GetGeneros() => _conexion.Query<Genero>(_queryGeneros);

    private static readonly string _queryAltaGenero
        = @"INSERT INTO Genero VALUES (@idGenero, @genero)";

    public void AltaGenero(Genero genero)
    {
        _conexion.Execute(
            _queryAltaGenero,
            new
            {
                idGenero = genero.idGenero,
                genero = genero.genero
            }
        );
    }


    private static readonly string _queryUnGeneroPorId
        = @"SELECT idGenero, genero FROM Genero WHERE idGenero = @idGenero LIMIT 1";
    public Genero? DetalleGenero(byte idGenero) => _conexion.QueryFirstOrDefault<Genero>(_queryUnGeneroPorId, new { idGenero = idGenero });

    #endregion


    #region Autor
    private static readonly string _queryAutores
        = "SELECT idAutor, nombre, bibliografia, nacimiento, fallecimiento FROM Autor";
    public IEnumerable<Autor> GetAutores() => _conexion.Query<Autor>(_queryAutores);

    private static readonly string _queryAltaAutor
        = @"INSERT INTO Autor VALUES (@idAutor, @nombre, @bibliografia, @nacimiento, @fallecimiento)";
    public void AltaAutor(Autor autor)
    {
        _conexion.Execute(_queryAltaAutor,
                          new
                          {
                              idAutor = autor.idAutor,
                              nombre = autor.nombre,
                              bibliografia = autor.bibliografia,
                              nacimiento = autor.nacimiento,
                              fallecimiento = autor.fallecimiento
                          });
    }
    private static readonly string _queryUnAutorPorId
        = @"SELECT idAutor, nombre, bibliografia, nacimiento, fallecimiento FROM Autor WHERE idAutor = @idAutor LIMIT 1";
    public Autor? DetalleAutor(uint idAutor) => _conexion.QueryFirstOrDefault<Autor>(_queryUnAutorPorId, new { idAutor = idAutor });
    #endregion


    #region Calificacion
    private static readonly string _queryCalificaciones
        = "SELECT * FROM  Calificacion";
    public IEnumerable<Calificacion> GetCalificaciones() => _conexion.Query<Calificacion>(_queryCalificaciones);
    private static readonly string _queryAltaCalificacion
        = @"INSERT INTO Autor VALUES (@idCalificacion, @ISBN, @DNI, @calificacion)";
    public void AltaCalificacion(Calificacion calificacion)
    {
        _conexion.Execute(_queryAltaCalificacion,
                          new
                          {
                              idCalificacion = calificacion.idCalificacion,
                              ISBN = calificacion.ISBN,
                              DNI = calificacion.DNI,
                              calificacion = calificacion.calificacion
                          });
    }
    private static readonly string _queryUnaCalificacionPorId
        = @"SELECT * FROM calificacion WHERE idCalificacion = @idCalificacion LIMIT 1";
    public Calificacion? DetalleCalificacion(uint idCalificacion) => _conexion.QueryFirstOrDefault<Calificacion>(_queryUnaCalificacionPorId, new { idCalificacion = idCalificacion });
    #endregion

    #region Libro
    private static readonly string _queryLibro
        = "SELECT * FROM Libro";
    public IEnumerable<Libro> GetLibros() => _conexion.Query<Libro>(_queryLibro);

    private static readonly string _queryAltaLibro
        = @"INSERT INTO Libro VALUES (@ISBN, @idAutor, @idOtroAutor, @idGenero, @titulo, @publicacion, @calificacion, @disponible)";

    public void AltaLibro(Libro libro)
    {
        _conexion.Execute(_queryAltaLibro,
                         new
                         {
                             ISBN = libro.ISBN,
                             idAutor = libro.idAutor,
                             idOtroAutor = libro.idOtroAutor,
                             idGenero = libro.idGenero,
                             titulo = libro.titulo,
                             publicacion = libro.publicacion,
                             calificacion = libro.calificacion,
                             disponible = libro.disponible
                         });
    }

    private static readonly string _queryUnLibroPorId
        = @"SELECT * FROM Libro WHERE ISBN = @ISBN LIMIT 1";
    public Libro? DetalleLibro(uint ISBN) => _conexion.QueryFirstOrDefault<Libro>(_queryUnLibroPorId, new{ISBN = ISBN});
    #endregion
}
