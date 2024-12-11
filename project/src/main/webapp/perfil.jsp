<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Verificação de autenticação
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Simulação de objeto de usuário (na prática, seria um objeto User do seu modelo)
    class User {
        private String nome;
        private String sobrenome;
        private String email;
        private String telefone;
        private String endereco;
        private String dataNascimento;

        // Construtor, getters e setters
        public User(String nome, String sobrenome, String email, String telefone, String endereco, String dataNascimento) {
            this.nome = nome;
            this.sobrenome = sobrenome;
            this.email = email;
            this.telefone = telefone;
            this.endereco = endereco;
            this.dataNascimento = dataNascimento;
        }

        // Métodos getters e setters
        // (código completo omitido por brevidade)
    }

    // Usuário recuperado da sessão ou banco de dados
    User usuario = (User) session.getAttribute("user");
    if (usuario == null) {
        usuario = new User(
                "Gabriel",
                "Garcia",
                "gabriel.garcia@email.com",
                "11987654321",
                "Rua Example, 123 - São Paulo, SP",
                "1990-05-15"
        );
        session.setAttribute("user", usuario);
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/perfil.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <title>OnStage - Perfil do Usuário</title>
    <style>
        .edit-mode {
            border: 1px solid #007bff;
            background-color: #f1f1f1;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
<!-- Cabeçalho (mantido igual ao original) -->
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
                <span class="profile-name"><%= usuario.getNome() %></span>
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

<!-- Formulário de Perfil com Edição Dinâmica -->
<form id="perfil-form" action="AtualizarPerfilServlet" method="post">
    <!-- Dados Pessoais -->
    <div class="dados-pessoais">
        <h2>Dados Pessoais</h2>

        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome"
                   value="<%= usuario.getNome() %>" readonly>
        </div>

        <div class="form-group">
            <label for="sobrenome">Sobrenome:</label>
            <input type="text" id="sobrenome" name="sobrenome"
                   value="<%= usuario.getSobrenome() %>" readonly>
        </div>

        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email"
                   value="<%= usuario.getEmail() %>">
            <button type="button" class="edit-btn" onclick="toggleEdit('email')">Editar</button>
        </div>

        <div class="form-group">
            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone"
                   value="<%= usuario.getTelefone() %>">
            <button type="button" class="edit-btn" onclick="toggleEdit('telefone')">Editar</button>
        </div>

        <div class="form-group">
            <label for="dataNascimento">Data de Nascimento:</label>
            <input type="date" id="dataNascimento" name="dataNascimento"
                   value="<%= usuario.getDataNascimento() %>">
            <button type="button" class="edit-btn" onclick="toggleEdit('dataNascimento')">Alterar</button>
        </div>
    </div>

    <!-- Endereço -->
    <div class="endereco">
        <h2>Endereço</h2>
        <div class="form-group">
            <label for="endereco">Endereço Completo:</label>
            <input type="text" id="endereco" name="endereco"
                   value="<%= usuario.getEndereco() %>">
            <button type="button" class="edit-btn" onclick="toggleEdit('endereco')">Editar Endereço</button>
        </div>
    </div>

    <div class="form-group">
        <button type="submit" id="salvar-alteracoes" class="hidden">Salvar Alterações</button>
    </div>
</form>

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
    function toggleEdit(campo) {
        const input = document.getElementById(campo);
        const botaoSalvar = document.getElementById('salvar-alteracoes');

        input.removeAttribute('readonly');
        input.classList.add('edit-mode');

        botaoSalvar.classList.remove('hidden');
    }

    document.getElementById('perfil-form').addEventListener('submit', function(event) {
        const email = document.getElementById('email');
        const telefone = document.getElementById('telefone');
        const dataNascimento = document.getElementById('dataNascimento');

        if (!/\S+@\S+\.\S+/.test(email.value)) {
            alert('Por favor, insira um e-mail válido.');
            event.preventDefault();
            return;
        }

        if (!/^\d{10,11}$/.test(telefone.value.replace(/\D/g,''))) {
            alert('Por favor, insira um telefone válido.');
            event.preventDefault();
            return;
        }

        const hoje = new Date();
        const nascimento = new Date(dataNascimento.value);
        if (nascimento > hoje) {
            alert('Data de nascimento não pode ser no futuro.');
            event.preventDefault();
            return;
        }
    });
</script>
</body>
</html>