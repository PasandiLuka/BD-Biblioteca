using System.Data;
using Biblioteca.Core.Persistencia;
using Biblioteca.Dapper;
using MySqlConnector;

namespace Biblioteca.Test
{
    public class TestAdoLibro
    {   
        protected IDbConnection _conexion { get; private set; }
        private IRepoLibro _repoLibro;
        public TestAdoLibro()
        {
            string cadenaConexion = @"Server=localhost;Database=bd_biblioteca; Uid=5to_agbd;Pwd=Trigg3rs!;";
            _conexion = new MySqlConnection(cadenaConexion);
            _repoLibro = new RepoLibro(_conexion);
        }

        [Fact]
        public void CuandoHacesUnInsertEnLibro_DebeAlmacenarDichaFilaEnLaTablaLibro()
        {
            var _libro = new Libro()
            {
                ISBN = 1,
                idAutor = 1,
                idOtroAutor = 1,
                idGenero = 1,
                titulo = "vale_por_un_titulo",
                publicacion = DateTime.Parse("1-01-01"),
                calificacion = 1,
                disponible = false
            };

            _repoLibro.AltaLibro(_libro);

            var detalleLibro = _repoLibro.DetalleLibro(1);

            Assert.NotNull(detalleLibro);
            Assert.Equal<uint>(1, detalleLibro.ISBN);
            Assert.Equal<uint>(1, detalleLibro.idAutor);
            Assert.Equal<uint?>(1, detalleLibro.idOtroAutor);
            //Falta
        }
    }
}