document.addEventListener('DOMContentLoaded', function () {
  console.log("Script carregado com sucesso!");

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
    const isDarkTheme = document.body.classList.toggle('dark-theme');
    document.body.classList.toggle('light-theme', !isDarkTheme);

    // Atualiza a logo conforme o tema
    const logo = document.querySelector('.logo');
    if (logo) {
      logo.src = isDarkTheme ? 'img/OS_Logotipo_White.png' : 'img/OS_Logotipo_Black.png';
    }

    // Alterar o ícone do botão conforme o tema
    let icon = document.querySelector(".theme-toggle .icon");
    if (isDarkTheme) {
        icon.innerText = "🌙"; // Lua para tema escuro
    } else {
        icon.innerText = "☀️"; // Sol para tema claro
    }
});
});
