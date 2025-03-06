package loja.virtual_java.loja_treinamento.enums;

public enum TipoEndereco {
    COBRANCA("Cobrança"),
    ENTREGA("Entrega");

    private final String descricao;

    TipoEndereco(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
    public String toString() {
        return descricao;
    }
}
