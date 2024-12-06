// JavaScript corrigido
document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.container');
    const signUpContainer = document.querySelector('.sign-up-container');
    const signInContainer = document.querySelector('.sign-in-container');
    const toggleButtons = document.querySelectorAll('.toggle-btn');

    let isLoginForm = true;

    const toggleForms = () => {
        isLoginForm = !isLoginForm;

        if (!isLoginForm) {
            signUpContainer.style.transform = 'translateX(0)';
            signUpContainer.style.opacity = '1';
            signUpContainer.style.visibility = 'visible';

            signInContainer.style.transform = 'translateX(-100%)';
            signInContainer.style.opacity = '0';
            signInContainer.style.visibility = 'hidden';

            container.style.width = '800px'; // Largura para acomodar o novo formulário, se necessário
        } else {
            signUpContainer.style.transform = 'translateX(100%)';
            signUpContainer.style.opacity = '0';
            signUpContainer.style.visibility = 'hidden';

            signInContainer.style.transform = 'translateX(0)';
            signInContainer.style.opacity = '1';
            signInContainer.style.visibility = 'visible';

            container.style.width = '350px'; // Voltar para o tamanho original
        }
    };

    toggleButtons.forEach(button => {
        button.addEventListener('click', toggleForms);
    });
});