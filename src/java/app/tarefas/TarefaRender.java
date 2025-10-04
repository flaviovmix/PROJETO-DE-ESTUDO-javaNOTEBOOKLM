package app.tarefas;

import app.Utilidades;
import java.util.List;

public class TarefaRender {

    public static String tarefasAtivaInativas(boolean ativoInativo) {
        TarefaDAO dao = new TarefaDAO();
        List<TarefaBean> tarefas = dao.listarTarefas(ativoInativo);

        StringBuilder sb = new StringBuilder();
        for (TarefaBean tarefa : tarefas) {
            sb.append(renderizar(tarefa));
        }
        return sb.toString();
    }

    public static String renderizar(TarefaBean tarefa) {
        StringBuilder sb = new StringBuilder();
        String ativoInativo = tarefa.isAtivo() ? "" : " opaco";

        sb.append("    <div class=\"task " + tarefa.getPrioridade() + "\">\n");

        sb.append("      <div class=\"task-content\">\n");

        sb.append("        <div class=\"task-title " + ativoInativo + "\">\n");
        sb.append("          <a href=\"novaTarefa.html\" class=\"link-sem-estilo\">");
        sb.append(tarefa.getTitulo());
        sb.append("          </a>\n");
        sb.append("        </div>\n");

        sb.append("        <div class=\"task-meta " + ativoInativo + "\">\n");

        sb.append("          <a href=\"novaTarefa.html\" class=\"link-sem-estilo\">\n");
        sb.append("            <span><i class=\"fas fa-layer-group\"></i>");
        sb.append(tarefa.getQuantidade_de_subtarefas() + " etapas");
        sb.append("</span>\n");
        sb.append("          </a>\n");

        sb.append("          <span>\n");
        sb.append("            <i class=\"fas fa-calendar-alt\"></i>\n");
        sb.append(Utilidades.dateToString(tarefa.getData_criacao(), "dd MMM - yyyy"));
        sb.append("          \n</span>\n");

        sb.append("          <span>\n");
        sb.append("            <i class=\"fas fa-user-alt\"></i>\n");
        sb.append(tarefa.getResponsavel());
        sb.append("          \n</span>\n");

        sb.append("        </div>\n");

        sb.append("        <span class=\"descricao " + ativoInativo + "\">");
        sb.append(tarefa.getDescricao());
        sb.append("        </span>\n");

        sb.append("      </div>\n"); // fecha task-content

        sb.append("      <div class=\"task-actions\">\n");

        sb.append("        <div>\n");
        sb.append("          <label class=\"checkbox-container\">\n");
        sb.append("            <div class=\"usuario_concluir\">\n");

        sb.append("              <div class=\"assigned\"><strong>");
        sb.append(Utilidades.dateToString(tarefa.getData_conclusao(), "EEEE, dd 'de' MMM 'de' yyyy"));
        sb.append("              </strong></div>\n");

        sb.append("              <form action=\"#\" method=\"get\" style=\"display:inline;\">\n");
        sb.append("                <input type=\"hidden\" name=\"estado_atual\" value=\"true\">\n");
        sb.append("                <input type=\"hidden\" name=\"id_tarefa\" value=\"" + tarefa.getId_tarefa() + "\">\n");

        if (!tarefa.isAtivo()) {
            sb.append("                <input type=\"checkbox\" name=\"inativo\" checked>\n");
        } else {
            sb.append("                <input type=\"checkbox\" name=\"inativo\">\n");
        }

        sb.append("              </form>\n");

        sb.append("            </div>\n"); // fecha usuario_concluir
        sb.append("          </label>\n");
        sb.append("        </div>\n");

        sb.append("        <a href=\"#\" class=\"deletar-link\">\n");
        sb.append("          <i class=\"fas fa-trash\"></i>\n");
        sb.append("        </a>\n");

        sb.append("      </div>\n"); // fecha task-actions

        sb.append("    </div>\n"); // fecha task

        return sb.toString();
    }

}
