<%@page import="java.util.List"%>
<%@page import="entidad.Agente"%> <!-- Importa la entidad Agente en lugar de Cliente -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lista de Agentes - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
    </head>
    <body>
        <main>
            <div class="card-container">
                <div class="card">
                    <h2>Lista de Agentes</h2>
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Teléfono</th>
                                <th>Correo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Obtén la lista de agentes del atributo "agentes"
                                List<Agente> agentes = (List<Agente>) request.getAttribute("agentes");
                                for (Agente agente : agentes) {
                            %>
                            <tr>
                                <td><%= agente.getNombre() %></td>
                                <td><%= agente.getTelefono() %></td>
                                <td><%= agente.getEmail() %></td>
                                <td>
                                    <!-- Botón de eliminar -->
                                    <form action="EliminarAgente" method="post" style="display:inline;">
                                        <input type="hidden" name="idAgente" value="<%= agente.getIdagente() %>">
                                        <button type="submit" class="btn-detalle">Eliminar</button>
                                    </form>
                                </td>
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
