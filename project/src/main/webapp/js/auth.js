// Espera a página carregar completamente
document.addEventListener('DOMContentLoaded', function() {
    // Encontra o formulário de login na página
    const loginForm = document.getElementById('loginForm');
    
    // Quando o formulário for enviado (quando clicar em "Entrar")
    loginForm.addEventListener('submit', async function(e) {
        // Impede o comportamento padrão do formulário
        e.preventDefault();
        
        // Pega os valores que o usuário digitou
        const formData = {
            email: document.getElementById('email').value,    // O que foi digitado no campo de email
            password: document.getElementById('password').value // O que foi digitado no campo de senha
        };

        try {
            // Envia os dados para o servidor
            const response = await fetch('/OnStage_war/auth', {
                method: 'POST',                    // Tipo de requisição
                headers: {
                    'Content-Type': 'application/json'  // Formato dos dados
                },
                body: JSON.stringify(formData)     // Converte os dados para JSON
            });

            // Se deu tudo certo com a requisição
            if (response.ok) {
                // Redireciona para a página principal
                window.location.href = 'index.html';
            } else {
                // Se algo deu errado, mostra mensagem de erro
                alert('Login falhou');
            }
        } catch (error) {
            // Se houver algum erro na comunicação com o servidor
            alert('Erro ao fazer login');
        }
    });
});