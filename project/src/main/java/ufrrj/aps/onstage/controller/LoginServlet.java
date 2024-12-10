package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ufrrj.aps.onstage.dao.clienteDAO;
import ufrrj.aps.onstage.model.cliente;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Apenas redireciona para o login ou outra página, se necessário
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("Email");
        String senha = request.getParameter("Senha");
        
        clienteDAO dao = new clienteDAO();
        try {
            cliente cliente = dao.buscarPorEmailSenha(email, senha);
            
            if (cliente != null) {
                // Verifica se já existe uma sessão
                HttpSession session = request.getSession(true); // Cria uma nova sessão se não existir
                session.setMaxInactiveInterval(1800); // Define o tempo de expiração da sessão (30 minutos)
                
                // Armazena o cliente na sessão
                session.setAttribute("cliente", cliente);
                
                // Redireciona para a página principal após login bem-sucedido
                response.sendRedirect("index.jsp");
            } else {
                // Caso as credenciais não sejam válidas
                response.sendRedirect("login.html?erro=1"); // Exemplo de redirecionamento com mensagem de erro
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.html?erro=2"); // Caso de erro na consulta ao banco
        }
    }
}