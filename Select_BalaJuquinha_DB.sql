-- Relatório de Frequência de Manutenção por Equipamento
SELECT 
    E.Nome AS Equipamento,
    TM.Descricao AS `Tipo Manutenção`,
    COUNT(OM.idOrdem_Manutencao) AS `Total Manutenções`
FROM 
    Ordem_Manutencao OM
JOIN 
    Equipamento E ON OM.Equipamento_idEquipamento = E.idEquipamento
JOIN 
    TipoManutencao TM ON OM.TipoManutencao_idTipoManutencao = TM.idTipoManutencao
GROUP BY 
    E.Nome, TM.Descricao
ORDER BY 
    E.Nome, TM.Descricao;


-- Relatório de Custos de Manutenção por Técnico
SELECT 
    T.Nome AS Tecnico,
    IFNULL(DATEDIFF(OM.DataConclusao, OM.DataSolicitacao), DATEDIFF(CURDATE(), OM.DataSolicitacao)) as `Quant. dias`,
    IFNULL(DATEDIFF(OM.DataConclusao, OM.DataSolicitacao), DATEDIFF(CURDATE(), OM.DataSolicitacao)) * 8 AS `Duração em Horas`,
    SUM(
        -- Cálculo da duração em dias
        DATEDIFF(
            IFNULL(OM.DataConclusao, CURDATE()), -- Se DataConclusao for NULL, usa a data atual
            OM.DataSolicitacao
        ) * 8 * T.SalarioHora + -- Custo da mão de obra
        IFNULL(
            (SELECT SUM(P.Custo)
             FROM Ordem_Manutencao_has_Peca OMP
             JOIN Peca P ON OMP.Peca_idPeca = P.idPeca
             WHERE OMP.Ordem_Manutencao_idOrdem_Manutencao = OM.idOrdem_Manutencao),
            0
        ) -- Custo total das peças, se houver
    ) AS `Custo Total`
FROM 
    Ordem_Manutencao_has_Tecnico OMT
JOIN 
    Tecnico T ON OMT.Tecnico_idTecnico = T.idTecnico
JOIN 
    Ordem_Manutencao OM ON OM.idOrdem_Manutencao = OMT.Ordem_Manutencao_idOrdem_Manutencao
GROUP BY 
    T.Nome, `Quant. dias`, `Duração em Horas`
ORDER BY 
    `Custo Total` DESC;

-- Relatório de Equipamentos com Maior Frequência de Falhas
SELECT 
    E.Nome AS Equipamento,
    COUNT(OM.idOrdem_Manutencao) AS Qtd_Corretivas
FROM 
    Ordem_Manutencao OM
JOIN 
    Equipamento E ON OM.Equipamento_idEquipamento = E.idEquipamento
JOIN 
    TipoManutencao TM ON OM.TipoManutencao_idTipoManutencao = TM.idTipoManutencao
WHERE 
    TM.Descricao = 'Corretiva'
GROUP BY 
    E.Nome
ORDER BY 
    Qtd_Corretivas DESC;

    
    
    
-- Custin fi
SELECT
    OM.idOrdem_Manutencao,
    E.Nome AS Equipamento,
    COALESCE(T.Nome, 'Não Atribuído') AS Tecnico, -- Usa 'Não Atribuído' se não houver técnico
    SOM.tipoStatus AS `Status Manutencao`,
    OM.DataSolicitacao AS `Data Solicitação`,
    -- Cálculo do Custo Estimado
    -- Mão de obra: (Data Atual - Data Solicitação) * 8 horas/dia * Salário por Hora do Técnico
    DATEDIFF(CURDATE(), OM.DataSolicitacao) * 8 * COALESCE(T.SalarioHora, 0) +
    -- Custo das peças: Soma do custo das peças associadas à ordem
    COALESCE(SUM(P.Custo), 0) AS `Custo Estimado`
FROM
    Ordem_Manutencao OM
JOIN
    Equipamento E ON OM.Equipamento_idEquipamento = E.idEquipamento
JOIN
    Status_Ordem_Manutencao SOM ON OM.Status_Ordem_Manutencao_idStatus = SOM.idStatus
LEFT JOIN
    Ordem_Manutencao_has_Tecnico OMT ON OM.idOrdem_Manutencao = OMT.Ordem_Manutencao_idOrdem_Manutencao
LEFT JOIN
    Tecnico T ON T.idTecnico = OMT.Tecnico_idTecnico
LEFT JOIN
    Ordem_Manutencao_has_Peca OMP ON OM.idOrdem_Manutencao = OMP.Ordem_Manutencao_idOrdem_Manutencao
LEFT JOIN
    Peca P ON OMP.Peca_idPeca = P.idPeca
WHERE
    SOM.tipoStatus = 'Pendente'
GROUP BY
    OM.idOrdem_Manutencao, E.Nome, T.Nome, SOM.tipoStatus, OM.DataSolicitacao, T.SalarioHora -- Inclui SalarioHora no GROUP BY para cálculo correto
ORDER BY
    OM.DataSolicitacao ASC;
    