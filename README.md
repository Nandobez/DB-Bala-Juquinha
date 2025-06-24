# Gerenciamento de Manutenção de Equipamentos Industriais

Este projeto oferece um esquema de banco de dados e dados iniciais para um sistema de gerenciamento de manutenção, projetado para rastrear equipamentos, ordens de manutenção, técnicos e peças.

## Sumário

  * [Estrutura do Banco de Dados](https://www.google.com/search?q=%23estrutura-do-banco-de-dados)
  * [Começando](https://www.google.com/search?q=%23come%C3%A7ando)
      * [Pré-requisitos](https://www.google.com/search?q=%23pr%C3%A9-requisitos)
      * [Instalação](https://www.google.com/search?q=%23instala%C3%A7%C3%A3o)
  * [Consultando o Banco de Dados](https://www.google.com/search?q=%23consultando-o-banco-de-dados)
  * [Contribuindo](https://www.google.com/search?q=%23contribuindo)
  * [Licença](https://www.google.com/search?q=%23licen%C3%A7a)

## Estrutura do Banco de Dados

O banco de dados `BalaJuquinha_DB` é composto pelas seguintes tabelas:

  * **Peca**: Armazena informações sobre peças de reposição.
      * `idPeca` (INT, PK, AUTO\_INCREMENT): Identificador único da peça.
      * `Nome` (VARCHAR(200)): Nome da peça.
      * `Origem` (VARCHAR(45)): Origem/fornecedor da peça.
      * `Custo` (DECIMAL(18,2)): Custo da peça.
      * `Disponibilidade` (VARCHAR(45)): Status de disponibilidade da peça.
  * **Tecnico**: Armazena informações sobre técnicos de manutenção.
      * `idTecnico` (INT, PK, AUTO\_INCREMENT): Identificador único do técnico.
      * `Nome` (VARCHAR(200)): Nome do técnico.
      * `SalarioHora` (DECIMAL(18,2)): Salário por hora do técnico.
  * **Equipamento**: Armazena informações sobre equipamentos industriais.
      * `idEquipamento` (INT, PK, AUTO\_INCREMENT): Identificador único do equipamento.
      * `Nome` (VARCHAR(200)): Nome do equipamento.
      * `Fabricante` (VARCHAR(45)): Fabricante do equipamento.
      * `DataAquisicao` (DATE): Data de aquisição do equipamento.
      * `Local` (VARCHAR(200)): Localização do equipamento.
      * `Modelo` (VARCHAR(45)): Modelo do equipamento.
      * `Status` (VARCHAR(45)): Status operacional atual do equipamento.
      * `CustoInicial` (DECIMAL(18,2)): Custo inicial do equipamento.
      * `Periodicidade` (VARCHAR(100)): Periodicidade da manutenção.
  * **TipoManutencao**: Define os tipos de manutenção (ex: Preventiva, Corretiva).
      * `idTipoManutencao` (INT, PK, AUTO\_INCREMENT): Identificador único para o tipo de manutenção.
      * `Descricao` (VARCHAR(200)): Descrição do tipo de manutenção.
  * **Status\_Ordem\_Manutencao**: Define os possíveis status para as ordens de manutenção.
      * `idStatus` (INT, PK, AUTO\_INCREMENT): Identificador único para o status.
      * `tipoStatus` (VARCHAR(100)): Descrição do status (ex: 'Concluída', 'Pendente', 'Em Andamento').
  * **Ordem\_Manutencao**: Armazena detalhes sobre as ordens de manutenção.
      * `idOrdem_Manutencao` (INT, PK, AUTO\_INCREMENT): Identificador único da ordem de manutenção.
      * `DataConclusao` (DATE): Data de conclusão da ordem de manutenção.
      * `DataSolicitacao` (DATE): Data de solicitação da ordem de manutenção.
      * `Equipamento_idEquipamento` (INT, FK): Chave estrangeira para a tabela `Equipamento`.
      * `TipoManutencao_idTipoManutencao` (INT, FK): Chave estrangeira para a tabela `TipoManutencao`.
      * `Status_Ordem_Manutencao_idStatus` (INT, FK): Chave estrangeira para a tabela `Status_Ordem_Manutencao`.
  * **Ordem\_Manutencao\_has\_Tecnico**: Tabela de junção que liga ordens de manutenção a técnicos.
      * `Ordem_Manutencao_idOrdem_Manutencao` (INT, PK, FK): Chave estrangeira para `Ordem_Manutencao`.
      * `Tecnico_idTecnico` (INT, PK, FK): Chave estrangeira para `Tecnico`.
  * **Equipamento\_has\_Peca**: Tabela de junção que liga equipamentos às suas peças associadas.
      * `Equipamento_idEquipamento` (INT, PK, FK): Chave estrangeira para `Equipamento`.
      * `Peca_idPeca` (INT, PK, FK): Chave estrangeira para `Peca`.
      * `Descricao` (VARCHAR(180)): Descrição de como a peça é utilizada com o equipamento.
  * **Qualificacao**: Armazena diversas qualificações que os técnicos podem ter.
      * `idQualificacao` (INT, PK, AUTO\_INCREMENT): Identificador único para a qualificação.
      * `Descricao` (VARCHAR(180)): Descrição da qualificação.
  * **Tecnico\_has\_Qualificacao**: Tabela de junção que liga técnicos às suas qualificações.
      * `Tecnico_idTecnico` (INT, PK, FK): Chave estrangeira para `Tecnico`.
      * `Qualificacao_idQualificacao` (INT, PK, FK): Chave estrangeira para `Qualificacao`.
      * `Experiencia` (INT): Anos de experiência com esta qualificação.
  * **Ordem\_Manutencao\_has\_Peca**: Tabela de junção que liga ordens de manutenção às peças utilizadas.
      * `Ordem_Manutencao_idOrdem_Manutencao` (INT, PK, FK): Chave estrangeira para `Ordem_Manutencao`.
      * `Peca_idPeca` (INT, PK, FK): Chave estrangeira para `Peca`.

## Começando

Estas instruções permitirão que você tenha uma cópia do projeto em execução em sua máquina local.

### Pré-requisitos

  * Servidor MySQL (ou um sistema de banco de dados SQL compatível)

### Instalação

1.  **Crie o Banco de Dados e as Tabelas:**
    Execute o script `Table_BalaJuquinha_DB.sql` para criar o banco de dados e todas as tabelas necessárias.

    ```bash
    mysql -u seu_usuario -p < Table_BalaJuquinha_DB.sql
    ```

2.  **Popule o Banco de Dados:**
    Execute o script `Insert_BalaJuquinha_DB.sql` para inserir os dados iniciais nas tabelas.

    ```bash
    mysql -u seu_usuario -p BalaJuquinha_DB < Insert_BalaJuquinha_DB.sql
    ```

## Consultando o Banco de Dados

O arquivo `Select_BalaJuquinha_DB.sql` contém exemplos de consultas para obter vários relatórios e insights do banco de dados. Estes incluem:

  * **Relatório de Frequência de Manutenção por Equipamento**: Mostra o número total de manutenções por equipamento e tipo de manutenção.
  * **Relatório de Custos de Manutenção por Técnico**: Calcula o custo total de manutenção atribuído a cada técnico, considerando mão de obra e peças.
  * **Relatório de Equipamentos com Maior Frequência de Falhas**: Identifica os equipamentos que passaram por mais manutenções corretivas.
  * **Custo Estimado de Ordens de Manutenção Pendentes**: Estima o custo para ordens de manutenção pendentes, incluindo mão de obra (baseado na data atual) e peças.

Você pode executar essas consultas usando seu cliente MySQL:

```bash
mysql -u seu_usuario -p BalaJuquinha_DB < Select_BalaJuquinha_DB.sql
```

## Contribuindo

Sinta-se à vontade para fazer um fork deste repositório, sugerir melhorias ou enviar pull requests.

## Licença

Este projeto é de código aberto e está disponível sob a [Licença MIT](https://www.google.com/search?q=LICENSE).
