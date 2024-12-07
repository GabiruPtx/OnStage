document.addEventListener('DOMContentLoaded', function () {
  // Verifica se o usuário está logado
  const isLoggedIn = localStorage.getItem('isLoggedIn');

  const authButton = document.getElementById('auth-btn'); // Botão de login/cadastro
  const profileMenu = document.getElementById('profile-container'); // Menu de perfil
  const profileName = document.getElementById('profile-name'); // Nome no perfil
  const profileDropdown = document.getElementById('profile-dropdown'); // Dropdown de perfil

  if (isLoggedIn === 'true') {
    // Esconde o botão de login/cadastro
    if (authButton) authButton.style.display = 'none';

    // Mostra o menu de perfil
    if (profileMenu) profileMenu.style.display = 'flex';

    // Opcional: Atualiza o nome no menu de perfil com o email do usuário
    const userEmail = localStorage.getItem('userEmail');
    if (profileName && userEmail) {
      profileName.textContent = userEmail.split('@')[0]; // Exibe apenas o nome do email
    }
  } else {
    // Mostra o botão de login/cadastro se não estiver logado
    if (authButton) authButton.style.display = 'block';
    if (profileMenu) profileMenu.style.display = 'none';
  }

  // Adiciona funcionalidade de logout
  const logoutButton = document.getElementById('logout-btn');
  if (logoutButton) {
    logoutButton.addEventListener('click', function () {
      // Limpa o estado de login
      localStorage.removeItem('isLoggedIn');
      localStorage.removeItem('userEmail');

      // Atualiza a interface e redireciona
      window.location.href = "index.html"; // Redireciona para a página de índice
    });
  }

  // Controle do menu dropdown ao passar o mouse
  profileMenu.addEventListener('mouseenter', function () {
    profileDropdown.classList.remove('hidden');
  });

  profileMenu.addEventListener('mouseleave', function () {
    profileDropdown.classList.add('hidden');
  });

  // Fecha o menu dropdown se clicar fora dele
  document.addEventListener('click', function (e) {
    if (
      !profileMenu.contains(e.target) &&
      !profileDropdown.contains(e.target)
    ) {
      profileDropdown.classList.add('hidden');
    }
  });

  // Alterna entre os temas (escuro e claro)
  document.getElementById('theme-toggle').addEventListener('click', function () {
    // Alterna as classes de tema
    const isDarkTheme = document.body.classList.toggle('black-theme');
    document.body.classList.toggle('white-theme', !isDarkTheme);

    // Alterar o ícone do botão conforme o tema
    let icon = document.querySelector(".theme-toggle .icon");
    if (isDarkTheme) {
      icon.innerText = "🌙"; // Lua para tema escuro
    } else {
      icon.innerText = "☀️"; // Sol para tema claro
    }
  });

  // Função para editar dados do usuário
  function enableEditing(inputId, buttonId) {
    const input = document.getElementById(inputId);
    const button = document.getElementById(buttonId);

    button.addEventListener('click', function () {
      if (input.disabled) {
        input.disabled = false;
        input.focus();
        button.textContent = 'Salvar';
      } else {
        input.disabled = true;
        button.textContent = 'Editar';
        // Salvar os dados no localStorage (ou enviar para o servidor)
        localStorage.setItem(inputId, input.value);
      }
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    const btnCadastrarCartao = document.getElementById('btn-cadastrar-cartao');
    const popupCartao = document.getElementById('popup-cartao');
    const closePopup = document.getElementById('close-popup');
    const cadastroCartaoForm = document.getElementById('cadastro-cartao-form');
    const cartaoSalvo = document.getElementById('cartao-salvo');
    const cartaoNumero = document.getElementById('cartao-numero');
    const cartaoNome = document.getElementById('cartao-nome');
    const cartaoValidade = document.getElementById('cartao-validade');
  
    // Abre a pop-up quando clica no botão de adicionar cartão
    btnCadastrarCartao.addEventListener('click', function () {
      popupCartao.style.display = 'flex';
    });
  
    // Fecha a pop-up
    closePopup.addEventListener('click', function () {
      popupCartao.style.display = 'none';
    });
  
    // Ao submeter o formulário de cadastro do cartão
    cadastroCartaoForm.addEventListener('submit', function (e) {
      e.preventDefault(); // Impede o envio do formulário padrão
  
      const numeroCartao = document.getElementById('numero-cartao').value;
      const nomeCartao = document.getElementById('nome-cartao').value;
      const validadeCartao = document.getElementById('validade-cartao').value;
      const cvvCartao = document.getElementById('cvv-cartao').value;
  
      // Armazena os dados do cartão no localStorage (ou você pode salvar em um banco de dados)
      localStorage.setItem('numeroCartao', numeroCartao);
      localStorage.setItem('nomeCartao', nomeCartao);
      localStorage.setItem('validadeCartao', validadeCartao);
      localStorage.setItem('cvvCartao', cvvCartao);
  
      // Exibe as informações do cartão salvo
      cartaoNumero.textContent = `Número do Cartão: ${numeroCartao}`;
      cartaoNome.textContent = `Nome no Cartão: ${nomeCartao}`;
      cartaoValidade.textContent = `Validade: ${validadeCartao}`;
  
      // Mostra o cartão salvo e esconde a pop-up
      cartaoSalvo.style.display = 'block';
      popupCartao.style.display = 'none';
    });
  });
  
  
});
