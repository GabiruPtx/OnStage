<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifica se o usuário está autenticado
    String userName = null;
    String userLastName = null;
    String userEmail = null;
    String userPhone = null;
    String userAddress = null;
    String userBirthDate = null;

    if (session.getAttribute("user") != null) {
        userName = (String) session.getAttribute("userName");
        userLastName = (String) session.getAttribute("userLastName");
        userEmail = (String) session.getAttribute("userEmail");
        userPhone = (String) session.getAttribute("userPhone");
        userAddress = (String) session.getAttribute("userAddress");
        userBirthDate = (String) session.getAttribute("userBirthDate");
    } else {
        // Redireciona para a página de login se o usuário não estiver autenticado
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/perfil.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <title>OnStage - O espetáculo ao seu alcance</title>
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
            <div id="profile-container" class="profile-container">
                <button class="profile-btn">
                    GG
                    <span class="profile-name"><%= userName != null ? userName : "Usuário" %></span>
                </button>
                <div class="profile-dropdown">
                    <ul>
                        <li><a href="perfil.jsp">Minha conta</a></li>
                        <li><a href="#">Central de ajuda</a></li>
                        <li><a href="logout.jsp">Sair</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
            <span class="icon">☀️</span>
        </button>
    </header>

    <!-- Seção: Dados Pessoais -->
    <div class="dados-pessoais">
        <h2>Dados Pessoais</h2>
        <form id="dados-pessoais-form">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" value="<%= userName %>" disabled>
            </div>
            <div class="form-group">
                <label for="sobrenome">Sobrenome:</label>
                <input type="text" id="sobrenome" value="<%= userLastName %>" disabled>
            </div>
            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="email" id="email" value="<%= userEmail %>">
                <button type="button" class="edit-btn" id="edit-email">Editar</button>
            </div>
            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" id="telefone" value="<%= userPhone %>">
                <button type="button" class="edit-btn" id="edit-telefone">Editar</button>
            </div>
            <div class="form-group">
                <label for="data-nascimento">Data de Nascimento:</label>
                <input type="date" id="data-nascimento" value="<%= userBirthDate %>">
                <button type="button" class="edit-btn" id="edit-data-nascimento">Alterar</button>
            </div>
        </form>
    </div>

    <!-- Seção: Endereço -->
    <div class="endereco">
        <h2>Endereço</h2>
        <form id="endereco-form">
            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" value="<%= userAddress %>" disabled>
                <button type="button" class="edit-btn" id="edit-endereco">Editar Endereço</button>
            </div>
        </form>
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
