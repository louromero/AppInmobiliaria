<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cliente - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
        <style>

        body.register-page::before {
            content: "";
            position: absolute;
            top: 20%;
            width: 40%;
            height: 80%;
            border-radius: 50%;
            background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-24.jpg'); /* Reemplaza con la ruta de tu imagen */
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
            background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-37.jpg'); /* Reemplaza con la ruta de tu segunda imagen */
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
    </style>
</head>
<body class="register-page">
    <main>
        <section class="form-section">
            <h2>Registrar Cliente</h2>
            <form action="RegistrarCliente" method="post" onsubmit="return validarFormulario()">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
                <div class="form-group">
                    <label for="email">Correo Electrónico:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono" required>
                </div>
                <button type="submit" class="btn">Registrar</button>
            </form>
        </section>
    </main>

    <!-- Mensajes flotantes -->
    <div id="notification" class="notification 
        <c:if test='${not empty error}'>error</c:if>'>
        <c:choose>
            <c:when test='${not empty registroExitoso}'>
                Registro exitoso.
            </c:when>
            <c:when test='${not empty error}'>
                El correo ya está registrado.
            </c:when>
        </c:choose>
    </div>

    <script>
        // Mostrar el mensaje si existe un estado de éxito o error
        window.onload = function() {
            const notification = document.getElementById('notification');
            if (notification.innerText.trim() !== "") {
                notification.style.display = 'block';
                setTimeout(() => {
                    notification.style.display = 'none';
                    <% if (request.getAttribute("registroExitoso") != null) { %>
                        window.location.href = 'ListarClientes.jsp';
                    <% } %>
                }, 3000);
            }
        };

        function validarFormulario() {
            // Verifica si los campos están vacíos
            var nombre = document.getElementById("nombre").value;
            var email = document.getElementById("email").value;
            var telefono = document.getElementById("telefono").value;

            if (nombre === "" || email === "" || telefono === "") {
                alert("Por favor, complete todos los campos.");
                return false; // Previene el envío del formulario si hay campos vacíos
            }
            return true; // Permite el envío si todos los campos están completos
        }
    </script>
</body>
</html>
