package br.com.drianodev.servlet;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/calculos")
public class CalculosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private List<String[]> calcularAtraso(List<String[]> registrosHorario, List<String[]> registrosMarcacoes) {
        List<String[]> calculosAtraso = new ArrayList<>();

        for (String[] horario : registrosHorario) {
            String horarioEntrada = horario[0];
            String horarioSaida = horario[1];

            for (String[] marcacao : registrosMarcacoes) {
                String marcacaoEntrada = marcacao[0];
                String marcacaoSaida = marcacao[1];

                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                    long horarioEntradaMillis = sdf.parse(horarioEntrada).getTime();
                    long horarioSaidaMillis = sdf.parse(horarioSaida).getTime();
                    long marcacaoEntradaMillis = sdf.parse(marcacaoEntrada).getTime();
                    long marcacaoSaidaMillis = sdf.parse(marcacaoSaida).getTime();

                    if (horarioSaidaMillis > marcacaoEntradaMillis && horarioEntradaMillis < marcacaoSaidaMillis) {
                        long atrasoInicio = Math.max(horarioEntradaMillis, marcacaoEntradaMillis);
                        long atrasoFim = Math.min(horarioSaidaMillis, marcacaoSaidaMillis);

                        calculosAtraso.add(new String[] {
                                horarioEntrada,
                                horarioSaida,
                                sdf.format(atrasoInicio) + " - " + sdf.format(atrasoFim)
                        });
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }

        return calculosAtraso;
    }
}