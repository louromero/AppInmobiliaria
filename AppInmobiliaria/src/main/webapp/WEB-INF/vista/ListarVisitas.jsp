<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="entidad.VisitaInmueble"%>
<%@page import="entidad.Agente"%>
<%@page import="entidad.Cliente"%>
<%@page import="entidad.Inmueble"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Visitas</title>
    <link rel="stylesheet" href="css/vista.css">
</head>
<body>
    <main>
        <div class="card-container">
            <div class="card">
                <h2>Visitas Programadas</h2>
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Estado</th>
                            <th>Dirección</th>
                            <th>Agente</th>
                            <th>Cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Formateadores para fecha y hora
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                            
                            
                            List<VisitaInmueble> visitas = (List<VisitaInmueble>) request.getAttribute("visitas");
                            for (VisitaInmueble visita : visitas) {
                        %>
                        <tr>
                            <td><%= visita.getVisitaInmueblePK().getFecha() %></td>
                            <td><%= visita.getHora() %></td>
                            <td><%= visita.getEstado() %></td>
                            <td><%= visita.getInmueble().getUbicacion() %></td>
                            <td><%= visita.getAgente().getNombre() %></td>
                            <td><%= visita.getCliente().getNombre() %></td>
                            <!-- Columna con botón de edición 
                            <td>
                                <form action="EditarVisita" method="get">
                                    <input type="hidden" name="visitaId" value="<%= visita.getVisitaInmueblePK().getIdvisitaInmueble() %>" />
                                    <button type="submit" class="btn">Editar</button>
                                </form>
                            </td>-->
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>
