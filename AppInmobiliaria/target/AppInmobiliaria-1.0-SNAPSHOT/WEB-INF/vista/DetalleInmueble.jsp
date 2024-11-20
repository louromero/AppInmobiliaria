<%@page import="entidad.Inmueble"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AppInmobiliaria - Detalle de Inmueble</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            /* Sección hero */
            .hero {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                padding: 40px 80px;
                background-color: #ffffff;
                border-radius: 16px;
                box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.05);
                margin: 20px auto;
                width: 80%;
                max-width: 1200px;
            }

            .hero-text {
                max-width: 45%;
                text-align: left;
            }

            .hero-text h2 {
                font-size: 36px;
                color: #4b4b4b;
                margin-bottom: 20px;
            }

            .hero-text p {
                font-size: 18px;
                color: #7c7c7c;
            }

            /* Carrusel de imágenes */
            .hero-image-carousel {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                max-width: 400px;
                height: inherit;
                overflow: hidden;
                top: -30px;
            }

            .carousel-image {
                display: none; /* Oculta todas las imágenes por defecto */
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                left: 0;
            }

            .carousel-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 8px;
            }

            /* Estilos para los botones de navegación */
            .carousel-controls {
                position: absolute;
                top: 50%;
                width: 100%;
                display: flex;
                justify-content: space-between;
                transform: translateY(-50%);
            }

            .carousel-btn {
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                font-size: 18px;
            }

            /* Error */
            .error {
                font-size: 16px;
                color: #e74c3c;
                margin-bottom: 20px;
            }

            /* Media query para dispositivos más pequeños */
            @media (max-width: 768px) {
                .hero {
                    flex-direction: column;
                    padding: 20px;
                }

                .hero-text, .hero-image-carousel {
                    max-width: 100%;
                }

                .hero-text h2 {
                    font-size: 1.8rem;
                }

                .hero-text p {
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>
        <main>
            <!-- Sección de detalle del inmueble -->
            <section class="hero">
                <div class="hero-text">
                    <h2>Detalle del Inmueble</h2>

                    <!-- Mostrar error si ocurre alguno -->
                    <c:if test="${not empty error}">
                        <div class="error">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Mostrar detalles del inmueble si existe -->
                    <c:if test="${not empty inmueble}">
                        <div class="inmueble-detalle">
                            <h3>${inmueble.titulo}</h3>
                            <p><strong>Descripción:</strong> ${inmueble.descripcion}</p>
                            <p><strong>Ubicación:</strong> ${inmueble.ubicacion}</p>
                            <p><strong>Estado:</strong> ${inmueble.estado}</p>
                            <p><strong>Tipo:</strong> ${inmueble.tipo}</p>
                            <p><strong>Precio:</strong> ${inmueble.precio}</p>
                        </div>
                    </c:if>
                </div>

                <!-- Carrusel de imágenes -->
                <div class="hero-image-carousel">
                    <c:forEach var="imagen" items="${inmueble.imagenesInmueble}" varStatus="status">
                        <div class="carousel-image" id="image-${status.index}">
                            <img src="${imagen.urlImagen}" alt="${imagen.descripcion}" />
                        </div>
                    </c:forEach>

                    <!-- Botones de control para el carrusel -->
                    <div class="carousel-controls">
                        <button class="carousel-btn" onclick="prevImage()">&#10094;</button>
                        <button class="carousel-btn" onclick="nextImage()">&#10095;</button>
                    </div>
                </div>
            </section>

            <!-- Banner informativo -->
            <section class="info-banner">
                <p>Descubre hogares únicos con diseños modernos, minimalistas y llenos de luz natural.</p>
            </section>
        </main>

        <script>
            // Variables para controlar la imagen actual en el carrusel
            let currentIndex = 0;
            const images = document.querySelectorAll('.carousel-image');

            // Mostrar la primera imagen al cargar la página
            function showImage(index) {
                images.forEach((img, i) => {
                    img.style.display = i === index ? 'block' : 'none';
                });
            }
            showImage(currentIndex);

            // Función para mostrar la imagen anterior
            function prevImage() {
                currentIndex = (currentIndex === 0) ? images.length - 1 : currentIndex - 1;
                showImage(currentIndex);
            }

            // Función para mostrar la imagen siguiente
            function nextImage() {
                currentIndex = (currentIndex === images.length - 1) ? 0 : currentIndex + 1;
                showImage(currentIndex);
            }
        </script>
    </body>
</html>
