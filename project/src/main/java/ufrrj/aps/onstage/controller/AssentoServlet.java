package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ufrrj.aps.onstage.dao.assentoDAO;
import ufrrj.aps.onstage.dao.eventoDAO;
import ufrrj.aps.onstage.dao.sessaoDAO;
import ufrrj.aps.onstage.model.Assento;
import ufrrj.aps.onstage.model.Sessao;
import ufrrj.aps.onstage.model.evento;

@WebServlet("/Assento")
public class AssentoServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private sessaoDAO sessaoDAO;
    private assentoDAO assentoDAO;
    private eventoDAO eventoDAO;

    public AssentoServlet() {
        this.sessaoDAO = new sessaoDAO();
        this.assentoDAO = new assentoDAO();
        this.eventoDAO = new eventoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // Pegar o parâmetro sessaoId
        String id = req.getParameter("id");
        System.out.println("ID da sessão: " + id);

        // Verificar se o parâmetro existe
        if (id == null || id.trim().isEmpty()) {

            System.err.println("ID da sessão não foi fornecido");
            resp.sendRedirect("erro.jsp");
            return;

        }
        
        try {
            
            // Buscar a sessão no banco de dados
            Sessao sessao = sessaoDAO.getSessaoById(Integer.parseInt(id));
            
            if (sessao == null) {

                // Se a sessão não for encontrada, redirecionar para página de erro
                System.out.println("Checkpoint evento detalhe servlet");
                resp.sendRedirect("erro.jsp");
                return;

            }
            
            System.err.println("Ok evento detalhe servlet");

            // Buscar os assentos organizados por fileira para a sala desta sessão
            Map<Character, List<Assento>> assentosOrganizados = 
                assentoDAO.getAssentosOrganizadosPorFileira(sessao.getSala().getId());
            
            // Adicionar os dados ao request para usar no JSP
            req.getSession().setAttribute("sessao", sessao);
            req.getSession().setAttribute("assentosOrganizados", assentosOrganizados);
            
            System.out.println("Id da sessão AssentoServlet: " + sessao.getId());

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
        
            // Pegar o parâmetro sessaoId

            System.out.println("### Parâmetros recebidos ###");
            Map<String, String[]> parametros = req.getParameterMap();
            for (Map.Entry<String, String[]> entry : parametros.entrySet()) {
                System.out.println("Chave: " + entry.getKey() + ", Valores: " + Arrays.toString(entry.getValue()));
            }

            String id = req.getParameter("sessaoId");
            // Verificar se o parâmetro existe
            if (id == null || id.trim().isEmpty()) {
                System.err.println("ID da sessão não foi fornecido");
                resp.sendRedirect("erro.jsp");
                return;
            }
        
            try {
            // Recupera os parâmetros enviados pelo formulário
            String assentosSelecionados = req.getParameter("assentosSelecionados");
            String sessaoIdParam = req.getParameter("sessaoId");



            if (assentosSelecionados == null || sessaoIdParam == null) {
                throw new IllegalArgumentException("Dados insuficientes para processar a solicitação.");
            }

            int sessaoId = Integer.parseInt(sessaoIdParam);

            // Obtém o id da sala através da sessão
            Sessao sessao = sessaoDAO.getSessaoById(sessaoId);
            System.out.println("Id do evento - AssentoServlet: " + sessao.getId_evento());
            int id_evento = sessao.getId_evento();
            evento evento = eventoDAO.buscarEventoPorId (id_evento);

            if (sessao == null) {
                throw new IllegalArgumentException("Sessão não encontrada.");
            }
            if (evento == null) {
                throw new IllegalArgumentException("Evento não encontrado.");
            }
            
            int salaId = sessao.getSala().getId();

            // Converte o JSON de assentos selecionados em uma lista de objetos
            Gson gson = new Gson();
            List<Map<String, String>> assentos = gson.fromJson(assentosSelecionados, new TypeToken<List<Map<String, String>>>(){}.getType());

            // Atualiza cada assento no banco de dados
            for (Map<String, String> assento : assentos) {
                
                char fileira = assento.get("fileira").charAt(0);
                int numero = Integer.parseInt(assento.get("numero"));

                System.out.println("Fileira: " + fileira + ", Número: " + numero + ", Sala ID: " + salaId);

                // Define o novo estado como reservado
                assentoDAO.atualizarEstadoAssento(salaId, fileira, numero, "RESERVADO");
            }

            // Redireciona para a página de ingressos
            req.setAttribute("sessao", sessao);
            req.setAttribute("evento", evento);
            for (Map<String, String> assento : assentos) {
                System.out.println("Assento ID: " + assento.get("id") + 
                                  ", Fileira: " + assento.get("fileira") + 
                                  ", Número: " + assento.get("numero") + 
                                  ", Estado: " + assento.get("estado"));
            }
            req.setAttribute("assentos", assentos);
            req.getRequestDispatcher("selecaoingressos.jsp").forward(req, resp);

            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("erro.jsp");
            }

    }

}
