<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/checkout.css">
    <script src="js/checkout.js" defer></script>
    <title>OnStage - Checkout</title>
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
            if (userName == null || userName.isEmpty()) {
            %>
                <!-- Botão de Cadastro/Login para usuários não logados -->
                <button id="auth-btn" class="auth-btn">Cadastro / Login</button>
            <%
            } else {
            %>
                <!-- Botão de Perfil e Menu para usuários logados -->
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

    <!-- Tela de Checkout -->
    <main>
        <h1 class="page-title">Checkout</h1>
        <!-- Lista de Assentos Escolhidos -->
        <section class="selected-seats">
            <h2>Assentos Selecionados</h2>
            <ul id="seat-list"></ul>
        </section>
        <!-- Tipo de Ingresso -->
        <section class="ticket-type">
            <h2>Tipo de Ingresso</h2>
            <form id="ticket-form">
                <label>
                    <input type="radio" name="ticketType" value="inteira" checked>
                    Inteira
                </label>
                <label>
                    <input type="radio" name="ticketType" value="meia">
                    Meia
                </label>
                <div id="cpf-container" style="display: none;">
                    <input type="text" placeholder="CPF (somente números)" id="cpf" maxlength="11">
                </div>
            </form>
        </section>
        <!-- Opções de Pagamento -->
        <section class="payment-options">
            <h2>Método de Pagamento</h2>
            <form id="payment-form">
                <div class="payment-method">
                    <label>
                        <input type="radio" name="payment" value="card" checked>
                        Cartão de Crédito
                    </label>
                    <div class="card-details">
                        <input type="text" placeholder="Nome no Cartão" id="card-name">
                        <input type="text" placeholder="Número do Cartão" id="card-number" maxlength="16">
                        <input type="text" placeholder="Validade (MM/AA)" id="card-expiry" maxlength="5">
                        <input type="text" placeholder="CVV" id="card-cvv" maxlength="3">
                    </div>
                </div>
                <div class="payment-method">
                    <label>
                        <input type="radio" name="payment" value="pix">
                        Pix
                    </label>
                    <p class="pix-instructions" id="pix-code"></p>
                </div>
               
                <button type="submit" class="submit-button">Finalizar Compra</button>
            </form>
        </section>
    </main>
    <!-- Rodapé -->
    <footer class="footer">
        <p>&copy; 2024 OnStage. Todos os direitos reservados.</p>
    </footer>
</body>
</html>