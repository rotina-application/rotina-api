# Rotina API

API do Projeto Rotina.

## Pre-requisitos

- JDK 25 (Temurin)
- Docker Desktop
- IntelliJ IDEA ou VS Code com Extension Pack for Java

## Como rodar

1. `cp .env.example .env` (no Windows: `copy .env.example .env`)
2. `docker compose up -d`
3. Rode `RotinaApiApplication` com a variavel `SPRING_PROFILES_ACTIVE=dev`
4. Swagger: http://localhost:8080/swagger-ui.html

## Fluxo de trabalho

1. `git switch main && git pull`
2. `git switch -c feature/nome-curto`
3. Commits no padrao Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`
4. `git push -u origin feature/nome-curto` e abra o PR para a main

## Migrations (Flyway)

- Arquivo: `src/main/resources/db/migration/V__descricao.sql`
- **Nunca** edite uma migration que ja esta na main. Crie uma nova.
