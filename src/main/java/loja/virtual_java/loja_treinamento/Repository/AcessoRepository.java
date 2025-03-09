package loja.virtual_java.loja_treinamento.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import loja.virtual_java.loja_treinamento.model.Acesso;

@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, Long> {
    //Acesso findByEmailAndSenha(String email, String senha);     
    
}
