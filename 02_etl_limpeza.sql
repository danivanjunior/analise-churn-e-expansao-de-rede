-- Calculando o tempo de ativação (SLA) e tempo de permanência
CREATE VIEW vw_assinaturas_tratadas AS
SELECT 
    a.id_assinatura,
    c.id_cliente,
    c.cidade,
    c.regional,
    a.plano,
    a.valor_mensal,
    a.status_contrato,
    DATEDIFF(day, c.data_cadastro, a.data_ativacao) AS dias_para_ativacao,
    COALESCE(DATEDIFF(day, a.data_ativacao, a.data_cancelamento), DATEDIFF(day, a.data_ativacao, CURRENT_DATE)) AS dias_permanencia
FROM assinaturas a
INNER JOIN clientes c ON a.id_cliente = c.id_cliente;