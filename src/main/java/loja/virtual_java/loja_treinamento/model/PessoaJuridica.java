package loja.virtual_java.loja_treinamento.model;

import jakarta.persistence.*;

@Entity
@Table(name = "pessoa_juridica")
@PrimaryKeyJoinColumn(name = "id")
public class PessoaJuridica extends Pessoa{
    
    private static final long serialVersionUID = 1L;
   
    @Column(name = "cnpj", nullable = false)
    private String cnpj;

    @Column(name = "inscricao_estadual", nullable = false)
    private String inscricaoEstadual;

    private String inscricaoMunicipal;

    @Column(name = "nome_fantazia", nullable = false)
    private String nomeFantazia;

    @Column(name = "razao_social", nullable = false)
    private String razaoSocial;
    
    private String categoria;

    public String getCnpj() {
        return cnpj;
    }
    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }
    public String getInscricaoEstadual() {
        return inscricaoEstadual;
    }
    public void setInscricaoEstadual(String inscricaoEstadual) {
        this.inscricaoEstadual = inscricaoEstadual;
    }
    public String getInscricaoMunicipal() {
        return inscricaoMunicipal;
    }
    public void setInscricaoMunicipal(String inscricaoMunicipal) {
        this.inscricaoMunicipal = inscricaoMunicipal;
    }
    public String getNomeFantazia() {
        return nomeFantazia;
    }
    public void setNomeFantazia(String nomeFantazia) {
        this.nomeFantazia = nomeFantazia;
    }
    public String getRazaoSocial() {
        return razaoSocial;
    }
    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }
    public String getCategoria() {
        return categoria;
    }
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    

}
