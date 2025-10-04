<%@page import="app.tarefas.TarefaRender"%>
<%@page import="app.Utilidades"%>
<%@page import="java.util.List"%>
<%@page import="app.tarefas.TarefaBean"%>
<%@page import="app.tarefas.TarefaDAO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



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
             <%= TarefaRender.tarefasAtivaInativas(true) %>
        </div>
      </div>

      
      <!-- Conteúdo da Aba: INATIVAS -->
      <div class="tab-content content-inativas">
        <div class="task-list ">
          <%= TarefaRender.tarefasAtivaInativas(false) %>
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