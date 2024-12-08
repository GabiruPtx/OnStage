<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/whiteStyle.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/theme.css">
    <script src="js/script.js" defer></script>
    <title>OnStage - O espetáculo ao seu alcance</title>

</head>
<body>
<!-- Cabeçalho -->
    <header class="header">

        <div class="menu-button">&#9776;</div>
        <div class="logo-container">
            <img src="img/OS_Logotipo_Black.png" alt="Logo" class="logo">
        </div>
        <div class="search-bar">
            <input type="text" placeholder="Buscar eventos...">
        </div>
        <button class="auth-btn">Cadastrar/Login</button>
        <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
            <span class="icon">☀️</span>
        </button>

    </header>
    <main>

        <section class="EventosEmAlta" id="eventosEmAlta">
            <div class="container">
                <div class="FilmesEmAlta"></div>
                <div class="PeçasEmAlta"></div>
            </div>
        </section>
        <section class="EventosProximos" id="eventosProximos">

        </section>
        <section class="Estreando" id="estreando">

        </section>
        <section class="EmBreve" id="emBreve">

        </section>
        <section class="EventosPorCategoria" id="evntPorCategoria">

        </section>

    </main>
<!-- Rodapé -->
    <footer class="footer">
        <section class="SobreNós" id="sobreNos"></section>
        <p>&copy; 2024 Ingressos Online. Todos os direitos reservados.</p>
    </footer>
</body>
</html>