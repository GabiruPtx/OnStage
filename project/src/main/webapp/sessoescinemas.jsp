<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%@ page import="ufrrj.aps.onstage.model.evento" %>
<%@ page import="ufrrj.aps.onstage.model.genero" %>
<%@ page import="ufrrj.aps.onstage.model.Sessao" %>
<%@ page import="ufrrj.aps.onstage.model.fichaTecnica" %>
<%@ page import="ufrrj.aps.onstage.model.Local" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>


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
    <link rel="stylesheet" href="css/sessaocinema.css">
    <script src="js/sessoescinemas.js" defer></script>
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
            HttpSession ssessao = request.getSession(false);
            cliente cliente = (cliente) ssessao.getAttribute("cliente");
            if(cliente == null) {

            %>
                 <!-- Visitante (não autenticado) -->
                 <button id="auth-btn" class="auth-btn" onclick="window.location.href='login.html'">Cadastro / Login</button>
            
            <%
                } else {
                    
                    String nome = cliente.getNome();
                    String sobrenome = cliente.getSobrenome();
                    String iniciais = "";
                    if(nome != null && nome.length() > 0) {
                        iniciais += nome.charAt(0);
                    }
                    if(sobrenome != null && sobrenome.length() > 0) {
                        iniciais += sobrenome.charAt(0);
                    }
                    System.out.println("5. Iniciais geradas: " + iniciais);
            %>

                <!-- Usuário autenticado -->
                <div id="profile-container" class="profile-container" style="display: block;">
                  <button class="profile-btn">
                      <%= iniciais %>
                      <p class="profile-name"><%= nome + " " + sobrenome %></p>
                  </button>
                  <div class="profile-dropdown">
                      <ul>
                          <li><a href="perfil.jsp">Minha conta</a></li>
                          <li><a href="#">Central de ajuda</a></li>
                          <li><a href="LogoutServlet" id="logout-btn">Sair</a></li>
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

    <main>
    <!-- Informações do Evento -->
    <section class="movie-info">
        <img src="<%= evento.getImagem_url() %>" alt="<%= evento.getTitulo() %>" class="poster">
        <div class="details">
            <h1><%= evento.getTitulo() %></h1>
            <p>
                <!--Exibindo a duração-->
                <%= evento.getDuracao() %> Minutos | 
                <%
                    //Exibindo os gêneros
                    List<genero> generos = evento.getGeneros();
                    for (int i = 0; i < generos.size(); i++) {
                        out.print(generos.get(i).getNome());
                        if (i < generos.size() - 1) {
                            out.print(" | ");
                        }
                    }
                %>
            </p>
            
            <p>Classificação Indicativa: <%= evento.getClass_indicativa() %></p>
            <p><%= evento.getTipo() %></p>

        </div>
    </section>

    <!-- Botão para exibir a aba "Sobre o Filme" -->
    <button id="toggle-sobre">Sobre o Filme</button>

    <!-- Aba "Sobre o Filme" -->
    <div class="conteudo-aba" id="sobre">
        <div id="sinopse-conteudo" style="display: none;">
            <h2>Sobre o Filme</h2>
            <p class="synopsis"><%= evento.getDescricao() %></p>

            <!-- Ficha Técnica -->
            <section class="ficha-tecnica">
                <h3>Ficha Técnica:</h3>
                <div class="ficha-item">
                    <span class="ficha-titulo">Direção:</span> <%= evento.getFicha().getDirecao() %>
                </div>
                <div class="ficha-item">
                    <p>Gênero: 
                        <%
                            List<genero> geneross = evento.getGeneros();
                            for (int i = 0; i < geneross.size(); i++) {
                                out.print(geneross.get(i).getNome());
                                if (i < geneross.size() - 1) {
                                    out.print(", ");
                                }
                            }
                        %>
                    </p>
                </div>
                <div class="ficha-item">
                    <span class="ficha-titulo">Distribuidor:</span> <%= evento.getFicha().getDistribuidora() %>
                </div>
                <div class="ficha-item">
                    <span class="ficha-titulo">Duração:</span> <%= evento.getDuracao() %> Minutos
                </div>
            </section>
        </div>
    </div>
    <!-- Seção de sessões (mantém os dados fictícios ou torna dinâmico) -->
    <section class="sessions">
        <h2>Sessões</h2>
        
        <!-- Botões para filtrar por data -->
        <div class="filters">
            <%
                // Obter as sessões e organizá-las por data
                List<Sessao> sessoes = (List<Sessao>) request.getAttribute("sessoes");
                Map<String, List<Sessao>> sessoesPorData = new LinkedHashMap<>();
    
                if (sessoes != null && !sessoes.isEmpty()) {
                    for (Sessao s : sessoes) {
                        String dataFormatada = new java.text.SimpleDateFormat("dd/MM").format(s.getData());
                        sessoesPorData.putIfAbsent(dataFormatada, new ArrayList<>());
                        sessoesPorData.get(dataFormatada).add(s);
                    }
    
                    // Gerar botões para cada data
                    for (String data : sessoesPorData.keySet()) {
            %>
                        <button class="filter-button" data-date="<%= data %>"><%= data %></button>
            <%
                    }
                }
            %>
        </div>
        
        <!-- Div para exibir as sessões filtradas -->
        <div class="cinemas">
            <%
                if (sessoesPorData != null && !sessoesPorData.isEmpty()) {
                    for (Map.Entry<String, List<Sessao>> entry : sessoesPorData.entrySet()) {
                        String data = entry.getKey();
                        List<Sessao> sessoesDoDia = entry.getValue();
            %>
                        <!-- Div escondida para exibir apenas quando a data correspondente for selecionada -->
                        <div class="cinema-day" data-date="<%= data %>" style="<%= data.equals(sessoesPorData.keySet().iterator().next()) ? "" : "display:none;" %>">
                            <%
                                // Organizar sessões por local
                                Map<String, List<Sessao>> sessoesPorLocal = new LinkedHashMap<>();
                                for (Sessao s : sessoesDoDia) {
                                    sessoesPorLocal.putIfAbsent(s.getLocal().getNome(), new ArrayList<>());
                                    sessoesPorLocal.get(s.getLocal().getNome()).add(s);
                                }
    
                                for (Map.Entry<String, List<Sessao>> localEntry : sessoesPorLocal.entrySet()) {
                                    String local = localEntry.getKey();
                                    List<Sessao> sessoesNoLocal = localEntry.getValue();
                            %>
                                    <h3><%= local %></h3>
                                    <div class="times">
                                        <%
                                            for (Sessao s : sessoesNoLocal) {
                                        %>
                                            <a href="assentosServlet?id=<%= s.getId() %>">
                                                <button><%= s.getHorario() %></button>
                                            </a>
                                        <%
                                            }
                                        %>
                                    </div>
                            <%
                                }
                            %>
                        </div>
            <%
                    }
                } else {
            %>
                <p>Não há sessões disponíveis para este evento.</p>
            <%
                }
            %>
        </div>
    </section>
    
  </main>

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

    <div class="container">
      <div class="column payment-methods">
        <h4>Formas de Pagamento</h4>
        <div>
          <img src="img/visa.jpg" alt="Visa">
          <img src="img/mastercard.jpg" alt="Mastercard">
          <img src="img/nubank.jpg" alt="Nubank">
          <!-- Adicione mais ícones conforme necessário -->
        </div>
      </div>
      <div class="column awards">
        <h4>Selo do Consumidor</h4>
        <img src="img/reclame aqui.png" alt="Reclame Aqui">
        <img src="img/premio.png" alt="Prêmio Melhor App">
      </div>
    </div>

    <div class="footer-bottom">
        OnStage Ltda / CNPJ: 00.000.000/0001-00 Endereço: Rua Dois de Fevereiro, 85 - 5º andar - Engenho de Dentro - RJ - 20000-000<br>
        Atendimento ao cliente © 2024 - Copyright OnStage.com - Todos os direitos reservados.
    </div>
  </footer>
</body>
</html>