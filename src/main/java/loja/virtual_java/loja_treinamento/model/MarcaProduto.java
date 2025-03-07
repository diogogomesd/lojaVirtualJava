package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name="marca_produto")
@SequenceGenerator(name = "seq_marca_produto", sequenceName = "seq_marca_produto", allocationSize = 1, initialValue = 1)
public class MarcaProduto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_marca_produto")
    private long id;
    private String nameDesc;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNameDesc() {
        return nameDesc;
    }

    public void setNameDesc(String nameDesc) {
        this.nameDesc = nameDesc;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (id ^ (id >>> 32));
        result = prime * result + ((nameDesc == null) ? 0 : nameDesc.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        MarcaProduto other = (MarcaProduto) obj;
        if (id != other.id)
            return false;
        if (nameDesc == null) {
            if (other.nameDesc != null)
                return false;
        } else if (!nameDesc.equals(other.nameDesc))
            return false;
        return true;
    }
    
}
