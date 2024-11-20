package controlador;

import entidad.Agente;
import entidad.Cliente;
import entidad.Inmueble;
import entidad.VisitaInmueble;
import entidad.VisitaInmueblePK;
import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import session.AgenteFacade;
import session.ClienteFacade;
import session.InmuebleFacade;
import session.VisitaInmuebleFacade;

@WebServlet(name = "Manejador",
        loadOnStartup = 1,
        urlPatterns = {
            "/IniciarSesion",
            "/ListarInmuebles",
            "/ListarClientes",
            "/ListarAgentes",
            "/ListarVisitas",
            "/RegistrarAgente",
            "/DetalleInmueble",
            "/RegistrarCliente",
            "/RegistrarInmueble",
            "/RegistrarVisita",
            "/EliminarCliente",
            "/EliminarAgente",
            "/EliminarInmueble",
            "/CerrarSesion"
        }
)
public class Manejador extends HttpServlet {

    @EJB
    private AgenteFacade agenteF;

    /*@Inject // Inyecta automáticamente el ClienteFacade
    private ClienteFacade clienteF;*/
    @EJB
    private ClienteFacade clienteF;

    @EJB
    private InmuebleFacade inmuebleF;

    @EJB
    private VisitaInmuebleFacade visitaF;

    @Override
    public void init() throws ServletException {
        // Cargar lista inicial de inmuebles
        getServletContext().setAttribute("inmuebles", inmuebleF.findAll());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = null;
        String pathUsuario = request.getServletPath();
        System.out.println("path = " + pathUsuario);

        try {
            switch (pathUsuario) {
                case "/IniciarSesion":
                    String correo = request.getParameter("correo");
                    String clave = request.getParameter("contrasena");

                    Agente agente = agenteF.iniciarSesion(correo, clave);
                    if (agente != null) {
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("agente", agente);
                        url = "ListarInmuebles";
                    } else {
                        request.setAttribute("error", "Credenciales incorrectas.");
                        url = "/WEB-INF/vista/IniciarSesion.jsp";
                    }
                    break;

                case "/RegistrarAgente":
                    try {
                        String nombre = request.getParameter("nombre");
                        String email = request.getParameter("email");
                        String telefono = request.getParameter("telefono");
                        String claveAgente = request.getParameter("clave");

                        if (nombre == null || nombre.isEmpty()
                                || email == null || email.isEmpty()
                                || telefono == null || telefono.isEmpty()
                                || claveAgente == null || claveAgente.isEmpty()) {
                            request.setAttribute("error", "Todos los campos son obligatorios.");
                            url = "/WEB-INF/vista/RegistrarAgente.jsp";
                            break;
                        }

                        Agente existente = (Agente) agenteF.findByEmail(email);
                        if (existente != null) {
                            request.setAttribute("error", "El correo ya está registrado.");
                            url = "/WEB-INF/vista/RegistrarAgente.jsp";
                        } else {
                            Agente nuevoAgente = new Agente();
                            nuevoAgente.setNombre(nombre);
                            nuevoAgente.setEmail(email);
                            nuevoAgente.setTelefono(telefono);
                            nuevoAgente.setClave(claveAgente);

                            agenteF.create(nuevoAgente);
                            request.setAttribute("registroExitoso", true);
                            url = "/WEB-INF/vista/RegistrarAgente.jsp";
                        }
                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al registrar agente", e);
                        request.setAttribute("error", "Datos incorrectos para registrar agente.");
                        url = "/WEB-INF/vista/RegistrarAgente.jsp";
                    }
                    break;

                case "/RegistrarCliente":
                    try {
                        String nombreC = request.getParameter("nombre");
                        String emailC = request.getParameter("email");
                        String telefonoC = request.getParameter("telefono");

                        if (nombreC == null || nombreC.isEmpty()
                                || emailC == null || emailC.isEmpty()
                                || telefonoC == null || telefonoC.isEmpty()) {
                            request.setAttribute("error", "Todos los campos son obligatorios.");
                            url = "/WEB-INF/vista/RegistrarCliente.jsp";
                            break;
                        }

                        Cliente cliente = new Cliente();
                        cliente.setNombre(nombreC);
                        cliente.setEmail(emailC);
                        cliente.setTelefono(telefonoC);

                        clienteF.create(cliente);

                        request.setAttribute("registroExitoso", true);
                        url = "/WEB-INF/vista/RegistrarCliente.jsp";
                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al registrar cliente", e);
                        request.setAttribute("error", "Datos incorrectos para registrar cliente.");
                        url = "/WEB-INF/vista/RegistrarCliente.jsp";
                    }
                    break;
                case "/RegistrarVisita":
                    try {
                        List<Agente> agentes = agenteF.findAll();
                        List<Cliente> clientes = clienteF.findAll();
                        List<Inmueble>inmuebles = inmuebleF.findAll();

                        System.out.println("Agentes: " + agentes.size()); 
                        System.out.println("Clientes: " + clientes.size()); 
                        System.out.println("Inmuebles: " + inmuebles.size()); 

                        request.setAttribute("agentes", agentes);
                        request.setAttribute("clientes", clientes);
                        request.setAttribute("inmuebles", inmuebles);

                        String idAgenteParam = request.getParameter("agenteId");
                        String idClienteParam = request.getParameter("clienteId");
                        String idInmuebleParam = request.getParameter("inmuebleId");
                        String fechaParam = request.getParameter("fecha");
                        String horaParam = request.getParameter("hora");
                        String estado = request.getParameter("estado");

                        System.out.println("Datos recibidos: " + idAgenteParam + ", " + idClienteParam + ", " + idInmuebleParam); // Debugging

                        if (idAgenteParam == null || idAgenteParam.isEmpty()
                                || idClienteParam == null || idClienteParam.isEmpty()
                                || idInmuebleParam == null || idInmuebleParam.isEmpty()
                                || fechaParam == null || fechaParam.isEmpty()
                                || horaParam == null || horaParam.isEmpty()
                                || estado == null || estado.isEmpty()) {
                            request.setAttribute("error", "Todos los campos son obligatorios.");
                            url = "/WEB-INF/vista/RegistrarVisita.jsp";
                            break;
                        }

                        int idAgente = Integer.parseInt(idAgenteParam);
                        int idCliente = Integer.parseInt(idClienteParam);
                        int idInmueble = Integer.parseInt(idInmuebleParam);
                        LocalDate fecha = LocalDate.parse(fechaParam);
                        LocalTime hora = LocalTime.parse(horaParam);

                        agente = agenteF.find(idAgente);
                        Cliente cliente = clienteF.find(idCliente);
                        Inmueble inmueble = inmuebleF.find(idInmueble);

                        if (agente == null || cliente == null || inmueble == null) {
                            request.setAttribute("error", "Agente, cliente o inmueble no encontrados.");
                            url = "/WEB-INF/vista/RegistrarVisita.jsp";
                            break;
                        }

                        VisitaInmueblePK visitaPK = new VisitaInmueblePK();
                        visitaPK.setIdvisitaInmueble(0);
                        visitaPK.setFecha(fecha);

                        VisitaInmueble visita = new VisitaInmueble();
                        visita.setVisitaInmueblePK(visitaPK);
                        visita.setHora(hora);
                        visita.setEstado(estado);
                        visita.setAgente(agente);
                        visita.setCliente(cliente);
                        visita.setInmueble(inmueble);

                        visitaF.create(visita);

                        request.setAttribute("registroExitoso", true);
                        url = "/WEB-INF/vista/RegistrarVisita.jsp";
                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al registrar visita", e);
                        request.setAttribute("error", "Datos incorrectos para registrar la visita.");
                        url = "/WEB-INF/vista/RegistrarVisita.jsp";
                    }
                    break;

                case "/ListarInmuebles":
                    List<Inmueble> inmuebles = inmuebleF.findAll();
                    request.setAttribute("inmuebles", inmuebles);
                    url = "/WEB-INF/vista/ListarInmuebles.jsp";
                    request.getRequestDispatcher(url).forward(request, response);
                    break;

                case "/DetalleInmueble":
                    try {
                        String idParam = request.getParameter("id");
                        if (idParam != null && !idParam.isEmpty()) {
                            int idInmueble = Integer.parseInt(idParam);

                            Inmueble inmueble = inmuebleF.obtenerInmueblePorId(idInmueble);

                            if (inmueble != null) {
                                request.setAttribute("inmueble", inmueble);

                                url = "/WEB-INF/vista/DetalleInmueble.jsp";
                            } else {
                                request.setAttribute("error", "Inmueble no encontrado.");
                                url = "/WEB-INF/vista/error.jsp";
                            }
                        } else {
                            request.setAttribute("error", "ID de inmueble no especificado.");
                            url = "/WEB-INF/vista/error.jsp";
                        }
                    } catch (NumberFormatException e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al cargar detalles del inmueble", e);
                        request.setAttribute("error", "Error al cargar los detalles del inmueble.");
                        url = "/WEB-INF/vista/error.jsp";
                    }
                    break;

                case "/ListarClientes":
                    request.setAttribute("clientes", clienteF.findAll());
                    url = "/WEB-INF/vista/ListarClientes.jsp";
                    request.getRequestDispatcher(url).forward(request, response);

                    break;

                case "/EliminarCliente":
                    try {
                        String idClienteParam = request.getParameter("idCliente");
                        System.out.println("Id del cliente a eliminar: " + idClienteParam); // Debug

                        if (idClienteParam != null && !idClienteParam.isEmpty()) {
                            int idCliente = Integer.parseInt(idClienteParam);

                            // Buscar y eliminar el cliente
                            Cliente cliente = clienteF.find(idCliente);
                            if (cliente != null) {
                                clienteF.remove(cliente);
                                System.out.println("Cliente eliminado: " + cliente.getNombre()); // Debug
                            } else {
                                System.out.println("Cliente no encontrado para eliminación."); // Debug
                            }
                        }

                        List<Cliente> clientes = clienteF.findAll();

                        if (clientes != null && !clientes.isEmpty()) {
                            System.out.println("Lista de clientes obtenida con éxito.");
                        } else {
                            System.out.println("No se encontraron clientes o la lista está vacía.");
                        }

                        request.setAttribute("clientes", clientes);

                        url = "/WEB-INF/vista/ListarClientes.jsp";

                        if (!response.isCommitted()) {
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            System.out.println("La respuesta ya fue enviada, no se puede hacer forward.");
                        }

                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al eliminar cliente", e);
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar cliente.");
                    }
                    break;

                case "/EliminarInmueble":
                    try {
                        String idInmuebleParam = request.getParameter("idInmueble");
                        System.out.println("Id del inmueble a eliminar: " + idInmuebleParam); // Debug

                        if (idInmuebleParam != null && !idInmuebleParam.isEmpty()) {
                            int idInmueble = Integer.parseInt(idInmuebleParam);

                            Inmueble inmueble = inmuebleF.find(idInmueble);
                            if (inmueble != null) {
                                inmuebleF.remove(inmueble);
                                System.out.println("Inmueble eliminado: " + inmueble.getUbicacion()); // Debug
                            } else {
                                System.out.println("Inmueble no encontrado para eliminación."); // Debug
                            }
                        }

                        inmuebles = inmuebleF.findAll();

                        if (inmuebles != null && !inmuebles.isEmpty()) {
                            System.out.println("Lista de inmuebles obtenida con éxito.");
                        } else {
                            System.out.println("No se encontraron inmuebles o la lista está vacía.");
                        }

                        // Establecer la lista de inmuebles en el request
                        request.setAttribute("inmuebles", inmuebles);

                        // Redirigir a la página de listado de inmuebles
                        url = "/WEB-INF/vista/ListarInmuebles.jsp"; // Asegúrate de que esta ruta sea correcta

                        if (!response.isCommitted()) {
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            System.out.println("La respuesta ya fue enviada, no se puede hacer forward.");
                        }

                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al eliminar inmueble", e);
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar inmueble.");
                    }
                    break;

                case "/EliminarAgente":
                    try {
                        String idAgenteParam = request.getParameter("idAgente");
                        System.out.println("Id del agente a eliminar: " + idAgenteParam); // Debug

                        if (idAgenteParam != null && !idAgenteParam.isEmpty()) {
                            int idAgente = Integer.parseInt(idAgenteParam);

                            // Buscar y eliminar el agente
                            agente = agenteF.find(idAgente);
                            if (agente != null) {
                                agenteF.remove(agente);
                                System.out.println("Agente eliminado: " + agente.getNombre()); // Debug
                            } else {
                                System.out.println("Agente no encontrado para eliminación."); // Debug
                            }
                        }

                        // Obtener la lista de agentes nuevamente
                        List<Agente> agentes = agenteF.findAll();

                        // Verificar que la lista no esté vacía
                        if (agentes != null && !agentes.isEmpty()) {
                            System.out.println("Lista de agentes obtenida con éxito.");
                        } else {
                            System.out.println("No se encontraron agentes o la lista está vacía.");
                        }

                        // Establecer la lista de agentes en el request
                        request.setAttribute("agentes", agentes);

                        // Redirigir a la página de listado de agentes
                        url = "/WEB-INF/vista/ListarAgentes.jsp"; // Asegúrate de que esta ruta sea correcta

                        if (!response.isCommitted()) {
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            System.out.println("La respuesta ya fue enviada, no se puede hacer forward.");
                        }

                    } catch (Exception e) {
                        Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error al eliminar agente", e);
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar agente.");
                    }
                    break;

                case "/ListarAgentes":
                    try {
                        List<Agente> agentes = agenteF.findAll();

                        if (agentes != null && !agentes.isEmpty()) {
                            System.out.println("Lista de agentes obtenida con éxito.");
                        } else {
                            System.out.println("No se encontraron agentes o la lista está vacía.");
                        }

                        request.setAttribute("agentes", agentes);
                        url = "/WEB-INF/vista/ListarAgentes.jsp";

                        if (!response.isCommitted()) {
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            System.out.println("La respuesta ya fue enviada, no se puede hacer forward.");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al listar agentes.");
                    }
                    break;

                case "/RegistrarInmueble":
                    try {
                        // Obtener los parámetros del formulario
                        String titulo = request.getParameter("titulo");
                        String descripcion = request.getParameter("descripcion");
                        String ubicacion = request.getParameter("ubicacion");
                        String estado = request.getParameter("estado");
                        String tipo = request.getParameter("tipo");
                        String precioParam = request.getParameter("precio");

                        // Verificar que los campos no estén vacíos
                        if (titulo == null || titulo.isEmpty()
                                || descripcion == null || descripcion.isEmpty()
                                || ubicacion == null || ubicacion.isEmpty()
                                || estado == null || estado.isEmpty()
                                || tipo == null || tipo.isEmpty()
                                || precioParam == null || precioParam.isEmpty()) {
                            request.setAttribute("error", "Todos los campos son obligatorios.");
                            url = "/WEB-INF/vista/RegistrarInmueble.jsp";
                            break;
                        }

                        // Convertir el precio a BigDecimal
                        BigDecimal precio;
                        try {
                            precio = new BigDecimal(precioParam);
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "El precio debe ser un número válido.");
                            url = "/WEB-INF/vista/RegistrarInmueble.jsp";
                            break;
                        }

                        // Crear el objeto Inmueble y asignar los valores
                        Inmueble inmueble = new Inmueble();
                        inmueble.setTitulo(titulo);
                        inmueble.setDescripcion(descripcion);
                        inmueble.setUbicacion(ubicacion);
                        inmueble.setEstado(estado);
                        inmueble.setTipo(tipo);
                        inmueble.setPrecio(precio);

                        // Guardar el inmueble usando la fachada de Inmueble
                        inmuebleF.create(inmueble);

                        // Redirigir o pasar mensaje de éxito
                        request.setAttribute("mensaje", "Inmueble registrado exitosamente.");
                        url = "/WEB-INF/vista/RegistrarInmueble.jsp";
                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Ocurrió un error al registrar el inmueble.");
                        url = "/WEB-INF/vista/RegistrarInmueble.jsp";
                    }
                    break;

                case "/ListarVisitas":
                    request.setAttribute("visitas", visitaF.findAll());
                    url = "/WEB-INF/vista/ListarVisitas.jsp";
                    break;

                case "/CerrarSesion":
                    request.getSession().invalidate();
                    url = "index.jsp";
                    break;
            }

            request.getRequestDispatcher(url).forward(request, response);

        } catch (ServletException | IOException e) {
            Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, "Error en processRequest", e);
            request.setAttribute("error", "Ha ocurrido un error inesperado.");
            request.getRequestDispatcher("/WEB-INF/vista/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Manejador servlet for managing real estate platform actions";
    }
}
