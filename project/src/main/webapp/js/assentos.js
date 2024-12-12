document.addEventListener("DOMContentLoaded", () => {
    const seats = document.querySelectorAll(".seat.available");
    const confirmBtn = document.getElementById("confirm-selection");
    let selectedSeats = [];

    // Evento de clique nos assentos disponíveis
    seats.forEach(seat => {
        seat.addEventListener("click", () => {
            if (!seat.classList.contains("reserved")) {
                seat.classList.toggle("selected");
                
                // Capturar todos os atributos do assento de forma segura
                const assentoData = {
                    id: seat.getAttribute("data-seat-id") || '',
                    sala: seat.getAttribute("data-sala-id") || '',
                    fileira: seat.getAttribute("data-fileira") || '',
                    numero: seat.getAttribute("data-numero") || '',
                    tipo: seat.getAttribute("data-tipo") || '',
                    estado: seat.classList.contains("selected") ? "RESERVADO" : (seat.getAttribute("data-estado") || 'DISPONIVEL')
                };
                
                // Verificação de dados antes de adicionar
                if (assentoData.fileira && assentoData.numero) {
                    if (seat.classList.contains("selected")) {
                        selectedSeats.push(assentoData);
                        console.log("Assento adicionado:", assentoData);
                    } else {
                        selectedSeats = selectedSeats.filter(item => item.id !== assentoData.id);
                        console.log("Assento removido:", assentoData.id);
                    }
                    
                    console.log("Lista atual de assentos:", selectedSeats);
                } else {
                    console.error("Dados do assento incompletos:", assentoData);
                }
            }
        });
    });

    // Função de confirmação de seleção de assentos
    confirmBtn.addEventListener("click", () => {
        if (selectedSeats.length > 0) {
            // Debug antes de enviar
            console.log("Enviando assentos:", selectedSeats);
            
            // Criar um formulário dinamicamente
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'Assento';

            // Adicionar os assentos selecionados como campos hidden
            const assentosInput = document.createElement('input');
            assentosInput.type = 'hidden';
            assentosInput.name = 'assentosSelecionados'; // Mudando o nome para corresponder ao servlet
            assentosInput.value = JSON.stringify(selectedSeats);
            form.appendChild(assentosInput);

            // Adicionar o ID da sessão
            const sessaoId = document.getElementById('sessao-id').value;
            const sessaoInput = document.createElement('input');
            sessaoInput.type = 'hidden';
            sessaoInput.name = 'sessaoId';
            sessaoInput.value = sessaoId;
            form.appendChild(sessaoInput);

            // Debug do formulário antes de enviar
            console.log("Dados do formulário:", {
                sessaoId: sessaoId,
                assentos: assentosInput.value
            });

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
    const isDarkTheme = document.body.classList.toggle('black-theme');
    document.body.classList.toggle('white-theme', !isDarkTheme);
  
    let icon = document.querySelector(".theme-toggle .icon");
    if (isDarkTheme) {
        icon.innerText = "🌙";
    } else {
        icon.innerText = "☀️";
    }
  
    const logo = document.querySelector('.logo');
    logo.src = isDarkTheme ? 'img/OS_Logotipo_White.png' : 'img/OS_Logotipo_Black.png';
});