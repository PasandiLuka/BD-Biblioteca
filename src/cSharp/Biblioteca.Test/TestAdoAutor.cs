using System.Data;
using Biblioteca.Core.Persistencia;
using Biblioteca.Dapper;
using MySqlConnector;


namespace Biblioteca.Test;

public class TestAdoAutor
{
    protected IDbConnection _conexion { get; private set; }
    private IRepoLibro _repoLibro;
    public TestAdoAutor()
    {
        string cadenaConexion = @"Server=localhost;Database=bd_biblioteca;Uid=*****;Pwd=*****;";
        _conexion = new MySqlConnection(cadenaConexion);
        _repoLibro = new RepoLibro(_conexion);
    }

    [Fact]
    public void CuandoHaceUnInsertEnAutor_DebeAlmacenarDichaFilaEnLaTablaAutor()
    {
        var _autor = new Autor()
        {
            idAutor = 10,
            nombre = "vale_por_un_nombre",
            bibliografia = "vale_por_una_bibliografia",
            nacimiento = DateTime.Parse("1-01-01"),
            fallecimiento = null
        };
        _repoLibro.AltaAutor(_autor);
        var detalleAutor = _repoLibro.DetalleAutor(10);
        
        Assert.NotNull(detalleAutor);
        Assert.Equal<uint>(10, detalleAutor.idAutor);
        Assert.Equal("vale_por_un_nombre", detalleAutor.nombre);
        Assert.Equal("vale_por_una_bibliografia", detalleAutor.bibliografia);
        Assert.Equal(DateTime.Parse("1-01-01"), detalleAutor.nacimiento);
        Assert.Null(detalleAutor.fallecimiento);
    }

    [Fact]
    public void CuandoRealizoUnInsertEnGeneroConUnaPkDuplicada_DebeDevolverLaExcepcion()
    {
        var _autor = new Autor()
        {
            idAutor = 1,
            nombre = "vale_por_un_nombre",
            bibliografia = "vale_por_una_bibliografia",
            nacimiento = DateTime.Parse("1-01-01"),
            fallecimiento = null
        };
        Assert.Throws<MySqlException>(() => _repoLibro.AltaAutor(_autor));
    }
}
