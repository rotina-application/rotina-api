package io.github.projetorotina.rotina_api.infra;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration 
public class OpenApiConfig {
    @Bean 
    OpenAPI rotinaOpenAPI() {
        return new OpenAPI().info(new Info()
                .title("Rotina API")
                .version("v1")
                .description("API do Projeto Rotina"));
    }
}
