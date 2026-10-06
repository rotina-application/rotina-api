-- gen_random_uuid() é nativo no PostgreSQL 13+; não precisa de extensão.
CREATE TABLE usuario (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL CHECK (TRIM(email) <> ''),
    senha_hash VARCHAR(255),
    google_id VARCHAR(255),
    email_verificado BOOLEAN NOT NULL DEFAULT FALSE,
    ofensiva_atual INTEGER NOT NULL DEFAULT 0,
    ultima_atividade DATE,
    timezone VARCHAR(64) NOT NULL DEFAULT 'America/Sao_Paulo',
    data_cadastro TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uk_usuario_google_id UNIQUE (google_id),
    CONSTRAINT ck_usuario_credencial CHECK (
        (senha_hash IS NOT NULL AND TRIM(senha_hash) <> '') OR 
        (google_id IS NOT NULL AND TRIM(google_id) <> '')
    ),
    CONSTRAINT ck_usuario_ofensiva CHECK (ofensiva_atual >= 0)
);

-- Impede cadastrar Joao@x.com e joao@x.com como contas diferentes
CREATE UNIQUE INDEX ux_usuario_email_lower ON usuario (LOWER(TRIM(email)));

CREATE TABLE sessao_pomodoro (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL,
    inicio TIMESTAMPTZ NOT NULL,
    fim TIMESTAMPTZ,
    duracao_minutos INTEGER,
    ciclos_concluidos INTEGER NOT NULL DEFAULT 0,
    timestamp_frontend TIMESTAMPTZ,
    status_validacao VARCHAR(20) NOT NULL DEFAULT 'EM_ANDAMENTO',
    CONSTRAINT fk_sessao_usuario FOREIGN KEY (usuario_id) 
        REFERENCES usuario (id) ON DELETE CASCADE,
    CONSTRAINT ck_sessao_status 
        CHECK (status_validacao IN ('EM_ANDAMENTO','VALIDA','SUSPEITA','DESCARTADA')),
    CONSTRAINT ck_sessao_periodo CHECK (fim IS NULL OR fim >= inicio),
    CONSTRAINT ck_sessao_duracao CHECK (duracao_minutos IS NULL OR duracao_minutos >= 0),
    CONSTRAINT ck_sessao_ciclos CHECK (ciclos_concluidos >= 0),
    CONSTRAINT ck_sessao_fim_duracao CHECK (fim IS NULL OR duracao_minutos IS NOT NULL)
);

CREATE INDEX ix_sessao_usuario_inicio ON sessao_pomodoro (usuario_id, inicio DESC);

CREATE TABLE medalha (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    icone_url VARCHAR(255),
    criterio_desbloqueio VARCHAR(100) NOT NULL,
    CONSTRAINT uk_medalha_nome UNIQUE (nome)
);

CREATE TABLE usuario_medalha (
    usuario_id UUID NOT NULL,
    medalha_id UUID NOT NULL,
    data_conquista TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT pk_usuario_medalha PRIMARY KEY (usuario_id, medalha_id),
    CONSTRAINT fk_um_usuario FOREIGN KEY (usuario_id) 
        REFERENCES usuario (id) ON DELETE CASCADE,
    CONSTRAINT fk_um_medalha FOREIGN KEY (medalha_id) 
        REFERENCES medalha (id) ON DELETE CASCADE
);