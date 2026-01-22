# Projetos-Power-Bi
# 📦 Dashboard de Supply Chain: Gestão de Estoque e Curva ABC

![Status](https://img.shields.io/badge/Status-Concluído-success)
![Ferramenta](https://img.shields.io/badge/Power_BI-Desktop-yellow)
![Foco](https://img.shields.io/badge/Foco-Logística_%26_Supply_Chain-blue)

> **[🔗 CLIQUE AQUI PARA VER O DASHBOARD INTERATIVO](COLOQUE_SEU_LINK_DO_NOVYPRO_OU_POWERBI_AQUI)**

## 💼 O Desafio de Negócio
Uma distribuidora fictícia precisava gerenciar um inventário com **3.000 SKUs (produtos)** distintos. O objetivo principal era reduzir o capital imobilizado em produtos de baixo giro e evitar a ruptura (falta de estoque) em produtos de alto valor agregado.

**Perguntas a responder:**
1. Quais produtos estão com nível crítico de estoque (Ruptura ou Abaixo do Mínimo)?
2. Quanto de capital financeiro está "parado" no estoque hoje?
3. Quais são os produtos e fornecedores da **Classe A** (Curva ABC)?

---

## 🛠️ A Solução Construída

Utilizei o **Power BI** para transformar os dados brutos de movimentação em um painel estratégico.

### 1. Tratamento de Dados (ETL)
* **Correção de Localidade:** A base original utilizava ponto para decimais (padrão US), o que gerava erros de cálculo no Power BI Brasil. Foi aplicado tratamento no **Power Query** para conversão e tipagem correta dos dados.
* **Padronização:** Limpeza de nomes de categorias e fornecedores.

### 2. Modelagem e DAX Avançado
* **Cálculo Financeiro Preciso (Iteradores):**
    * *Problema:* Multiplicar totais de médias gera valores errados.
    * *Solução:* Uso da função `SUMX` para calcular `(Estoque * Custo)` linha a linha.
    ```dax
    Capital Imobilizado Real = SUMX(estoque_3000, estoque_3000[Estoque_Atual] * estoque_3000[Custo_Unitario])
    ```

* **Curva ABC (Pareto 80/20):**
    * Desenvolvimento de um algoritmo via DAX para classificar dinamicamente os produtos em classes A (70% do valor), B (20%) e C (10%).
    * Isso permitiu focar a gestão nos fornecedores que realmente impactam o fluxo de caixa.

* **Status Dinâmico (Semáforo):**
    * Lógica condicional (`SWITCH`) para classificar itens em: 🔴 Ruptura, 🟡 Reposição, 🔵 Excesso e 🟢 Saudável.

---

## 📊 Visualização de Dados (UI/UX)
* **Gráfico de Dispersão:** Análise de risco cruzando *Lead Time* (Eixo X) com *Nível de Estoque* (Eixo Y), permitindo identificar gargalos logísticos.
* **Treemap de Fornecedores:** Visualização hierárquica para identificar a concentração de capital por parceiro comercial.
* **Navegação:** Menu superior personalizado para transição entre visão tática (Giro) e estratégica (Fornecedores).

---

## 📂 Arquivos Neste Repositório
* `dashboard_estoque.pbix` - Arquivo editável do projeto.
* `estoque_3000.csv` - Base de dados gerada via script para simulação.

---

### 👨‍💻 Autor
Desenvolvido por **Gabriel**
*Conecte-se comigo no [LinkedIn](SEU_LINK_DO_LINKEDIN)*
