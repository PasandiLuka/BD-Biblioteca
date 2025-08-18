using System.Data;
using Biblioteca.Core.Persistencia;
using Biblioteca.Dapper;
using MySqlConnector;


namespace Biblioteca.Test;

public class TestAdoGenero
{
    protected IDbConnection _conexion { get; private set; }
    private IRepoLibro _repoLibro;
    public TestAdoGenero()
    {
        string cadenaConexion = @"Server=localhost;Database=bd_biblioteca;Uid=5to_agbd;Pwd=Trigg3rs!;";
        _conexion = new MySqlConnection(cadenaConexion);
        _repoLibro = new RepoLibro(_conexion);
    }

    [Fact]
    public void CuandoHaceUnInsertEnGenero_DebeAlmacenarDichaFilaEnLaTablaGenero()
    {
        var _genero = new Genero()
        {
            idGenero = 10,
            genero = "Policial"
        };
        _repoLibro.AltaGenero(_genero);
        var genero = _repoLibro.DetalleGenero(10);

        Assert.NotNull(genero);
        Assert.Equal("Policial", genero.genero);
        Assert.Equal(10, genero.idGenero);
    }

    [Theory]
    [InlineData(1, "Romance")]
    [InlineData(2, "Dramatico")]
    [InlineData(3, "Policial")]
    public void CuandoRealizoUnInsertEnGeneroConUnaPkDuplicada_DebeDevolverLaExcepcion(byte idGenero, string genero)
    {
        var _genero = new Genero()
        {
            idGenero = idGenero,
            genero = genero
        };
        Assert.Throws<MySqlException>(() => _repoLibro.AltaGenero(_genero));
    }
}