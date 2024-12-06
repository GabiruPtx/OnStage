const track = document.querySelector('.carrossel-track');
const prevButton = document.querySelector('.carrossel-button.prev');
const nextButton = document.querySelector('.carrossel-button.next');

const items = document.querySelectorAll('.image-container');
const itemWidth = items[0].getBoundingClientRect().width;

// Adiciona espaçamento adicional ao cálculo da largura
const gap = parseInt(getComputedStyle(track).gap) || 0;

// Ajusta o índice inicial
let currentIndex = 1;

// Configura o estilo inicial
track.style.transform = `translateX(-${(itemWidth + gap) * currentIndex}px)`;

// Função para mover o carrossel
function moveCarrossel(index) {
  track.style.transition = 'transform 0.5s ease';
  track.style.transform = `translateX(-${(itemWidth + gap) * index}px)`;
  currentIndex = index;

  // Reseta a posição após a transição
  track.addEventListener('transitionend', () => {
    if (currentIndex === 0) {
      track.style.transition = 'none';
      currentIndex = items.length - 2; // Pula para o final real
      track.style.transform = `translateX(-${(itemWidth + gap) * currentIndex}px)`;
    } else if (currentIndex === items.length - 1) {
      track.style.transition = 'none';
      currentIndex = 1; // Pula para o início real
      track.style.transform = `translateX(-${(itemWidth + gap) * currentIndex}px)`;
    }
  });
}

// Botões de navegação
prevButton.addEventListener('click', () => moveCarrossel(currentIndex - 1));
nextButton.addEventListener('click', () => moveCarrossel(currentIndex + 1));

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

// Funções para o carrossel
document.querySelectorAll('.carrossel').forEach((carrossel) => {
  const track = carrossel.querySelector('.carrossel-track');
  const images = Array.from(track.children);
  const prevButton = carrossel.querySelector('.carrossel-button.prev');
  const nextButton = carrossel.querySelector('.carrossel-button.next');
  let currentIndex = 0;

  function updateCarousel() {
    const carrosselWidth = carrossel.offsetWidth; // Largura do contêiner
    track.style.transform = `translateX(-${currentIndex * (carrosselWidth / 2)}px)`; // Move o carrossel
  }

  nextButton.addEventListener('click', () => {
    currentIndex = (currentIndex + 1) % Math.ceil(images.length / 2); // Volta ao início após o fim
    updateCarousel();
  });

  prevButton.addEventListener('click', () => {
    currentIndex = (currentIndex - 1 + Math.ceil(images.length / 2)) % Math.ceil(images.length / 2); // Vai ao final após o início
    updateCarousel();
  });

  // Redimensionamento responsivo
  window.addEventListener('resize', updateCarousel);

  // Inicializa o carrossel
  updateCarousel();
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