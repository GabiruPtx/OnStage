<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ufrrj.aps.onstage.model.cliente"%>
<%
    System.out.println("Sessão atual: " + session.getId());
    System.out.println("Cliente na sessão: " + session.getAttribute("cliente"));
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <script src="js/script.js" defer></script>
    <script src="js/navegacao.js" defer></script>
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
        <div class="search-bar">
            <input type="text" placeholder="Buscar eventos...">
        </div>
        <div id="auth-container">
          <%
          System.out.println("1. Iniciando verificação de sessão");
          HttpSession sessao = request.getSession(false);
          
          System.out.println("2. Sessão obtida: " + (sessao != null));
          cliente cliente = (cliente) sessao.getAttribute("cliente");
          
          System.out.println("3. Cliente obtido: " + (cliente != null));
          if(cliente == null) {
              System.out.println("4A. Entrando no bloco cliente null");
          %>
              <!-- Botão de Cadastro/Login quando não há sessão -->
              <button id="auth-btn" class="auth-btn" onclick="window.location.href='login.html'">Cadastro / Login</button>
          <%
          } else {
              System.out.println("4B. Entrando no bloco cliente existe");
              System.out.println("Nome do cliente: " + cliente.getNome());
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
              <!-- Botão de Perfil e Menu quando há sessão -->
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
              <% System.out.println("6. Div do perfil gerada"); %>
          <%
          }
          System.out.println("7. Fim da verificação");
          %>
      </div>
        <button id="theme-toggle" class="theme-toggle" aria-label="Alternar tema">
            <span class="icon">☀️</span>
        </button>
    </header>

    <!-- Corpo principal -->
    <main>
      <!-- Palco em Cena (sofreu alteração) -->
      <section class="EventosEmAlta">
          <h2>Palco em Cena</h2>
          <div class="carrossel">
              <div class="carrossel-track">
                  <div class="image-container">
                      <img src="img/vivaelvisexperience.png" alt="Evento 1">
                      <div class="overlay">
                          <h3>Viva Elvis Experience</h3>
                          <p>“Viva Elvis Experience”, interpretado por Alex Ferrera, é um espetáculo musical que contempla 20 anos de carreira de Elvis Presley, desde sua ascensão à fama na década de 1950, até as suas fabulosas e inesquecíveis apresentações nos anos 70.</p>
                          <a href="sessoescinemas.jsp">
                              <button><a href="EventoDetalheServlet?id=1">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/o-rei-leao-cartaz.webp" alt="Evento 2">
                      <div class="overlay">
                          <h3>Rei Leão, O Musical</h3>
                          <p>Rei Leão, O Musical é um musical encantador, baseado na obra teatral, de domínio público, “Hamlet”, do famoso dramaturgo inglês William Shakespeare, e que ganhou uma nova adaptação independente criada pela mesma produtora de grandiosos espetáculos de circulação nacional e internacional.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=2">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/captura_de_tela_2024-11-22_155210.webp" alt="Evento 3">
                      <div class="overlay">
                          <h3>Rafael Portugal - Tô só Desabafando</h3>
                          <p>Se você acha que já riu de tudo, vai se surpreender com Rafael Portugal. O humorista apresenta no seu espetáculo inédito ‘Tô Só Desabafando’, a rapidez do stand up aliada à criatividade na composição de um personagem inusitado.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=7">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/les-mis.webp" alt="Evento 4">
                      <div class="overlay">
                          <h3>Les Misérables</h3>
                          <p>Viva um espetáculo inesquecível no West End the Londres, com Les Misérables (os Miseráveis) em sua aclamada versão musical. Baseada na famosa obra de Victor Hugo, Les Mis é um conto sobre o amor, o sacrifício e poder da redenção.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=5">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/DOM-1.jpg" alt="Evento 5">
                      <div class="overlay">
                          <h3>Dom Quixote de Lugar Nenhum</h3>
                          <p>O musical "Dom Quixote de Lugar Nenhum", inspirado na obra de Miguel de Cervantes, é uma produção do diretor Ruy Guerra e conta com a trilha sonora de Zeca Baleiro. A montagem é estrelada por Lucas Leto e Claudia Ohana e traz uma interpretação nordestina da história clássica.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=6">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/diego-1080-988x1080.jpg" alt="Evento 6">
                      <div class="overlay">
                          <h3>Diego Besou em: Pronto! Socorro!</h3>
                          <p>O enfermeiro Diego Besou apresenta Pronto! Socoorro!, um espetáculo como você nunca viu sobre a área da saúde. Afinal, as coisas que acontecem em um pronto-socorro até Deus duvida!</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=8">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/Capa-CD.webp" alt="Evento 7">
                      <div class="overlay">
                          <h3>A Casa de Bernarda Alba</h3>
                          <p>A Casa de Bernarda Alba é a última peça teatral - a terceira da trilogia de dramas folclóricos - do escritor espanhol Federico García Lorca. Também integram a trilogia as peças Bodas de Sangue e Yerma.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=4">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/20110905.webp" alt="Evento 8">
                      <div class="overlay">
                          <h3>Cats</h3>
                          <p>Cats, uma adaptação livre do musical da Broadway, conta a história de uma tribo de gatos, chamado Jellicle – palavra que só eles sabem o devido significado – que se reúnem uma vez por ano no Jellicle Ball para saberem quem, entre eles, será o escolhido por seu velho e sábio líder Deuteronômio para ir a um lugar mágico e poder renascer para uma nova vida Jellicle.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=3">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
              </div>
              <button class="carrossel-button prev">&#10094;</button>
              <button class="carrossel-button next">&#10095;</button>
          </div>
      </section>

      <!-- Filmes em Alta -->
    <section class="FilmesEmAlta">
    <h2>Filmes em Cartaz</h2>
    <div class="carrossel">
      <div class="carrossel-track">
          <div class="slide">
              <div class="image-container">
                  <img src="img/todo-tempo-que-temos1.jpg" alt="Filme 1">
                  <div class="overlay">
                      <h3>Todo Tempo que Temos</h3>
                      <p>Almut e Tobias são unidos por um encontro surpresa que muda suas vidas. Ao embarcarem em um caminho desafiado pelos limites do tempo, eles aprendem a valorizar cada momento de sua história de amor não convencional.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=9">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/venom3-corrigido.jpg" alt="Filme 2">
                  <div class="overlay">
                      <h3>Venom 3 - A Última Rodada</h3>
                      <p>Eddie e Venom devem tomar uma decisão devastadora enquanto são perseguidos por um misterioso homem.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=10">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/wicked-posterportrait.webp" alt="Filme 3">
                  <div class="overlay">
                      <h3>Wicked</h3>
                      <p>Na Terra de Oz, uma jovem chamada Elphaba forma uma improvável amizade com uma estudante popular chamada Glinda. Após um encontro com o Mágico de Oz, o relacionamento delas logo chega a uma encruzilhada.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=11">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/ainda.jpg" alt="Filme 4">
                  <div class="overlay">
                      <h3>Ainda Estou Aqui</h3>
                      <p>No início da década de 1970, o Brasil enfrenta o endurecimento da ditadura militar. No Rio de Janeiro, a família Paiva - Rubens, Eunice e seus cinco filhos - vive à beira da praia em uma casa de portas abertas para os amigos. Um dia, Rubens Paiva é levado por militares à paisana e desaparece.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=12">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/6ce3721e81afccfcf8c878de07b317e5.jpg" alt="Filme 5">
                  <div class="overlay">
                      <h3>O Senhor dos Anéis: A Guerra dos Rohirrim</h3>
                      <p>Um ataque repentino de Wulf, um implacável senhor Dunlending, força Helm Mão-de-Martelo e seu povo a fazer uma última resistência na antiga fortaleza de Hornburg. Encontrando-se em uma situação desesperadora, a filha de Helm lidera a resistência.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=16">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/a-forja-o-poder-da-transformacao-posterportrait.webp" alt="Filme 6">
                  <div class="overlay">
                      <h3>A Forja: O Poder da Transformação</h3>
                      <p>Um ano depois de terminar o ensino médio e sem planos para o futuro, Isaiah é desafiado por sua mãe solteira e um empresário de sucesso a começar um relacionamento com Deus para traçar um rumo melhor para sua vida.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=14">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/herege-posterportrait.webp" alt="Filme 7">
                  <div class="overlay">
                      <h3>Herege</h3>
                      <p>Em HEREGE, duas jovens missionárias devotas acabam presas na casa de um homem misterioso (Hugh Grant). Elas são forçadas a participar de um jogo perturbador que desafia sua fé e põe em xeque tudo o que acreditam.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=13">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/image.jpg" alt="Filme 8">
                  <div class="overlay">
                      <h3>A Maldição da Chorona</h3>
                      <p>Na Los Angeles da década de 1970, uma assistente social criando seus dois filhos sozinha depois de ser deixada viúva começa a ver semelhanças entre um caso que está investigando e a entidade sobrenatural La Llorona.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=17">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
          <div class="slide">
              <div class="image-container">
                  <img src="img/guldcsha8aivddc.jpg" alt="Filme 9">
                  <div class="overlay">
                      <h3>Moana 2</h3>
                      <p>Moana viaja para os mares distantes depois de receber uma ligação inesperada de seus ancestrais.</p>
                      <a href="sessoescinemas.jsp">
                        <button><a href="EventoDetalheServlet?id=15">Comprar Ingresso</a></button>
                          </a>
                  </div>
              </div>
          </div>
      </div>
      <button class="carrossel-button prev">&#10094;</button>
      <button class="carrossel-button next">&#10095;</button>
    </div>
    </section>


      <!-- Estreando -->
      <section class="Estreando">
          <h2>Em Estreia</h2>
          <div class="carrossel">
              <div class="carrossel-track">
                  <div class="image-container">
                      <img src="img/solo leveling.webp" alt="Estreia 1">
                      <div class="overlay">
                          <h3>Solo Leveling: Segundo Despertar</h3>
                          <p>Há mais de uma década, surgiu uma misteriosa passagem chamada "portal" que conecta este mundo a uma dimensão diferente, o que fez com que pessoas despertassem poderes únicos e ganhassem o nome de "caçadores". Os caçadores usam seus poderes sobre-humanos para conquistar masmorras dentro dos portais e assim ganhar a vida.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=18">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/mufasaoreileao.jpg" alt="Estreia 2">
                      <div class="overlay">
                          <h3>Mufasa: O Rei Leão</h3>
                          <p>Mufasa, um filhote órfão, perdido e sozinho, conhece um simpático leão chamado Taka, herdeiro de uma linhagem real. O encontro ao acaso dá início a uma grande jornada de um grupo extraordinário de deslocados em busca de seu destino, além de revelar a ascensão de um dos maiores reis das Terras do Orgulho.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=19">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/Kraven_the_Hunter_poster.jpg" alt="Estreia 3">
                      <div class="overlay">
                          <h3>Kraven, O Caçador</h3>
                          <p>O imigrante russo Sergei Kravinoff tem a missão de provar que é o maior caçador do mundo.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=21">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/sonic3.webp" alt="Estreia 4">
                      <div class="overlay">
                          <h3>Sonic 3 - O Filme</h3>
                          <p>Sonic está pronto para mais liberdade, mas o Dr. Robotnik (Jim Carrey) retorna para um embate final.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=23">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/avatar3.png" alt="Estreia 5">
                      <div class="overlay">
                          <h3>Avatar 3: Fogo e Cinzas </h3>
                          <p>Apelidado provisóriamente como Avatar: The Seed Bearer, seguiremos Jake Sully (Sam Worthington), Neytiri (Zoe Saldana) com seus filhos em uma nova tribo Na'vi, provavelmente que tenha relações com o fogo ou cinzas, apelidade de "Ash People" ou "Povo das Cinzas" pelo diretor. O novo povo será antagonista do longa.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=22">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/o_auto_da_compadecida_2_cartaz__6g01u50y.jpg" alt="Estreia 6">
                      <div class="overlay">
                          <h3>Auto da Compadecida 2</h3>
                          <p>Os malandros João Grilo e Chicó retornam 25 anos depois da sua última aventura.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=20">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/images.jpg" alt="Estreia 6">
                      <div class="overlay">
                          <h3>O Conde de Monte Cristo</h3>
                          <p>Edmond Dantes é preso por um crime que não cometeu. Após 14 anos na prisão, ele consegue realizar uma fuga ousada. Agora rico além dos seus sonhos, ele assume a identidade do Conde de Monte Cristo e executa sua vingança.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=24">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
                  <div class="image-container">
                      <img src="img/Quando-a-Morte-Sussurra-2.jpg" alt="Estreia 6">
                      <div class="overlay">
                          <h3>Quando a Morte Sussurra 2</h3>
                          <p>Em 1975, Yak continua sua busca pelo espírito maligno que tirou a vida de sua irmã três anos antes. Ignorando os pedidos da família para que desista, Yak descobre que o espírito é controlado por um xamã escondido numa floresta perigosa e mística.</p>
                          <a href="sessoescinemas.jsp">
                            <button><a href="EventoDetalheServlet?id=25">Comprar Ingresso</a></button>
                          </a>
                      </div>
                  </div>
              </div>
              <button class="carrossel-button prev">&#10094;</button>
              <button class="carrossel-button next">&#10095;</button>
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