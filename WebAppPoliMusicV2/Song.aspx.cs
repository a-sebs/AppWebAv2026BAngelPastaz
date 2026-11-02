// Autor: angel.pastaz - Cédula: 1751179977
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebAppPoliMusicV2
{
    public partial class Song : System.Web.UI.Page
    {
        string strConnString = ConfigurationManager.ConnectionStrings["BDD_PoliMusicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // El usuario se guarda en sesión al hacer login (Login.aspx.cs)
            Entities.User user = Session[Util.Constants.USER] as Entities.User;
            if (user == null)
            {
                // La cookie de login sigue viva pero la sesión expiró: se vuelve a pedir login
                FormsAuthentication.SignOut();
                Response.Redirect("~/Login.aspx", true);
                return;
            }

            if (!Page.IsPostBack)
            {
                lblUserName.Text = Server.HtmlEncode(user.UserName);
                imgUserPhoto.ImageUrl = GetUserPhotoUrl(user.Photo);
                LoadSongs();
            }
        }

        private void LoadSongs()
        {
            try
            {
                DataTable dtSongs = new BLL.Song(strConnString).Read();
                gvSongs.DataSource = dtSongs;
                gvSongs.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Songs could not be loaded: " + Server.HtmlEncode(ex.Message);
            }
        }

        /// <summary>
        /// Convierte la ruta guardada en la BDD (ej. ~/songFiles/x.mp3) en una URL que entiende el navegador.
        /// </summary>
        protected string GetSongUrl(object songPath)
        {
            string path = Convert.ToString(songPath);
            if (path.StartsWith("~"))
            {
                path = ResolveUrl(path);
            }
            return HttpUtility.HtmlAttributeEncode(path);
        }

        /// <summary>
        /// Devuelve la foto del usuario, o la foto por defecto si no existe en el servidor.
        /// </summary>
        private string GetUserPhotoUrl(string photo)
        {
            string defaultPhoto = "~/UserImages/default.jpg";
            if (string.IsNullOrEmpty(photo))
            {
                return defaultPhoto;
            }
            try
            {
                return File.Exists(Server.MapPath(photo)) ? photo : defaultPhoto;
            }
            catch (Exception)
            {
                return defaultPhoto;
            }
        }
    }
}
