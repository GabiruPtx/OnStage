document.getElementById('theme-toggle').addEventListener('click', function () {
  document.body.classList.toggle('black-theme');
  document.body.classList.toggle('white-theme');
});
//Pode acabar saindo
themeToggleButton.addEventListener("click", () => {
  // Alterna entre os temas adicionando/removendo classes no <body>
  const isDarkTheme = document.body.classList.toggle("black-theme");
  document.body.classList.toggle("white-theme", !isDarkTheme);

  // Atualiza o ícone do botão baseado no tema
  const icon = themeToggleButton.querySelector(".icon");
  icon.textContent = isDarkTheme ? "🌙" : "☀️";
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
