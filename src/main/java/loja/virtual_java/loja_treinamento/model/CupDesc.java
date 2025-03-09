package loja.virtual_java.loja_treinamento.model;

import java.math.BigDecimal;
import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "cup_desc")
@SequenceGenerator(name = "seq_cup_desc", sequenceName = "seq_cup_desc", allocationSize = 1, initialValue = 1)
public class CupDesc {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cup_desc")
    private Long id;

    @Column(name = "cod_descricao", nullable = false)
    private String codDescricao;

    private BigDecimal valorRealDesconto;

    private BigDecimal valorPorcentagemDesconto;

    @Column(name = "data_validade", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataValidade;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getCodDescricao() {
        return codDescricao;
    }
    public void setCodDescricao(String codDescricao) {
        this.codDescricao = codDescricao;
    }
    public BigDecimal getValorRealDesconto() {
        return valorRealDesconto;
    }
    public void setValorRealDesconto(BigDecimal valorRealDesconto) {
        this.valorRealDesconto = valorRealDesconto;
    }
    public BigDecimal getValorPorcentagemDesconto() {
        return valorPorcentagemDesconto;
    }
    public void setValorPorcentagemDesconto(BigDecimal valorPorcentagemDesconto) {
        this.valorPorcentagemDesconto = valorPorcentagemDesconto;
    }
    public Date getDataValidade() {
        return dataValidade;
    }
    public void setDataValidade(Date dataValidade) {
        this.dataValidade = dataValidade;
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
        CupDesc other = (CupDesc) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }    
}
