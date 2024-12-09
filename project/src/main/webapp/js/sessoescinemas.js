document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".filter-button");
  const cinemaDays = document.querySelectorAll(".cinema-day");

  buttons.forEach(button => {
      button.addEventListener("click", () => {
          const date = button.getAttribute("data-date");

          // Ocultar todas as sessões
          cinemaDays.forEach(day => day.style.display = "none");

          // Mostrar apenas as sessões correspondentes
          const activeDay = document.querySelector(`.cinema-day[data-date="${date}"]`);
          if (activeDay) {
              activeDay.style.display = "block";
          }
      });
  });
});

document.getElementById("toggle-sobre").addEventListener("click", function() {
  const sinopseConteudo = document.getElementById("sinopse-conteudo");
  if (sinopseConteudo.style.display === "none" || sinopseConteudo.style.display === "") {
      sinopseConteudo.style.display = "block"; // Exibe a aba
  } else {
      sinopseConteudo.style.display = "none"; // Esconde a aba
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

  // Atualizar a logo com base no tema
  const logo = document.querySelector('.logo');
  logo.src = isDarkTheme ? 'img/OS_Logotipo_White.png' : 'img/OS_Logotipo_Black.png';
});


