<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="ufrrj.aps.onstage.model.Assento" %>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%@ page import="ufrrj.aps.onstage.model.Sessao"%>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/assentos.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js" defer></script>
    <script src="js/assentos.js" defer></script>
    <title>OnStage - Escolha de Assentos</title>
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
          Sessao sessao = (Sessao) ssessao.getAttribute("sessao");
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
    <!-- Tela de assentos -->
    <main>
      <h1 class="page-title">Escolha seu Assento</h1>
      <div class="screen">Tela</div>
      <%
        if (sessao != null) {
            System.out.println("Id da sessão tela assentos.jsp: " + sessao.getId());
        } else {
            System.out.println("Sessão é null. Não foi possível acessar o ID.");
        }
      %>
      
      <!-- Assentos -->
      <div class="cinema-seats">
          <c:forEach var="fileira" items="${assentosOrganizados}">
              <div class="row">
                  <c:forEach var="assento" items="${fileira.value}">
                      <c:set var="seatClass" value="seat"/>
                      
                      <!-- Classes baseadas no estado -->
                      <c:if test="${assento.estado == 'DISPONIVEL'}">
                          <c:set var="seatClass" value="${seatClass} available"/>
                      </c:if>
                      <c:if test="${assento.estado == 'RESERVADO'}">
                          <c:set var="seatClass" value="${seatClass} reserved"/>
                      </c:if>
                      
                      <!-- Classes baseadas no tipo -->
                      <c:if test="${assento.tipo == 'PREMIUM'}">
                          <c:set var="seatClass" value="${seatClass} premium"/>
                      </c:if>
                      <c:if test="${assento.tipo == 'DEFICIENTE'}">
                          <c:set var="seatClass" value="${seatClass} disabled-seat"/>
                      </c:if>
                      
                      <div class="${seatClass}" 
                           data-seat="${assento.fileira}${assento.numero}" 
                           data-tipo="${assento.tipo}">
                          ${assento.fileira}${assento.numero}
                      </div>
                  </c:forEach>
              </div>
          </c:forEach>
      </div>
      
      <!-- Painel de informações -->
      <div class="info-panel">
          <div><span class="seat available"></span> Disponível</div>
          <div><span class="seat reserved"></span> Reservado</div>
          <div><span class="seat selected"></span> Selecionado</div>
          <div><span class="seat premium available"></span> Premium</div>
          <div><span class="seat disabled-seat available"></span> Acessível</div>
      </div>
      
      <button id="confirm-selection">Confirmar Seleção</button>
  </main>
  

  <script>
      const sessaoId = "<%= sessao != null ? sessao.getId() : "" %>";
  </script>
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