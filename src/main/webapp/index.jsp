<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Ponto</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/styles.css" rel="stylesheet">
    <!-- jQuery e Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script src="./js/script.js"></script>
</head>
<body>

    <div class="container mt-5">
        <!-- Horário de Trabalho -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h3>Horário de Trabalho</h3>

                <form id="horarioTrabalhoForm" action="horarioTrabalho" method="post">
                    <div class="form-group">
                        <label for="horaEntrada">Entrada: <span class="required">*</span></label>
                        <input type="text" name="horaEntrada" class="form-control" placeholder="hh:mm" maxlength="5" required oninput="autoCompleteTime(this)" onkeydown="handleBackspace(this)" onblur="validateTimeInput(this)">
                        <span class="warning-message"></span>
                    </div>
    
                    <div class="form-group">
                        <label for="horaSaida">Saída: <span class="required">*</span></label>
                        <input type="text" name="horaSaida" class="form-control" placeholder="hh:mm" maxlength="5" required oninput="autoCompleteTime(this)" onkeydown="handleBackspace(this)" onblur="validateTimeInput(this)">
                        <span class="warning-message"></span>
                    </div>
    
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>

            <div class="col-md-6">
                
                <h3>Registros - Horário de Trabalho</h3>

                <!-- Sua estrutura HTML e tabela -->
                <table id="horarioTrabalhoTable" class="table">
                    <thead>
                        <tr>
                            <th>Entrada</th>
                            <th>Saída</th>
                        </tr>
                    </thead>

                    <tbody>
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
            </div>
        </div>

        <!-- Marcações Feitas -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h3>Marcações Feitas</h3>

                <form id="marcacoesFeitasForm" action="marcacoesFeitas" method="post">
                    <div class="form-group">
                        <label for="horaEntrada">Entrada: <span class="required">*</span></label>
                        <input type="text" name="horaEntrada" class="form-control" placeholder="hh:mm" maxlength="5" required oninput="autoCompleteTime(this)" onkeydown="handleBackspace(this)" onblur="validateTimeInput(this)">
                        <span class="warning-message"></span>
                    </div>
    
                    <div class="form-group">
                        <label for="horaSaida">Saída: <span class="required">*</span></label>
                        <input type="text" name="horaSaida" class="form-control" placeholder="hh:mm" maxlength="5" required oninput="autoCompleteTime(this)" onkeydown="handleBackspace(this)" onblur="validateTimeInput(this)">
                        <span class="warning-message"></span>
                    </div>

                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>

            <div class="col-md-6">
                <h3>Registros - Marcações Feitas</h3>

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
            </div>
        </div>

        <!-- Cálculos de Atraso -->
        <div class="row mb-4">

            <div class="col-md-6">
                <h3>Cálculos de Atraso</h3>

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
            </div>
        </div>

        <!-- Cálculos de Hora Extra -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h3>Cálculos de Hora Extra</h3>
                
                <table id="calculosExtraTable" class="table">
                    <thead>
                        <tr>
                            <th>Entrada</th>
                            <th>Saída</th>
                            <th>Extra</th>
                        </tr>
                    </thead>
        
                    <tbody>
                        <!-- Os cálculos de atraso serão exibidos aqui via GET -->
                        <%
                            List<String[]> extras = (List<String[]>) request.getAttribute("extras");
                            if (extras != null) {
                                for (String[] extra : extras) {
                        %>
                        <tr>
                            <td><%= extra[0] %></td>
                            <td><%= extra[1] %></td>
                            <td><%= extra[2] %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script>
        function autoCompleteTime(input) {
            // Verifica se o comprimento da entrada é igual a 2
            if (input.value.length === 2) {
                // Adiciona ":" automaticamente após dois caracteres
                input.value += ":";
            }
        }

        function handleBackspace(input) {
            // Verifica se a tecla pressionada é o backspace e remove o último caractere, incluindo o ":"
            if (event.key === "Backspace" && input.value.length > 0) {
                input.value = input.value.slice(0, -1);
            }
        }

        $(document).ready(function () {
            // Inicializa a máscara nos campos de entrada
            $('input[name="horaEntrada"]').mask('00:00', { placeholder: 'hh:mm' });
            $('input[name="horaSaida"]').mask('00:00', { placeholder: 'hh:mm' });

            // Adiciona um ouvinte de evento para o formulário
            $("#horarioTrabalhoForm").submit(function (event) {
                // Chama a função de validação antes de enviar o formulário
                validateTimeInput($('input[name="horaEntrada"]'));
                validateTimeInput($('input[name="horaSaida"]'));

                // Verifica se algum campo possui a classe de erro após a validação
                if ($(this).find('.error-border').length > 0) {
                    // Se houver algum campo com erro, impede o envio do formulário
                    event.preventDefault();
                }
            });
        });

        function validateTimeInput(input) {
            var inputValue = $(input).val();
            var parts = inputValue.split(':');

            var hours = parseInt(parts[0], 10);
            var minutes = parseInt(parts[1], 10);

            var warningMessage = $(input).next('.warning-message');

            // Verifica se as horas estão dentro do intervalo de 0 a 23 e os minutos de 0 a 59
            if (isNaN(hours) || isNaN(minutes) || hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
                $(input).val('');
                warningMessage.text('Por favor, insira uma hora válida.');
                warningMessage.show();
                $(input).addClass('error-border');
            } else {
                warningMessage.hide();
                $(input).removeClass('error-border');
            }
        }
    </script>
</body>
</html>
