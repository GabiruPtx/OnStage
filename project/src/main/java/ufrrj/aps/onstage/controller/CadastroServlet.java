package ufrrj.aps.onstage.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ufrrj.aps.onstage.dao.clienteDAO;
import ufrrj.aps.onstage.model.cliente;

@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {

    public CadastroServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    
        String Nome = request.getParameter("Nome");
        String Sobrenome = request.getParameter("Sobrenome");
        String Email = request.getParameter("Email");
        String Senha = request.getParameter("Senha");
        System.out.println("Senha recebida no servlet: " + Senha);
        String CPF = request.getParameter("CPF");
        String Telefone = request.getParameter("Telefone");
        String DataNascimento = request.getParameter("DataNascimento");
        String Logradouro = request.getParameter("Logradouro");
        String Numero = request.getParameter("Numero");
        String Complemento = request.getParameter("Complemento");
        String Bairro = request.getParameter("Bairro");
        String Cidade = request.getParameter("Cidade");
        System.out.println("Bairro: " + Cidade);
        String Estado = request.getParameter("Estado");
        System.out.println("Estado: " + Estado);
        String CEP = request.getParameter("CEP");

        cliente cliente = new cliente(Nome, Sobrenome, Email, Senha, CPF, Telefone, DataNascimento, Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP);
        clienteDAO dao = new clienteDAO(); 

        try {
            dao.inserir(cliente);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(0);
        session.setAttribute("cliente", cliente);
        response.sendRedirect(request.getContextPath() + "/index.html");
    
    }
}