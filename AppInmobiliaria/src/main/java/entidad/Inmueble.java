package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;

/**
 *
 * @author lulur
 */
@Entity
@Table(name = "inmueble", catalog = "dbinmuebles", schema = "", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"idinmueble"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Inmueble.findAll", query = "SELECT i FROM Inmueble i"),
    @NamedQuery(name = "Inmueble.findByIdinmueble", query = "SELECT i FROM Inmueble i WHERE i.idinmueble = :idinmueble"),
    @NamedQuery(name = "Inmueble.findByTitulo", query = "SELECT i FROM Inmueble i WHERE i.titulo = :titulo"),
    @NamedQuery(name = "Inmueble.findByDescripcion", query = "SELECT i FROM Inmueble i WHERE i.descripcion = :descripcion"),
    @NamedQuery(name = "Inmueble.findByUbicacion", query = "SELECT i FROM Inmueble i WHERE i.ubicacion = :ubicacion"),
    @NamedQuery(name = "Inmueble.findByEstado", query = "SELECT i FROM Inmueble i WHERE i.estado = :estado"),
    @NamedQuery(name = "Inmueble.findByTipo", query = "SELECT i FROM Inmueble i WHERE i.tipo = :tipo"),
    @NamedQuery(name = "Inmueble.findByPrecio", query = "SELECT i FROM Inmueble i WHERE i.precio = :precio")})
public class Inmueble implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idinmueble", nullable = false)
    private Integer idinmueble;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "titulo", nullable = false, length = 45)
    private String titulo;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 800)
    @Column(name = "descripcion", nullable = false, length = 800)
    private String descripcion;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 80)
    @Column(name = "ubicacion", nullable = false, length = 80)
    private String ubicacion;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 8)
    @Column(name = "estado", nullable = false, length = 8)
    private String estado;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "tipo", nullable = false, length = 12)
    private String tipo;

    @Basic(optional = false)
    @NotNull
    @Column(name = "precio", nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "inmueble")
    private Collection<ImagenesInmueble> imagenesInmuebleCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "inmueble")
    private Collection<VisitaInmueble> visitaInmuebleCollection;

    // Relación con imágenes
    /*@OneToMany(mappedBy = "inmueble", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ImagenesInmueble> imagenesInmueble;*/

    @OneToMany(mappedBy = "inmueble", fetch = FetchType.LAZY)
    private List<ImagenesInmueble> imagenesInmueble;

    public List<ImagenesInmueble> getImagenesInmueble() {
        return imagenesInmueble;
    }

    public void setImagenesInmueble(List<ImagenesInmueble> imagenesInmueble) {
        this.imagenesInmueble = imagenesInmueble;
    }

    public Inmueble() {
    }

    public Inmueble(Integer idinmueble) {
        this.idinmueble = idinmueble;
    }

    public Inmueble(Integer idinmueble, String titulo, String descripcion, String ubicacion, String estado, String tipo, BigDecimal precio) {
        this.idinmueble = idinmueble;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.ubicacion = ubicacion;
        this.estado = estado;
        this.tipo = tipo;
        this.precio = precio;
    }

    public Integer getIdinmueble() {
        return idinmueble;
    }

    public void setIdinmueble(Integer idinmueble) {
        this.idinmueble = idinmueble;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    @XmlTransient
    public Collection<ImagenesInmueble> getImagenesInmuebleCollection() {
        return imagenesInmuebleCollection;
    }

    public void setImagenesInmuebleCollection(Collection<ImagenesInmueble> imagenesInmuebleCollection) {
        this.imagenesInmuebleCollection = imagenesInmuebleCollection;
    }

    @XmlTransient
    public Collection<VisitaInmueble> getVisitaInmuebleCollection() {
        return visitaInmuebleCollection;
    }

    public void setVisitaInmuebleCollection(Collection<VisitaInmueble> visitaInmuebleCollection) {
        this.visitaInmuebleCollection = visitaInmuebleCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idinmueble != null ? idinmueble.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Inmueble)) {
            return false;
        }
        Inmueble other = (Inmueble) object;
        return this.idinmueble != null && this.idinmueble.equals(other.idinmueble);
    }

    @Override
    public String toString() {
        return "entidad.Inmueble[ idinmueble=" + idinmueble + " ]";
    }
}
