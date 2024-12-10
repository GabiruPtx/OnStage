package aps.onstage.dao;

import aps.onstage.entity.Ingresso;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IngressoDAO {

    public List<Ingresso> listarIngressos() {
        String sql = "SELECT * FROM ingresso";
        List<Ingresso> ingressos = new ArrayList<>();

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ingresso ingresso = new Ingresso();
                ingresso.setId(rs.getLong("id"));
                ingresso.setEvento(rs.getString("evento"));
                ingresso.setPreco(rs.getDouble("preco"));
                ingresso.setData(rs.getDate("data").toLocalDate());
                ingressos.add(ingresso);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar ingressos: " + e.getMessage());
        }

        return ingressos;
    }

    public Ingresso buscarPorId(Long id) {
        String sql = "SELECT * FROM ingresso WHERE id = ?";
        Ingresso ingresso = null;

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ingresso = new Ingresso();
                ingresso.setId(rs.getLong("id"));
                ingresso.setEvento(rs.getString("evento"));
                ingresso.setPreco(rs.getDouble("preco"));
                ingresso.setData(rs.getDate("data").toLocalDate());
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar ingresso: " + e.getMessage());
        }

        return ingresso;
    }

    public void salvar(Ingresso ingresso) {
        String sql = "INSERT INTO ingresso (evento, preco, data) VALUES (?, ?, ?)";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, ingresso.getEvento());
            stmt.setDouble(2, ingresso.getPreco());
            stmt.setDate(3, Date.valueOf(ingresso.getData()));
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao salvar ingresso: " + e.getMessage());
        }
    }

    public void atualizar(Ingresso ingresso) {
        String sql = "UPDATE ingresso SET evento = ?, preco = ?, data = ? WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, ingresso.getEvento());
            stmt.setDouble(2, ingresso.getPreco());
            stmt.setDate(3, Date.valueOf(ingresso.getData()));
            stmt.setLong(4, ingresso.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar ingresso: " + e.getMessage());
        }
    }

    public void deletar(Long id) {
        String sql = "DELETE FROM ingresso WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setLong(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao deletar ingresso: " + e.getMessage());
        }
    }
}
