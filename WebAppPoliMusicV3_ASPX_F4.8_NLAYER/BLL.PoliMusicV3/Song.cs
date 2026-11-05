using System;
using System.Data;

namespace BLL.PoliMusicV3
{
    /// <summary>
    /// Capa de L&oacute;gica de Negocio (BLL) para la gesti&oacute;n y orquestaci&oacute;n del repertorio de obras sonoras.
    /// Aplica validaciones de dominio y desacopla la capa de presentaci&oacute;n de la persistencia directa.
    /// </summary>
    public class Song
    {
        private readonly DAL.PoliMusicV3.Song _dalSong;

        public Song(string connectionString)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
            {
                throw new ArgumentNullException(nameof(connectionString), "La cadena de conexi&oacute;n no puede ser nula ni vac&iacute;a.");
            }

            _dalSong = new DAL.PoliMusicV3.Song(connectionString);
        }

        /// <summary>
        /// Consulta la totalidad de pistas musicales disponibles en la fonoteca.
        /// </summary>
        public DataTable Read()
        {
            return _dalSong.Read();
        }

        /// <summary>
        /// M&eacute;todo de negocio para lectura global del cat&aacute;logo de obras.
        /// </summary>
        public DataTable ReadAll()
        {
            return _dalSong.ReadAll();
        }

        /// <summary>
        /// Obtiene la ficha de una obra musical previa validaci&oacute;n de su identificador.
        /// </summary>
        public DataTable ReadById(int idSong)
        {
            if (idSong <= 0)
            {
                return new DataTable();
            }

            return _dalSong.ReadById(idSong);
        }

        /// <summary>
        /// Incrementa el contador de audiciones verificando la validez del identificador.
        /// </summary>
        public int IncreasePlays(int idSong)
        {
            if (idSong <= 0)
            {
                return 0;
            }

            return _dalSong.IncreasePlays(idSong);
        }

        /// <summary>
        /// Retorna la instancia de dominio tipada correspondiente al identificador solicitado.
        /// </summary>
        public EntityLayer.PoliMusicV3.Song GetById(int idSong)
        {
            if (idSong <= 0)
            {
                return null;
            }

            return _dalSong.GetById(idSong);
        }
    }
}
