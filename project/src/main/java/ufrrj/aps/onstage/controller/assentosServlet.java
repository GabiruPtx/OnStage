package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ufrrj.aps.onstage.dao.assentoDAO;
import ufrrj.aps.onstage.dao.sessaoDAO;
import ufrrj.aps.onstage.model.Assento;
import ufrrj.aps.onstage.model.Sessao;

@WebServlet("/assentosServlet")
public class assentosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public assentosServlet() {
        // Construtor padrão
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;

        // Recuperar o ID do evento
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("erro.jsp");
            return;
        }

        // Inicializar DAOs e variáveis
        sessaoDAO sessaoDAO = new sessaoDAO();
        assentoDAO assentoDAO = new assentoDAO();
        Sessao sessao = null;
        Map<Character, List<Assento>> assentosOrganizados = null;

        try {
            // Obter a sessão pelo ID
            sessao = sessaoDAO.getSessaoById(id);

            if (sessao != null && sessao.getSala() != null) {
                // Obter os assentos organizados por fileira
                assentosOrganizados = assentoDAO.getAssentosOrganizadosPorFileira(sessao.getSala().getId());
            } else {
                req.setAttribute("error", "Sala não encontrada para a sessão.");
                RequestDispatcher errorDispatcher = req.getRequestDispatcher("erro.jsp");
                errorDispatcher.forward(req, resp);
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Erro ao acessar o banco de dados.");
            RequestDispatcher errorDispatcher = req.getRequestDispatcher("erro.jsp");
            errorDispatcher.forward(req, resp);
            return;
        }

        // Verificar se há assentos disponíveis
        if (assentosOrganizados == null || assentosOrganizados.isEmpty()) {
            req.setAttribute("message", "Nenhum assento disponível para esta sala.");
        }

        // Configurar atributos na requisição
        req.setAttribute("assentosOrganizados", assentosOrganizados);
        req.setAttribute("sessao", sessao);

        // Encaminhar para a JSP
        RequestDispatcher dispatcher = req.getRequestDispatcher("/assentos.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Se o método POST não for necessário, pode ser removido
    }
}
