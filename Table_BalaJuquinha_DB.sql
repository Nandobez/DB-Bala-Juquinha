DROP DATABASE IF EXISTS BalaJuquinha_DB;
CREATE DATABASE BalaJuquinha_DB DEFAULT CHARACTER SET utf8mb4;
USE BalaJuquinha_DB;

-- Tabela Peca
CREATE TABLE IF NOT EXISTS Peca (
    idPeca INT AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    Origem VARCHAR(45) NOT NULL,
    Custo DECIMAL(18,2) NOT NULL,
    Disponibilidade VARCHAR(45) NOT NULL,
    PRIMARY KEY (idPeca)
);

-- Tabela Tecnico
CREATE TABLE IF NOT EXISTS Tecnico (
    idTecnico INT AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    SalarioHora DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (idTecnico)
);

-- Tabela Equipamento
CREATE TABLE IF NOT EXISTS Equipamento (
    idEquipamento INT AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    Fabricante VARCHAR(45) NOT NULL,
    DataAquisicao DATE NOT NULL,
    Local VARCHAR(200) NOT NULL,
    Modelo VARCHAR(45),
    Status VARCHAR(45) NOT NULL,
    CustoInicial DECIMAL(18,2) NOT NULL,
    Periodicidade VARCHAR(100) NOT NULL,
    PRIMARY KEY (idEquipamento)
);

-- Tabela TipoManutencao
CREATE TABLE IF NOT EXISTS TipoManutencao (
    idTipoManutencao INT AUTO_INCREMENT,
    Descricao VARCHAR(200),
    PRIMARY KEY (idTipoManutencao)
);

-- Tabela Status_Ordem_Manutencao
CREATE TABLE IF NOT EXISTS Status_Ordem_Manutencao (
    idStatus INT AUTO_INCREMENT,
    tipoStatus VARCHAR(100) NOT NULL,
    PRIMARY KEY (idStatus)
);

-- Tabela Ordem_Manutencao
CREATE TABLE IF NOT EXISTS Ordem_Manutencao (
    idOrdem_Manutencao INT AUTO_INCREMENT,
    DataConclusao DATE NULL,
    DataSolicitacao DATE NOT NULL,
    Equipamento_idEquipamento INT NOT NULL,
    TipoManutencao_idTipoManutencao INT NOT NULL,
    Status_Ordem_Manutencao_idStatus INT NOT NULL,
    PRIMARY KEY (idOrdem_Manutencao)
    -- CUSTO COMO VARIAVEL DERIVADA -> VALORPECA + VALOR TECNICO.SALARIOHORA * DATEDIFF*8
);

-- Tabela Ordem_Manutencao_has_Tecnico
CREATE TABLE IF NOT EXISTS Ordem_Manutencao_has_Tecnico (
    Ordem_Manutencao_idOrdem_Manutencao INT NOT NULL,
    Tecnico_idTecnico INT NOT NULL,
    PRIMARY KEY (Ordem_Manutencao_idOrdem_Manutencao, Tecnico_idTecnico)
);

-- Tabela Equipamento_has_Peca
CREATE TABLE IF NOT EXISTS Equipamento_has_Peca (
    Equipamento_idEquipamento INT NOT NULL,
    Peca_idPeca INT NOT NULL,
    Descricao VARCHAR(180),
    PRIMARY KEY (Equipamento_idEquipamento, Peca_idPeca)
);

-- Tabela Qualificacao
CREATE TABLE IF NOT EXISTS Qualificacao (
    idQualificacao INT AUTO_INCREMENT,
    Descricao VARCHAR(180) NOT NULL,
    PRIMARY KEY (idQualificacao)
);

-- Tabela Tecnico_has_Qualificacao
CREATE TABLE IF NOT EXISTS Tecnico_has_Qualificacao (
    Tecnico_idTecnico INT NOT NULL,
    Qualificacao_idQualificacao INT NOT NULL,
    Experiencia INT,
    PRIMARY KEY (Tecnico_idTecnico, Qualificacao_idQualificacao)
);

-- Tabela Ordem_Manutencao_has_Peca
CREATE TABLE IF NOT EXISTS Ordem_Manutencao_has_Peca (
    Ordem_Manutencao_idOrdem_Manutencao INT NOT NULL,
    Peca_idPeca INT NOT NULL,
    PRIMARY KEY (Ordem_Manutencao_idOrdem_Manutencao, Peca_idPeca)
);

-- Índices corretamente criados nas colunas existentes
CREATE INDEX fk_Ordem_Manutencao_Equipamento1_idx ON Ordem_Manutencao (Equipamento_idEquipamento);
CREATE INDEX fk_Ordem_Manutencao_TipoManutencao1_idx ON Ordem_Manutencao (TipoManutencao_idTipoManutencao);
CREATE INDEX fk_Ordem_Manutencao_Status1_idx ON Ordem_Manutencao (Status_Ordem_Manutencao_idStatus);

ALTER TABLE Ordem_Manutencao
    ADD CONSTRAINT fk_Ordem_Manutencao_Equipamento1
        FOREIGN KEY (Equipamento_idEquipamento) REFERENCES Equipamento (idEquipamento),
    ADD CONSTRAINT fk_Ordem_Manutencao_TipoManutencao1
        FOREIGN KEY (TipoManutencao_idTipoManutencao) REFERENCES TipoManutencao (idTipoManutencao),
    ADD CONSTRAINT fk_Ordem_Manutencao_Status1_idx
        FOREIGN KEY (Status_Ordem_Manutencao_idStatus) REFERENCES Status_Ordem_Manutencao (idStatus);


CREATE INDEX fk_Ordem_Manutencao_has_Tecnico_Tecnico1_idx ON Ordem_Manutencao_has_Tecnico (Tecnico_idTecnico ASC);
CREATE INDEX fk_Ordem_Manutencao_has_Tecnico_Ordem_Manutencao_idx ON Ordem_Manutencao_has_Tecnico (Ordem_Manutencao_idOrdem_Manutencao ASC);

ALTER TABLE Ordem_Manutencao_has_Tecnico
    ADD CONSTRAINT fk_Ordem_Manutencao_has_Tecnico_Ordem_Manutencao
        FOREIGN KEY (Ordem_Manutencao_idOrdem_Manutencao) REFERENCES Ordem_Manutencao (idOrdem_Manutencao),
    ADD CONSTRAINT fk_Ordem_Manutencao_has_Tecnico_Tecnico1
        FOREIGN KEY (Tecnico_idTecnico) REFERENCES Tecnico (idTecnico);

CREATE INDEX fk_Equipamento_has_Peca_Peca1_idx ON Equipamento_has_Peca (Peca_idPeca ASC);
CREATE INDEX fk_Equipamento_has_Peca_Equipamento1_idx ON Equipamento_has_Peca (Equipamento_idEquipamento ASC);

ALTER TABLE Equipamento_has_Peca
    ADD CONSTRAINT fk_Equipamento_has_Peca_Equipamento1
        FOREIGN KEY (Equipamento_idEquipamento) REFERENCES Equipamento (idEquipamento),
    ADD CONSTRAINT fk_Equipamento_has_Peca_Peca1
        FOREIGN KEY (Peca_idPeca) REFERENCES Peca (idPeca);

CREATE INDEX fk_Tecnico_has_Qualificacao_Qualificacao1_idx ON Tecnico_has_Qualificacao (Qualificacao_idQualificacao ASC);
CREATE INDEX fk_Tecnico_has_Qualificacao_Tecnico1_idx ON Tecnico_has_Qualificacao (Tecnico_idTecnico ASC);

ALTER TABLE Tecnico_has_Qualificacao
    ADD CONSTRAINT fk_Tecnico_has_Qualificacao_Tecnico1
        FOREIGN KEY (Tecnico_idTecnico) REFERENCES Tecnico (idTecnico),
    ADD CONSTRAINT fk_Tecnico_has_Qualificacao_Qualificacao1
        FOREIGN KEY (Qualificacao_idQualificacao) REFERENCES Qualificacao (idQualificacao);

CREATE INDEX fk_Ordem_Manutencao_has_Peca_Peca1_idx ON Ordem_Manutencao_has_Peca (Peca_idPeca ASC);
CREATE INDEX fk_Ordem_Manutencao_has_Peca_Ordem_Manutencao1_idx ON Ordem_Manutencao_has_Peca (Ordem_Manutencao_idOrdem_Manutencao ASC);

ALTER TABLE Ordem_Manutencao_has_Peca
    ADD CONSTRAINT fk_Ordem_Manutencao_has_Peca_Ordem_Manutencao1
        FOREIGN KEY (Ordem_Manutencao_idOrdem_Manutencao) REFERENCES Ordem_Manutencao (idOrdem_Manutencao),
    ADD CONSTRAINT fk_Ordem_Manutencao_has_Peca_Peca1
        FOREIGN KEY (Peca_idPeca) REFERENCES Peca (idPeca);