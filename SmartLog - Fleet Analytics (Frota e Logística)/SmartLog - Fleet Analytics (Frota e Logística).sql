USE Logistica_DB;
GO

-- 1. SE A TABELA JÁ TIVER SIDO CRIADA PARCIALMENTE, VAMOS GARANTIR:
IF OBJECT_ID('Manutencoes', 'U') IS NOT NULL DROP TABLE Manutencoes;
IF OBJECT_ID('Oficinas', 'U') IS NOT NULL DROP TABLE Oficinas;
IF OBJECT_ID('Rotas_Padrao', 'U') IS NOT NULL DROP TABLE Rotas_Padrao;
GO

-- 2. CRIANDO A TABELA DE OFICINAS
CREATE TABLE Oficinas (
    ID_Oficina INT PRIMARY KEY,
    Nome_Oficina VARCHAR(100),
    Cidade VARCHAR(50),
    Tipo_Contrato VARCHAR(50), 
    Avaliacao_Servico INT 
);

INSERT INTO Oficinas VALUES 
(1, 'Oficina Central da Mina', 'Belo Horizonte', 'Interna', 5),
(2, 'Diesel Center Vale', 'Itabira', 'Parceira', 4),
(3, 'Auto Elétrica do Zé', 'Congonhas', 'Emergencia', 3),
(4, 'Truck Service Express', 'Betim', 'Parceira', 4),
(5, 'Mecânica Pesada Global', 'Ouro Preto', 'Parceira', 5);
GO

-- 3. CRIANDO A TABELA DE MANUTENÇÕES
CREATE TABLE Manutencoes (
    ID_Manutencao INT PRIMARY KEY IDENTITY(1,1),
    ID_Veiculo INT,
    ID_Oficina INT,
    Data_Entrada DATE,
    Custo_Total DECIMAL(10,2),
    Descricao_Servico VARCHAR(200),
    Tipo_Manutencao VARCHAR(20)
);
GO

-- 4. POPULANDO MANUTENÇÕES (Versão Corrigida do Loop)
DECLARE @i INT;
SET @i = 1;

WHILE @i <= 200
BEGIN
    INSERT INTO Manutencoes (ID_Veiculo, ID_Oficina, Data_Entrada, Custo_Total, Descricao_Servico, Tipo_Manutencao)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 50) + 1,
        (ABS(CHECKSUM(NEWID())) % 5) + 1, 
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID())) % 365), GETDATE()), 
        (ABS(CHECKSUM(NEWID())) % 5000) + 500, 
        'Troca de componentes e revisão', 
        CASE WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0 THEN 'Preventiva' ELSE 'Corretiva' END
    );
    
    SET @i = @i + 1;
END;
GO

-- 5. CRIANDO E POPULANDO ROTAS PADRÃO
CREATE TABLE Rotas_Padrao (
    ID_Rota INT PRIMARY KEY,
    Nome_Rota VARCHAR(100),
    Distancia_Padrao_KM DECIMAL(10,2),
    Tempo_Estimado_Horas DECIMAL(10,1),
    Tipo_Terreno VARCHAR(50)
);

INSERT INTO Rotas_Padrao VALUES
(1, 'Mina A -> Porto Seco', 450.00, 8.0, 'Asfalto'),
(2, 'Mina B -> Siderúrgica', 120.50, 3.5, 'Misto'),
(3, 'Centro CD -> Cliente Capital', 50.00, 1.5, 'Asfalto'),
(4, 'Mina A -> Barragem', 15.00, 0.8, 'Terra'),
(5, 'Inter-Estadual Log', 850.00, 14.0, 'Asfalto');
GO

-- 6. ATUALIZANDO VIAGENS COM AS ROTAS
-- Verifica se a coluna já existe antes de adicionar para não dar erro
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Viagens' AND COLUMN_NAME = 'ID_Rota')
BEGIN
    ALTER TABLE Viagens ADD ID_Rota INT;
END
GO

UPDATE Viagens
SET ID_Rota = (ABS(CHECKSUM(NEWID())) % 5) + 1;
GO

PRINT 'Tudo corrigido e tabelas criadas!';