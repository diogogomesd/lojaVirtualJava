package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

@Entity
@Table(name = "item_venda_loja")
@SequenceGenerator(name = "seq_item_venda_loja", sequenceName = "seq_item_venda_loja", allocationSize = 1, initialValue = 1)
public class ItemVendaLoja {
 
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_item_venda_loja")
    private Long id;

    private Double quantidade;

    @ManyToOne
    @JoinColumn(name = "produto_id", nullable = false, foreignKey = @ForeignKey(name = "fk_produto", value = ConstraintMode.CONSTRAINT))
    private Produto produto;

    @ManyToOne
    @JoinColumn(name = "venda_compra_loja_virtual_id", nullable = false, foreignKey = @ForeignKey(name = "fk_venda_compra_loja_virtual", value = ConstraintMode.CONSTRAINT))
    private VendaCompraLojaVirtual vendaCompra;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Double quantidade) {
        this.quantidade = quantidade;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public VendaCompraLojaVirtual getVendaCompra() {
        return vendaCompra;
    }

    public void setVendaCompra(VendaCompraLojaVirtual vendaCompra) {
        this.vendaCompra = vendaCompra;
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
        ItemVendaLoja other = (ItemVendaLoja) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }
}
