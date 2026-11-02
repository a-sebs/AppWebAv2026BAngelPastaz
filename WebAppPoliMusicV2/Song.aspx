<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Song.aspx.cs" Inherits="WebAppPoliMusicV2.Song" %>
<%-- Autor: angel.pastaz - Cédula: 1751179977 --%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>PoliMusic - Canciones</title>
    <style type="text/css">
        body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: #f2f4f8; color: #1f2933; }
        .topbar { display: flex; align-items: center; gap: 14px; padding: 14px 28px; background: #12263f; color: #ffffff; }
        .brand { margin-right: auto; font-size: 22px; font-weight: bold; letter-spacing: 1px; }
        .brand span { color: #4fd1c5; }
        .avatar { width: 44px; height: 44px; border-radius: 50%; object-fit: cover; border: 2px solid #4fd1c5; background: #ffffff; }
        .logout { color: #ffffff; text-decoration: none; border: 1px solid #4fd1c5; padding: 6px 14px; border-radius: 16px; }
        .logout:hover { background: #4fd1c5; color: #12263f; }
        .content { max-width: 1000px; margin: 28px auto; padding: 0 16px; }
        h2 { margin: 0 0 14px 0; }
        .songs { width: 100%; border-collapse: collapse; background: #ffffff; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); }
        .songs th { background: #1f3a5f; color: #ffffff; text-align: left; padding: 10px 12px; }
        .songs td { padding: 8px 12px; border-bottom: 1px solid #e4e7eb; vertical-align: middle; }
        .songs tr:nth-child(even) td { background: #f8fafc; }
        .songs .path { color: #6b7280; font-size: 12px; }
        .songs audio { width: 260px; }
        .message { color: #c0392b; font-weight: bold; }
        .footer { max-width: 1000px; margin: 0 auto 28px auto; padding: 12px 16px 0 16px; border-top: 1px solid #e4e7eb; color: #6b7280; font-size: 13px; text-align: center; }
    </style>
</head>
<body>
    <form id="formSong" runat="server">
        <div class="topbar">
            <div class="brand">Poli<span>Music</span></div>
            <asp:Image ID="imgUserPhoto" runat="server" CssClass="avatar" AlternateText="Foto de usuario" />
            <div>Welcome <strong><asp:Label ID="lblUserName" runat="server" /></strong></div>
            <a class="logout" href="Logout.aspx">Logout</a>
        </div>

        <div class="content">
            <h2>Song list:</h2>
            <asp:GridView ID="gvSongs" runat="server" AutoGenerateColumns="False" CssClass="songs"
                GridLines="None" EmptyDataText="No hay canciones registradas.">
                <Columns>
                    <asp:BoundField DataField="ID_SONG" HeaderText="ID Canci&oacute;n" />
                    <asp:BoundField DataField="SONG_NAME" HeaderText="Nombre" />
                    <asp:BoundField DataField="SONG_PATH" HeaderText="Ruta" ItemStyle-CssClass="path" />
                    <asp:BoundField DataField="PLAYS" HeaderText="Reproducciones" />
                    <asp:TemplateField HeaderText="Reproducir">
                        <ItemTemplate>
                            <audio controls="controls" preload="metadata" src='<%# GetSongUrl(Eval("SONG_PATH")) %>'>
                                Tu navegador no soporta audio HTML5.
                            </audio>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>

        <div class="footer">
            Desarrollado por <strong>angel.pastaz</strong> &middot; C&eacute;dula: <strong>1751179977</strong>
        </div>
    </form>

    <script type="text/javascript">
        // Al reproducir una canción se pausan las demás
        document.addEventListener('play', function (e) {
            var players = document.getElementsByTagName('audio');
            for (var i = 0; i < players.length; i++) {
                if (players[i] !== e.target) {
                    players[i].pause();
                }
            }
        }, true);
    </script>
</body>
</html>
