package app.tarefas;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TarefaListaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean ativo = !"false".equalsIgnoreCase(request.getParameter("ativas"));
        String html = TarefaRender.tarefasAtivaInativas(ativo);

        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().write(html);
    }
}
