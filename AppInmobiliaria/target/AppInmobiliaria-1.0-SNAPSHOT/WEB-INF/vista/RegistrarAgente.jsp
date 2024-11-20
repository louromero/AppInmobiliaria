<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Agente - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            
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
            /* Estilo para mensajes de notificación */
            .notification-message {
                margin-top: 15px;
                padding: 10px;
                border-radius: 5px;
                text-align: center;
                display: none; 
            }
            .notification-success {
                background-color: #4CAF50;
                color: white;
            }
            .notification-error {
                background-color: #f44336; 
                color: white;
            }
        </style>
    </head>
    <body class="register-page">
        <header>
            <div class="logo">
                <a href="index.jsp">
                    <h1>AppInmobiliaria</h1>
                </a>
            </div>
            <nav>
                <ul>
                    <li><a href="IniciarSesion">Iniciar Sesión</a></li>
                    <li><a href="RegistrarAgente">Registrarse</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <section class="form-section">
                <h2>Registrar Agente</h2>
                <form action="RegistrarAgente" method="post">
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
                    <div class="form-group">
                        <label for="clave">Clave:</label>
                        <input type="password" id="clave" name="clave" required>
                    </div>
                    <button type="submit" class="btn">Registrar</button>

                    <!-- Mensaje de notificación -->
                    <c:choose>
                        <c:when test="${not empty registroExitoso}">
                            <div class="notification-message notification-success">
                                Registro exitoso. Inicia sesión.
                            </div>
                        </c:when>
                        <c:when test="${not empty error}">
                            <div class="notification-message notification-error">
                                ${error}
                            </div>
                        </c:when>
                    </c:choose>
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
                        window.location.href = 'ListarAgentes.jsp';
            <% }%>
                    }, 30000);
                }
            };
        </script>
    </body>
</html>