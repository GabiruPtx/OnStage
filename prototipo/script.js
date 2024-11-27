// Alternar temas
document.getElementById('theme-black').addEventListener('click', function () {
  document.body.classList.remove('white-theme');
  document.body.classList.add('black-theme');
});

document.getElementById('theme-white').addEventListener('click', function () {
  document.body.classList.remove('black-theme');
  document.body.classList.add('white-theme');
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
