using System;
using System.Data;
using System.Data.SqlClient;

namespace DAL.PoliMusicV3
{
    /// <summary>
    /// Capa de Acceso a Datos (DAL) para el cat&aacute;logo de pistas musicales en TBL_SONG.
    /// Utiliza consultas ADO.NET optimizadas mediante DataReader y par&aacute;metros fuertemente tipados.
    /// </summary>
    public class Song
    {
        private readonly string _connectionString;

        public Song(string connectionString)
        {
            _connectionString = connectionString;
        }

        /// <summary>
        /// Obtiene todas las pistas sonoras ordenadas por su identificador ascendente.
        /// </summary>
        public DataTable Read()
        {
            const string sql = "SELECT ID_SONG, SONG_NAME, SONG_PATH, PLAYS FROM TBL_SONG ORDER BY ID_SONG ASC";
            DataTable dtResult = new DataTable("SongsCatalog");

            using (SqlConnection dbConnection = new SqlConnection(_connectionString))
            using (SqlCommand dbCommand = new SqlCommand(sql, dbConnection))
            {
                dbCommand.CommandType = CommandType.Text;
                dbConnection.Open();

                using (SqlDataReader dataReader = dbCommand.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    dtResult.Load(dataReader);
                }
            }

            return dtResult;
        }

        /// <summary>
        /// Delegador sem&aacute;ntico para lectura completa del cat&aacute;logo.
        /// </summary>
        public DataTable ReadAll()
        {
            return Read();
        }

        /// <summary>
        /// Realiza la b&uacute;squeda de una obra por su ID mediante consulta SQL parametrizada.
        /// </summary>
        public DataTable ReadById(int idSong)
        {
            const string sql = "SELECT ID_SONG, SONG_NAME, SONG_PATH, PLAYS FROM TBL_SONG WHERE ID_SONG = @SongId";
            DataTable dtResult = new DataTable("SongRecord");

            using (SqlConnection dbConnection = new SqlConnection(_connectionString))
            using (SqlCommand dbCommand = new SqlCommand(sql, dbConnection))
            {
                dbCommand.CommandType = CommandType.Text;
                dbCommand.Parameters.Add(new SqlParameter("@SongId", SqlDbType.Int) { Value = idSong });

                dbConnection.Open();
                using (SqlDataReader dataReader = dbCommand.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    dtResult.Load(dataReader);
                }
            }

            return dtResult;
        }

        /// <summary>
        /// Incrementa de forma at&oacute;mica el contador de audiciones en SQL Server.
        /// </summary>
        public int IncreasePlays(int idSong)
        {
            const string sql = "UPDATE TBL_SONG SET PLAYS = COALESCE(PLAYS, 0) + 1 WHERE ID_SONG = @SongId";

            using (SqlConnection dbConnection = new SqlConnection(_connectionString))
            using (SqlCommand dbCommand = new SqlCommand(sql, dbConnection))
            {
                dbCommand.CommandType = CommandType.Text;
                dbCommand.Parameters.Add(new SqlParameter("@SongId", SqlDbType.Int) { Value = idSong });

                dbConnection.Open();
                return dbCommand.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Obtiene y mapea directamente una entidad de dominio a partir del identificador de la obra.
        /// </summary>
        public EntityLayer.PoliMusicV3.Song GetById(int idSong)
        {
            DataTable dt = ReadById(idSong);
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                return new EntityLayer.PoliMusicV3.Song(
                    Convert.ToInt32(row["ID_SONG"]),
                    row["SONG_NAME"] != DBNull.Value ? row["SONG_NAME"].ToString() : string.Empty,
                    row["SONG_PATH"] != DBNull.Value ? row["SONG_PATH"].ToString() : string.Empty,
                    row["PLAYS"] != DBNull.Value ? Convert.ToInt32(row["PLAYS"]) : 0
                );
            }

            return null;
        }
    }
}
