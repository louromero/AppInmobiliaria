<%@page import="entidad.Inmueble"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lista de Inmuebles - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
    </head>
    <body>

        <main>
            <div class="card-container">
                <div class="card">
                    <h2>Inmuebles Disponibles</h2>
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>Dirección</th>
                                <th>Precio</th>
                                <th>Descripción</th>
                                <th></th>
                                <th></th>

                            </tr>
                        </thead>

                        <tbody>
                            <%
                                List<Inmueble> inmuebles = (List<Inmueble>) request.getAttribute("inmuebles");
                                for (Inmueble inmueble : inmuebles) {
                            %>
                            <tr>
                                <td><%= inmueble.getUbicacion()%></td>
                                <td><%= inmueble.getPrecio()%></td>
                                <td><%= inmueble.getDescripcion()%></td>
                                <td>
                                    <!-- Botón para ver detalles del inmueble -->
                                    <a href="DetalleInmueble?id=<%= inmueble.getIdinmueble()%>" class="btn-detalle">Ver</a>
                                </td>
                                <td>
                                    <!-- Botón de eliminar -->
                                    <form action="EliminarInmueble" method="post" style="display:inline;">
                                        <input type="hidden" name="idInmueble" value="<%= inmueble.getIdinmueble()%>">
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