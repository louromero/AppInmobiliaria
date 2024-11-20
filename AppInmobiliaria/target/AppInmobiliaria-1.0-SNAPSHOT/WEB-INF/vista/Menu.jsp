<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <head>
        <title>Menú Principal</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
    </head>
    <body>
        <header>
            <div class="logo">
                <h1><a href="inicio.jsp">AppInmobiliaria</a></h1>
            </div>
            <nav>
                <ul>
                    <!--<li><a href="RegistrarAgente">Registrar Agente</a></li>-->
                    <li><a href="RegistrarCliente">Registrar Cliente</a></li>
                    <li><a href="RegistrarInmueble">Registrar Inmueble</a></li>
                    <li><a href="RegistrarVisita">Registrar Visita</a></li>


                    <li><a href="ListarInmuebles">Listar Inmuebles</a></li>
                    <li><a href="ListarAgentes">Listar Agentes</a></li>

                    <li><a href="ListarClientes">Listar Clientes</a></li>

                    <li><a href="ListarVisitas">Listar Visitas</a></li>
                    
                    <li><a href="CerrarSesion">Cerrar Sesión</a></li>
                </ul>
            </nav>
        </header>
    </body>
</html>
