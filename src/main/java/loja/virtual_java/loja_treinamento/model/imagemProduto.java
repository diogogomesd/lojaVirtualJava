package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

@Entity
@Table(name = "imagem_produto")
@SequenceGenerator(name = "seq_imagem_produto", 
    sequenceName = "seq_imagem_produto", allocationSize = 1, initialValue = 1)
public class imagemProduto {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagem_produto")
    private Long id;
    @Column(columnDefinition = "text")
    private String imagemOriginal;
    @Column(columnDefinition = "text")
    private String imagemMiniatura;

    @ManyToOne
    @JoinColumn(name = "produto_id", nullable = false, 
        foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "fk_imagem_produto_produto"))
    private Produto produto;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImagemOriginal() {
        return imagemOriginal;
    }

    public void setImagemOriginal(String imagemOriginal) {
        this.imagemOriginal = imagemOriginal;
    }

    public String getImagemMiniatura() {
        return imagemMiniatura;
    }

    public void setImagemMiniatura(String imagemMiniatura) {
        this.imagemMiniatura = imagemMiniatura;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
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
        imagemProduto other = (imagemProduto) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }
}
