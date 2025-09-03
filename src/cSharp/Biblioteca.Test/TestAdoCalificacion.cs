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
            var _calificacion = new Calificacion()
            {
                idCalificacion = 1,
                ISBN = 1,
                DNI = 1,
                calificacion = 1

            };

            _repoLibro.AltaCalificacion(_calificacion);

            var detalleCalificacion = _repoLibro.DetalleCalificacion(1);

            Assert.NotNull(detalleCalificacion);
            Assert.Equal<uint>(1, detalleCalificacion.idCalificacion);
            Assert.Equal<uint>(1, detalleCalificacion.ISBN);
            Assert.Equal<uint>(1, detalleCalificacion.DNI);
            Assert.Equal(1, detalleCalificacion.calificacion);
        }

        [Fact]
        public void CuandoRealizoUnInsertEnCalificacionConUnaPkDuplicada_DebeDevolverLaExcepcion()
        {
           var _calificacion = new Calificacion()
            {
                idCalificacion = 1,
                calificacion = 1,
                ISBN = 1,
                DNI = 1
                
            };
        Assert.Throws<MySqlException>(() => _repoLibro.AltaCalificacion(_calificacion));
        }
    }
}