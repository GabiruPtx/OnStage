document.addEventListener("DOMContentLoaded", () => {
    const seats = document.querySelectorAll(".seat.available");
    const confirmBtn = document.getElementById("confirm-selection");
    let selectedSeats = [];

    // Evento de clique nos assentos disponíveis
    seats.forEach(seat => {
        seat.addEventListener("click", () => {
            if (!seat.classList.contains("reserved")) {
                seat.classList.toggle("selected");
                const seatNumber = seat.textContent;
                
                // Adiciona ou remove o assento da lista
                if (seat.classList.contains("selected")) {
                    selectedSeats.push(seatNumber);
                } else {
                    selectedSeats = selectedSeats.filter(item => item !== seatNumber);
                }
            }
        });
    });

    // Função de confirmação de seleção de assentos
    confirmBtn.addEventListener("click", () => {
        if (selectedSeats.length > 0) {
            // Armazena os assentos no localStorage
            localStorage.setItem("selectedSeats", JSON.stringify(selectedSeats));
            window.location.href = "checkout.html"; // Redireciona para a página de checkout
        } else {
            alert("Selecione pelo menos um assento!");
        }
    });
});