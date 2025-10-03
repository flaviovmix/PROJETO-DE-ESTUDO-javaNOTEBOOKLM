package app;

import java.util.Date;
import java.text.SimpleDateFormat;

public class Utilidades {
    public static String nullTrim(Integer valor){
        if(valor == null){
            return "";
        } else {
            return valor.toString();
        }
    }

    public static String nullTrim(String valor){
        if(valor == null){
            return "";
        } else {
            return valor.trim();
        }
    }
    
    public static String nullTrim(Date valor){
        if(valor == null){
            return "";
        } else {
            return valor.toString();
        }
    }  

    public static String listaBranca(String texto) {
        if (texto == null) return "";

        StringBuilder sb = new StringBuilder();
        String permitidosExtras = "áàâãéêíóôõúüçñÁÀÂÃÉÊÍÓÔÕÚÜÇÑ";

        for (char c : texto.toCharArray()) {
            if (Character.isLetterOrDigit(c)) {
                sb.append(c);
            } else if (c == ' ' || c == '\n') {
                sb.append(c);
            } else if (
                        c == '.' || c == ',' || c == '-' || c == '_' ||
                        c == '!' || c == '?' || c == ':' || c == ';' ||
                        c == '(' || c == ')' || c == '@'
                    ) {
                sb.append(c);
            } else if (permitidosExtras.indexOf(c) >= 0) {
                sb.append(c);
                } else if (c == '"') {
                    sb.append("&quot;");
                } else if (c == '\'') {
                    sb.append("&#39;");
                } else if (c == '<') {
                    sb.append("&lt;");
                } else if (c == '>') {
                    sb.append("&gt;");
                } else if (c == '&') {
                    sb.append("&amp;");
                } else if (c == '%') {
                    sb.append("&#37;");
                } else if (c == '$') {
                    sb.append("&#36;");
                }
            // ? todo o resto é ignorado
        }
        // só pega sequências de 2 ou mais espaços
        return sb.toString()
             .replaceAll(" {2,}", " ").trim();
    }



    public static String dateToString(Date data, String pattern) {
        String result = "";
        if (data != null) {
            SimpleDateFormat formatter = new SimpleDateFormat(pattern);
            result = formatter.format(data);
        }
        return result;
    }
    
    public static java.sql.Date stringToDate(String data, String pattern) {
        data = nullTrim(data);
        if (data.isEmpty()) {
            return null;
        } else {
            try {
                SimpleDateFormat formatter = new SimpleDateFormat(pattern);
                formatter.setLenient(false);
                java.util.Date utilDate = formatter.parse(data);
                return new java.sql.Date(utilDate.getTime()); // converte para java.sql.Date
            } catch (Exception e) {
                return null;
            }
        }
    }

    
}
