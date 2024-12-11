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