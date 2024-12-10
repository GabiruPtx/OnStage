const plusButtons = document.querySelectorAll('.quantity-btn');
const totalElement = document.querySelector('.total p:last-child'); // Total no resumo

const ticketPrices = {
    "Inteira": 31.88,
    "Meia Estudante": 17.88,
    "Meia Criança": 17.88,
    "Meia - Pessoa Idosa": 17.88,
    "Meia Entrada - Pessoa com Deficiência": 17.88
};

// Função para atualizar o total
function updateTotal() {
    let total = 0;

    // Para cada tipo de ingresso
    document.querySelectorAll('.ticket').forEach((ticket, index) => {
        const quantity = parseInt(ticket.querySelector('.quantity-input').value);
        const price = Object.values(ticketPrices)[index]; // Preço do ingresso
        total += quantity * price; // Calcula o total para o tipo de ingresso
    });

    // Atualiza o total no HTML
    totalElement.textContent = `Total: R$ ${total.toFixed(2)}`;
}

// Adiciona os ouvintes de evento para os botões de quantidade
plusButtons.forEach(button => {
    button.addEventListener('click', (e) => {
        const input = e.target.parentElement.querySelector('.quantity-input');
        let currentValue = parseInt(input.value);

        if (e.target.innerText === "+") {
            input.value = currentValue + 1;
        } else if (e.target.innerText === "-" && currentValue > 0) {
            input.value = currentValue - 1;
        }

        updateTotal(); // Atualiza o total após mudança na quantidade
    });
});

// Inicializa o total ao carregar a página
updateTotal();

