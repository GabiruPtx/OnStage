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
            const urlParams = new URLSearchParams(window.location.search);
            const sessaoId = urlParams.get('id');
            const sessaoInput = document.createElement('input');
            sessaoInput.type = 'hidden';
            sessaoInput.name = 'sessaoId';
            sessaoInput.value = sessaoId;
            form.appendChild(sessaoInput);

            // Adicionar o formulário ao documento e enviá-lo
            document.body.appendChild(form);
            form.submit();
        } else {
            alert("Selecione pelo menos um assento!");
        }
    });
});

// Manter o código do theme-toggle
document.getElementById('theme-toggle').addEventListener('click', function () {
    const isDarkTheme = document.body.classList.toggle('black-theme');
    document.body.classList.toggle('white-theme', !isDarkTheme);
    
    let icon = document.querySelector(".theme-toggle .icon");
    if (isDarkTheme) {
        icon.innerText = "🌙";
    } else {
        icon.innerText = "☀️";
    }
});