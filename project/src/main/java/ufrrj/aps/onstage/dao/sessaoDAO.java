package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ufrrj.aps.onstage.model.Sala;
import ufrrj.aps.onstage.model.Sessao;
import ufrrj.aps.onstage.util.DBConnection;

public class sessaoDAO {

    public Sessao getSessaoById(int idSessao) throws SQLException {
        String sql = "SELECT * FROM sessao WHERE id_sessao = ?";

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Definir o parâmetro antes de executar a consulta
            stmt.setInt(1, idSessao);
            System.out.println("ID da sessão: " + idSessao);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Sessao sessao = new Sessao();
                    sessao.setId(rs.getInt("id_sessao"));
                    sessao.setId_evento(rs.getInt("id_evento"));
                    sessao.setData(rs.getDate("data"));
                    sessao.setHorario(rs.getString("horario"));

                    // Buscar a sala associada
                    Sala sala = salaDAO.getSalaById(rs.getInt("id_sala"));
                    if (sala != null) {
                        sessao.setSala(sala);
                        sessao.setLocal(sala.getLocal());
                    } else {
                        System.err.println("Sala não encontrada para ID: " + rs.getInt("id_sala"));
                    }

                    return sessao;
                }
            }
        }

        return null;
    }

    public List<Sessao> getSessoesByEvento(int idEvento) throws SQLException {
        String sql = "SELECT * FROM sessao WHERE id_evento = ?";
        List<Sessao> sessoes = new ArrayList<>();

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Definir o parâmetro antes de executar a consulta
            stmt.setInt(1, idEvento);

            // Instanciar o DAO da sala
            salaDAO salaDAO = new salaDAO();

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Sessao sessao = new Sessao();
                    sessao.setId(rs.getInt("id_sessao"));
                    sessao.setData(rs.getDate("data"));
                    sessao.setHorario(rs.getString("horario"));

                    // Buscar a sala associada
                    Sala sala = salaDAO.getSalaById(rs.getInt("id_sala"));
                    if (sala != null) {
                        sessao.setSala(sala);
                        sessao.setLocal(sala.getLocal());
                    } else {
                        System.err.println("Sala não encontrada para ID: " + rs.getInt("id_sala"));
                    }

                    // Adicionar a sessão à lista
                    sessoes.add(sessao);
                }
            }
        }

        return sessoes;
    }
}
