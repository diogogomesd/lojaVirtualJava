package loja.virtual_java.loja_treinamento.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import loja.virtual_java.loja_treinamento.Repository.AcessoRepository;
import loja.virtual_java.loja_treinamento.model.Acesso;

@Service
public class AcessoService {
    
    @Autowired
    private AcessoRepository acessoRepository;

    public Acesso save(Acesso acesso) {
        return acessoRepository.save(acesso);
    }
}
