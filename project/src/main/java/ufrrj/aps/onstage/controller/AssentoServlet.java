package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ufrrj.aps.onstage.dao.assentoDAO;
import ufrrj.aps.onstage.dao.sessaoDAO;
import ufrrj.aps.onstage.model.Assento;
import ufrrj.aps.onstage.model.Sessao;

@WebServlet("/Assentos")
public class AssentoServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private sessaoDAO sessaoDAO;
    private assentoDAO assentoDAO;

    public AssentoServlet() {
        this.sessaoDAO = new sessaoDAO();
        this.assentoDAO = new assentoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
         try {
            // Recuperar o ID da sessão da URL
            
            int sessaoId = Integer.parseInt(req.getParameter("Id"));
            
            // Buscar a sessão no banco de dados
            Sessao sessao = sessaoDAO.getSessaoById(sessaoId);
            
            if (sessao == null) {
                // Se a sessão não for encontrada, redirecionar para página de erro
                resp.sendRedirect("erro.jsp");
                return;
            }
            
            // Buscar os assentos organizados por fileira para a sala desta sessão
            Map<Character, List<Assento>> assentosOrganizados = 
                assentoDAO.getAssentosOrganizadosPorFileira(sessao.getSala().getId());
            
            // Adicionar os dados ao request para usar no JSP
            req.setAttribute("sessao", sessao);
            req.setAttribute("assentosOrganizados", assentosOrganizados);
            
            // Encaminhar para a página JSP
            req.getRequestDispatcher("/assentos.jsp")
                  .forward(req, resp);
            
        } catch (NumberFormatException e) {
            // Log do erro e redirecionamento para página de erro
            System.err.println("Erro ao converter ID da sessão: " + e.getMessage());
            resp.sendRedirect("erro.jsp");
            
        } catch (SQLException e) {
            // Log do erro e redirecionamento para página de erro
            System.err.println("Erro ao acessar banco de dados: " + e.getMessage());
            resp.sendRedirect("erro.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Se o método POST não for necessário, pode ser removido
    }

}
