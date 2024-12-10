document.addEventListener("DOMContentLoaded", () => {
    const themeToggle = document.getElementById("theme-toggle");
    const seatList = document.getElementById("seat-list");
    const paymentForm = document.getElementById("payment-form");
    const cardInputs = document.querySelectorAll(".card-details input");
    const paymentMethods = document.querySelectorAll('input[name="payment"]');
    const pixCode = document.getElementById("pix-code");


    
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

// Javascript para alternar visibilidade dos campos do cartão de débito
document.getElementById("debit-card-toggle").addEventListener("click", function() {
  var debitCardDetails = document.getElementById("debit-card-details");
  if (debitCardDetails.style.display === "none" || debitCardDetails.style.display === "") {
      debitCardDetails.style.display = "block";
      this.innerHTML = "Clique aqui para ocultar o cartão de débito";
  } else {
      debitCardDetails.style.display = "none";
      this.innerHTML = "Clique aqui para preencher o cartão de débito";
  }
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
        window.location.href = "index.html";
    });
});
const ticketTypeRadios = document.querySelectorAll('input[name="ticketType"]');
const cpfContainer = document.getElementById('cpf-container');
const cpfInput = document.getElementById('cpf');

// Atualiza a visibilidade do campo CPF com base no tipo de ingresso selecionado
ticketTypeRadios.forEach(radio => {
    radio.addEventListener('change', () => {
        if (radio.value === 'meia' && radio.checked) {
            cpfContainer.style.display = 'block';
        } else {
            cpfContainer.style.display = 'none';
            cpfInput.value = ''; // Limpa o CPF se o usuário mudar para "inteira"
        }
    });
});
document.addEventListener('DOMContentLoaded', function () {
    console.log("Script carregado com sucesso!");// Verifica se o usuário está logado
    const isLoggedIn = localStorage.getItem('isLoggedIn');
  
    const authButton = document.getElementById('auth-btn'); // Botão de login/cadastro
    const profileMenu = document.getElementById('profile-container'); // Menu de perfil
    const profileName = document.getElementById('profile-name'); // Nome no perfil
    const profileDropdown = document.getElementById('profile-dropdown'); // Dropdown de perfil
  
    if (isLoggedIn === 'true') {
      // Esconde o botão de login/cadastro
      if (authButton) authButton.style.display = 'none';
  
      // Mostra o menu de perfil
      if (profileMenu) profileMenu.style.display = 'flex';
  
      // Opcional: Atualiza o nome no menu de perfil com o email do usuário
      const userEmail = localStorage.getItem('userEmail');
      if (profileName && userEmail) {
        profileName.textContent = userEmail.split('@')[0]; // Exibe apenas o nome do email
      }
    } else {
      // Mostra o botão de login/cadastro se não estiver logado
      if (authButton) authButton.style.display = 'block';
      if (profileMenu) profileMenu.style.display = 'none';
    }
  
    // Adiciona funcionalidade de logout
    const logoutButton = document.getElementById('logout-btn');
    if (logoutButton) {
      logoutButton.addEventListener('click', function () {
        // Limpa o estado de login
        localStorage.removeItem('isLoggedIn');
        localStorage.removeItem('userEmail');
  
        // Atualiza a interface e redireciona
        window.location.href = "index.html"; // Redireciona para a página de índice
      });
    }
  
    // Controle do menu dropdown ao passar o mouse
    profileMenu.addEventListener('mouseenter', function () {
      profileDropdown.classList.remove('hidden');
    });
  
    profileMenu.addEventListener('mouseleave', function () {
      profileDropdown.classList.add('hidden');
    });
  
    // Fecha o menu dropdown se clicar fora dele
    document.addEventListener('click', function (e) {
      if (
        !profileMenu.contains(e.target) &&
        !profileDropdown.contains(e.target)
      ) {
        profileDropdown.classList.add('hidden');
      }
    });
})  