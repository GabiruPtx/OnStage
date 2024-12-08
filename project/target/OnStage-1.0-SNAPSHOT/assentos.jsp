<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <%
            // Arrays com o status dos assentos (isso poderia vir de um banco de dados)
            String[][] seats = {
                {"A1", "A2", "A3", "A4", "A5"},
                {"B1", "B2", "B3", "B4", "B5"},
                {"C1", "C2", "C3", "C4", "C5"}
            };
            
            // Array com assentos reservados (isso poderia vir de um banco de dados)
            String[] reservedSeats = {"A3", "B3", "C5"};
            
            // Função para verificar se um assento está reservado
            boolean isReserved(String seat, String[] reserved) {
                for (String r : reserved) {
                    if (r.equals(seat)) return true;
                }
                return false;
            }
            
            // Gera as fileiras de assentos dinamicamente
            for (String[] row : seats) {
            %>
                <div class="row">
                    <%
                    for (String seat : row) {
                        String seatClass = isReserved(seat, reservedSeats) ? "reserved" : "available";
                    %>
                        <div class="seat <%= seatClass %>" data-seat="<%= seat %>"><%= seat %></div>
                    <%
                    }
                    %>
                </div>
            <%
            }
            %>
        </div>
        <!-- Painel de informações -->
        <div class="info-panel">
            <div><span class="seat available"></span> Disponível</div>
            <div><span class="seat reserved"></span> Reservado</div>
            <div><span class="seat selected"></span> Selecionado</div>
        </div>
        <button id="confirm-selection">Confirmar Seleção</button>
    </main>
    <!-- Rodapé -->
    <footer class="footer">
        <p>&copy; 2024 OnStage. Todos os direitos reservados.</p>
    </footer>
</body>
</html>