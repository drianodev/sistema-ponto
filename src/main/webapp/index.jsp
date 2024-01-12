<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Ponto</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <!-- Tabela de Horário de Trabalho -->
    <h3>Horário de Trabalho</h3>

    <form id="horarioTrabalhoForm" action="horarioTrabalho" method="post">
        <label for="horaEntrada">Entrada:</label>
        <input type="text" name="horaEntrada" class="form-control" placeholder="HH:MM" maxlength="5" required>

        <label for="horaSaida">Saída:</label>
        <input type="text" name="horaSaida" class="form-control" placeholder="HH:MM" maxlength="5" required>

        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>

    <h3>Registros</h3>

    <table id="horarioTrabalhoTable" class="table">
        <thead>
        <tr>
            <th>Entrada</th>
            <th>Saída</th>
        </tr>
        </thead>
        <tbody>
            <!-- Os registros serão exibidos aqui via GET -->
            <% 
                List<String[]> registrosHorario = (List<String[]>) request.getAttribute("registrosHorario");
                if (registrosHorario != null) {
                    for (String[] registroHorario : registrosHorario) {
            %>
            <tr>
                <td><%= registroHorario[0] %></td>
                <td><%= registroHorario[1] %></td>
            </tr>
            <% 
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Tabela de Marcações Feitas -->
    <h3>Marcações Feitas</h3>

    <form id="marcacoesFeitasForm" action="marcacoesFeitas" method="post">
        <label for="horaEntrada">Entrada:</label>
        <input type="text" name="horaEntrada" class="form-control" placeholder="HH:MM" maxlength="5" required>

        <label for="horaSaida">Saída:</label>
        <input type="text" name="horaSaida" class="form-control" placeholder="HH:MM" maxlength="5" required>

        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>

    <h3>Registros</h3>

    <table id="horarioMarcacoesTable" class="table">
        <thead>
        <tr>
            <th>Entrada</th>
            <th>Saída</th>
        </tr>
        </thead>
        <tbody>
            <!-- Os registros serão exibidos aqui via GET -->
            <% 
                List<String[]> registrosMarcacoes = (List<String[]>) request.getAttribute("registrosMarcacoes");
                if (registrosMarcacoes != null) {
                    for (String[] registroMarcacoes : registrosMarcacoes) {
            %>
            <tr>
                <td><%= registroMarcacoes[0] %></td>
                <td><%= registroMarcacoes[1] %></td>
            </tr>
            <% 
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Tabela de Cálculos de Atraso -->
    <h3>Cálculos de Atraso</h3>

    <form id="calculoAtrasoForm" action="#" method="post">
        <button type="submit" class="btn btn-primary">Calcular Atrasos e Horas Extras</button>
    </form>
    
    <table id="calculosAtrasoTable" class="table">
        <thead>
            <tr>
                <th>Entrada</th>
                <th>Saída</th>
                <th>Atraso</th>
            </tr>
        </thead>

        <tbody>
            <!-- Os cálculos de atraso serão exibidos aqui via GET -->
            <%
                List<String[]> calculosAtraso = (List<String[]>) request.getAttribute("calculosAtraso");
                if (calculosAtraso != null) {
                    for (String[] calculo : calculosAtraso) {
            %>
            <tr>
                <td><%= calculo[0] %></td>
                <td><%= calculo[1] %></td>
                <td><%= calculo[2] %></td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Tabela de Cálculos de Hora Extra -->
    <h3>Cálculos de Hora Extra</h3>
    <table class="table">
        <!-- Adicione as colunas da tabela de Cálculos de Hora Extra da mesma forma que a tabela de Horário de Trabalho -->
    </table>
</div>

<!-- Bootstrap JS and JQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="./js/script.js"></script>
</body>
</html>
