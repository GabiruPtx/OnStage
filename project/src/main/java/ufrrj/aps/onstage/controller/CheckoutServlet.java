package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ufrrj.aps.onstage.dao.ingressoDAO;
import ufrrj.aps.onstage.model.Ingresso;
import ufrrj.aps.onstage.model.Sessao;
import ufrrj.aps.onstage.model.cliente;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public CheckoutServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }
    
    @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session == null) {
        resp.sendRedirect("login.html");
        return;
    }
    
    cliente usuario = (cliente) session.getAttribute("cliente");
    if (usuario == null) {
        resp.sendRedirect("login.html");
        return;
    }

    Sessao sessaoEvento = (Sessao) session.getAttribute("sessao");
    if (sessaoEvento == null) {
        req.setAttribute("errorMessage", "Sessão do evento não encontrada");
        req.getRequestDispatcher("erro.jsp").forward(req, resp);
        return;
    }

    // Recupera os assentos selecionados da sessão
    @SuppressWarnings("unchecked")
    List<Map<String, String>> assentosSelecionados = 
        (List<Map<String, String>>) session.getAttribute("assentos");
        
    // Add this check for null assentos
    if (assentosSelecionados == null || assentosSelecionados.isEmpty()) {
        req.setAttribute("errorMessage", "Nenhum assento foi selecionado. Por favor, selecione os assentos antes de prosseguir com a compra.");
        req.getRequestDispatcher("erro.jsp").forward(req, resp);
        return;
    }
            
        // Recupera os dados dos tickets do formulário como JSON
        String ticketsJson = req.getParameter("tickets");
        JSONArray ticketsArray = new JSONArray(ticketsJson);
        
        // Cria lista de ingressos
        List<Ingresso> ingressos = new ArrayList<>();
        int assentoIndex = 0;
        
        // Para cada tipo de ingresso no JSON
        for (int i = 0; i < ticketsArray.length(); i++) {
            JSONObject ticket = ticketsArray.getJSONObject(i);
            String tipo = ticket.getString("type");
            int quantidade = ticket.getInt("quantity");
            double preco = ticket.getDouble("price");
            
            // Cria um ingresso para cada quantidade deste tipo
            for (int j = 0; j < quantidade; j++) {
                if (assentoIndex < assentosSelecionados.size()) {
                    Ingresso ingresso = new Ingresso();
                    ingresso.setIdSessao(sessaoEvento.getId());
                    ingresso.setIdAssento(Integer.parseInt(
                        assentosSelecionados.get(assentoIndex).get("id")));
                    ingresso.setIdCliente(usuario.getId());
                    ingresso.setTipo(tipo);
                    ingresso.setValor(preco);
                    ingresso.setDataCompra(LocalDateTime.now());
                    
                    ingressos.add(ingresso);
                    assentoIndex++;
                }
            }
        }
        
        try {
            // Salva os ingressos e recupera os IDs
            ingressoDAO ingressoDAO = new ingressoDAO();
            List<Integer> idsIngressos = ingressoDAO.inserirIngressos(ingressos);
            
            // Salva os IDs na sessão para uso na página de pagamento
            session.setAttribute("idsIngressos", idsIngressos);
            
            // Calcula o valor total
            double valorTotal = ingressos.stream()
                .mapToDouble(Ingresso::getValor)
                .sum();
            session.setAttribute("valorTotal", valorTotal);
            
            // Redireciona para a página de pagamento
            resp.sendRedirect("checkout.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", 
                "Erro ao processar ingressos. Por favor, tente novamente.");
            req.getRequestDispatcher("erro.jsp").forward(req, resp);
        }

    }
    
}
