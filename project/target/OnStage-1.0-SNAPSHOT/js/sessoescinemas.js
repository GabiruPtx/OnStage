// Função para obter os parâmetros da URL
function getQueryParams() {
    const params = new URLSearchParams(window.location.search);
    return {
        nome: params.get('nome') || "Nome do filme não encontrado",
        imagem: params.get('imagem') || "img/default-poster.jpg",
        sinopse: params.get('sinopse') || "Sinopse não disponível",
        genero: params.get('genero') || "Gênero não especificado",
        duracao: params.get('duracao') || "Duração não especificada"
    };
}

// Renderizar as informações do filme na página
function renderizarFilme() {
    const { nome, imagem, sinopse, genero, duracao } = getQueryParams();

    // Atualizar os elementos da página
    document.getElementById('filme-nome').textContent = nome;
    document.getElementById('filme-poster').src = imagem;
    document.getElementById('filme-poster').alt = `Poster do filme ${nome}`;
    document.getElementById('filme-descricao').textContent = sinopse;
    document.getElementById('filme-genero').textContent = genero;
    document.getElementById('filme-duracao').textContent = `Duração: ${duracao}`;
}

// Inicializar ao carregar
document.addEventListener('DOMContentLoaded', renderizarFilme);
