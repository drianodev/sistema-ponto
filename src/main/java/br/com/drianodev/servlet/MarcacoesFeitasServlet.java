package br.com.drianodev.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/marcacoesFeitas")
public class MarcacoesFeitasServlet extends HttpServlet implements Serializable {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String entrada = request.getParameter("horaEntrada");
        String saida = request.getParameter("horaSaida");

        if (isValidTime(entrada) && isValidTime(saida)) {
            List<String[]> registros = getRegistros(request);
            registros.add(new String[] { entrada, saida });
            request.getSession().setAttribute("registros", registros);

            response.setContentType("text/html");
            response.getWriter().write(buildTableRows(registros));
            return;
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private boolean isValidTime(String time) {
        return time.matches("^([01]?[0-9]|2[0-3]):[0-5][0-9]$");
    }

    private List<String[]> getRegistros(HttpServletRequest request) {
        List<String[]> registros = (List<String[]>) request.getSession().getAttribute("registros");

        if (registros == null) {
            registros = new ArrayList<>();
            request.getSession().setAttribute("registros", registros);
        }

        return registros;
    }

    private String buildTableRows(List<String[]> registros) {
        StringBuilder htmlRows = new StringBuilder();
        for (String[] registro : registros) {
            htmlRows.append("<tr>");
            htmlRows.append("<td>").append(registro[0]).append("</td>");
            htmlRows.append("<td>").append(registro[1]).append("</td>");
            htmlRows.append("</tr>");
        }
        return htmlRows.toString();
    }
}
