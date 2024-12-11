<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="ufrrj.aps.onstage.model.Sessao, ufrrj.aps.onstage.model.evento" %>
<%@ page import="ufrrj.aps.onstage.model.Assento" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra de Ingressos</title>
    <link rel="stylesheet" href="css/selecaoingressos.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <script src="js/selecaoingressos.js" defer></script>
</head>
<body>
    <div class="container">
        <!-- Cabeçalho -->
        <header class="header">
            <div class="logo-container">
                <a href="index.jsp">
                    <img src="img/OS_Logotipo_Black.png" alt="Logo" class="logo">
                </a>
            </div>
            <div id="auth-container">
                <% HttpSession sessao = request.getSession(false);
                   cliente usuario = (cliente) sessao.getAttribute("cliente");
                   if (usuario == null) { %>
                    <!-- Visitante (não autenticado) -->
                    <button id="auth-btn" class="auth-btn" onclick="window.location.href='login.html'">Cadastro / Login</button>
                <% } else {
                       String nome = usuario.getNome();
                       String sobrenome = usuario.getSobrenome();
                       String iniciais = "";
                       if (nome != null && nome.length() > 0) {
                           iniciais += nome.charAt(0);
                       }
                       if (sobrenome != null && sobrenome.length() > 0) {
                           iniciais += sobrenome.charAt(0);
                       } %>
                    <!-- Usuário autenticado -->
                    <div id="profile-container" class="profile-container" style="display: block;">
                        <button class="profile-btn">
                            <%= iniciais %>
                            <span class="profile-name"><%= nome + " " + sobrenome %></span>
                        </button>
                        <div class="profile-dropdown">
                            <ul>
                                <li><a href="perfil.jsp">Minha Conta</a></li>
                                <li><a href="#">Central de Ajuda</a></li>
                                <li><a href="LogoutServlet" id="logout-btn">Sair</a></li>
                            </ul>
                        </div>
                    </div>
                <% } %>
            </div>
            <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
                <span class="icon">☀️</span>
            </button>
        </header>

        <!-- Conteúdo Principal -->
        <div class="main-content">
            <!-- Dados da Sessão -->
            <% 
                sessao sessaoEvento = (sessao) sessao.getAttribute("sessao");
                evento eventoAtual = (evento) sessao.getAttribute("evento");
                List<String> assentosSelecionados = (List<String>) sessao.getAttribute("assentosSelecionados");
            %>
            <div class="movie-info">
                <h3><%= eventoAtual.getNome() %></h3>
                <p class="classificacao"><%= eventoAtual.getClassificacao() %> | <%= eventoAtual.getGenero() %></p>
                <p>Sala <%= sessaoEvento.getSala() %> | <%= sessaoEvento.getData() %> <%= sessaoEvento.getHorario() %></p>
                <p>Assentos: <%= String.join(", ", assentosSelecionados) %></p>
            </div>

            <!-- Tipos de Ingressos -->
            <div class="ticket-options">
                <% 
                    Map<String, Double> tiposIngressos = (Map<String, Double>) sessao.getAttribute("tiposIngressos");
                    for (Map.Entry<String, Double> ingresso : tiposIngressos.entrySet()) { 
                %>
                    <div class="ticket">
                        <div class="ticket-label">
                            <p><%= ingresso.getKey() %></p>
                            <span>R$ <%= String.format("%.2f", ingresso.getValue()) %></span>
                        </div>
                        <div class="ticket-quantity">
                            <button class="quantity-btn">-</button>
                            <input type="number" value="0" class="quantity-input" readonly>
                            <button class="quantity-btn">+</button>
                        </div>
                    </div>
                <% } %>
                <div class="back-button">
                    <a href="assentos.html">
                        <button>Voltar</button>
                    </a>
                </div>
            </div>


    <!-- Rodapé -->
    <footer>
        <div class="container">
            <div class="column">
                <h4>Menu</h4>
                <ul>
                    <li><a href="#">Filmes</a></li>
                    <li><a href="#">Musicais</a></li>
                    <li><a href="#">Peças teatrais</a></li>
                </ul>
            </div>
            <div class="column">
                <h4>Institucional</h4>
                <ul>
                    <li><a href="#">Quem Somos</a></li>
                    <li><a href="#">Assessoria de Imprensa</a></li>
                    <li><a href="#">Vale-Presente Corporativo</a></li>
                    <li><a href="#">Faça parte do time</a></li>
                </ul>
            </div>
            <div class="column">
                <h4>Políticas</h4>
                <ul>
                    <li><a href="#">Privacidade e Segurança</a></li>
                    <li><a href="#">Trocas e Cancelamentos</a></li>
                    <li><a href="#">Termos de Uso</a></li>
                </ul>
            </div>
            <div class="column">
                <h4>Redes Sociais</h4>
                <ul>
                    <li><a href="#">Facebook</a></li>
                    <li><a href="#">YouTube</a></li>
                    <li><a href="#">Instagram</a></li>
                    <li><a href="#">LinkedIn</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            OnStage Ltda / CNPJ: 00.000.000/0001-00 Endereço: Rua Dois de Fevereiro, 85 - 5º andar - Engenho de Dentro - RJ - 20000-000<br>
            Atendimento ao cliente © 2024 - Copyright OnStage.com - Todos os direitos reservados.
        </div>
    </footer>
</body>
</html>
