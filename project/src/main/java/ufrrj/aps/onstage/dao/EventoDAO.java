package aps.onstage.dao;

import aps.onstage.entity.Evento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventoDAO {

    // Método para listar todos os eventos
    public List<Evento> listarEventos() {
        List<Evento> eventos = new ArrayList<>();
        String sql = "SELECT * FROM evento";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setId(rs.getLong("id"));
                evento.setTitulo(rs.getString("titulo"));
                evento.setDuracao(rs.getString("duracao"));
                evento.setClassificacao(rs.getString("classificacao"));
                evento.setSinopse(rs.getString("sinopse"));
                eventos.add(evento);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar eventos: " + e.getMessage());
        }

        return eventos;
    }

    // Método para buscar evento por ID
    public Evento buscarPorId(Long id) {
        Evento evento = null;
        String sql = "SELECT * FROM evento WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                evento = new Evento();
                evento.setId(rs.getLong("id"));
                evento.setTitulo(rs.getString("titulo"));
                evento.setDuracao(rs.getString("duracao"));
                evento.setClassificacao(rs.getString("classificacao"));
                evento.setSinopse(rs.getString("sinopse"));
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar evento por ID: " + e.getMessage());
        }

        return evento;
    }

    // Método para salvar um novo evento
    public void salvar(Evento evento) {
        String sql = "INSERT INTO evento (titulo, duracao, classificacao, sinopse) VALUES (?, ?, ?, ?)";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, evento.getTitulo());
            stmt.setString(2, evento.getDuracao());
            stmt.setString(3, evento.getClassificacao());
            stmt.setString(4, evento.getSinopse());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao salvar evento: " + e.getMessage());
        }
    }

    // Método para atualizar evento existente
    public void atualizar(Evento evento) {
        String sql = "UPDATE evento SET titulo = ?, duracao = ?, classificacao = ?, sinopse = ? WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, evento.getTitulo());
            stmt.setString(2, evento.getDuracao());
            stmt.setString(3, evento.getClassificacao());
            stmt.setString(4, evento.getSinopse());
            stmt.setLong(5, evento.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar evento: " + e.getMessage());
        }
    }

    // Método para deletar evento por ID
    public void deletar(Long id) {
        String sql = "DELETE FROM evento WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setLong(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao deletar evento: " + e.getMessage());
        }
    }
}
