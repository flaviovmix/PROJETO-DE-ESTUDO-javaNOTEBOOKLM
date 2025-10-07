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
<div id="cronometro" 
     style="position: fixed; bottom: 10px; right: 15px; 
            background: rgba(0,0,0,0.6); color: #fff; 
            padding: 6px 12px; border-radius: 6px; 
            font-family: monospace; font-size: 14px; 
            z-index: 9999;">
  00:00:00
</div>
  <div class="task-list ">
    <div class="tabs">
      <!-- Radios controlam as abas -->
      <input type="radio" name="tabs" id="tab-ativas" checked="">
      <label for="tab-ativas">Ativas</label>

      <input type="radio" name="tabs" id="tab-inativas">
      <label for="tab-inativas">Concluídas</label>
    
      <!-- Conteúdo da Aba: ATIVAS -->
        <div class="tab-content content-ativas">
          <div id="lista-ativas" class="task-list"></div>
        </div>

      
      <!-- Conteúdo da Aba: INATIVAS -->
        <div class="tab-content content-inativas">
          <div id="lista-inativas" class="task-list"></div>
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
  
<script>
    document.addEventListener("DOMContentLoaded", function() {
      // Carrega as tarefas ativas ao iniciar
      carregarTarefas(true);

      // Quando clicar nas abas, recarrega via AJAX
      document.getElementById("tab-ativas").addEventListener("change", () => carregarTarefas(true));
      document.getElementById("tab-inativas").addEventListener("change", () => carregarTarefas(false));
    });

    function carregarTarefas(ativas) {
      fetch("tarefaLista?ativas=" + ativas)
        .then(resp => resp.text())
        .then(html => {
          if (ativas) {
            document.getElementById("lista-ativas").innerHTML = html;
          } else {
            document.getElementById("lista-inativas").innerHTML = html;
          }
        })
        .catch(err => console.error("Erro ao carregar tarefas:", err));
    }
</script>

  
<script>
    function alterarEstado(checkbox) {
      const form = checkbox.form;
      const id_tarefa = form.querySelector('[name=id_tarefa]').value;
      const estado_atual = form.querySelector('[name=estado_atual]').value;

      fetch('tarefa', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `acao=alterar&id_tarefa=${id_tarefa}&estado_atual=${estado_atual}`
      })
      .then(response => {
        if (!response.ok) throw new Error('Erro na requisição');
        const linha = checkbox.closest('.task').remove();
        linha.remove();
      })
      .catch(error => console.error('Falha ao atualizar:', error));
    }
</script>
<script>
let segundos = 0;
setInterval(() => {
  segundos++;
  const horas = String(Math.floor(segundos / 3600)).padStart(2, '0');
  const minutos = String(Math.floor((segundos % 3600) / 60)).padStart(2, '0');
  const segs = String(segundos % 60).padStart(2, '0');
  document.getElementById('cronometro').textContent = `${horas}:${minutos}:${segs}`;
}, 1000);
</script>

</body>

</html>