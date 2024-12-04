// Selecionar o botão
const themeToggleButton = document.getElementById("theme-toggle");

// Selecionar as seções e outros elementos que serão estilizados
const sections = document.querySelectorAll("section");
const menuButton = document.querySelector(".menu-button");
const authButton = document.querySelector(".auth-btn");
const footer = document.querySelector(".footer");

// Paletas de cores para os temas
const themeColors = {
    light: {
        body: "#ffffff",
        text: "#000000",
        sections: ["#e6e6fa", "#30d5c8", "#3f51b5", "#2e2e2e", "#e6e6fa"],
        menuButton: "#3f51b5",
        authButton: "#3f51b5",
        footer: "#2e2e2e"
    },
    dark: {
        body: "#121212",
        text: "#ffffff",
        sections: ["#2e2e2e", "#30d5c8", "#3f51b5", "#2e2e2e", "#3f51b5"],
        menuButton: "#1e88e5",
        authButton: "#1e88e5",
        footer: "#333333"
    }
};

// Função para aplicar as cores do tema
function applyThemeColors(theme) {
    console.log(`Aplicando tema: ${theme}`);
    const colors = themeColors[theme];

    // Alterar cor de fundo do body e do texto
    document.body.style.backgroundColor = colors.body;
    document.body.style.color = colors.text;

    // Alterar as cores das seções dinamicamente
    sections.forEach((section, index) => {
        const color = colors.sections[index % colors.sections.length]; // Cor atual baseada no índice
        section.style.backgroundColor = color;
        console.log(`Seção ${index + 1}: Aplicando cor ${color}`);
    });

    // Alterar cores dos botões
    menuButton.style.backgroundColor = colors.menuButton;
    authButton.style.backgroundColor = colors.authButton;

    // Alterar cor do rodapé
    footer.style.backgroundColor = colors.footer;
}

// Alternar tema
themeToggleButton.addEventListener("click", () => {
    // Detectar o tema atual e alternar
    const isDarkTheme = document.body.classList.toggle("dark-theme");
    const currentTheme = isDarkTheme ? "dark" : "light";

    // Salvar a escolha do tema no localStorage
    localStorage.setItem('theme', currentTheme); // Salva o tema

    // Aplicar as cores do tema
    applyThemeColors(currentTheme);

    // Alterar o ícone do botão
    const icon = themeToggleButton.querySelector(".icon");
    icon.textContent = isDarkTheme ? "🌙" : "☀️";
});

// Verifica o tema no carregamento da página
document.addEventListener("DOMContentLoaded", () => {
    const storedTheme = localStorage.getItem('theme') || 'light';
    document.body.classList.toggle("dark-theme", storedTheme === 'dark');
    applyThemeColors(storedTheme);
    const icon = themeToggleButton.querySelector(".icon");
    icon.textContent = storedTheme === 'dark' ? "🌙" : "☀️";
});
