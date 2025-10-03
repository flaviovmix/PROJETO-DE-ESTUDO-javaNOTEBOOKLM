package app.tarefas;

import app.Utilidades;

public class TarefaRender {
    
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
        sb.append("0 etapas");
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
        sb.append("                <input type=\"hidden\" name=\"inativo\" value=\"0\">\n");
        sb.append("                <input type=\"hidden\" name=\"id_tarefa\" value=\"118\">\n");
        sb.append("                <input type=\"checkbox\" name=\"inativo\" checked>\n");
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
