# Análise de churn, receita e SLA de ativação em telecom (SQL)
Repositório destinado a análise de churn, SLA de ativação e receita regional em telecomunicações utilizando SQL, CTEs e modelagem relacional.

> **Nota de contexto:** Esse projeto reproduz uma solução analítica desenvolvida e aplicada em ambiente corporativo real no setor de Telecomunicações. Para fins de portfólio e proteção de dados (LGPD), todos os registros, valores e identidades presentes neste repositório foram **substituídos por dados fictícios (mockados)**, mantendo fielmente a lógica de negócio e a arquitetura técnica originais.

---

## O que me levou a agir?
Na operação de expansão em telecomunicações, acompanhávamos o volume bruto de vendas e o total de cancelamentos de forma isolada em planilhas. Tínhamos um problema claro: vendíamos bem, mas a base líquida não crescia na mesma proporção em determinadas cidades.

Faltava visibilidade para responder a três perguntas de negócio:
- O cancelamento está concentrado em alguma regional ou plano específico?
- Existe relação entre a demora na instalação técnica (SLA) e o cancelamento precoce do cliente?
- Quanto dinheiro estamos deixando na mesa por regional?
Pra resolver isso, estruturei uma base relacional e criei uma rotina em SQL pra cruzar os dados de cadastro comercial com os eventos de ativação e cancelamento.

## Resultados e impacto no negócio

A implementação dessa rotina de monitoramento permitiu sair de relatórios manuais pra uma visão da operação por regional. Com o cruzamento de dados de cadastro, ativação e cancelamento, conseguimos:

* **Identificar o foco do Churn:** A **Regional Sul** concentrou **50% de taxa de cancelamento**, puxada pelo plano de maior ticket médio (`Fibra 1GB`), revelando falhas no pós-venda e na entrega técnica dessa região;
* **Mapear o gargalo de ativação (SLA):** Identificamos que clientes que demoram **mais de 4 dias** para serem ativados têm uma propensão drasticamente maior ao cancelamento nos primeiros 90 dias;
* **Proteger a receita recorrente (MRR):** O diagnóstico permitiu priorizar a fila de instalação técnica nas regiões críticas, reduzindo o tempo médio de ativação e estancando a perda de receita mensal.

| Regional | Total de Contratos | Contratos Cancelados | Taxa de Churn (%) | SLA Médio de Ativação | Receita Mensal Ativa |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Norte** | 4 | 2 | **50,00%** 🔴 | 3,3 dias | R$ 179,80 |
| **Sul** | 2 | 1 | **50,00%** 🔴 | 4,5 dias | R$ 149,90 |
| **Metropolitana** | 2 | 0 | **0,00%** 🟢 | 1,5 dias | R$ 179,80 |

### Visão Visual: Taxa de Churn vs. SLA de Ativação

```text
Taxa de Churn por Regional:
Norte         | ████████████████████ 50.0% (SLA: 3.3 dias)
Sul           | ████████████████████ 50.0% (SLA: 4.5 dias)
Metropolitana |                      00.0% (SLA: 1.5 dias)
