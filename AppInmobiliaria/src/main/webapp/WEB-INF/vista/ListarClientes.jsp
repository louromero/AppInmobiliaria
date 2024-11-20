<%@page import="java.util.List"%>
<%@page import="entidad.Cliente"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lista de Clientes - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
    </head>
    <body>
        <main>
            <div class="card-container">
                <div class="card">
                    <h2>Lista de Clientes</h2>
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
                                List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
                                for (Cliente cliente : clientes) {
                            %>
                            <tr>
                                <td><%= cliente.getNombre() %></td>
                                <td><%= cliente.getTelefono() %></td>
                                <td><%= cliente.getEmail() %></td>
                                <td>
                                    <!-- Botón de eliminar -->
                                    <form action="EliminarCliente" method="post" style="display:inline;">
                                        <input type="hidden" name="idCliente" value="<%= cliente.getIdcliente() %>">
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