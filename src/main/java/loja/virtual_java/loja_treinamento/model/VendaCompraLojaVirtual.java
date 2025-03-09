package loja.virtual_java.loja_treinamento.model;

import java.math.BigDecimal;
import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "venda_compra_loja_virtual")
@SequenceGenerator(name = "seq_venda_compra_loja_virtual", sequenceName = "seq_venda_compra_loja_virtual", allocationSize = 1, initialValue = 1)
public class VendaCompraLojaVirtual {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_venda_compra_loja_virtual")
    private Long id;

    @ManyToOne(targetEntity = Pessoa.class)
    @JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(name = "fk_pessoa", value = ConstraintMode.CONSTRAINT))
    private Pessoa pessoa;

    @ManyToOne
    @JoinColumn(name = "endereco_entrega_id", nullable = false, foreignKey = @ForeignKey(name = "fk_endereco_entrega", value = ConstraintMode.CONSTRAINT))
    private Endereco enderecoEntrega;

    @ManyToOne
    @JoinColumn(name = "endereco_cobranca_id", nullable = false, foreignKey = @ForeignKey(name = "fk_endereco_cobranca", value = ConstraintMode.CONSTRAINT))
    private Endereco enderecoCobranca;

    @Column(name = "valor_total", nullable = false)
    private BigDecimal valorTotal;

    private BigDecimal valorDesconto;

    @ManyToOne(targetEntity = FormaPagamento.class)
    @JoinColumn(name = "forma_pagamento_id", nullable = false, foreignKey = @ForeignKey(name = "fk_forma_pagamento", value = ConstraintMode.CONSTRAINT))
    private FormaPagamento formaPagamento;

    @OneToOne
    @JoinColumn(name = "nota_fiscal_venda_id", nullable = false, foreignKey = @ForeignKey(name = "fk_nota_fiscal_venda", value = ConstraintMode.CONSTRAINT))
    private NotaFiscalVenda notaFiscalVenda;

    @ManyToOne
    @JoinColumn(name = "cupom_desconto_id", foreignKey = @ForeignKey(name = "fk_cupom_desconto", value = ConstraintMode.CONSTRAINT))
    private CupDesc cupomDesconto;

    @Column(name = "valor_frete", nullable = false)
    private BigDecimal valorFrete;

    @Column(name = "dia_entrega", nullable = false)
    private Integer diaEntrega;

    @Column(name = "data_venda", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataVenda;

    @Column(name = "data_entrega", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataEntrega;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public Pessoa getPessoa() {
        return pessoa;
    }
    public void setPessoa(Pessoa pessoa) {
        this.pessoa = pessoa;
    }
    public Endereco getEnderecoEntrega() {
        return enderecoEntrega;
    }
    public void setEnderecoEntrega(Endereco enderecoEntrega) {
        this.enderecoEntrega = enderecoEntrega;
    }
    public Endereco getEnderecoCobranca() {
        return enderecoCobranca;
    }
    public void setEnderecoCobranca(Endereco enderecoCobranca) {
        this.enderecoCobranca = enderecoCobranca;
    }
    public BigDecimal getValorTotal() {
        return valorTotal;
    }
    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal;
    }
    public BigDecimal getValorDesconto() {
        return valorDesconto;
    }
    public void setValorDesconto(BigDecimal valorDesconto) {
        this.valorDesconto = valorDesconto;
    }
    public FormaPagamento getFormaPagamento() {
        return formaPagamento;
    }
    public void setFormaPagamento(FormaPagamento formaPagamento) {
        this.formaPagamento = formaPagamento;
    }
    public NotaFiscalVenda getNotaFiscalVenda() {
        return notaFiscalVenda;
    }
    public void setNotaFiscalVenda(NotaFiscalVenda notaFiscalVenda) {
        this.notaFiscalVenda = notaFiscalVenda;
    }
    public CupDesc getCupomDesconto() {
        return cupomDesconto;
    }
    public void setCupomDesconto(CupDesc cupomDesconto) {
        this.cupomDesconto = cupomDesconto;
    }
    public BigDecimal getValorFrete() {
        return valorFrete;
    }
    public void setValorFrete(BigDecimal valorFrete) {
        this.valorFrete = valorFrete;
    }
    public Integer getDiaEntrega() {
        return diaEntrega;
    }
    public void setDiaEntrega(Integer diaEntrega) {
        this.diaEntrega = diaEntrega;
    }
    public Date getDataVenda() {
        return dataVenda;
    }
    public void setDataVenda(Date dataVenda) {
        this.dataVenda = dataVenda;
    }
    public Date getDataEntrega() {
        return dataEntrega;
    }
    public void setDataEntrega(Date dataEntrega) {
        this.dataEntrega = dataEntrega;
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
        VendaCompraLojaVirtual other = (VendaCompraLojaVirtual) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }
}
