package ufrrj.aps.onstage.controller;

import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ufrrj.aps.onstage.util.DBConnection;
import ufrrj.aps.onstage.util.LoginRequest;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Collectors;

import static java.sql.DriverManager.getConnection;

@WebServlet("/auth")
public class AuthenticationServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Lê o corpo da requisição
        String requestBody = request.getReader().lines().collect(Collectors.joining());
        LoginRequest loginRequest = gson.fromJson(requestBody, LoginRequest.class);

        // Verifica as credenciais (exemplo simples)
        if (isValidUser(loginRequest)) {
            // Cria uma sessão
            HttpSession session = request.getSession(true);
            session.setAttribute("user", loginRequest.getEmail());

            // Envia resposta de sucesso simples
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Login successful");
        } else {
            // Envia resposta de erro simples
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Invalid credentials");
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            return no.toString(16);
        } catch (Exception e) {
            return password; // fallback para caso algo dê errado
        }
    }

    private boolean isValidUser(LoginRequest loginRequest) {
        try (Connection conn = DBConnection.getConection()) {
            if (conn == null) {
                throw new SQLException("Falha na conexão com o banco");
            }

            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE email = ? AND password = ?"
            );

            stmt.setString(1, loginRequest.getEmail());
            stmt.setString(2, hashPassword(loginRequest.getPassword()));

            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
