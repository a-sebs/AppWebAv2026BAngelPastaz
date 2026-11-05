using System;
using System.Web.UI;

namespace WebAppPoliMusicV3
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                EntityLayer.PoliMusicV3.User user = Session[EntityLayer.PoliMusicV3.Util.Constants.USER] as EntityLayer.PoliMusicV3.User;
                string userName = "Angel.Pastaz";

                if (user != null && !string.IsNullOrEmpty(user.UserName))
                {
                    userName = user.UserName;
                }
                else if (User != null && User.Identity != null && !string.IsNullOrEmpty(User.Identity.Name))
                {
                    userName = User.Identity.Name;
                }

                lblUserName.Text = userName;
            }
        }
    }
}
