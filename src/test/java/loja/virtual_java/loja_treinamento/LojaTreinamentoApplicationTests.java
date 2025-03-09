package loja.virtual_java.loja_treinamento;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import loja.virtual_java.loja_treinamento.Repository.AcessoRepository;
import loja.virtual_java.loja_treinamento.model.Acesso;
import loja.virtual_java.loja_treinamento.service.AcessoService;

@SpringBootTest(classes = LojaTreinamentoApplication.class)
public class LojaTreinamentoApplicationTests {

	@Autowired
	private AcessoService acessoService;

	// @Autowired
	// private AcessoRepository acessoRepository;

	@Test
	public void testeCadastroAcesso() {
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoService.save(acesso);
	}

}
