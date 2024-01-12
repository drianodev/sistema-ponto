package br.com.drianodev.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/calculoAtraso")
public class CalculoAtrasoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupera os registros da tabela de horário de trabalho e marcações feitas
        List<String[]> registrosHorario = (List<String[]>) request.getSession().getAttribute("registrosHorario");
        List<String[]> registrosMarcacoes = (List<String[]>) request.getSession().getAttribute("registrosMarcacoes");

        // Calcula os atrasos e horas extras
        List<String[]> atrasos = calcularAtrasos(registrosHorario, registrosMarcacoes);
        List<String[]> horasExtras = calcularHorasExtras(registrosHorario, registrosMarcacoes);

        // Retorna apenas os registros formatados em HTML como resposta
        response.setContentType("text/html");
        response.getWriter().write(buildTableRows("Atrasos", atrasos));
        response.getWriter().write(buildTableRows("Horas Extras", horasExtras));
    }

    private List<String[]> calcularAtrasos(List<String[]> horarioTrabalho, List<String[]> marcacoesFeitas) {
        List<String[]> atrasos = new ArrayList<>();

        for (String[] horario : horarioTrabalho) {
            for (String[] marcacao : marcacoesFeitas) {
                String entradaHorario = horario[0];
                String saidaHorario = horario[1];
                String entradaMarcacao = marcacao[0];
                String saidaMarcacao = marcacao[1];

                // Realiza a lógica de subtração para calcular o atraso
                if (compareTimes(entradaMarcacao, entradaHorario) > 0) {
                    // Atraso
                    atrasos.add(new String[] { entradaHorario, entradaMarcacao });
                }

                if (compareTimes(saidaMarcacao, saidaHorario) > 0) {
                    // Horas extras
                    atrasos.add(new String[] { saidaHorario, saidaMarcacao });
                }
            }
        }

        return atrasos;
    }

    private List<String[]> calcularHorasExtras(List<String[]> horarioTrabalho, List<String[]> marcacoesFeitas) {
        List<String[]> horasExtras = new ArrayList<>();

        for (String[] horario : horarioTrabalho) {
            for (String[] marcacao : marcacoesFeitas) {
                String entradaHorario = horario[0];
                String saidaHorario = horario[1];
                String entradaMarcacao = marcacao[0];
                String saidaMarcacao = marcacao[1];

                // Realiza a lógica de subtração para calcular as horas extras
                if (compareTimes(entradaMarcacao, entradaHorario) < 0) {
                    // Horas extras
                    horasExtras.add(new String[] { entradaMarcacao, entradaHorario });
                }

                if (compareTimes(saidaMarcacao, saidaHorario) < 0) {
                    // Atraso
                    horasExtras.add(new String[] { saidaMarcacao, saidaHorario });
                }
            }
        }

        return horasExtras;
    }

    // Função auxiliar para comparar horas
    private int compareTimes(String time1, String time2) {
        // Implemente a lógica de comparação de horas conforme necessário
        // Aqui, você pode converter as strings para objetos do tipo LocalTime e
        // usar a função compareTo()
        return time1.compareTo(time2);
    }

    private String buildTableRows(String title, List<String[]> registros) {
        StringBuilder htmlRows = new StringBuilder();
        htmlRows.append("<h3>").append(title).append("</h3>");
        htmlRows.append("<table class=\"table\">");
        htmlRows.append("<thead><tr><th>Início</th><th>Fim</th></tr></thead>");
        htmlRows.append("<tbody>");
        for (String[] registro : registros) {
            htmlRows.append("<tr>");
            htmlRows.append("<td>").append(registro[0]).append("</td>");
            htmlRows.append("<td>").append(registro[1]).append("</td>");
            htmlRows.append("</tr>");
        }
        htmlRows.append("</tbody></table>");
        return htmlRows.toString();
    }
}