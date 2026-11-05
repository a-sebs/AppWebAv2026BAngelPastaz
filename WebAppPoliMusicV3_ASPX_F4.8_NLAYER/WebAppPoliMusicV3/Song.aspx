<%@ Page Title="Cat&aacute;logo de Obras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Song.aspx.cs" Inherits="WebAppPoliMusicV3.Song" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Tipografias: Space Grotesk y JetBrains Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&family=Space+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style type="text/css">
        :root {
            --amber-primary: #f59e0b;
            --amber-glow: #fbbf24;
            --amber-light: #fef3c7;
            --amber-dark: #b45309;
            --amber-halo: rgba(245, 158, 11, 0.35);
            --amber-subtle: rgba(245, 158, 11, 0.08);
            --carbon-base: #070a10;
            --carbon-panel: #0d121c;
            --carbon-surface: #141b2a;
            --carbon-border: rgba(245, 158, 11, 0.22);
            --carbon-border-light: rgba(255, 255, 255, 0.08);
            --text-heading: #ffffff;
            --text-body: #94a3b8;
            --text-muted: #64748b;
        }

        html, body {
            background-color: var(--carbon-base) !important;
            color: var(--text-heading) !important;
            font-family: 'Space Grotesk', -apple-system, sans-serif !important;
        }

        .navbar-dark.bg-dark {
            background: #090c13 !important;
            border-bottom: 2px solid var(--amber-dark) !important;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.85);
        }

        .body-content {
            max-width: 1300px;
            margin: 0 auto;
            padding: 24px 16px 130px; /* Margen inferior para dar espacio al dock de audio fijo */
        }

        footer {
            border-top: 1px solid var(--carbon-border-light) !important;
            color: var(--text-muted) !important;
            padding-top: 24px;
            margin-top: 50px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.82rem;
        }

        hr { display: none !important; }

        /* Estructura Principal: Rack de Estudio en Cascada */
        .studio-workstation-layout {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        /* Alerta de Mensaje */
        .pm-alert-banner {
            border-radius: 10px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.88rem;
            padding: 14px 20px;
            border-left: 5px solid var(--amber-primary);
        }

        /* 1. Barra de Control Superior Unificada (Top Ribbon) */
        .studio-control-ribbon {
            background: linear-gradient(135deg, #111724 0%, #0a0d14 100%);
            border: 1px solid var(--carbon-border);
            border-radius: 14px;
            padding: 16px 26px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .operator-identity-unit {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .operator-avatar-img {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--amber-primary);
            box-shadow: 0 0 12px var(--amber-halo);
        }

        .operator-avatar-fallback {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--amber-primary), var(--amber-dark));
            color: #070a10;
            font-weight: 800;
            font-size: 18px;
            box-shadow: 0 0 12px var(--amber-halo);
        }

        .operator-meta-group {
            display: flex;
            flex-direction: column;
        }

        .operator-tag-badge {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.7rem;
            color: var(--amber-glow);
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .operator-name-display {
            font-size: 1.15rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            line-height: 1.2;
        }

        .ribbon-center-brand {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.8rem;
            color: var(--text-body);
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--carbon-border-light);
            padding: 6px 18px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .ribbon-counter-badge {
            background: rgba(245, 158, 11, 0.12);
            border: 1px solid var(--amber-primary);
            color: var(--amber-glow);
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.85rem;
            font-weight: 700;
            padding: 6px 18px;
            border-radius: 20px;
            box-shadow: 0 0 12px rgba(245, 158, 11, 0.2);
        }

        /* 2. Mesa Principal de Pistas de Ancho Completo (100% Full-Width Rack) */
        .studio-playlist-card {
            background: var(--carbon-panel);
            border: 1px solid var(--carbon-border);
            border-radius: 16px;
            padding: 26px 30px;
            box-shadow: 0 16px 42px rgba(0, 0, 0, 0.55);
        }

        .playlist-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            padding-bottom: 14px;
            border-bottom: 1px solid var(--carbon-border-light);
        }

        .playlist-card-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .playlist-card-title span {
            color: var(--amber-primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .playlist-card-meta {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.74rem;
            color: var(--text-muted);
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .table-responsive-container {
            overflow-x: auto;
        }

        .grid-studio-rack {
            width: 100%;
            border-collapse: collapse;
        }

        .grid-studio-rack th {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.72rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--amber-glow);
            padding: 12px 18px;
            background: #090d15;
            border-top: 1px solid var(--carbon-border-light);
            border-bottom: 2px solid var(--amber-primary);
            font-weight: 700;
        }

        .grid-studio-rack tbody tr {
            background-color: transparent;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.16s ease;
        }

        .grid-studio-rack tbody tr:hover {
            background-color: rgba(245, 158, 11, 0.05);
        }

        .grid-studio-rack td {
            padding: 16px 18px;
            vertical-align: middle;
            color: var(--text-heading);
        }

        /* Fila Activa en Emision */
        .grid-studio-rack tbody tr.selected-song-row {
            background: linear-gradient(90deg, rgba(245, 158, 11, 0.22) 0%, rgba(180, 83, 9, 0.08) 100%) !important;
            border-left: 5px solid var(--amber-primary) !important;
            box-shadow: inset 0 0 16px rgba(245, 158, 11, 0.15) !important;
        }

        .track-index-num {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--text-muted);
        }

        .selected-song-row .track-index-num {
            color: var(--amber-glow);
        }

        .track-item-name {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.2px;
        }

        .selected-song-row .track-item-name {
            color: var(--amber-light);
            text-shadow: 0 0 10px rgba(245, 158, 11, 0.5);
        }

        .track-item-submeta {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.72rem;
            color: var(--text-muted);
            margin-top: 2px;
        }

        .meter-audition-badge {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-body);
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.82rem;
            padding: 6px 16px;
            border-radius: 6px;
            display: inline-block;
        }

        .selected-song-row .meter-audition-badge {
            background: rgba(245, 158, 11, 0.16);
            border-color: var(--amber-primary);
            color: var(--amber-glow);
            font-weight: 700;
        }

        .btn-trigger-action {
            background: var(--amber-primary);
            color: #070a10 !important;
            font-weight: 800;
            font-size: 0.8rem;
            padding: 8px 18px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.16s ease;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.35);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-trigger-action:hover {
            background: #ffffff;
            color: #070a10 !important;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(255, 255, 255, 0.4);
        }

        .btn-trigger-action.active-playing {
            background: #ffffff;
            color: #070a10 !important;
            box-shadow: 0 0 16px rgba(255, 255, 255, 0.7);
        }

        /* Ondas animadas de reproduccion */
        .sound-wave-bars, .playing-wave-icon {
            display: inline-flex;
            align-items: flex-end;
            gap: 2px;
            height: 12px;
            margin-right: 4px;
        }

        .sw-bar, .w-bar {
            width: 2.5px;
            background: #070a10;
            border-radius: 1px;
            animation: bounceWave 0.8s ease-in-out infinite alternate;
        }

        .sw-bar:nth-child(2), .w-bar:nth-child(2) { animation-delay: 0.2s; height: 10px; }
        .sw-bar:nth-child(3), .w-bar:nth-child(3) { animation-delay: 0.4s; height: 7px; }

        @keyframes bounceWave {
            0% { height: 3px; }
            100% { height: 12px; }
        }

        /* 3. Dock Inferior de Transporte de Audio Fijo (Bottom Master Dock) */
        .studio-transport-dock {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(13, 18, 28, 0.98);
            backdrop-filter: blur(20px);
            border-top: 3px solid var(--amber-primary);
            padding: 14px 30px;
            box-shadow: 0 -10px 40px rgba(0, 0, 0, 0.85);
            display: grid;
            grid-template-columns: 280px 1fr 240px;
            align-items: center;
            gap: 24px;
        }

        .dock-track-details {
            display: flex;
            flex-direction: column;
            gap: 2px;
            overflow: hidden;
        }

        .dock-tag-status {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.68rem;
            color: var(--amber-glow);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            font-weight: 700;
        }

        .dock-active-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ffffff;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .dock-active-plays {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.74rem;
            color: var(--text-muted);
        }

        .dock-audio-center {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .dock-audio-control {
            width: 100%;
            height: 40px;
            outline: none;
            filter: drop-shadow(0 4px 10px rgba(0, 0, 0, 0.5));
        }

        .dock-specs-end {
            text-align: right;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.74rem;
            color: var(--text-muted);
            line-height: 1.5;
        }

        @media (max-width: 992px) {
            .studio-transport-dock {
                grid-template-columns: 1fr;
                gap: 12px;
                position: static;
                margin-top: 20px;
            }
            .body-content { padding-bottom: 40px; }
            .dock-specs-end { text-align: left; }
        }
    </style>

    <script type="text/javascript">
        function playTrackAudio() {
            var audio = document.getElementById('<%= audioPlayer.ClientID %>');
            if (audio && (audio.src || audio.getAttribute('src'))) {
                audio.load();
                var promise = audio.play();
                if (promise !== undefined) {
                    promise.catch(function (error) {
                        console.log("Autoplay controlado por directivas del navegador: " + error);
                    });
                }
            }
        }
    </script>

    <div class="studio-workstation-layout">
        <!-- Panel de Alertas del Sistema -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-dismissible fade show pm-alert-banner" role="alert">
            <asp:Label ID="lblAlertMessage" runat="server"></asp:Label>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Cerrar"></button>
        </asp:Panel>

        <!-- 1. Barra de Control Superior Unificada (Top Ribbon) -->
        <header class="studio-control-ribbon">
            <div class="operator-identity-unit">
                <asp:Image ID="imgUser" runat="server" CssClass="operator-avatar-img" Visible="false" AlternateText="Avatar" />
                <asp:Label ID="lblAvatarFallback" runat="server" CssClass="operator-avatar-fallback"></asp:Label>
                <div class="operator-meta-group">
                    <span class="operator-tag-badge">OPERADOR AUTORIZADO</span>
                    <h2 class="operator-name-display">
                        <asp:Label ID="lblUserName" runat="server">Angel.Pastaz</asp:Label>
                    </h2>
                </div>
            </div>

            <div class="ribbon-center-brand">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="var(--amber-primary)">
                    <circle cx="12" cy="12" r="10"/>
                </svg>
                <span>FONOTECA INSTITUCIONAL // TABLA TBL_SONG</span>
            </div>

            <div class="ribbon-counter-badge">
                <asp:Label ID="lblTotalSongs" runat="server" Text="0"></asp:Label> Obras Indexadas
            </div>
        </header>

        <!-- 2. Mesa Principal de Pistas (100% Width Full-Width Studio Rack) -->
        <section class="studio-playlist-card">
            <div class="playlist-card-header">
                <div>
                    <h1 class="playlist-card-title">
                        <span>//</span> Cat&aacute;logo Maestro de Obras Sonoras
                    </h1>
                </div>
                <div class="playlist-card-meta">
                    Base de Datos: SQL Server &bull; Acceso: BLL/DAL N-Tier
                </div>
            </div>

            <div class="table-responsive-container">
                <asp:GridView ID="gvSongs" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="ID_SONG"
                    CssClass="grid-studio-rack"
                    GridLines="None"
                    OnRowCommand="gvSongs_RowCommand"
                    OnRowDataBound="gvSongs_RowDataBound">
                    <Columns>
                        <%-- Columna #: Indice --%>
                        <asp:TemplateField HeaderText="#" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" HeaderStyle-Width="60px">
                            <ItemTemplate>
                                <span class="track-index-num"><%# Eval("ID_SONG", "{0:D2}") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Columna Obra y Especificacion --%>
                        <asp:TemplateField HeaderText="OBRA FONOGR&Aacute;FICA / ARCHIVO">
                            <ItemTemplate>
                                <div>
                                    <div class="track-item-name"><%# Eval("SONG_NAME") %></div>
                                    <div class="track-item-submeta">MPEG Audio Layer 3 &bull; 320 kbps &bull; Est&eacute;reo &bull; Master Original</div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Columna Metrica de Audicion --%>
                        <asp:TemplateField HeaderText="M&Eacute;TRICA DE AUDICI&Oacute;N" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" HeaderStyle-Width="210px">
                            <ItemTemplate>
                                <span class="meter-audition-badge">
                                    <%# Eval("PLAYS") %> reproducciones
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Columna Disparador de Reproduccion --%>
                        <asp:TemplateField HeaderText="COMANDO DE EMISI&Oacute;N" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" HeaderStyle-Width="170px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkPlay" runat="server"
                                    CommandName="PlaySong"
                                    CommandArgument='<%# Eval("ID_SONG") %>'
                                    CssClass="btn-trigger-action"
                                    ToolTip="Ejecutar audici&oacute;n">
                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
                                        <polygon points="5 3 19 12 5 21 5 3"></polygon>
                                    </svg>
                                    <span>Escuchar</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-4 text-center text-muted" style="font-family: 'JetBrains Mono', monospace;">
                            No existen registros sonoros indexados en la base de datos SQL Server.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </section>

        <!-- 3. Dock Inferior de Transporte de Audio (Fixed Master Transport Bar) -->
        <div class="studio-transport-dock">
            <!-- Pista Activa -->
            <div class="dock-track-details">
                <div class="dock-tag-status">EMISI&Oacute;N EN TIEMPO REAL</div>
                <div class="dock-active-title">
                    <asp:Label ID="lblNowPlaying" runat="server" Text="Ninguna obra seleccionada"></asp:Label>
                </div>
                <div class="dock-active-plays">
                    <asp:Label ID="lblNowPlayingPlays" runat="server" Text="Selecciona una pista del cat&aacute;logo para escuchar"></asp:Label>
                </div>
            </div>

            <!-- Reproductor Nativo HTML5 -->
            <div class="dock-audio-center">
                <audio id="audioPlayer" runat="server" controls="controls" preload="metadata" class="dock-audio-control"></audio>
            </div>

            <!-- Ficha Tecnica de Transmision -->
            <div class="dock-specs-end">
                <div>Salida: <strong>HTML5 Audio API</strong></div>
                <div>Transmisi&oacute;n: <strong>320 kbps / 44.1 kHz</strong></div>
                <div style="color: var(--amber-glow);">Canal: Master Stereo</div>
            </div>
        </div>
    </div>
</asp:Content>