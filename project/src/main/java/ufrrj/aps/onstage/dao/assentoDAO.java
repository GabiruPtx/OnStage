package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import ufrrj.aps.onstage.model.Assento;
import ufrrj.aps.onstage.util.DBConnection;

public class assentoDAO {

    public Map<Character, List<Assento>> getAssentosOrganizadosPorFileira(int idSala) throws SQLException {
    List<Assento> assentos = getAssentosBySala(idSala);
    return assentos.stream().collect(Collectors.groupingBy(Assento::getFileira));
}

    public List<Assento> getAssentosBySala(int idSala) throws SQLException {
        String sql = "SELECT * FROM assento WHERE id_sala = ?";
        List<Assento> assentos = new ArrayList<>();

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idSala);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Assento assento = new Assento();
                    assento.setId(rs.getInt("id_assento"));
                    assento.setId_sala(rs.getInt("id_sala"));
                    assento.setFileira(rs.getString("fileira").charAt(0));
                    assento.setNumero(rs.getInt("numero"));
                    assento.setTipo(rs.getString("tipo"));
                    assento.setEstado(rs.getString("estado"));

                    assentos.add(assento);
                }
            }
        }
        return assentos;
    }
}
