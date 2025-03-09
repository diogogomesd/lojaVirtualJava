package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

@Entity
@Table(name = "nota_fiscal_venda")
@SequenceGenerator(name = "nota_fiscal_venda_seq", sequenceName = "nota_fiscal_venda_seq", allocationSize = 1, initialValue = 1)
public class NotaFiscalVenda {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "nota_fiscal_venda_seq")
    private Long id;

    @Column(name = "numero_nota_fiscal", nullable = false)
    private String numeroNotaFiscal;

    @Column(name = "serie", nullable = false)
    private String serie;

    @Column(name = "tipo", nullable = false)
    private String tipo;

    @Column(columnDefinition = "text", nullable = false)
    private String xml;
    @Column(columnDefinition = "text", nullable = false)
    private String pdf;

    @OneToOne
    @JoinColumn(name = "venda_compra_loja_virtual_id", nullable = false, foreignKey = @ForeignKey(name = "fk_venda_compra_loja_virtual", value = ConstraintMode.CONSTRAINT))
    private VendaCompraLojaVirtual vendaCompra;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getNumeroNotaFiscal() {
        return numeroNotaFiscal;
    }
    public void setNumeroNotaFiscal(String numeroNotaFiscal) {
        this.numeroNotaFiscal = numeroNotaFiscal;
    }
    public String getSerie() {
        return serie;
    }
    public void setSerie(String serie) {
        this.serie = serie;
    }
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getXml() {
        return xml;
    }
    public void setXml(String xml) {
        this.xml = xml;
    }
    public String getPdf() {
        return pdf;
    }
    public void setPdf(String pdf) {
        this.pdf = pdf;
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
        NotaFiscalVenda other = (NotaFiscalVenda) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }


    
}
