package loja.virtual_java.loja_treinamento.model;

import java.math.BigDecimal;

import jakarta.persistence.*;

@Entity
@Table(name = "produto")
@SequenceGenerator(name = "seq_produto", sequenceName = "seq_produto", allocationSize = 1, initialValue = 1)
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_produto")
    private Long id;

    @Column(name = "tipo_unidade", nullable = false)
    private String tipoUnidade;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(columnDefinition = "text", length = 2000, nullable = false)
    private String descricao;

    /*Nota item nota produto : ASSOCIAR*/

    @Column(name = "peso", nullable = false)
    private Double peso;

    @Column(name = "altura", nullable = false)
    private Double altura;

    @Column(name = "largura", nullable = false)
    private Double largura;

    @Column(name = "profundidade", nullable = false)
    private Double profundidade;

    @Column(name = "valor_venda", nullable = false)
    private BigDecimal valorVenda = BigDecimal.ZERO;

    @Column(name = "quantidade_estoque", nullable = false)
    private Integer quantidadeEstoque = 0;

    private Integer quantidadeAlertaEstoque = 0;

    private String linkYouTube;

    private Boolean AlertaQuantidadeEstoque = Boolean.FALSE;
    
    private Integer quantidadeClique = 0;

    @Column(name = "ativo", nullable = false)
    private Boolean ativo = Boolean.TRUE;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getTipoUnidade() {
        return tipoUnidade;
    }
    public void setTipoUnidade(String tipoUnidade) {
        this.tipoUnidade = tipoUnidade;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public Double getPeso() {
        return peso;
    }
    public void setPeso(Double peso) {
        this.peso = peso;
    }
    public Double getAltura() {
        return altura;
    }
    public void setAltura(Double altura) {
        this.altura = altura;
    }
    public Double getLargura() {
        return largura;
    }
    public void setLargura(Double largura) {
        this.largura = largura;
    }
    public Double getProfundidade() {
        return profundidade;
    }
    public void setProfundidade(Double profundidade) {
        this.profundidade = profundidade;
    }
    public BigDecimal getValorVenda() {
        return valorVenda;
    }
    public void setValorVenda(BigDecimal valorVenda) {
        this.valorVenda = valorVenda;
    }
    public Integer getQuantidadeEstoque() {
        return quantidadeEstoque;
    }
    public void setQuantidadeEstoque(Integer quantidadeEstoque) {
        this.quantidadeEstoque = quantidadeEstoque;
    }
    public Integer getQuantidadeAlertaEstoque() {
        return quantidadeAlertaEstoque;
    }
    public void setQuantidadeAlertaEstoque(Integer quantidadeAlertaEstoque) {
        this.quantidadeAlertaEstoque = quantidadeAlertaEstoque;
    }
    public String getLinkYouTube() {
        return linkYouTube;
    }
    public void setLinkYouTube(String linkYouTube) {
        this.linkYouTube = linkYouTube;
    }
    public Boolean getAlertaQuantidadeEstoque() {
        return AlertaQuantidadeEstoque;
    }
    public void setAlertaQuantidadeEstoque(Boolean alertaQuantidadeEstoque) {
        AlertaQuantidadeEstoque = alertaQuantidadeEstoque;
    }
    public Integer getQunatidadeClique() {
        return quantidadeClique;
    }
    public void setQunatidadeClique(Integer qunatidadeClique) {
        this.quantidadeClique = qunatidadeClique;
    }
    public Boolean getAtivo() {
        return ativo;
    }
    public void setAtivo(Boolean ativo) {
        this.ativo = ativo;
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
        Produto other = (Produto) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }   
    
}
