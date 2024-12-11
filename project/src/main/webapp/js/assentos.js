document.addEventListener("DOMContentLoaded", () => {
    const seats = document.querySelectorAll(".seat.available");
    const confirmBtn = document.getElementById("confirm-selection");
    let selectedSeats = [];

    // Evento de clique nos assentos disponíveis
    seats.forEach(seat => {
        seat.addEventListener("click", () => {
            if (!seat.classList.contains("reserved")) {
                seat.classList.toggle("selected");
                const seatId = seat.getAttribute("data-seat");
                const seatType = seat.getAttribute("data-tipo");
                
                // Adiciona ou remove o assento da lista
                if (seat.classList.contains("selected")) {
                    selectedSeats.push({
                        id: seatId,
                        tipo: seatType
                    });
                } else {
                    selectedSeats = selectedSeats.filter(item => item.id !== seatId);
                }
            }
        });
    });

    // Função de confirmação de seleção de assentos
    confirmBtn.addEventListener("click", () => {
        if (selectedSeats.length > 0) {
            // Criar um formulário dinamicamente
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'Assento';

            // Adicionar os assentos selecionados como campos hidden
            const assentosInput = document.createElement('input');
            assentosInput.type = 'hidden';
            assentosInput.name = 'assentosSelecionados';
            assentosInput.value = JSON.stringify(selectedSeats);
            form.appendChild(assentosInput);

            // Adicionar o ID da sessão (assumindo que está disponível na URL)
            const sessaoId = document.getElementById('sessao-id').value;
            const sessaoInput = document.createElement('input');
            sessaoInput.type = 'hidden';
            sessaoInput.name = 'sessaoId';
            sessaoInput.value = sessaoId;
            console.log(sessaoId);
            form.appendChild(sessaoInput);

            // Adicionar o formulário ao documento e enviá-lo
            document.body.appendChild(form);
            form.submit();
        } else {
            alert("Selecione pelo menos um assento!");
        }
    });
});

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