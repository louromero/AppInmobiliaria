<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Visita</title>
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
            background-color: #4CAF50; /* Verde para éxito */
            color: white;
            padding: 15px;
            border-radius: 5px;
            display: none;
            z-index: 1000;
        }

        .notification.error {
            background-color: #f44336; /* Rojo para error */
        }

        /* Estilo para los campos en línea */
        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-group {
            flex: 1;
        }
    </style>
</head>
<body class="register-page">
    <main>
        <section class="form-section">
            <h1>Registrar Visita a Inmueble</h1>

            <!-- Muestra mensajes de error o éxito -->
            <c:if test="${not empty error}">
                <div class="notification error">${error}</div>
            </c:if>
            <c:if test="${not empty registroExitoso}">
                <div class="notification">¡La visita se registró con éxito!</div>
            </c:if>

            <!-- Formulario de registro de visita -->
            <form action="RegistrarVisita" method="post">
                <div class="form-group">
                    <label for="agenteId">Agente:</label>
                    <select name="agenteId" id="agenteId" required>
                        <option value="">Seleccione un agente</option>
                        <c:forEach var="agente" items="${agentes}">
                            <option value="${agente.idagente}">${agente.nombre}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="clienteId">Cliente:</label>
                    <select name="clienteId" id="clienteId" required>
                        <option value="">Seleccione un cliente</option>
                        <c:forEach var="cliente" items="${clientes}">
                            <option value="${cliente.idcliente}">${cliente.nombre}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="inmuebleId">Inmueble:</label>
                    <select name="inmuebleId" id="inmuebleId" required>
                        <option value="">Seleccione un inmueble</option>
                        <c:forEach var="inmueble" items="${inmuebles}">
                            <option value="${inmueble.idinmueble}">${inmueble.ubicacion}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="fecha">Fecha:</label>
                        <input type="date" id="fecha" name="fecha" required>
                    </div>

                    <div class="form-group">
                        <label for="hora">Hora:</label>
                        <input type="time" id="hora" name="hora" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="estado">Estado:</label>
                    <select name="estado" id="estado" required>
                        <option value="">Seleccione un estado</option>
                        <option value="Pendiente">Pendiente</option>
                        <option value="Confirmada">Confirmada</option>
                        <option value="Cancelada">Cancelada</option>
                    </select>
                </div>

                <button type="submit" class="btn">Registrar Visita</button>
            </form>
        </section>
    </main>

    <script>
        // Mostrar el mensaje si existe un estado de éxito o error
        window.onload = function() {
            const notification = document.querySelector('.notification');
            if (notification && notification.innerText.trim() !== "") {
                notification.style.display = 'block';
                setTimeout(() => {
                    notification.style.display = 'none';
                    <% if (request.getAttribute("registroExitoso") != null) { %>
                        window.location.href = 'RegistrarVisita.jsp';
                    <% } %>
                }, 30000);
            }
        };
    </script>
</body>
</html>
