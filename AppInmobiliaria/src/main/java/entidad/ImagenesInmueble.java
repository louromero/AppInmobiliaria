package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 *
 * @author lulur
 */
@Entity
@Table(name = "imagenes_inmueble", catalog = "dbinmuebles", schema = "", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"idimagenes_inmueble"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ImagenesInmueble.findAll", query = "SELECT i FROM ImagenesInmueble i"),
    @NamedQuery(name = "ImagenesInmueble.findByIdimagenesInmueble", query = "SELECT i FROM ImagenesInmueble i WHERE i.idimagenesInmueble = :idimagenesInmueble"),
    @NamedQuery(name = "ImagenesInmueble.findByUrlImagen", query = "SELECT i FROM ImagenesInmueble i WHERE i.url_imagen = :url_imagen"),
    @NamedQuery(name = "ImagenesInmueble.findByDescripcion", query = "SELECT i FROM ImagenesInmueble i WHERE i.descripcion = :descripcion")})
public class ImagenesInmueble implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idimagenes_inmueble", nullable = false)
    private Integer idimagenesInmueble;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "url_imagen", nullable = false, length = 255)
    private String url_imagen;  // Ajuste en el nombre para mantener consistencia con el getter y setter

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "descripcion", nullable = false, length = 255)
    private String descripcion;

    @JoinColumn(name = "inmueble_idinmueble", referencedColumnName = "idinmueble", nullable = false)
    @ManyToOne(optional = false)
    private Inmueble inmueble;

    public ImagenesInmueble() {
    }

    public ImagenesInmueble(Integer idimagenesInmueble) {
        this.idimagenesInmueble = idimagenesInmueble;
    }

    public ImagenesInmueble(Integer idimagenesInmueble, String url_imagen, String descripcion) {
        this.idimagenesInmueble = idimagenesInmueble;
        this.url_imagen = url_imagen; // Ajuste en el nombre para mantener consistencia
        this.descripcion = descripcion;
    }

    public Integer getIdimagenesInmueble() {
        return idimagenesInmueble;
    }

    public void setIdimagenesInmueble(Integer idimagenesInmueble) {
        this.idimagenesInmueble = idimagenesInmueble;
    }

    public String getUrlImagen() {
        return url_imagen;
    }

    public void setUrlImagen(String url_imagen) {
        this.url_imagen = url_imagen;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Inmueble getInmueble() {
        return inmueble;
    }

    public void setInmueble(Inmueble inmueble) {
        this.inmueble = inmueble;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idimagenesInmueble != null ? idimagenesInmueble.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof ImagenesInmueble)) {
            return false;
        }
        ImagenesInmueble other = (ImagenesInmueble) object;
        return this.idimagenesInmueble != null && this.idimagenesInmueble.equals(other.idimagenesInmueble);
    }

    @Override
    public String toString() {
        return "entidad.ImagenesInmueble[ idimagenesInmueble=" + idimagenesInmueble + " ]";
    }
}


