package ufrrj.aps.onstage.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConection()
    {
        try {
            //tentar estabelecer a conexão
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnStage?serverTimezone=UTC", //linha de conexão
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

public static void fecharConexao(Connection conexao) {
    if (conexao != null) {
        try {
            conexao.close();
        } catch (SQLException e) {
            System.out.println("Erro ao fechar conexão: " + e.getMessage());
        }
    }
}

// Exemplo de uso
public static void main(String[] args) {
    Connection conexao = obterConexao();
    if (conexao != null) {
        System.out.println("Conexão estabelecida com sucesso!");
        fecharConexao(conexao);
    }
}
}