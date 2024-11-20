package entidad;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;

@Entity
@Table(name = "agente", catalog = "dbinmuebles", schema = "")
public class Agente implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idagente", nullable = false)
    private Integer idagente;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "nombre", nullable = false, length = 45)
    private String nombre;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "telefono", nullable = false, length = 45)
    private String telefono;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 50)
    @Column(name = "email", nullable = false, length = 50)
    private String email;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "clave", nullable = false, length = 45)
    private String clave;

    public Agente() {
    }

    public Agente(Integer idagente) {
        this.idagente = idagente;
    }

    // Constructor completo
    public Agente(Integer idagente, String nombre, String telefono, String email, String clave) {
        this.idagente = idagente;
        this.nombre = nombre;
        this.telefono = telefono;
        this.email = email;
        this.clave = clave;
    }

    // Getters and Setters
    public Integer getIdagente() {
        return idagente;
    }

    public void setIdagente(Integer idagente) {
        this.idagente = idagente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }
}
