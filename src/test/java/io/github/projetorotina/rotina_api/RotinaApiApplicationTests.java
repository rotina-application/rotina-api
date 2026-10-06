package io.github.projetorotina.rotina_api;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

@SpringBootTest
@Testcontainers
class RotinaApiApplicationTests {
	@Container
	@ServiceConnection
	@SuppressWarnings("deprecation")
	static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:17");

	@Test
		void contextLoads() {
		// Passa somente se: o contexto do Spring sobe, o Flyway aplica as
		// migrations num Postgres real e as Entities batem com o schema
		// (por causa do ddl-auto: validate).
	}
}
