package ufrrj.aps.onstage.service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import ufrrj.aps.onstage.util.LoginRequest;
import ufrrj.aps.onstage.util.DBConnection;

public class AuthenticationService {
    
    public boolean validateUser(LoginRequest loginRequest) {
        try (Connection conn = DBConnection.getConection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM users WHERE email = ? AND password = ?")) {
            
            stmt.setString(1, loginRequest.getEmail());
            stmt.setString(2, hashPassword(loginRequest.getPassword()));
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
            
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar usuário", e);
        }
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256"); // Usando SHA-256 em vez de MD5
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            
            // Padding com zeros à esquerda se necessário
            while (hashtext.length() < 64) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
            
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }
}