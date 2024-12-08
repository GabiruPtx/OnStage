 // Verifica se o usuário está logado
 const isLoggedIn = localStorage.getItem('isLoggedIn');

 const authButton = document.getElementById('auth-btn'); // Botão de login/cadastro
 const profileMenu = document.getElementById('profile-container'); // Menu de perfil

 if (isLoggedIn === 'true') {
     // Esconde o botão de login/cadastro
     if (authButton) authButton.style.display = 'none';

     // Mostra o menu de perfil
     if (profileMenu) profileMenu.style.display = 'block';

     // Opcional: Atualiza o nome no menu de perfil com o email do usuário
     const userEmail = localStorage.getItem('userEmail');
     const profileName = document.getElementById('profile-name');
     if (profileName && userEmail) {
         profileName.textContent = userEmail.split('@')[0]; // Exibe apenas o nome do email
     }
 } else {
     // Mostra o botão de login/cadastro se não estiver logado
     if (authButton) authButton.style.display = 'block';
     if (profileMenu) profileMenu.style.display = 'none';
 }

document.addEventListener('DOMContentLoaded', function() {
 const logoutButton = document.getElementById('logout-btn');

 if (logoutButton) {
     logoutButton.addEventListener('click', function() {
         // Limpa o estado de login
         localStorage.removeItem('isLoggedIn');
         localStorage.removeItem('userEmail');

         // Atualiza a interface
         window.location.href = "index.html"; // Redireciona para a página de índice
     });
 }
});



// Fecha o menu se clicar fora
document.addEventListener('click', function (e) {
 if (!profileToggle.contains(e.target) && !profileDropdown.contains(e.target)) {
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
