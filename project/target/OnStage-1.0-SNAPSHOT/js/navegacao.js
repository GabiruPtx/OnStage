// Seleciona o botão de autenticação
document.addEventListener('DOMContentLoaded', function() {
    const authButton = document.querySelector('.auth-btn');

    // Adiciona o evento de clique ao botão
    authButton.addEventListener('click', function() {
        // Redireciona para a página de autenticação
        window.location.href = 'auth.html';
    });
});