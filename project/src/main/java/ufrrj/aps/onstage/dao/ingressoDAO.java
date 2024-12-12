package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import ufrrj.aps.onstage.model.Ingresso;
import ufrrj.aps.onstage.util.DBConnection;

public class ingressoDAO {
    
    public List<Integer> inserirIngressos(List<Ingresso> ingressos) throws SQLException {
        List<Integer> idsGerados = new ArrayList<>();
        String sql = "INSERT INTO ingresso (id_sessao, id_assento, id_cliente, tipo, preco, data_compra) " +
                    "VALUES (?, ?, ?, ?, ?, ?) RETURNING id";
        
        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            for (Ingresso ingresso : ingressos) {
                stmt.setInt(1, ingresso.getIdSessao());
                stmt.setInt(2, ingresso.getIdAssento());
                stmt.setInt(3, ingresso.getIdCliente());
                stmt.setString(4, ingresso.getTipo());
                stmt.setDouble(5, ingresso.getValor());
                stmt.setTimestamp(6, Timestamp.valueOf(ingresso.getDataCompra()));
                
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    idsGerados.add(rs.getInt(1));
                }
            }
        }
        return idsGerados;
    }
}
