package br.com.drianodev.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/horarioTrabalho")
public class HorarioTrabalhoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String[]> registrosHorario = getRegistros(request);

        request.setAttribute("registrosHorario", registrosHorario);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String entrada = request.getParameter("horaEntrada");
        String saida = request.getParameter("horaSaida");

        if (isValidTime(entrada) && isValidTime(saida)) {
            List<String[]> registros = getRegistros(request);

            if (registros.size() >= 3) {
                request.getSession().setAttribute("avisoLimiteRegistros", "Aviso: Limite de 3 registros atingido.");
            } else {
                registros.add(new String[]{entrada, saida});
                request.getSession().setAttribute("registros", registros);
            }

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
        HttpSession session = request.getSession(false);

        if (session != null) {
            List<String[]> registros = (List<String[]>) session.getAttribute("registros");

            if (registros == null) {
                registros = new ArrayList<>();
                session.setAttribute("registros", registros);
            }

            return registros;
        }

        return new ArrayList<>(); // Ou pode retornar null, dependendo do seu caso de uso
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
