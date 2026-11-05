using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppPoliMusicV3
{
    public partial class Song : System.Web.UI.Page
    {
        private const string SELECTED_SONG_KEY = "SelectedSongId";

        private string strConnString = ConfigurationManager.ConnectionStrings["BDD_PoliMusicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            EntityLayer.PoliMusicV3.User user = GetCurrentUser();
            if (user == null)
            {
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            ShowUserInfo(user);

            if (!Page.IsPostBack)
            {
                LoadSongCatalog();
            }

            RestorePlayer();
        }

        /// <summary>
        /// Obtiene el usuario autenticado desde la sesion existente o desde FormsAuthentication.
        /// </summary>
        private EntityLayer.PoliMusicV3.User GetCurrentUser()
        {
            EntityLayer.PoliMusicV3.User user = Session[EntityLayer.PoliMusicV3.Util.Constants.USER] as EntityLayer.PoliMusicV3.User;
            if (user != null)
            {
                return user;
            }

            if (User != null && User.Identity != null && User.Identity.IsAuthenticated)
            {
                user = new EntityLayer.PoliMusicV3.User();
                user.UserName = User.Identity.Name;
                user.UserType = EntityLayer.PoliMusicV3.Util.Constants.ID_USER_NORMAL;
                return user;
            }

            return null;
        }

        /// <summary>
        /// Muestra el nombre y la foto del usuario autenticado de forma robusta,
        /// comprobando la existencia fisica del archivo para evitar iconos rotos.
        /// </summary>
        private void ShowUserInfo(EntityLayer.PoliMusicV3.User user)
        {
            lblUserName.Text = !string.IsNullOrEmpty(user.UserName) ? user.UserName : "Angel.Pastaz";

            bool photoExists = false;
            if (!string.IsNullOrEmpty(user.Photo))
            {
                try
                {
                    string physicalPath = Server.MapPath(user.Photo);
                    photoExists = System.IO.File.Exists(physicalPath);
                }
                catch
                {
                    photoExists = false;
                }
            }

            if (photoExists)
            {
                imgUser.ImageUrl = ResolveUrl(user.Photo);
                imgUser.Visible = true;
                lblAvatarFallback.Visible = false;
            }
            else
            {
                imgUser.Visible = false;
                lblAvatarFallback.Visible = true;
                lblAvatarFallback.Text = !string.IsNullOrEmpty(user.UserName) ? user.UserName.Substring(0, 1).ToUpper() : "A";
            }
        }

        /// <summary>
        /// Consulta el catalogo de canciones mediante BLL y enlaza los resultados al GridView.
        /// </summary>
        private void LoadSongCatalog()
        {
            try
            {
                BLL.PoliMusicV3.Song bllSong = new BLL.PoliMusicV3.Song(strConnString);
                DataTable dtSongs = bllSong.ReadAll();

                gvSongs.DataSource = dtSongs;
                gvSongs.DataBind();

                int totalCount = dtSongs != null ? dtSongs.Rows.Count : 0;
                lblTotalSongs.Text = totalCount.ToString();
            }
            catch (Exception ex)
            {
                ShowMessage("Error al cargar el cat&aacute;logo de canciones: " + ex.Message, true);
            }
        }

        /// <summary>
        /// Manejador de comandos de fila del GridView para la accion de reproducir.
        /// </summary>
        protected void gvSongs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PlaySong")
            {
                int idSong;
                if (int.TryParse(Convert.ToString(e.CommandArgument), out idSong))
                {
                    PlaySong(idSong);
                }
            }
        }

        /// <summary>
        /// Resalta visualmente en el GridView la cancion seleccionada y actualiza el estado del boton.
        /// Utiliza iconos SVG limpios sin caracteres unicode propensos a mojibake.
        /// </summary>
        protected void gvSongs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                if (drv != null && ViewState[SELECTED_SONG_KEY] != null)
                {
                    int currentId = Convert.ToInt32(drv["ID_SONG"]);
                    int selectedId = Convert.ToInt32(ViewState[SELECTED_SONG_KEY]);

                    if (currentId == selectedId)
                    {
                        e.Row.CssClass = (e.Row.CssClass + " selected-song-row").Trim();
                        LinkButton lnkPlay = e.Row.FindControl("lnkPlay") as LinkButton;
                        if (lnkPlay != null)
                        {
                            lnkPlay.CssClass = (lnkPlay.CssClass + " active-playing").Trim();
                            lnkPlay.Text = "<span class=\"playing-wave-icon\"><span class=\"w-bar\"></span><span class=\"w-bar\"></span><span class=\"w-bar\"></span></span> Sonando";
                            lnkPlay.ToolTip = "Canci&oacute;n en reproducci&oacute;n";
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Incrementa el contador de reproducciones, actualiza el reproductor HTML5 y emite el script de reproduccion.
        /// </summary>
        private void PlaySong(int idSong)
        {
            try
            {
                BLL.PoliMusicV3.Song bllSong = new BLL.PoliMusicV3.Song(strConnString);
                DataTable dtSong = bllSong.ReadById(idSong);

                if (dtSong == null || dtSong.Rows.Count == 0)
                {
                    ShowMessage("La canci&oacute;n seleccionada ya no existe en el cat&aacute;logo.", true);
                    LoadSongCatalog();
                    return;
                }

                string songPath = dtSong.Rows[0]["SONG_PATH"] != DBNull.Value ? dtSong.Rows[0]["SONG_PATH"].ToString() : string.Empty;
                if (string.IsNullOrEmpty(songPath))
                {
                    ShowMessage("La canci&oacute;n seleccionada no cuenta con una ruta de archivo de audio v&aacute;lida.", true);
                    return;
                }

                // Incrementar contador de reproducciones en SQL Server
                bllSong.IncreasePlays(idSong);

                // Guardar la cancion seleccionada en ViewState para persistencia entre postbacks
                ViewState[SELECTED_SONG_KEY] = idSong;

                // Re-enlazar el GridView para mostrar el contador actualizado y el resaltado visual
                LoadSongCatalog();

                // Actualizar informacion del reproductor
                string songName = dtSong.Rows[0]["SONG_NAME"] != DBNull.Value ? dtSong.Rows[0]["SONG_NAME"].ToString() : "Sin t&iacute;tulo";
                int plays = dtSong.Rows[0]["PLAYS"] != DBNull.Value ? Convert.ToInt32(dtSong.Rows[0]["PLAYS"]) + 1 : 1;

                audioPlayer.Src = ResolveUrl(songPath);
                lblNowPlaying.Text = songName;
                lblNowPlayingPlays.Text = string.Format("{0:N0} reproducciones", plays);

                // Limpiar alertas previas
                pnlAlert.Visible = false;

                // Iniciar reproduccion automatica en el navegador
                ScriptManager.RegisterStartupScript(this, GetType(), "playTrackAudio", "playTrackAudio();", true);
            }
            catch (Exception ex)
            {
                ShowMessage("No fue posible reproducir la canci&oacute;n: " + ex.Message, true);
            }
        }

        /// <summary>
        /// Restaura el estado del reproductor HTML5 durante postbacks a partir del ViewState.
        /// </summary>
        private void RestorePlayer()
        {
            if (ViewState[SELECTED_SONG_KEY] == null)
            {
                return;
            }

            int idSong = Convert.ToInt32(ViewState[SELECTED_SONG_KEY]);
            BLL.PoliMusicV3.Song bllSong = new BLL.PoliMusicV3.Song(strConnString);
            DataTable dtSong = bllSong.ReadById(idSong);

            if (dtSong != null && dtSong.Rows.Count > 0)
            {
                string songPath = dtSong.Rows[0]["SONG_PATH"] != DBNull.Value ? dtSong.Rows[0]["SONG_PATH"].ToString() : string.Empty;
                if (!string.IsNullOrEmpty(songPath))
                {
                    audioPlayer.Src = ResolveUrl(songPath);
                    lblNowPlaying.Text = dtSong.Rows[0]["SONG_NAME"] != DBNull.Value ? dtSong.Rows[0]["SONG_NAME"].ToString() : "Sin t&iacute;tulo";
                    int plays = dtSong.Rows[0]["PLAYS"] != DBNull.Value ? Convert.ToInt32(dtSong.Rows[0]["PLAYS"]) : 0;
                    lblNowPlayingPlays.Text = string.Format("{0:N0} reproducciones", plays);
                }
            }
            else
            {
                ViewState[SELECTED_SONG_KEY] = null;
            }
        }

        /// <summary>
        /// Muestra mensajes de error o advertencia en la interfaz con formato seguro.
        /// </summary>
        private void ShowMessage(string message, bool isError)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = isError ? "alert alert-danger alert-dismissible fade show pm-alert" : "alert alert-info alert-dismissible fade show pm-alert";
            lblAlertMessage.Text = message;
        }
    }
}
