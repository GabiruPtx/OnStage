<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">
    <script src="${pageContext.request.contextPath}/js/checkout.js" defer></script>
    <title>OnStage - Checkout</title>
</head>
<body>
<header class="header">
    <div class="logo-container">
        <a href="${pageContext.request.contextPath}/index.html">
            <img src="${pageContext.request.contextPath}/img/OS_Logotipo_Black.png" alt="Logo" class="logo">
        </a>
    </div>

    <div id="auth-container">
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <button id="auth-btn" class="auth-btn">Cadastro / Login</button>
            </c:when>
            <c:otherwise>
                <div id="profile-container" class="profile-container">
                    <button class="profile-btn">
                            ${sessionScope.user.initials}
                        <span class="profile-name">${sessionScope.user.fullName}</span>
                    </button>
                    <div class="profile-dropdown">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/perfil.jsp">Minha conta</a></li>
                            <li><a href="#">Central de ajuda</a></li>
                            <li><a href="${pageContext.request.contextPath}/LogoutServlet" id="logout-btn">Sair</a></li>
                        </ul>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
        <span class="icon">☀️</span>
    </button>
</header>

<main>
    <h1 class="page-title">Checkout</h1>

    <form id="checkout-form" action="${pageContext.request.contextPath}/ProcessCheckoutServlet" method="post">
        <section class="selected-seats">
            <h2>Assentos Selecionados</h2>
            <ul id="seat-list">
                <c:forEach items="${sessionScope.selectedSeats}" var="seat">
                    <li>${seat.seatNumber}</li>
                    <input type="hidden" name="selectedSeats" value="${seat.seatNumber}">
                </c:forEach>
            </ul>
        </section>

        <section class="ticket-type">
            <h2>Tipo de Ingresso</h2>
            <div>
                <label>
                    <input type="radio" name="ticketType" value="inteira" checked>
                    Inteira
                </label>
                <label>
                    <input type="radio" name="ticketType" value="meia" onclick="toggleCPFField()">
                    Meia
                </label>
                <div id="cpf-container" style="display: none;">
                    <input type="text"
                           placeholder="CPF (somente números)"
                           name="cpf"
                           id="cpf"
                           maxlength="11"
                           pattern="\d{11}"
                           title="Digite apenas números">
                </div>
            </div>
        </section>

        <section class="payment-options">
            <h2>Método de Pagamento</h2>
            <div>
                <div class="payment-method">
                    <label>
                        <input type="radio" name="paymentMethod" value="card" checked>
                        Cartão de Crédito
                    </label>
                    <div class="card-details">
                        <input type="text"
                               placeholder="Nome no Cartão"
                               name="cardName"
                               id="card-name"
                               required>
                        <input type="text"
                               placeholder="Número do Cartão"
                               name="cardNumber"
                               id="card-number"
                               maxlength="16"
                               pattern="\d{16}"
                               title="Digite 16 números"
                               required>
                        <input type="text"
                               placeholder="Validade (MM/AA)"
                               name="cardExpiry"
                               id="card-expiry"
                               maxlength="5"
                               pattern="\d{2}/\d{2}"
                               title="Use formato MM/AA"
                               required>
                        <input type="text"
                               placeholder="CVV"
                               name="cardCVV"
                               id="card-cvv"
                               maxlength="3"
                               pattern="\d{3}"
                               title="Digite 3 números"
                               required>
                    </div>
                </div>

                <div class="payment-method">
                    <label>
                        <input type="radio" name="paymentMethod" value="pix">
                        Pix
                    </label>
                    <p class="pix-instructions" id="pix-code">
                        <c:if test="${not empty pixQRCode}">
                            ${pixQRCode}
                        </c:if>
                    </p>
                </div>

                <button type="submit" class="submit-button">Finalizar Compra</button>
            </div>
        </section>
    </form>
</main>

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

<script>
    function toggleCPFField() {
        var halfTicketRadio = document.querySelector('input[value="meia"]');
        var cpfContainer = document.getElementById('cpf-container');
        cpfContainer.style.display = halfTicketRadio.checked ? 'block' : 'none';
    }
</script>
</body>
</html>