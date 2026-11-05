using System;

namespace EntityLayer.PoliMusicV3
{
    /// <summary>
    /// Modelo de entidad representativo del registro fonogr&aacute;fico almacenado en TBL_SONG.
    /// </summary>
    [Serializable]
    public class Song
    {
        public int ID { get; set; }
        public string SongName { get; set; }
        public string SongPath { get; set; }
        public int Plays { get; set; }

        public Song()
        {
            SongName = string.Empty;
            SongPath = string.Empty;
            Plays = 0;
        }

        public Song(int idSong, string title, string relativePath, int auditionCount)
        {
            this.ID = idSong;
            this.SongName = title;
            this.SongPath = relativePath;
            this.Plays = auditionCount;
        }

        public override string ToString()
        {
            return string.Format("{0:D2} - {1} ({2} audiciones)", ID, SongName, Plays);
        }
    }
}
