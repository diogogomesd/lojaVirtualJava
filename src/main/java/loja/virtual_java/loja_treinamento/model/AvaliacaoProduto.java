package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

@Entity
@Table(name = "avaliacao_produto")
@SequenceGenerator(name = "avaliacao_produto_seq", sequenceName = "avaliacao_produto_seq", allocationSize = 1, initialValue = 1)
public class AvaliacaoProduto {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "avaliacao_produto_seq")
    private Long id;

    @Column(name = "nota", nullable = false)
    private Integer nota;

    @Column(name = "descricao", nullable = false)
    private String descricao;

    @ManyToOne(targetEntity = Pessoa.class)
    @JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(name = "fk_pessoa", value = ConstraintMode.CONSTRAINT))
    private Pessoa pessoa;

    @ManyToOne
    @JoinColumn(name = "produto_id", nullable = false, foreignKey = @ForeignKey(name = "fk_produto", value = ConstraintMode.CONSTRAINT))
    private Produto produto;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getNota() {
        return nota;
    }

    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setNota(Integer nota) {
        this.nota = nota;
    }

    public Pessoa getPessoa() {
        return pessoa;
    }

    public void setPessoa(Pessoa pessoa) {
        this.pessoa = pessoa;
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
        AvaliacaoProduto other = (AvaliacaoProduto) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }
}
