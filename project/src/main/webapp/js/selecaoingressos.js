// Alterna entre os temas (escuro e claro)
document.getElementById('theme-toggle').addEventListener('click', function () {
    // Verificar se o body existe
    if (!document.body) return;

    // Alterna as classes de tema
    const isDarkTheme = document.body.classList.toggle('dark-theme');
    document.body.classList.toggle('light-theme', !isDarkTheme);

    // Alterar o ícone do botão conforme o tema
    const icon = document.querySelector(".theme-toggle .icon");
    if (icon) {
        icon.innerText = isDarkTheme ? "🌙" : "☀️"; // Lua para escuro, Sol para claro
    }

    // Atualizar a logo com base no tema
    const logo = document.querySelector('.logo');
    if (logo) {
        logo.src = isDarkTheme ? 'img/OS_Logotipo_White.png' : 'img/OS_Logotipo_Black.png';
    }
});
