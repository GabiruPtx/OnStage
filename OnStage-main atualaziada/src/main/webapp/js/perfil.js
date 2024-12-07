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

  enableEditing('nome', 'edit-nome');
  enableEditing('cpf', 'edit-cpf');
  enableEditing('email', 'edit-email');
  enableEditing('senha', 'edit-senha');

  // Função para cadastrar cartão
  const cadastroCartaoForm = document.getElementById('cadastro-cartao-form');
  cadastroCartaoForm.addEventListener('submit', function (e) {
    e.preventDefault();
    const numeroCartao = document.getElementById('numero-cartao').value;
    const nomeCartao = document.getElementById('nome-cartao').value;
    const validadeCartao = document.getElementById('validade-cartao').value;
    const cvvCartao = document.getElementById('cvv-cartao').value;

    // Salvar os dados do cartão no localStorage (ou enviar para o servidor)
    localStorage.setItem('numeroCartao', numeroCartao);
    localStorage.setItem('nomeCartao', nomeCartao);
    localStorage.setItem('validadeCartao', validadeCartao);
    localStorage.setItem('cvvCartao', cvvCartao);

    // Exibir os dados do cartão cadastrado
    document.getElementById('cartao-numero').textContent = `Número do Cartão: ${numeroCartao}`;
    document.getElementById('cartao-nome').textContent = `Nome no Cartão: ${nomeCartao}`;
    document.getElementById('cartao-validade').textContent = `Validade: ${validadeCartao}`;
    document.getElementById('cartao-cadastrado').style.display = 'block';
  });

  // Função para exibir o formulário de cadastro de cartão
  const btnCadastrarCartao = document.getElementById('btn-cadastrar-cartao');
  const cadastroCartao = document.getElementById('cadastro-cartao');
  if (btnCadastrarCartao) {
    btnCadastrarCartao.addEventListener('click', function () {
      cadastroCartao.style.display = 'block'; // Exibe o formulário de cadastro de cartão
      btnCadastrarCartao.style.display = 'none'; // Esconde o botão de cadastro após o clique
    });
  }
});
