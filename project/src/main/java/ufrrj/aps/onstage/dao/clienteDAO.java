package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import ufrrj.aps.onstage.model.cliente;
import ufrrj.aps.onstage.model.endereco;
import ufrrj.aps.onstage.util.DBConnection;

public class clienteDAO {
    private final enderecoDAO enderecoDAO;

    public clienteDAO() {
        this.enderecoDAO = new enderecoDAO();
    }

    // Método para inserir um cliente e seu endereço (se houver)
    public void inserir(cliente cliente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConection();
            conn.setAutoCommit(false);
            
            String sql = "INSERT INTO cliente (nome, sobrenome, email, senha, cpf, telefone, data_nasc) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
                         
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getSobrenome());
            stmt.setString(3, cliente.getEmail());
            System.out.println("Senha antes do INSERT: " + cliente.getSenha());
            stmt.setString(4, cliente.getSenha());
            stmt.setString(5, cliente.getCPF());
            stmt.setString(6, cliente.getTelefone());
            stmt.setDate(7, cliente.getData_nasc() != null ? Date.valueOf(cliente.getData_nasc()) : null);
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    cliente.setId(rs.getLong(1));
                    if (cliente.getEndereco() != null) {
                        cliente.getEndereco().setIdCliente(cliente.getId());
                        enderecoDAO.inserir(cliente.getEndereco(), conn);
                    }
                }
            }
            
            conn.commit();
        } catch (SQLException e) {
            System.out.println("Erro ao inserir cliente: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new SQLException("Erro ao inserir cliente: " + e.getMessage());
        } finally {
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    // Extrai os dados de um cliente do ResultSet
    private cliente extrairCliente(ResultSet rs) throws SQLException {
        cliente cliente = new cliente();

        cliente.setId(rs.getLong("id"));
        cliente.setNome(rs.getString("nome"));
        cliente.setSobrenome(rs.getString("sobrenome"));
        cliente.setEmail(rs.getString("email"));
        cliente.setSenha(rs.getString("senha"));
        cliente.setCPF(rs.getString("cpf"));
        cliente.setTelefone(rs.getString("telefone"));
        cliente.setData_nasc(rs.getString("data_nasc"));
        
        // Busca o endereço associado ao cliente
        enderecoDAO enderecoDAO = new enderecoDAO(); // Instância do DAO de endereço
        endereco endereco = enderecoDAO.buscarPorClienteId(cliente.getId()); // Busca pelo ID do cliente
        cliente.setEndereco(endereco); // Associa o endereço ao cliente

        return cliente;
    }
}