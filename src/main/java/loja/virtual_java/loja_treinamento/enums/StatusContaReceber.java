package loja.virtual_java.loja_treinamento.enums;

public enum StatusContaReceber {

    COBRANCA("Cobrança"),
    VENCIDA("Vencida"),
    ABERTA("Aberta"),
    QUITADA("Quitada");

    private String descricao;

    private StatusContaReceber(String descricao){
        this.descricao=descricao;
    }
    public String getDescricao(){
        return descricao;
    }
    
    @Override
    public String toString(){
        return this.getDescricao();
    }
}
