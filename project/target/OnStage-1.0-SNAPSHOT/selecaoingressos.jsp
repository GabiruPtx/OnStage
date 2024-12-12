<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="ufrrj.aps.onstage.model.Sessao, ufrrj.aps.onstage.model.evento" %>
<%@ page import="ufrrj.aps.onstage.model.Assento" %>
<%@ page import="ufrrj.aps.onstage.model.genero" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>



<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra de Ingressos</title>
    <link rel="stylesheet" href="css/selecaoingressos.css">
    <!--<link rel="stylesheet" href="css/style.css">-->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
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
                <% HttpSession httpSession = request.getSession(false);
                   cliente usuario = (cliente) httpSession.getAttribute("cliente");
                   if (usuario == null) { %>
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

        <div class="main-content">

            <!-- Tipos de Ingressos -->
            <div class="ticket-options">
                <div class="ticket">
                    <div class="ticket-label">
                        <p>Inteira</p>
                        <span>R$ 31,88</span>
                    </div>
                    <div class="ticket-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <input type="number" value="0" class="quantity-input" readonly data-price="31.88">
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>
                <div class="ticket">
                    <div class="ticket-label">
                        <p>Meia Estudante</p>
                        <span>R$ 17,88</span>
                    </div>
                    <div class="ticket-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <input type="number" value="0" class="quantity-input" readonly data-price="17.88">
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>
                <div class="ticket">
                    <div class="ticket-label">
                        <p>Meia Criança</p>
                        <span>R$ 17,88</span>
                    </div>
                    <div class="ticket-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <input type="number" value="0" class="quantity-input" readonly data-price="17.88">
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>
                <div class="ticket">
                    <div class="ticket-label">
                        <p>Meia - Pessoa Idosa</p>
                        <span>R$ 17,88</span>
                    </div>
                    <div class="ticket-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <input type="number" value="0" class="quantity-input" readonly data-price="17.88">
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>
                <div class="ticket">
                    <div class="ticket-label">
                        <p>Meia Entrada - Pessoa com Deficiência</p>
                        <span>R$ 17,88</span>
                    </div>
                    <div class="ticket-quantity">
                        <button class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                        <input type="number" value="0" class="quantity-input" readonly data-price="17.88">
                        <button class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                    </div>
                </div>

                <div class="back-button">
                    <a href="javascript:history.back()">
                        <button>Voltar</button>
                    </a>
                </div>
            </div>

            <!-- Resumo do Pedido -->
            <div class="order-summary">

            <!-- Dados do Evento -->
                <% 
                    Sessao sessaoEvento = (Sessao) request.getAttribute("sessao");
                    evento eventoAtual = (evento) request.getAttribute("evento");
                    List<Map<String, String>> assentosSelecionados = (List<Map<String, String>>) request.getAttribute("assentos");
                    int numAssentos = assentosSelecionados.size();
                %>
                <div class="movie-info">
                    <h3><%= eventoAtual.getTitulo() %></h3>
                    <p class="classificacao"><%= eventoAtual.getClass_indicativa() %> | 
                        <% 
                        List<genero> generos = eventoAtual.getGeneros();
                        for (int i = 0; i < generos.size(); i++) {
                            out.print(generos.get(i).getNome());
                            if (i < generos.size() - 1) {
                                out.print(" | ");
                            }
                        }
                        %>
                    </p>
                    <%
                        // Formatar a data
                        SimpleDateFormat dataFormat = new SimpleDateFormat("dd/MM");
                        String dataFormatada = dataFormat.format(sessaoEvento.getData());

                        // Converter a string do horário (caso necessário)
                        SimpleDateFormat horaFormat = new SimpleDateFormat("HH:mm"); // Formato esperado do horário
                        String horaFormatada;
                        try {
                            Date horario = horaFormat.parse(sessaoEvento.getHorario()); // Converter a string para Date
                            horaFormatada = horaFormat.format(horario); // Reformatar o horário
                        } catch (ParseException e) {
                            // Em caso de erro, usar o horário como está (evita quebra)
                            horaFormatada = sessaoEvento.getHorario();
                        }
                    %>
                    <p>Sala <%= sessaoEvento.getSala().getNumero() %> | <%= dataFormatada %> <%= horaFormatada %></p>


                    <p>Assentos: 
                        <% 
                            for (int i = 0; i < assentosSelecionados.size(); i++) {
                                out.print(assentosSelecionados.get(i).get("fileira") + assentosSelecionados.get(i).get("numero"));
                                if (i < assentosSelecionados.size() - 1) {
                                    out.print(", ");
                                }
                            }
                        %>
                    </p>
                </div>

                <div class="total">
                    <p>Itens: <span id="total-items">0</span></p>
                    <p>Total: R$ <span id="total-price">0,00</span></p>
                </div>
                <div class="payment">
                    <button onclick="proceedToCheckout()" id="checkout-btn" disabled>Ir para Pagamento</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let totalAssentos = <%= numAssentos %> ;
        let totalSelecionados = 0;
        let totalPreco = 0;

        function updateQuantity(button, change) {
            const container = button.parentElement;
            const input = container.querySelector('.quantity-input');
            const currentValue = parseInt(input.value);
            const price = parseFloat(input.dataset.price);
            const newValue = currentValue + change;

            if (newValue >= 0 && (totalSelecionados + change) <= totalAssentos) {
                input.value = newValue;
                totalSelecionados += change;
                totalPreco += change * price;
                
                updateSummary();
                updateCheckoutButton();
            }
        }

        function updateSummary() {
            document.getElementById('total-items').textContent = totalSelecionados;
            document.getElementById('total-price').textContent = totalPreco.toFixed(2);
        }

        function updateCheckoutButton() {
            const checkoutBtn = document.getElementById('checkout-btn');
            checkoutBtn.disabled = totalSelecionados !== totalAssentos;
        }

        function proceedToCheckout() {
            if (totalSelecionados === totalAssentos) {
                // Coletar dados dos ingressos selecionados
                const tickets = [];
                document.querySelectorAll('.ticket').forEach(ticket => {
                    const quantity = parseInt(ticket.querySelector('.quantity-input').value);
                    if (quantity > 0) {
                        tickets.push({
                            type: ticket.querySelector('.ticket-label p').textContent,
                            quantity: quantity,
                            price: parseFloat(ticket.querySelector('.quantity-input').dataset.price)
                        });
                    }
                });

                // Criar formulário para envio
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'Checkout';

                // Adicionar dados como campos hidden
                const ticketsInput = document.createElement('input');
                ticketsInput.type = 'hidden';
                ticketsInput.name = 'tickets';
                ticketsInput.value = JSON.stringify(tickets);
                form.appendChild(ticketsInput);

                // Adicionar o formulário e enviá-lo
                document.body.appendChild(form);
                form.submit();
            }
        }
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
