package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ufrrj.aps.onstage.model.evento;
import ufrrj.aps.onstage.model.fichaTecnica;
import ufrrj.aps.onstage.model.genero;
import ufrrj.aps.onstage.util.DBConnection;

public class eventoDAO {

    // Método para buscar um evento por ID
    public evento buscarEventoPorId(int id) throws SQLException {
        String sql = "SELECT * FROM evento WHERE id_evento = ?";
        
        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    evento e = new evento();
                    e.setId(rs.getInt("id_evento"));
                    e.setTitulo(rs.getString("titulo"));
                    e.setDescricao(rs.getString("descricao"));
                    e.setClass_indicativa(rs.getString("classificacao_indicativa"));
                    e.setDuracao(rs.getString("duracao"));
                    e.setTipo(rs.getString("tipo"));
                    e.setEstado(rs.getString("estado"));
                    e.setImagem_url(rs.getString("imagem_url"));
                    
                    // Buscando os gêneros associados ao evento
                    e.setGeneros(buscarGenerosPorEvento(id));
                    e.setFicha(buscarFichaTecnicaPorEvento(id));
                    
                    return e;
                }
            }
        }
        return null; // Retorna null se o evento não for encontrado
    }

    // Método para buscar os gêneros associados a um evento
    public List<genero> buscarGenerosPorEvento(int eventoId) throws SQLException {
        List<genero> generos = new ArrayList<>();
        
        String sql = """
            SELECT g.id_genero, g.nome 
            FROM genero g
            INNER JOIN evento_genero eg ON g.id_genero = eg.id_genero
            WHERE eg.id_evento = ?""";

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventoId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    genero g = new genero();
                    g.setId(rs.getInt("id_genero"));
                    g.setNome(rs.getString("nome"));
                    generos.add(g);
                }
            }
        }
        return generos; // Retorna a lista de gêneros
    }

    //Método para buscar a ficha técnica de um evento
    public fichaTecnica buscarFichaTecnicaPorEvento(int eventoId) throws SQLException {
    String sql = "SELECT * FROM ficha_tecnica WHERE id_evento = ?";
    
    try (Connection connection = DBConnection.getConection();
         PreparedStatement stmt = connection.prepareStatement(sql)) {
        
        stmt.setInt(1, eventoId);
        
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                fichaTecnica ft = new fichaTecnica();
                ft.setId(rs.getInt("id_ficha"));
                ft.setId_evento(rs.getInt("id_evento"));
                ft.setDirecao(rs.getString("direcao"));
                ft.setDistribuidora(rs.getString("distribuidora"));
                
                return ft;
            }
        }
    }
    
        return null; // Retorna null se não encontrar a ficha técnica
    }

}