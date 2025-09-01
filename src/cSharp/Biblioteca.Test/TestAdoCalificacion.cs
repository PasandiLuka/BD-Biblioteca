using System.Data;
using Biblioteca.Core.Persistencia;
using Biblioteca.Dapper;
using MySqlConnector;

namespace Biblioteca.Test
{
    public class TestAdoCalificacion
    {
        protected IDbConnection _conexion { get; private set; }

        private IRepoLibro _repoLibro;

        public TestAdoCalificacion()
        {
            string cadenaConexion = @"Server=localhost;Database=bd_biblioteca;Uid=5to_agbd;Pwd=Trigg3rs!;";
            _conexion = new MySqlConnection(cadenaConexion);
            _repoLibro = new RepoLibro(_conexion);
        }
        
        [Fact]
        public void CuandoHaceUnInsertEnCalificacion_DebeAlmacenarDichaFilaEnLaTablaCalifcacion()
        {
            
        }
    }
}