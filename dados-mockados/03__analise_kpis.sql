-- Análise de Taxa de Churn, Receita Ativa e SLA Médio por Regional
WITH metricas_regionais AS (
    SELECT 
        regional,
        COUNT(id_assinatura) AS total_contratos,
        SUM(CASE WHEN status_contrato = 'Cancelado' THEN 1 ELSE 0 END) AS total_cancelados,
        SUM(CASE WHEN status_contrato = 'Ativo' THEN valor_mensal ELSE 0 END) AS receita_mensal_ativa,
        AVG(dias_para_ativacao) AS media_dias_ativacao
    FROM vw_assinaturas_tratadas
    GROUP BY regional
)
SELECT 
    regional,
    total_contratos,
    total_cancelados,
    ROUND((CAST(total_cancelados AS FLOAT) / total_contratos) * 100, 2) AS taxa_churn_percentual,
    receita_mensal_ativa,
    ROUND(media_dias_ativacao, 1) AS sla_medio_ativacao_dias
FROM metricas_regionais
ORDER BY taxa_churn_percentual DESC;