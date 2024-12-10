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

  // Atualizar a logo com base no tema
  const logo = document.querySelector('.logo');
  logo.src = isDarkTheme ? 'img/OS_Logotipo_White.png' : 'img/OS_Logotipo_Black.png';
});

// Funções para o carrossel
document.querySelectorAll('.carrossel').forEach((carrossel) => {
  const track = carrossel.querySelector('.carrossel-track');
  const images = Array.from(track.children);
  const prevButton = carrossel.querySelector('.carrossel-button.prev');
  const nextButton = carrossel.querySelector('.carrossel-button.next');
  const totalImages = images.length;
  const visibleImages = 4; // Quantidade de imagens visíveis no carrossel
  const gap = 7; // Espaçamento entre as imagens
  let currentIndex = 0;

  // Define o layout inicial do carrossel
  function setTrackWidth() {
    const imageWidth = carrossel.offsetWidth / visibleImages - gap;
    images.forEach((image) => {
      image.style.width = `${imageWidth}px`;
    });

    const totalWidth = (imageWidth + gap) * totalImages - gap;
    track.style.width = `${totalWidth}px`;
  }

  // Move para o índice desejado
  function moveToIndex(index) {
    const imageWidth = carrossel.offsetWidth / visibleImages - gap;
    track.style.transition = 'transform 0.5s ease-in-out';
    track.style.transform = `translateX(-${index * (imageWidth + gap)}px)`;
    currentIndex = index;
  }

  // Avança para a próxima imagem
  nextButton.addEventListener('click', () => {
    if (currentIndex === totalImages - visibleImages) {
      // Retorna ao início se estiver no final
      moveToIndex(0);
    } else {
      moveToIndex(currentIndex + 1);
    }
  });

  // Retorna para a imagem anterior
  prevButton.addEventListener('click', () => {
    if (currentIndex === 0) {
      // Vai para o final se estiver no início
      moveToIndex(totalImages - visibleImages);
    } else {
      moveToIndex(currentIndex - 1);
    }
  });

  // Ajusta o carrossel ao redimensionar a tela
  window.addEventListener('resize', () => {
    setTrackWidth();
    moveToIndex(currentIndex); // Reajusta a posição
  });

  // Configurações iniciais
  setTrackWidth();
  moveToIndex(0);
});