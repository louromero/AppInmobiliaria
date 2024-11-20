<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registrar Inmueble</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            /* Imágenes de fondo transparentes */
            body.register-page::before {
                content: "";
                position: absolute;
                top: 20%;
                width: 40%;
                height: 80%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-24.jpg');
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }

            body.register-page::after {
                content: "";
                position: absolute;
                bottom: 16%;
                right: 1%;
                width: 34%;
                height: 74%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-37.jpg');
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }

            /* Estilo para mensajes flotantes */
            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #4CAF50;
                color: white;
                padding: 15px;
                border-radius: 5px;
                display: none;
                z-index: 1000;
            }

            .notification.error {
                background-color: #f44336;
            }

            /* Estilo para los campos en línea */
            .form-row {
                display: flex;
                gap: 20px;
            }

            .form-group {
                flex: 1;
                width: 106%;

            }
        </style>
    </head>
    <body class="register-page">
        <main>
            <section class="form-section">
                <h2>Registrar Inmueble</h2>

                <!-- Muestra mensajes de error o éxito -->
                <c:if test="${not empty error}">
                    <div class="notification error">${error}</div>
                </c:if>
                <c:if test="${not empty registroExitoso}">
                    <div class="notification">¡El inmueble se registró con éxito!</div>
                </c:if>

                <form action="RegistrarInmueble" method="POST">
                    <div class="form-group">
                        <label for="titulo">Título:</label>
                        <input type="text" name="titulo" id="titulo" required>
                    </div>

                    <div class="form-group">
                        <label for="descripcion">Descripción:</label>
                        <textarea name="descripcion" id="descripcion" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="ubicacion">Ubicación:</label>
                        <input type="text" name="ubicacion" id="ubicacion" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="estado">Estado:</label>
                            <select name="estado" id="estado" required>
                                <option value="alquiler">Alquiler</option>
                                <option value="venta">Venta</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="tipo">Tipo:</label>
                            <select name="tipo" id="tipo" required>
                                <option value="casa">Casa</option>
                                <option value="departamento">Departamento</option>
                                <option value="terreno">Terreno</option>
                                <option value="oficina">Oficina</option>
                                <option value="local">Local</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="precio">Precio:</label>
                        <input type="text" name="precio" id="precio" required>
                    </div>

                    <button type="submit" class="btn">Registrar Inmueble</button>
                </form>

                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>
                <c:if test="${not empty mensaje}">
                    <p style="color: green;">${mensaje}</p>
                </c:if>
            </section>
        </main>

        <script>
            // Mostrar mensaje de éxito o error
            window.onload = function () {
                const notification = document.querySelector('.notification');
                if (notification && notification.innerText.trim() !== "") {
                    notification.style.display = 'block';
                    setTimeout(() => {
                        notification.style.display = 'none';
            <% if (request.getAttribute("registroExitoso") != null) { %>
                        window.location.href = 'ListarInmuebles.jsp';
            <% }%>
                    }, 30000);
                }
            };
        </script>
    </body>
</html>
