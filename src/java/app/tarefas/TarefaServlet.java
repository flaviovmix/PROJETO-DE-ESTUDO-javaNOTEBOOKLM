package app.tarefas;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TarefaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        System.out.println("passei no Servlet");
        
        if ("alterar".equals(acao)) {

            int id_detalhe = Integer.parseInt(request.getParameter("id_tarefa"));
            boolean estadoAtual = Boolean.parseBoolean(request.getParameter("estado_atual"));
            boolean novoEstado = !estadoAtual;

            TarefaDAO tarefaDao = new TarefaDAO();
            tarefaDao.alterarAtivoInativo(id_detalhe, novoEstado);
            System.out.println("Novo estado: " + novoEstado + " | Id: " + id_detalhe);

        }

        response.sendRedirect("index.jsp");
    }
}
