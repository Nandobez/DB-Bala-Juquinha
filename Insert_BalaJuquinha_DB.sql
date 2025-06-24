USE BalaJuquinha_DB;
START TRANSACTION;

-- ---
-- Dados para Equipamento
-- ---
INSERT INTO Equipamento (Nome, Fabricante, DataAquisicao, Local, Modelo, Status, CustoInicial, Periodicidade)
VALUES
('Torno Mecânico', 'CNC Ltda', '2020-03-15', 'Fábrica A - Linha 1', 'TM-500', 'Ativo', 25000.00, 'Anual'),
('Prensa Hidráulica', 'PressTech', '2018-08-10', 'Fábrica A - Linha 2', 'PH-300', 'Ativo', 40000.00, 'Semestral'),
('Esteira Transportadora', 'MoveIt', '2021-01-22', 'Fábrica B - Logística', 'ET-700', 'Inativo', 18000.00, 'Trimensal'),
('Empilhadeira Elétrica', 'LiftPro', '2022-07-01', 'Fábrica B - Armazém', 'EP-2000', 'Ativo', 35000.00, 'Anual'),
('Máquina de Solda a Laser', 'WeldTech', '2023-02-20', 'Fábrica A - Produção', 'SW-1000', 'Ativo', 60000.00, 'Anual'),
('Compressor de Ar Industrial', 'AirFlow', '2019-11-05', 'Fábrica C - Manutenção', 'CA-800', 'Ativo', 15000.00, 'Semestral'),
('Robô de Montagem', 'RoboCorp', '2023-10-10', 'Fábrica A - Montagem', 'RM-9000', 'Ativo', 80000.00, 'Anual'),
('Injetora de Plástico', 'PlasMold', '2017-06-25', 'Fábrica C - Injeção', 'IP-250', 'Ativo', 55000.00, 'Trimensal'),
('Gerador de Energia', 'PowerGen', '2020-09-12', 'Fábrica B - Apoio', 'GE-150', 'Ativo', 22000.00, 'Anual');

-- ---
-- Dados para Técnico
-- ---
INSERT INTO Tecnico (Nome, SalarioHora)
VALUES 
('Carlos Silva', 44.50),
('Ana Paula', 20.00),
('João Mendes', 35.00),
('Mariana Costa', 28.00),
('Pedro Oliveira', 38.00),
('Sofia Almeida', 30.00),
('Fernanda Lima', 32.00),
('Ricardo Souza', 41.00);

-- ---
-- Dados para Qualificação
-- ---
INSERT INTO Qualificacao (idQualificacao, Descricao) VALUES
(1, 'Máquinas Pesadas'),
(2, 'Máquinas Leves'),
(3, 'Elétrica Industrial'),
(4, 'Mecânica Fina'),
(5, 'Automação Industrial'),
(6, 'Sistemas Hidráulicos');

-- ---
-- Dados para Técnico_has_Qualificação
-- ---
INSERT INTO Tecnico_has_Qualificacao (Tecnico_idTecnico, Qualificacao_idQualificacao) VALUES 
(1, 1),  -- Carlos: Máquinas Pesadas
(1, 6),  -- Carlos: Sistemas Hidráulicos
(2, 2),  -- Ana: Máquinas Leves
(3, 1),  -- João: Máquinas Pesadas
(3, 3),  -- João: Elétrica Industrial
(4, 3),  -- Mariana: Elétrica Industrial
(5, 1),  -- Pedro: Máquinas Pesadas
(5, 3),  -- Pedro: Elétrica Industrial
(6, 2),  -- Sofia: Máquinas Leves
(6, 4),  -- Sofia: Mecânica Fina
(7, 5),  -- Fernanda: Automação Industrial
(7, 3),  -- Fernanda: Elétrica Industrial
(8, 1),  -- Ricardo: Máquinas Pesadas
(8, 6);  -- Ricardo: Sistemas Hidráulicos

-- ---
-- Dados para Peças
-- ---
INSERT INTO Peca (Nome, Origem, Custo, Disponibilidade)
VALUES 
('Correia de Transmissão', 'Fornecedora A', 150.00, 'Em estoque'),
('Sensor de Pressão', 'Fornecedora B', 300.00, 'Fora de estoque'),
('Motor Elétrico', 'Fornecedora C', 1200.00, 'Em estoque'),
('Válvula Solenoide', 'Fornecedora D', 80.00, 'Em estoque'),
('Placa de Circuito', 'Fornecedora E', 500.00, 'Em estoque'),
('Filtro de Óleo', 'Fornecedora F', 70.00, 'Em estoque'),
('Atuador Linear', 'Fornecedora G', 600.00, 'Em estoque'),
('Bomba Hidráulica', 'Fornecedora H', 950.00, 'Em estoque'),
('Rolamento de Esferas', 'Fornecedora A', 45.00, 'Em estoque');

-- ---
-- Dados para Equipamento_has_Peca
-- ---
INSERT INTO Equipamento_has_Peca (Equipamento_idEquipamento, Peca_idPeca, Descricao)
VALUES
(1, 1, 'Correia usada no torno'),
(2, 2, 'Sensor da prensa'),
(3, 3, 'Motor para esteira'),
(4, 4, 'Válvula da empilhadeira'),
(5, 5, 'Placa da máquina de solda'),
(6, 6, 'Filtro do compressor'),
(7, 7, 'Atuador do robô'),
(2, 8, 'Bomba para prensa hidráulica'),
(1, 9, 'Rolamento para o torno');

-- ---
-- Dados para Tipo de Manutenção
-- ---
INSERT INTO TipoManutencao (Descricao)
VALUES
('Preventiva'),
('Corretiva');

-- ---
-- Dados para Status_Ordem_Manutencao
-- ---
INSERT INTO Status_Ordem_Manutencao (tipoStatus) 
VALUES 
('Concluída'),
('Pendente'),
('Em Andamento');

-- ---
-- Dados para Ordem de Manutenção
-- ---
INSERT INTO Ordem_Manutencao (Status_Ordem_Manutencao_idStatus, DataSolicitacao, DataConclusao, Equipamento_idEquipamento, TipoManutencao_idTipoManutencao)
VALUES
(1, '2024-01-05', '2024-01-10', 1, 1),   -- Preventiva no Torno (5 dias)
(1, '2024-02-10', '2024-02-15', 2, 2),   -- Corretiva na Prensa (5 dias)
(2, '2025-05-31', NULL, 3, 2),         -- Corretiva na Esteira (Pendente) (NULL)
(1, '2024-03-01', '2024-03-05', 4, 1),   -- Preventiva na Empilhadeira (4 dias)
(2, '2025-05-25', NULL, 5, 2),         -- Corretiva na Máquina de Solda (Pendente) (NULL)
(1, '2024-05-20', '2024-05-25', 6, 1),   -- Preventiva no Compressor (5 dias)
(3, '2025-05-20', NULL, 7, 2),         -- Corretiva no Robô (Em Andamento) (NULL)
(1, '2024-07-15', '2024-07-16', 8, 2),   -- Corretiva na Injetora (1 dia)
(1, '2024-08-01', '2024-08-03', 9, 1),   -- Preventiva no Gerador (2 dias)
(1, '2025-05-28', '2025-05-29', 1, 1),   -- Preventiva no Torno (Adicionada na última interação) (1 dia)
(2, '2025-05-30', NULL, 1, 2);         -- Corretiva no Torno (Pendente) (NULL)

-- ---
-- Dados para Ordem_Manutencao_has_Tecnico
-- ---
INSERT INTO Ordem_Manutencao_has_Tecnico (Ordem_Manutencao_idOrdem_Manutencao, Tecnico_idTecnico)
VALUES
(1, 1),  -- Carlos no torno (preventiva) (5 dias)
(2, 3),  -- João na prensa (5 dias)
(3, 2),  -- Ana na esteira (NULL)
(4, 4),  -- Mariana na empilhadeira (4 dias)
(5, 5),  -- Pedro na máquina de solda (NULL)
 (7, 7),  -- Fernanda no robô (NULL)
(9, 1),  -- Carlos no gerador (2 dias)
(10, 1), -- Carlos na preventiva do Torno (1 dia)
(11, 3); -- João na corretiva do Torno (NULL)

-- ---
-- Dados para Ordem_Manutencao_has_Peca
-- ---
INSERT INTO Ordem_Manutencao_has_Peca (Ordem_Manutencao_idOrdem_Manutencao, Peca_idPeca)
VALUES
(1, 1),  -- Correia usada no torno (preventiva)
(2, 2),  -- Sensor na prensa
(3, 3),  -- Motor na esteira
(4, 4),  -- Válvula na empilhadeira
(5, 5),  -- Placa na máquina de solda
(7, 7),  -- Atuador no robô
(9, 9),  -- Rolamento no gerador
(10, 9), -- Rolamento na preventiva do Torno
(11, 2); -- **Sensor de Pressão na nova corretiva do Torno**

COMMIT;
-- rollback;