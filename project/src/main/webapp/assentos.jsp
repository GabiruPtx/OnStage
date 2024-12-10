<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="ufrrj.aps.onstage.model.Assento" %>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/assentos.css">
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
        <div id="auth-container">
            <%
            // Verifica se existe uma sessão de usuário
            String userName = (String) session.getAttribute("userName");
            String userInitials = (String) session.getAttribute("userInitials");
            
            // Verifica se o usuário está logado
            if (userName == null || userName.isEmpty()) {
                // Redireciona para a página de login se não estiver autenticado
                response.sendRedirect("login.jsp");
            } else {
            %>
                <div id="profile-container" class="profile-container">
                    <button class="profile-btn">
                        <%= userInitials %>
                        <span class="profile-name"><%= userName %></span>
                    </button>
                    <div class="profile-dropdown">
                        <ul>
                            <li><a href="perfil.jsp">Minha conta</a></li>
                            <li><a href="#">Central de ajuda</a></li>
                            <li><a href="logout.jsp" id="logout-btn">Sair</a></li>
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