USE FoodFlash_DB;
GO

-- 1. Criando Diferença de Performance
-- McDonald's e Burger King (Rápidos: 15-30 min)
UPDATE Pedidos SET Tempo_Minutos = (ABS(CHECKSUM(NEWID())) % 15) + 15 WHERE ID_Restaurante IN (1, 2);

-- Pizzas e Sushi (Lentos: 40-60 min)
UPDATE Pedidos SET Tempo_Minutos = (ABS(CHECKSUM(NEWID())) % 20) + 40 WHERE ID_Restaurante IN (4, 5, 8);

-- 2. Criando Taxas de Entrega baseadas na distância (Simulação)
UPDATE Pedidos SET Taxa_Entrega = (Tempo_Minutos * 0.25) + (ABS(CHECKSUM(NEWID())) % 5);

PRINT 'Logística atualizada! Agora temos restaurantes rápidos e lentos.';