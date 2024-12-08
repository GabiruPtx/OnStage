<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%@ page import="ufrrj.aps.onstage.model.evento" %>
<%@ page import="ufrrj.aps.onstage.model.genero" %>
<%@ page import="java.util.List" %>

<%
    evento evento = (evento) request.getAttribute("evento");
    if (evento == null) {
%>
    <h1>Erro: Evento não encontrado</h1>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Evento - <%= evento.getTitulo() %></title>
    <link rel="stylesheet" href="css/sessoescinemas.css">
</head>
<body>
    <!-- Cabeçalho -->
    <header class="header">
        <div class="logo-container">
            <a href="index.jsp">
                <img src="img/OS_Logotipo_Black.png" alt="Logo" class="logo">
            </a>
        </div>
        
        <!-- Conteúdo de autenticação -->
        <div id="auth-container">
            <%
            HttpSession sessao = request.getSession(false);
            cliente cliente = (cliente) sessao.getAttribute("cliente");
            if(cliente == null) {

            %>
                 <!-- Visitante (não autenticado) -->
                 <button id="auth-btn" class="auth-btn" onclick="window.location.href='login.jsp'">Cadastro / Login</button>
            
            <%
                } else {
            %>
                <!-- Usuário autenticado -->
                <div id="profile-container" class="profile-container">
                    <button class="profile-btn">
                        GG
                        <span class="profile-name"><%= cliente.getNome() %></span>
                    </button>
                    <div class="profile-dropdown">
                        <ul>
                            <li><a href="perfil.jsp">Minha conta</a></li>
                            <li><a href="#">Central de ajuda</a></li>
                            <li><a href="logout.jsp">Sair</a></li>
                        </ul>
                    </div>
                </div>
            <%
                }
            %>
        </div>
        
        <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
            <span class="icon">☀️</span>
        </button>
    </header>

    <!-- Informações do Evento -->
    <section class="movie-info">
        <img src="<%= evento.getImagem_url() %>" alt="<%= evento.getTitulo() %>" class="poster">
        <div class="details">
            <h1><%= evento.getTitulo() %></h1>
            <p><%= evento.getDuracao() %> | <%= evento.getTipo() %></p>
            <p class="synopsis"><%= evento.getDescricao() %></p>
            <p>Classificação Indicativa: <%= evento.getClass_indicativa() %></p>

            <!-- Exibindo os gêneros -->
            <p>Gêneros: 
                <%
                    List<genero> generos = evento.getGeneros();
                    for (int i = 0; i < generos.size(); i++) {
                        out.print(generos.get(i).getNome());
                        if (i < generos.size() - 1) {
                            out.print(", ");
                        }
                    }
                %>
            </p>
        </div>
    </section>

    <!-- Seção de sessões (mantém os dados fictícios ou torna dinâmico) -->
    <section class="sessions">
        <h2>Sessões</h2>
        <!-- Dados de exemplo de sessões -->
        <div class="cinemas">
            <h3>Cine Araújo Jardim Guadalupe</h3>
            <div class="times">
                <a href="assentos.jsp"><button>14:40</button></a>
                <a href="assentos.jsp"><button>16:50</button></a>
                <a href="assentos.jsp"><button>19:00</button></a>
            </div>
        </div>
    </section>

    <!-- Rodapé -->
    <footer class="footer">
        <p>&copy; 2024 OnStage. Todos os direitos reservados.</p>
    </footer>
</body>
</html>