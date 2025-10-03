package app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDB {
   private final String host;
    private final String porta;
    private final String banco;
    private final String usuario;
    private final String senha;

    private Connection conexao;

    public ConexaoDB() {
        this.host = "localhost";
        this.porta = "5432";
        this.banco = "LISTA_TAREFAS";
        this.usuario = "postgres";
        this.senha = "masterkey";
    }

    public Connection abrirConexao() {
        String url = "jdbc:postgresql://" + host + ":" + porta + "/" + banco;

        try {
            
            Class.forName("org.postgresql.Driver");
            this.conexao = DriverManager.getConnection(url, usuario, senha);
            return this.conexao; //Conexão estabelecida com sucesso!
            
        } catch (ClassNotFoundException e) {
            System.out.println("Driver JDBC não encontrado: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Erro ao conectar ao banco: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Erro inesperado: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public void fecharConexao() {
        if (this.conexao != null) {
            try {
                if (!this.conexao.isClosed()) { // garante que está aberta
                    this.conexao.close();
                    System.out.println("Conexão fechada com sucesso!");
                }
            } catch (SQLException e) {
                System.out.println("Erro ao fechar a conexão: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
//    public Connection getConexao() {
//        return this.conexao;
//    }

}