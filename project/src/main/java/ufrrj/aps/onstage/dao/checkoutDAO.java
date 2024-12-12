package ufrrj.aps.onstage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import ufrrj.aps.onstage.model.Checkout;
import ufrrj.aps.onstage.util.DBConnection;

public class checkoutDAO {
    
        public Integer inserirCheckout(Checkout checkout) throws SQLException {
        String sql = "INSERT INTO checkout (id_cliente, valor_total, tipo_pagamento, data_pagamento) " +
                    "VALUES (?, ?, ?, ?) RETURNING id";
        
        try (Connection connection = DBConnection.getConection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, checkout.getIdCliente());
            stmt.setDouble(2, checkout.getValorTotal());
            stmt.setString(3, checkout.getTipoPagamento());
            stmt.setTimestamp(4, Timestamp.valueOf(checkout.getDataPagamento()));
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
         // Se chegou aqui, a inserção não retornou um ID como esperado
         throw new SQLException("Falha ao inserir checkout: nenhum ID foi gerado");
    }
    
    public void inserirIngressoCheckout(Integer idCheckout, List<Integer> idsIngressos) throws SQLException {
        String sql = "INSERT INTO ingresso_checkout (id_checkout, id_ingresso) VALUES (?, ?)";
        
        try (Connection connection = DBConnection.getConection();
        PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            for (Integer idIngresso : idsIngressos) {
                stmt.setInt(1, idCheckout);
                stmt.setInt(2, idIngresso);
                stmt.executeUpdate();
            }
        }
    }
}