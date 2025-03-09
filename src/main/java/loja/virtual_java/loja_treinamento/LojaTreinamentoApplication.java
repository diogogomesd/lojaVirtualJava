package loja.virtual_java.loja_treinamento;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EntityScan(basePackages = "loja.virtual_java.loja_treinamento.model")
@ComponentScan(basePackages = {"loja_treinamento.*"})
@EnableJpaRepositories(basePackages = {"loja.virtual_java.loja_treinamento.repository"})
@EnableTransactionManagement
public class LojaTreinamentoApplication {

	public static void main(String[] args) {
		SpringApplication.run(LojaTreinamentoApplication.class, args);
	}
}
