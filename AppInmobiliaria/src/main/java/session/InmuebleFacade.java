/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package session;

import entidad.Inmueble;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

/**
 *
 * @author lulur
 */
@Stateless
public class InmuebleFacade extends AbstractFacade<Inmueble> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public InmuebleFacade() {
        super(Inmueble.class);
    }

    public Inmueble obtenerInmueblePorId(int id) {
        TypedQuery<Inmueble> query = em.createQuery("SELECT i FROM Inmueble i LEFT JOIN FETCH i.imagenesInmueble WHERE i.idinmueble = :id", Inmueble.class);
        query.setParameter("id", id);
        return query.getSingleResult();
    }
    
}