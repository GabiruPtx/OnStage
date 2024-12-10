document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login-form'); // Corrigido para corresponder ao ID do formulário

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault(); // Impede o comportamento padrão do formulário

        // Obtém os valores do formulário
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        // Simula login aceitando qualquer email e senha
        if (email && password) {
            // Armazena o estado de login no localStorage
            localStorage.setItem('isLoggedIn', 'true');
            localStorage.setItem('userEmail', email);

            // Redireciona para a página inicial
            window.location.href = 'index.html';
        } else {
            alert('Por favor, preencha todos os campos!');
        }
    });
});
