package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ufrrj.aps.onstage.dao.eventoDAO;
import ufrrj.aps.onstage.dao.sessaoDAO;
import ufrrj.aps.onstage.model.Sessao;
import ufrrj.aps.onstage.model.evento;

@WebServlet("/DetalhesDoEvento")
public class EventoDetalheServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Recuperando o ID do evento passado como parâmetro
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect("erro.jsp");
            return;
        }
    
        // Buscar os dados do evento e das sessões no banco de dados
        eventoDAO eventoDAO = new eventoDAO();
        sessaoDAO sessaoDAO = new sessaoDAO();
        List<Sessao> sessoes = null;
        evento evento = null;
    
        try {
            evento = eventoDAO.buscarEventoPorId(id);
            sessoes = sessaoDAO.getSessoesByEvento(id); // Obtendo as sessões para o evento
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Erro ao buscar dados no banco: " + e.getMessage());
            response.sendRedirect("erro.jsp");
            return;
        }

        System.out.println("ID do evento recebido: " + id);
        System.out.println("Evento encontrado: " + (evento != null ? evento.getTitulo() : "Nenhum"));
        System.out.println("Sessões encontradas: " + (sessoes != null ? sessoes.size() : 0));

        
        if (sessoes == null || sessoes.isEmpty()) {
            System.out.println("Nenhuma sessão encontrada para o evento com ID: " + id);
        }
        
    
        if (evento != null) {
            // Adicionar o evento e as sessões ao request
            request.setAttribute("evento", evento);
            request.setAttribute("sessoes", sessoes);
    
            // Encaminhar para a página JSP com os dados
            RequestDispatcher dispatcher = request.getRequestDispatcher("/sessoescinemas.jsp");
            dispatcher.forward(request, response);
        } else {
            // Redirecionar para uma página de erro se o evento não for encontrado
            response.sendRedirect("erro.jsp");
        }
    }
    
}