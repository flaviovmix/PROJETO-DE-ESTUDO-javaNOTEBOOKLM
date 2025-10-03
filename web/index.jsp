<%@page import="app.Utilidades"%>
<%@page import="java.util.List"%>
<%@page import="app.tarefas.TarefaBean"%>
<%@page import="app.tarefas.TarefaDAO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    TarefaDAO tarefaDAO = new TarefaDAO();
    List<TarefaBean> tarefasAtivas = tarefaDAO.listarTarefas(true);
    List<TarefaBean> tarefasInativas = tarefaDAO.listarTarefas(false);
%>


        
<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8">
  <title>To-Do List</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="./css/guias.css">

  <link rel="stylesheet" href="./css/index-claro.css">
  <link rel="stylesheet" href="./css/modal-claro.css">

</head>

<body>
  <header>
    <div class="container">
      <button class="btn-add" onclick="window.location.href='novaTarefa.html'">Nova Tarefa</button>
      <a href="#" class="config-icon" onclick="openModalConfig(); return false;">
        <i class="fas fa-cog"></i>
      </a>
    </div>
  </header>

  <div class="task-list ">
    <div class="tabs">
      <!-- Radios controlam as abas -->
      <input type="radio" name="tabs" id="tab-ativas" checked="">
      <label for="tab-ativas">Ativas</label>

      <input type="radio" name="tabs" id="tab-inativas">
      <label for="tab-inativas">Concluídas</label>
    
      <!-- Conteúdo da Aba: ATIVAS -->
      <div class="tab-content content-ativas">
        <div class="task-list ">
            <% for (TarefaBean tarefa : tarefasAtivas) {  %>
                <div class="task <%= tarefa.getPrioridade() %>">

                  <div class="task-content">
                    <div class="task-title ">
                      <a href="novaTarefa.html" class="link-sem-estilo"><%= tarefa.getTitulo() %></a> 
                    </div>
                    <div class="task-meta"> 
                      <a href="novaTarefa.html" class="link-sem-estilo"> 
                        <span><i class="fas fa-layer-group"></i>0 etapas</span>
                      </a> 
                      <span><i class="fas fa-calendar-alt"></i><%= Utilidades.dateToString(tarefa.getData_criacao(), "dd MMM - yyyy")  %></span> 
                      <span><i class="fas fa-user-alt"></i><%= tarefa.getResponsavel() %></span> 

                    </div> 
                    <span class="descricao"><%= tarefa.getDescricao() %></span>
                  </div>

                  <div class="task-actions">
                    <div> 
                      <label class="checkbox-container">
                        <div class="usuario_concluir">
                            <div class="assigned"><strong><%= Utilidades.dateToString(tarefa.getData_conclusao(), "EEEE, dd 'de' MMM 'de' yyyy")  %></strong></div>
                          <form action="#" method="get" style="display:inline;"> 
                            <input type="hidden" name="estado_atual" value="true">
                            <input type="hidden" name="ativa" value="0">
                            <input type="hidden" name="id_tarefa" value="118"> 
                            <input type="checkbox" name="ativo">
                          </form>
                        </div>
                      </label>
                    </div> 
                    <a href="#" class="deletar-link">
                      <i class="fas fa-trash"></i>
                    </a>
                  </div>

                </div>
            <% } %>
        </div>
      </div>

      
      <!-- Conteúdo da Aba: INATIVAS -->
      <div class="tab-content content-inativas">

        <div class="task-list ">
          <% for (TarefaBean tarefa : tarefasInativas) {  %>
            <div class="task baixa">

              <div class="task-content">
                <div class="task-title opaco">
                  <a href="novaTarefa.html" class="link-sem-estilo">TAREFA</a> 
                </div>
                <div class="task-meta opaco"> 
                  <a href="novaTarefa.html" class="link-sem-estilo"> 
                    <span><i class="fas fa-layer-group"></i>0 etapas</span>
                  </a> 
                  <span><i class="fas fa-calendar-alt"></i>14 ago - 2025</span> 
                  <span><i class="fas fa-user-alt"></i>Pedro Henrique</span> 

                </div> 
                <span class="descricao opaco">AQUI VAI A DESCRICAO DA TAREFA</span>
              </div>

              <div class="task-actions">
                <div> 
                  <label class="checkbox-container">
                    <div class="usuario_concluir">
                      <div class="assigned"><strong>Quinta-feira, 14 ago - 2025</strong></div>
                      <form action="#" method="get" style="display:inline;"> 
                        <input type="hidden" name="estado_atual" value="true">
                        <input type="hidden" name="inativo" value="0">
                        <input type="hidden" name="id_tarefa" value="118"> 
                        <input type="checkbox" name="inativo" checked>
                      </form>
                    </div>
                  </label>
                </div> 
                <a href="#" class="deletar-link">
                  <i class="fas fa-trash"></i>
                </a>
              </div>

            </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DELETAR -->
  <div class="modal-overlay" id="modalDeletar" style="display:none;">
    <div class="modal">
      <h2>Confirmar Exclusão</h2>
      <table class="tabela-confirmacao">
        <tbody>
          <tr>
            <td><i class="fas fa-pen"></i> Título:</td>
            <td id="tituloDeletar"></td>
          </tr>
          <tr>
            <td><i class="fas fa-user"></i> Responsável:</td>
            <td id="tituloResponsavel"></td>
          </tr>
          <tr>
            <td><i class="fas fa-bolt"></i> Prioridade:</td>
            <td id="tituloPrioridade"></td>
          </tr>
          <tr>
            <td><i class="fas fa-thumbtack"></i> Status:</td>
            <td id="tituloStatus"></td>
          </tr>
        </tbody>
      </table>

      <form id="formDeletar" method="post" action="#">
        <input type="hidden" name="id_tarefa" id="id_tarefa_deletar" value="0">
        <div class="modal-buttons">
          <button type="submit" class="btn-deletar-confirmar">Sim, deletar</button>
          <button type="button" class="btn-cancelar" onclick="closeModalDeletar()">Cancelar</button>
        </div>
      </form>

    </div>
  </div>

  <!-- MODAL CONFIGURAÇÃO -->
  <div class="modal-overlay" id="modalConfig" style="display:none;">
    <div class="modal">
      <h2>Configurações</h2>
      <table class="tabela-configuracao">
        <tbody>
          <tr>
            <td><i class="fas fa-adjust"></i> <strong>Tema:</strong></td>
            <td></td>
          </tr>
          <tr>
            <td>

              <form id="formTema" action="#" method="post">
                <input type="hidden" name="id_configuracao" value="1">
                <div class="bolinhas-wrapper">
                  <div class="bolinhas-selector">
                    <input type="radio" id="bolinha1" name="tema" value="1"
                      onchange="document.getElementById('formTema').submit()" checked="">
                    <label for="bolinha1">Claro</label>
                  </div>
                  <div class="bolinhas-selector">
                    <input type="radio" id="bolinha2" name="tema" value="2"
                      onchange="document.getElementById('formTema').submit()">
                    <label for="bolinha2">Escuro</label>
                  </div>
                  <div class="bolinhas-selector">
                    <input type="radio" id="bolinha3" name="tema" value="3"
                      onchange="document.getElementById('formTema').submit()">
                    <label for="bolinha3">Base no Sistema</label>
                  </div>
                </div>
              </form>

            </td>
          </tr>
        </tbody>
      </table>

      <table class="tabela-configuracao">
        <tbody>
          <tr>
            <td><i class="fas fa-adjust"></i> <strong>Nova área:</strong></td>
            <td></td>
          </tr>
          <tr>
            <td><i class="fas fa-thumbtack"></i>vazio</td>
            <td></td>
          </tr>
        </tbody>
      </table>
      <div class="modal-buttons">
        <button type="button" class="btn-cancelar" onclick="closeModalConfig()">Fechar</button>
      </div>
    </div>
  </div>


  <script src="./js/index.js"></script>
  <script src="./js/Utilidades.js"></script>







</body>

</html>