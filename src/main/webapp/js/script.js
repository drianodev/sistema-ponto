$(document).ready(function () {

    // Submissão do formulário de Horário de Trabalho
    $("#horarioTrabalhoForm").submit(function (event) {
        event.preventDefault(); // Impede o envio padrão do formulário

        $.ajax({
            type: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function (response) {
                // Atualiza a tabela com os novos registros
                $("#horarioTrabalhoTable tbody").html(response);

                // Limpa os campos do formulário após o envio
                $("#horarioTrabalhoForm")[0].reset();
            },
            error: function (error) {
                console.error(error);
            }
        });
    });

    // Submissão do formulário de Marcações Feitas
    $("#marcacoesFeitasForm").submit(function (event) {
        event.preventDefault(); // Impede o envio padrão do formulário

        $.ajax({
            type: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function (response) {
                // Atualiza a tabela com os novos registros
                $("#horarioMarcacoesTable tbody").html(response);

                // Limpa os campos do formulário após o envio
                $("#marcacoesFeitasForm")[0].reset();
            },
            error: function (error) {
                console.error(error);
            }
        });
    });

    // Submissão do formulário de Cálculo de Atraso
    $("#calculoAtrasoForm").submit(function (event) {
        event.preventDefault(); // Impede o envio padrão do formulário

        $.ajax({
            type: "POST",
            url: "calculoAtraso", // Este é o URL do seu servlet
            success: function (response) {
                // Atualiza a tabela com os novos registros
                $("#calculoAtrasoTable").html(response);
            },
            error: function (error) {
                console.error(error);
            }
        });
    });
});