document.addEventListener("DOMContentLoaded", () => {
    const themeToggle = document.getElementById("theme-toggle");
    const seatList = document.getElementById("seat-list");
    const paymentForm = document.getElementById("payment-form");
    const cardInputs = document.querySelectorAll(".card-details input");
    const paymentMethods = document.querySelectorAll('input[name="payment"]');
    const pixCode = document.getElementById("pix-code");

    // Alterna tema claro/escuro
    themeToggle.addEventListener("click", () => {
        document.body.classList.toggle("dark-theme");
        themeToggle.querySelector(".icon").textContent = 
            document.body.classList.contains("dark-theme") ? "☀️" : "🌙";
    });

    // Preenche lista de assentos do localStorage
    const selectedSeats = JSON.parse(localStorage.getItem("selectedSeats")) || [];
    selectedSeats.forEach(seat => {
        const li = document.createElement("li");
        li.textContent = seat;
        seatList.appendChild(li);
    });

    // Alterna obrigatoriedade dos campos do cartão e gera código PIX
    paymentMethods.forEach(method => {
        method.addEventListener("change", () => {
            const isCard = document.querySelector('input[name="payment"]:checked').value === "card";
            cardInputs.forEach(input => {
                input.required = isCard;
                input.disabled = !isCard;
            });

            if (!isCard) {
                const randomPixCode = `PIX-${Math.random().toString(36).substring(2, 10).toUpperCase()}`;
                pixCode.textContent = `Use o seguinte código PIX: ${randomPixCode}`;
            } else {
                pixCode.textContent = "";
            }
        });
    });

    // Finaliza compra
    paymentForm.addEventListener("submit", (event) => {
        event.preventDefault();
        alert("Seu ingresso será enviado por e-mail ou poderá ser retirado na bilheteria.");
        localStorage.removeItem("selectedSeats");
        window.location.href = "inicial.html";
    });
});
