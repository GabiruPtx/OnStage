package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ufrrj.aps.onstage.dao.eventoDAO;
import ufrrj.aps.onstage.model.evento;

@WebServlet("/EventoDetalheServlet")
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

        // Buscar os dados do evento no banco de dados
        eventoDAO eventoDAO = new eventoDAO();
        evento evento = null;

        try {
            evento = eventoDAO.buscarEventoPorId(id);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
            return;
        }

        if (evento != null) {
            // Adicionar o evento ao request
            request.setAttribute("evento", evento);

            // Encaminhar para a página JSP com os dados
            RequestDispatcher dispatcher = request.getRequestDispatcher("/sessoescinemas.jsp");
            dispatcher.forward(request, response);
        } else {
            // Redirecionar para uma página de erro se o evento não for encontrado
            response.sendRedirect("erro.jsp");
        }
    }
}
