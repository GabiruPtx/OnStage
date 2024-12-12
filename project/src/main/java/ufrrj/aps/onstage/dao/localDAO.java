package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ufrrj.aps.onstage.model.Local;
import ufrrj.aps.onstage.util.DBConnection;

public class localDAO {

    public Local getLocalById(int idLocal) throws SQLException {
        String sql = "SELECT * FROM local WHERE id_local = ?";

        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idLocal);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return criarLocal(rs);
                }
            }
        }

        return null;
    }

    private Local criarLocal(ResultSet rs) throws SQLException {
        Local local = new Local();
        local.setId(rs.getInt("id_local"));
        local.setNome(rs.getString("nome"));
        local.setLogradouro(rs.getString("logradouro"));
        local.setNumero(rs.getString("numero"));
        local.setMunicipio(rs.getString("municipio"));
        local.setEstado(rs.getString("estado"));
        local.setTipoLocal(rs.getString("tipoLocal"));
        return local;
    }
}
