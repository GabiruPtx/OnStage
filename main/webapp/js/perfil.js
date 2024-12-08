document.addEventListener('DOMContentLoaded', function () {
  console.log("Script carregado com sucesso!");// Verifica se o usuário está logado
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
});
document.addEventListener('DOMContentLoaded', function () {
  console.log("DOM completamente carregado!");

  const btnCadastrarCartao = document.getElementById('btn-cadastrar-cartao');
  const popupCartao = document.getElementById('popup-cartao');
  const closePopup = document.getElementById('close-popup');
  const cadastroCartaoForm = document.getElementById('cadastro-cartao-form');
  const cartaoSalvo = document.getElementById('cartao-salvo');
  const cartaoNumero = document.getElementById('cartao-numero');
  const cartaoNome = document.getElementById('cartao-nome');
  const cartaoValidade = document.getElementById('cartao-validade');

  // Verifica se elementos necessários existem antes de manipular
  if (btnCadastrarCartao && popupCartao) {
      btnCadastrarCartao.addEventListener('click', function () {
          console.log("Abrindo pop-up de cadastro...");
          popupCartao.style.display = 'flex';
      });
  }

  if (closePopup && popupCartao) {
      closePopup.addEventListener('click', function () {
          console.log("Fechando pop-up...");
          popupCartao.style.display = 'none';
      });
  }

  if (cadastroCartaoForm) {
      cadastroCartaoForm.addEventListener('submit', function (e) {
          e.preventDefault();

          const numeroCartao = document.getElementById('numero-cartao')?.value || '';
          const nomeCartao = document.getElementById('nome-cartao')?.value || '';
          const validadeCartao = document.getElementById('validade-cartao')?.value || '';

          if (cartaoNumero && cartaoNome && cartaoValidade && cartaoSalvo) {
              cartaoNumero.textContent = `Número do Cartão: ${numeroCartao}`;
              cartaoNome.textContent = `Nome no Cartão: ${nomeCartao}`;
              cartaoValidade.textContent = `Validade: ${validadeCartao}`;
              cartaoSalvo.style.display = 'block';
          } else {
              console.error("Elementos necessários para exibir o cartão salvo não foram encontrados!");
          }

          popupCartao.style.display = 'none';
          cadastroCartaoForm.reset();
      });
  }

  // Adicionar mais verificações, se necessário
  document.querySelectorAll('.some-selector').forEach(function (element) {
      if (element && element.classList.contains('some-class')) {
          console.log("Elemento com classe encontrado!");
      }
  });
});


    // Função para ativar edição de um campo
    function toggleEditField(inputElement) {
      inputElement.disabled = !inputElement.disabled;
  }

  // Lógica para os botões de "Editar" dos dados pessoais
  const editEmailBtn = document.getElementById('edit-email');
  const editSenhaBtn = document.getElementById('edit-senha');
  const editTelefoneBtn = document.getElementById('edit-telefone');
  const editDataNascimentoBtn = document.getElementById('edit-data-nascimento');
  
  if (editEmailBtn) {
      editEmailBtn.addEventListener('click', function () {
          const emailInput = document.getElementById('email');
          toggleEditField(emailInput);
      });
  }

  if (editSenhaBtn) {
      editSenhaBtn.addEventListener('click', function () {
          const senhaInput = document.getElementById('senha');
          toggleEditField(senhaInput);
      });
  }

  if (editTelefoneBtn) {
      editTelefoneBtn.addEventListener('click', function () {
          const telefoneInput = document.getElementById('telefone');
          toggleEditField(telefoneInput);
      });
  }

  if (editDataNascimentoBtn) {
      editDataNascimentoBtn.addEventListener('click', function () {
          const dataNascimentoInput = document.getElementById('data-nascimento');
          toggleEditField(dataNascimentoInput);
      });
  }

  // Lógica para o botão de "Editar Endereço"
  const editEnderecoBtn = document.getElementById('edit-endereco');
  if (editEnderecoBtn) {
      editEnderecoBtn.addEventListener('click', function () {
          const enderecoInputs = document.querySelectorAll('#endereco-form input');
          enderecoInputs.forEach(function(input) {
              toggleEditField(input);
          });
      });
  }

