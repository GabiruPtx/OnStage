// Alternância de Tema
document.getElementById('theme-toggle').addEventListener('click', function () {
  const isDarkTheme = document.body.classList.toggle('black-theme');
  document.body.classList.toggle('white-theme', !isDarkTheme);
  let icon = document.querySelector(".theme-toggle .icon");
  icon.innerText = isDarkTheme ? "🌙" : "☀️";
});

// Botão de Perfil
const profileToggle = document.getElementById('profile-toggle');
const profileDropdown = document.getElementById('profile-dropdown');

profileToggle.addEventListener('click', function () {
  profileDropdown.classList.toggle('hidden');
});

// Fecha o menu se clicar fora
document.addEventListener('click', function (e) {
  if (!profileToggle.contains(e.target) && !profileDropdown.contains(e.target)) {
    profileDropdown.classList.add('hidden');
  }
});

// Alterar Senha (Simulação)
document.getElementById('edit-senha').addEventListener('click', function () {
  const senhaInput = document.getElementById('senha');
  const isEditing = !senhaInput.disabled;

  if (isEditing) {
    senhaInput.disabled = true;
    this.textContent = 'Alterar';
    alert('Senha alterada com sucesso!');
  } else {
    senhaInput.disabled = false;
    this.textContent = 'Salvar';
  }
});
