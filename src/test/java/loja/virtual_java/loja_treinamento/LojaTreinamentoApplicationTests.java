package loja.virtual_java.loja_treinamento;

import loja.virtual_java.loja_treinamento.controller.AcessoController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import loja.virtual_java.loja_treinamento.model.Acesso;

@SpringBootTest(classes = LojaTreinamentoApplication.class)
public class LojaTreinamentoApplicationTests {

	@Autowired
	private AcessoController acessoController;

	@Test
	public void testeCadastroAcesso() {
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_GENERAL");
		acessoController.salvarAcesso(acesso);
	}
}
