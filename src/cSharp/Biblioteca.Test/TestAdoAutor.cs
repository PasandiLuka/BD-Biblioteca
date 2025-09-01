using System.Data;
using Biblioteca.Core.Persistencia;
using Biblioteca.Dapper;
using MySqlConnector;


namespace Biblioteca.Test;

public class TestAdoAutor
{
    //Esta es la conexion para la BD
    protected IDbConnection _conexion { get; private set; }

    //ESte es el repo que voy a testear
    private IRepoLibro _repoLibro;

    //En este constructor, configuro la cade ade config. e instancia los 2 de arriba
    public TestAdoAutor()
    {
        string cadenaConexion = @"Server=localhost;Database=bd_biblioteca;Uid=5to_agbd;Pwd=Trigg3rs!;";
        _conexion = new MySqlConnection(cadenaConexion);
        _repoLibro = new RepoLibro(_conexion);
    }

    //Cuando pones fact, es un metodo de test (se evalua)
    [Fact]
    public void CuandoHaceUnInsertEnAutor_DebeAlmacenarDichaFilaEnLaTablaAutor()
    {
        //Instancian un autor para probar
        var _autor = new Autor()
        {
            idAutor = 10,
            nombre = "vale_por_un_nombre",
            bibliografia = "vale_por_una_bibliografia",
            nacimiento = DateTime.Parse("1-01-01"),
            fallecimiento = null
        };

        //Se da de alta el autor mediante el repo
        _repoLibro.AltaAutor(_autor);

        //Se lo trae de la BD mediante el repo
        var detalleAutor = _repoLibro.DetalleAutor(10);

    //Es lo que se espera que se espera
        Assert.NotNull(detalleAutor);
        Assert.Equal<uint>(10, detalleAutor.idAutor);
        Assert.Equal("vale_por_un_nombre", detalleAutor.nombre);
        Assert.Equal("vale_por_una_bibliografia", detalleAutor.bibliografia);
        Assert.Equal(DateTime.Parse("1-01-01"), detalleAutor.nacimiento);
        Assert.Null(detalleAutor.fallecimiento);
    }

    [Fact]
    public void CuandoRealizoUnInsertEnAutorConUnaPkDuplicada_DebeDevolverLaExcepcion()
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
