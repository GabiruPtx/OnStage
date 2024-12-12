package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
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
import ufrrj.aps.onstage.dao.assentoDAO;
import ufrrj.aps.onstage.dao.eventoDAO;
import ufrrj.aps.onstage.dao.ingressoDAO;
import ufrrj.aps.onstage.dao.sessaoDAO;
import ufrrj.aps.onstage.model.Ingresso;
import ufrrj.aps.onstage.model.Sessao;
import ufrrj.aps.onstage.model.cliente;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private sessaoDAO sessaoDAO;
    private assentoDAO assentoDAO;
    private eventoDAO eventoDAO;

    public CheckoutServlet() {
        this.sessaoDAO = new sessaoDAO();
        this.assentoDAO = new assentoDAO();
        this.eventoDAO = new eventoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        System.out.println("### Parâmetros recebidos ###");
            Map<String, String[]> parametros = req.getParameterMap();
            for (Map.Entry<String, String[]> entry : parametros.entrySet()) {
                System.out.println("Chave: " + entry.getKey() + ", Valores: " + Arrays.toString(entry.getValue()));
        }

    try{

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

        String sessaoIdParam = req.getParameter("sessaoId");
        System.out.println("Entrou no CheckoutServlet");

         // Buscar a sessão no banco de dados
         Sessao sessao = sessaoDAO.getSessaoById(Integer.parseInt(sessaoIdParam));
            
         if (sessao == null) {

             // Se a sessão não for encontrada, redirecionar para página de erro
             System.out.println("Checkpoint evento detalhe servlet");
             resp.sendRedirect("erro.jsp");
             return;

         }

                // Recupera os assentos selecionados da sessão
                @SuppressWarnings("unchecked")
                Object rawAssentos = session.getAttribute("assentosSelecionados");
                
                if (rawAssentos == null) {
                    System.err.println("Nenhum assento recuperado da sessão.");
                    req.getRequestDispatcher("erro.jsp").forward(req, resp);
                    return;
                }
                
                // Verifica se o objeto recuperado é do tipo esperado
                List<Map<String, String>> assentosSelecionados;
                if (rawAssentos instanceof List) {
                    // Verifica se é uma lista de listas (possível erro de estrutura)
                    if (!((List<?>) rawAssentos).isEmpty() && ((List<?>) rawAssentos).get(0) instanceof List) {
                        // Converte para o formato correto
                        assentosSelecionados = new ArrayList<>();
                        for (Object innerList : (List<?>) rawAssentos) {
                            if (innerList instanceof List) {
                                for (Object assento : (List<?>) innerList) {
                                    if (assento instanceof Map) {
                                        assentosSelecionados.add((Map<String, String>) assento);
                                    }
                                }
                            }
                        }
                    } else {
                        // Caso esteja no formato esperado
                        assentosSelecionados = (List<Map<String, String>>) rawAssentos;
                    }
                } else {
                    System.err.println("Formato inesperado para assentosSelecionados.");
                    req.getRequestDispatcher("erro.jsp").forward(req, resp);
                    return;
                }
                
                // Valida se a lista está vazia
                if (assentosSelecionados.isEmpty()) {
                    System.err.println("Nenhum assento selecionado na lista.");
                    req.getRequestDispatcher("erro.jsp").forward(req, resp);
                    return;
                }
                
                // Itera pelos assentos recuperados e imprime
                for (Map<String, String> assento : assentosSelecionados) {
                    System.out.println("Assento selecionado: " + assento);
                }
                
        // Adiciona logs para verificar o estado completo da sessão
        System.out.println("Sessão ID: " + session.getId());
        System.out.println("Atributos da sessão:");
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            System.out.println(name + ": " + session.getAttribute(name));
        }

        // Prossegue com o restante do processamento caso não haja erros
        System.out.println("Processamento concluído com sucesso.");
                
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
                        ingresso.setIdSessao(sessao.getId());
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
                session.setAttribute("ingressos", ingressos);
                session.setAttribute("sessao", sessao);
                session.setAttribute("valorTotal", valorTotal);
                
                // Redireciona para a página de pagamento
                resp.sendRedirect("checkout.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("Erro ao redirecionar para a página de pagamento");
                req.getRequestDispatcher("erro.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erro ao processar ingressos");
            req.getRequestDispatcher("erro.jsp").forward(req, resp);
        }
    
    }
}
