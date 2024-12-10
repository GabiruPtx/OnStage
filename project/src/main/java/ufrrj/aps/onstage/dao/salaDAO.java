package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import ufrrj.aps.onstage.model.Assento;
import ufrrj.aps.onstage.model.Local;
import ufrrj.aps.onstage.model.Sala;
import ufrrj.aps.onstage.util.DBConnection;

public class salaDAO {

    public static Sala getSalaById(int idSala) throws SQLException {
        String sql = "SELECT * FROM sala WHERE id_sala = ?";

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Definindo o valor do parâmetro antes de executar a consulta
            stmt.setInt(1, idSala);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Sala sala = new Sala();
                    sala.setId(rs.getInt("id_sala"));
                    sala.setNumero(rs.getString("numero"));

                    // Obter o Local associado à sala
                    localDAO localDAO = new localDAO();
                    Local local = localDAO.getLocalById(rs.getInt("id_local"));
                    sala.setLocal(local);

                    // Coletar os assentos relacionados à sala
                    assentoDAO assentoDAO = new assentoDAO();
                    List<Assento> assentos = assentoDAO.getAssentosBySala(idSala);
                    sala.setAssentos(assentos);

                    return sala;
                }
            }
        }
        return null;
    }
}
