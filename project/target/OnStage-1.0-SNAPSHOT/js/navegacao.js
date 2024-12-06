//Arquivo responsável por todos os botões interativos da página

document.addEventListener('DOMContentLoaded', function() {
    // Objeto com mapeamento de botões e suas páginas destino
    const buttonRedirects = {
        '.cadastro-btn': 'cadastro.html',
        '.auth-btn': 'login.html',
        '.login-btn': 'login.html',
        '.home-btn': 'index.html',
        '.perfil-btn': 'perfil.html'
        // Adicione mais botões conforme necessário
    };

    // Função para adicionar eventos de redirecionamento
    Object.entries(buttonRedirects).forEach(([selector, page]) => {
        const button = document.querySelector(selector);
        if (button) {
            button.addEventListener('click', () => window.location.href = page);
        }
    });
});