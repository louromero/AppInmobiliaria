/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package session;

import entidad.Agente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lulur
 */
@Stateless
public class AgenteFacade extends AbstractFacade<Agente> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AgenteFacade() {
        super(Agente.class);
    }

    /**
     * Método para autenticar a un agente en el sistema usando su correo y
     * contraseña.
     *
     * @param email El correo electrónico del agente.
     * @param clave La contraseña del agente.
     * @return El objeto Agente si las credenciales son correctas; null si no lo
     * son.
     */
    public Agente iniciarSesion(String email, String clave) {
        try {
            TypedQuery<Agente> query = em.createQuery("SELECT a FROM Agente a WHERE a.email = :email AND a.clave = :clave", Agente.class);
            query.setParameter("email", email);
            query.setParameter("clave", clave);
            return query.getSingleResult();
        } catch (NoResultException e) {
            // No se encontró un agente con las credenciales proporcionadas
            return null; // Retornar null si no hay coincidencias
        } catch (Exception e) {
            // Manejar cualquier otra excepción que pueda ocurrir
            Logger.getLogger(AgenteFacade.class.getName()).log(Level.SEVERE, "Error al iniciar sesión", e);
            return null; // Retornar null en caso de error
        }
    }

    /**
     * Método para registrar un nuevo agente en la base de datos.
     *
     * @param agente El objeto Agente a registrar.
     * @throws IllegalArgumentException Si el correo electrónico ya está
     * registrado.
     */
    /*public void RegistrarAgente(Agente agente) throws IllegalArgumentException {
        // Verificar si ya existe un agente con el mismo correo
        TypedQuery<Long> query = em.createQuery("SELECT COUNT(a) FROM Agente a WHERE a.email = :email", Long.class);
        query.setParameter("email", agente.getEmail());

        Long count = query.getSingleResult();
        if (count > 0) {
            throw new IllegalArgumentException("El correo electrónico ya está registrado.");
        }

        // Registrar el nuevo agente
        this.create(agente);
    }*/
    // AgenteFacade.java
    public Agente findByEmail(String email) {
        try {
            return (Agente) em.createQuery("SELECT a FROM Agente a WHERE a.email = :email")
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null; // Retorna null si no se encuentra ningún agente
        }
    }

}
