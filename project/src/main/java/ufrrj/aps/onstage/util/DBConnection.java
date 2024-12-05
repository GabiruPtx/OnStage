package ufrrj.aps.onstage.util;

import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection {

    public Connection getConection()
    {
       try {
           //tentar estabelecer a conexão
           Connection conn = DriverManager.getConnection(
                   "jdbc:mysql://localhost:3306/projetojavabiblioteca?serverTimezone=UTC", //linha de conexão
                   "root", //usuario do mysql
                   ""  //senha do mysql
           );
           return conn;
       } catch (Exception e) {
           //se der erro na conexão
           System.out.println("Erro ao conectar: " + e.getMessage());
           return null;
       }
    }

}
