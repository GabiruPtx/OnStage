const showLogin = document.getElementById('showLogin');
const showSignUp = document.getElementById('showSignUp');
const container = document.getElementById('container');

showLogin.addEventListener('click', () => {
    container.classList.remove('right-panel-active');
});

showSignUp.addEventListener('click', () => {
    container.classList.add('right-panel-active');
});