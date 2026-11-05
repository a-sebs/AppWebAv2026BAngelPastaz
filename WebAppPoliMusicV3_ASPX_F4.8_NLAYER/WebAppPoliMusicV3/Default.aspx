<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebAppPoliMusicV3._Default" ResponseEncoding="utf-8" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
            padding: 24px 16px 60px;
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

        /* Contenedor Principal: Centro de Comando Sonoro */
        .portal-command-center {
            display: flex;
            flex-direction: column;
            gap: 26px;
        }

        /* 1. Header de Estado Superior */
        .cmd-top-header {
            background: linear-gradient(135deg, #111724 0%, #0a0d14 100%);
            border: 1px solid var(--carbon-border);
            border-left: 5px solid var(--amber-primary);
            border-radius: 14px;
            padding: 22px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .cmd-header-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .cmd-title-tag {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.72rem;
            color: var(--amber-glow);
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 700;
        }

        .cmd-main-title {
            font-size: 1.85rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            line-height: 1.2;
            letter-spacing: -0.5px;
        }

        .cmd-main-title span {
            color: var(--amber-primary);
        }

        .cmd-status-strip {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .status-pill-item {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.75rem;
            padding: 6px 14px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--carbon-border-light);
            color: var(--text-body);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-pill-item.active {
            border-color: var(--amber-primary);
            color: var(--amber-glow);
            background: rgba(245, 158, 11, 0.1);
        }

        .live-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #22c55e;
            box-shadow: 0 0 8px #22c55e;
            display: inline-block;
        }

        /* 2. Banner de Accion Rapida y Sesion Activa */
        .cmd-hero-action-deck {
            background: var(--carbon-panel);
            border: 1px solid var(--carbon-border);
            border-radius: 18px;
            padding: 34px 38px;
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: center;
            gap: 30px;
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.6);
            position: relative;
            overflow: hidden;
        }

        .cmd-hero-action-deck::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 320px;
            height: 100%;
            background: radial-gradient(circle at 100% 50%, rgba(245, 158, 11, 0.12), transparent 70%);
            pointer-events: none;
        }

        .hero-deck-content {
            max-width: 720px;
        }

        .operator-identity-row {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 14px;
        }

        .operator-avatar-square {
            width: 46px;
            height: 46px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--amber-primary), var(--amber-dark));
            color: #070a10;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 19px;
            box-shadow: 0 0 14px var(--amber-halo);
        }

        .operator-details-group {
            display: flex;
            flex-direction: column;
        }

        .operator-label-meta {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.72rem;
            color: var(--amber-primary);
            text-transform: uppercase;
            font-weight: 600;
        }

        .operator-fullname {
            font-size: 1.2rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
        }

        .hero-deck-description {
            color: var(--text-body);
            font-size: 0.98rem;
            line-height: 1.6;
            margin-bottom: 0;
        }

        .btn-launch-transport {
            background: linear-gradient(135deg, var(--amber-glow) 0%, var(--amber-primary) 100%);
            color: #070a10 !important;
            font-weight: 800;
            font-size: 0.95rem;
            padding: 16px 32px;
            border-radius: 12px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 8px 24px rgba(245, 158, 11, 0.4);
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .btn-launch-transport:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(245, 158, 11, 0.6);
            background: #ffffff;
            color: #070a10 !important;
        }

        /* 3. Diagrama de Flujo N-Capas (Horizontal Pipeline Stepper) */
        .pipeline-stepper-container {
            background: var(--carbon-panel);
            border: 1px solid var(--carbon-border-light);
            border-radius: 18px;
            padding: 30px 32px;
            box-shadow: 0 12px 34px rgba(0, 0, 0, 0.45);
        }

        .pipeline-section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--carbon-border-light);
        }

        .pipeline-section-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pipeline-section-title span {
            color: var(--amber-primary);
            font-family: 'JetBrains Mono', monospace;
        }

        .pipeline-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }

        .pipeline-node {
            background: var(--carbon-surface);
            border: 1px solid var(--carbon-border-light);
            border-top: 3px solid var(--amber-primary);
            border-radius: 12px;
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            position: relative;
            transition: transform 0.16s ease, border-color 0.16s ease;
        }

        .pipeline-node:hover {
            transform: translateY(-3px);
            border-color: var(--amber-primary);
        }

        .node-step-tag {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.68rem;
            color: var(--amber-glow);
            font-weight: 700;
            letter-spacing: 1px;
        }

        .node-step-heading {
            font-size: 0.95rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
        }

        .node-step-role {
            font-size: 0.82rem;
            color: var(--text-body);
            line-height: 1.45;
            margin: 0;
        }

        .node-step-tech {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.7rem;
            color: var(--text-muted);
            margin-top: 4px;
        }

        /* 4. Tablero de Diagnostico y Parametros de Entorno */
        .tech-ledger-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .tech-ledger-card {
            background: var(--carbon-panel);
            border: 1px solid var(--carbon-border-light);
            border-radius: 14px;
            padding: 24px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .ledger-card-header {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.76rem;
            color: var(--amber-primary);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--carbon-border-light);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .ledger-specs-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .ledger-spec-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.86rem;
            padding-bottom: 8px;
            border-bottom: 1px dashed rgba(255, 255, 255, 0.05);
        }

        .spec-item-key {
            color: var(--text-body);
        }

        .spec-item-val {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 600;
            color: #ffffff;
        }

        .operational-protocol-steps {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .protocol-step-item {
            display: flex;
            gap: 12px;
            align-items: flex-start;
        }

        .protocol-num-circle {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: rgba(245, 158, 11, 0.15);
            border: 1px solid var(--amber-primary);
            color: var(--amber-glow);
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.72rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .protocol-text-content {
            font-size: 0.85rem;
            color: var(--text-body);
            line-height: 1.5;
        }

        .protocol-text-content strong {
            color: #ffffff;
        }

        @media (max-width: 992px) {
            .cmd-hero-action-deck { grid-template-columns: 1fr; }
            .pipeline-grid { grid-template-columns: 1fr 1fr; }
            .tech-ledger-row { grid-template-columns: 1fr; }
        }

        @media (max-width: 600px) {
            .pipeline-grid { grid-template-columns: 1fr; }
        }
    </style>

    <div class="portal-command-center">
        <!-- 1. Header de Estado Superior -->
        <header class="cmd-top-header">
            <div class="cmd-header-info">
                <div class="cmd-title-tag">// PLATAFORMA DE AUDITOR&Iacute;A Y DISTRIBUCI&Oacute;N DE MEDIOS</div>
                <h1 class="cmd-main-title">Consola Central de Administraci&oacute;n <span>PoliMusic</span></h1>
            </div>

            <div class="cmd-status-strip">
                <div class="status-pill-item">
                    <span class="live-dot"></span>
                    <span>ESTADO: ACTIVO</span>
                </div>
                <div class="status-pill-item">
                    <span>BDD: SQL SERVER (TBL_SONG)</span>
                </div>
                <div class="status-pill-item active">
                    <span>ARQUITECTURA: N-TIER</span>
                </div>
            </div>
        </header>

        <!-- 2. Banner de Accion Rapida y Sesion Activa -->
        <section class="cmd-hero-action-deck">
            <div class="hero-deck-content">
                <div class="operator-identity-row">
                    <div class="operator-avatar-square">AP</div>
                    <div class="operator-details-group">
                        <span class="operator-label-meta">OPERADOR AUDITOR REGISTRADO</span>
                        <h2 class="operator-fullname">
                            <asp:Label ID="lblUserName" runat="server">Angel.Pastaz</asp:Label>
                        </h2>
                    </div>
                </div>

                <p class="hero-deck-description">
                    Sesi&oacute;n verificada mediante esquema FormsAuthentication y almacenamiento persistente en SQL Server. El sistema se encuentra configurado para la navegaci&oacute;n desacoplada del cat&aacute;logo de grabaciones maestras y el registro din&aacute;mico de m&eacute;tricas de reproducci&oacute;n.
                </p>
            </div>

            <div>
                <a href="Song" class="btn-launch-transport">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <polygon points="5 3 19 12 5 21 5 3"></polygon>
                    </svg>
                    <span>Abrir Cat&aacute;logo de Canciones</span>
                </a>
            </div>
        </section>

        <!-- 3. Diagrama de Flujo N-Capas -->
        <section class="pipeline-stepper-container">
            <div class="pipeline-section-header">
                <h3 class="pipeline-section-title">
                    <span>//</span> Flujo Transaccional Desacoplado N-Tier
                </h3>
                <div style="font-family: 'JetBrains Mono', monospace; font-size: 0.72rem; color: var(--text-muted);">
                    POLIMUSIC V3 &bull; AISLAMIENTO DE DEPENDENCIAS
                </div>
            </div>

            <div class="pipeline-grid">
                <!-- Capa 1: Persistencia Relacional -->
                <div class="pipeline-node">
                    <div class="node-step-tag">FASE 01 &bull; PERSISTENCIA</div>
                    <div class="node-step-heading">SQL Server Express</div>
                    <p class="node-step-role">Tabla relacional <code>TBL_SONG</code> con almacenamiento de metadatos, rutas de audio y contadores de reproducci&oacute;n.</p>
                    <div class="node-step-tech">&gt; Driver SqlClient</div>
                </div>

                <!-- Capa 2: Acceso a Datos -->
                <div class="pipeline-node">
                    <div class="node-step-tag">FASE 02 &bull; ACCESO A DATOS</div>
                    <div class="node-step-heading">DAL.PoliMusicV3</div>
                    <p class="node-step-role">Ejecuci&oacute;n de sentencias ADO.NET estrictamente parametrizadas con gesti&oacute;n determinista de conexiones y transacciones.</p>
                    <div class="node-step-tech">&gt; Capa Aislada (DAL)</div>
                </div>

                <!-- Capa 3: Reglas de Negocio -->
                <div class="pipeline-node">
                    <div class="node-step-tag">FASE 03 &bull; L&Oacute;GICA DE NEGOCIO</div>
                    <div class="node-step-heading">BLL.PoliMusicV3</div>
                    <p class="node-step-role">Coordinaci&oacute;n l&oacute;gica, validaci&oacute;n de identificadores de pista y actualizaci&oacute;n at&oacute;mica del medidor de reproducciones.</p>
                    <div class="node-step-tech">&gt; Reglas del Dominio</div>
                </div>

                <!-- Capa 4: Presentacion Web -->
                <div class="pipeline-node">
                    <div class="node-step-tag">FASE 04 &bull; PRESENTACI&Oacute;N</div>
                    <div class="node-step-heading">WebAppPoliMusicV3</div>
                    <p class="node-step-role">Interfaz responsiva construida con <code>GridView</code>, persistencia en <code>ViewState</code> y reproductor nativo HTML5.</p>
                    <div class="node-step-tech">&gt; ASP.NET Web Forms 4.8</div>
                </div>
            </div>
        </section>

        <!-- 4. Tablero de Diagnostico y Parametros de Entorno -->
        <div class="tech-ledger-row">
            <!-- Ficha 1: Diagnostico del Servidor -->
            <div class="tech-ledger-card">
                <div class="ledger-card-header">
                    <span>ESPECIFICACIONES DE INFRAESTRUCTURA</span>
                    <span style="color: var(--amber-glow);">&#9670; PAR&Aacute;METROS</span>
                </div>
                <div class="ledger-specs-list">
                    <div class="ledger-spec-item">
                        <span class="spec-item-key">Plataforma Base:</span>
                        <span class="spec-item-val">.NET Framework 4.8</span>
                    </div>
                    <div class="ledger-spec-item">
                        <span class="spec-item-key">Lenguaje de Implementaci&oacute;n:</span>
                        <span class="spec-item-val">C# (N-Tier Architecture)</span>
                    </div>
                    <div class="ledger-spec-item">
                        <span class="spec-item-key">Base de Datos:</span>
                        <span class="spec-item-val">SQL Server &bull; BDD_PoliMusic</span>
                    </div>
                    <div class="ledger-spec-item">
                        <span class="spec-item-key">Autenticaci&oacute;n Activa:</span>
                        <span class="spec-item-val">FormsAuthentication (SHA-1)</span>
                    </div>
                    <div class="ledger-spec-item">
                        <span class="spec-item-key">Operador Responsable:</span>
                        <span class="spec-item-val" style="color: var(--amber-glow);">Angel Pastaz</span>
                    </div>
                </div>
            </div>

            <!-- Ficha 2: Protocolo de Uso -->
            <div class="tech-ledger-card">
                <div class="ledger-card-header">
                    <span>PROTOCOLO DE REPRODUCCI&Oacute;N AUDITADA</span>
                    <span style="color: var(--amber-glow);">&#9670; PASOS</span>
                </div>
                <div class="operational-protocol-steps">
                    <div class="protocol-step-item">
                        <div class="protocol-num-circle">1</div>
                        <div class="protocol-text-content">
                            <strong>Acceso al Cat&aacute;logo:</strong> Haga clic en el bot&oacute;n superior o en el men&uacute; de navegaci&oacute;n para ingresar a <code>Song.aspx</code>.
                        </div>
                    </div>
                    <div class="protocol-step-item">
                        <div class="protocol-num-circle">2</div>
                        <div class="protocol-text-content">
                            <strong>Consulta en Vivo:</strong> La aplicaci&oacute;n ejecutar&aacute; la consulta SQL mediante <code>BLL.Song.ReadAll()</code> y poblar&aacute; el <code>GridView</code>.
                        </div>
                    </div>
                    <div class="protocol-step-item">
                        <div class="protocol-num-circle">3</div>
                        <div class="protocol-text-content">
                            <strong>Disparo de Audici&oacute;n:</strong> Al pulsar "Escuchar", el contador en SQL Server se incrementar&aacute; en tiempo real y el audio se reproducir&aacute; sin cortes.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>