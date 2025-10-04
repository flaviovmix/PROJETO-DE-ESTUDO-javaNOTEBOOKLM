package app.tarefas;

import app.ConexaoDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TarefaDAO {

    public List<TarefaBean> listarTarefas(boolean ativoOuInativo) {
        List<TarefaBean> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder();

//        sql.append("SELECT tarefas.* , (");
//        sql.append(     "SELECT COUNT(*) ");
//        sql.append("    FROM detalhes_tarefa ");
//        sql.append(     "WHERE detalhes_tarefa.fk_tarefa = tarefas.id_tarefa ");
//        sql.append(") AS quantidade_de_subtarefas ");
//        sql.append("FROM tarefas WHERE ativo = ? ");
        
        sql.append("SELECT ");
        sql.append("    t.*, ");
        sql.append("    COUNT(d.id_detalhe) AS quantidade_de_subtarefas ");
        sql.append("FROM tarefas t ");
        sql.append("LEFT JOIN detalhes_tarefa d ");
        sql.append("       ON d.fk_tarefa = t.id_tarefa ");
        sql.append("WHERE t.ativo = ? ");
        sql.append("GROUP BY t.id_tarefa, t.titulo");

        try (Connection conn = new ConexaoDB().abrirConexao();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            // aqui você passa o valor do parâmetro ?
            ps.setBoolean(1, ativoOuInativo);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TarefaBean tarefa = new TarefaBean();
                    tarefa.setTitulo(rs.getString("titulo"));
                    tarefa.setPrioridade(rs.getString("prioridade"));
                    tarefa.setDescricao(rs.getString("descricao"));
                    tarefa.setResponsavel(rs.getString("responsavel"));
                    tarefa.setData_conclusao(rs.getDate("data_conclusao"));
                    tarefa.setData_criacao(rs.getDate("data_criacao"));
                    tarefa.setAtivo(rs.getBoolean("ativo"));
                    tarefa.setQuantidade_de_subtarefas(rs.getInt("quantidade_de_subtarefas"));
                    lista.add(tarefa);
                }
            }

        } catch (SQLException erro) {
            erro.printStackTrace();
        }

        return lista;
    }

}
