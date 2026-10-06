package io.github.projetorotina.rotina_api;

import org.springframework.boot.SpringApplication;

public class TestRotinaApiApplication {

	public static void main(String[] args) {
		SpringApplication.from(RotinaApiApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
