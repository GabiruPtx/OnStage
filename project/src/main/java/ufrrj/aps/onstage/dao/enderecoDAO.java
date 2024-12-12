package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ufrrj.aps.onstage.model.endereco;
import ufrrj.aps.onstage.util.DBConnection;

public class enderecoDAO {

    public enderecoDAO() {

    }

    // Insere um endereço no banco de dados
    public void inserir(endereco endereco, Connection conn) throws SQLException {
        String sql = "INSERT INTO endereco (id_cliente, logradouro, numero, complemento, " +
                     "bairro, cidade, estado, cep) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, endereco.getIdCliente());
            stmt.setString(2, endereco.getLogradouro());
            stmt.setString(3, endereco.getNumero());
            stmt.setString(4, endereco.getComplemento());
            stmt.setString(5, endereco.getBairro());
            stmt.setString(6, endereco.getCidade());
            stmt.setString(7, endereco.getEstado());
            stmt.setString(8, endereco.getCep());

            stmt.executeUpdate();
        }
    }

    // Busca um endereço pelo ID do cliente
    public endereco buscarPorClienteId(int clienteId) throws SQLException {
        String sql = "SELECT * FROM endereco WHERE id_cliente = ?";

        try (Connection conn = DBConnection.getConection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, clienteId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extrairEndereco(rs);
                }
            }
        }
        return null;
    }

    // Extrai as informações do ResultSet para um objeto Endereco
    private endereco extrairEndereco(ResultSet rs) throws SQLException {
        endereco endereco = new endereco();

        endereco.setId(rs.getLong("id_endereco"));
        endereco.setIdCliente(rs.getInt("id_cliente"));
        endereco.setLogradouro(rs.getString("logradouro"));
        endereco.setNumero(rs.getString("numero"));
        endereco.setComplemento(rs.getString("complemento"));
        endereco.setBairro(rs.getString("bairro"));
        endereco.setCidade(rs.getString("cidade"));
        endereco.setEstado(rs.getString("estado"));
        endereco.setCep(rs.getString("cep"));

        return endereco;
    }
}