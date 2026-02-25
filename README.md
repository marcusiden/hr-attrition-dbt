# 🏢 HR Attrition Analytics — dbt + Snowflake

A end-to-end analytics engineering project analyzing employee attrition and turnover using the IBM HR Analytics dataset. Built with dbt Cloud and Snowflake.

---

## 📌 Project Overview

This project answers the question: **"Why do employees leave, and who is most at risk?"**

Using 1,470 employee records across 35 attributes, this pipeline transforms raw HR data into a structured data warehouse with attrition risk scores, satisfaction analysis, compensation benchmarking, and tenure segmentation.

---

## 🏗️ Architecture
```
Raw Layer (Snowflake)
        ↓
Staging Layer        → Clean, rename, cast raw data
        ↓
Intermediate Layer   → Business logic & transformations
        ↓
Marts Layer          → Star schema, ready for analysis
```

---

## 📊 Data Model

### Fact Table
| Table | Description |
|---|---|
| `fct_employees_attrition` | One row per employee with all metrics, risk scores and attrition flag |

### Dimension Tables
| Table | Description |
|---|---|
| `dim_employees` | Employee demographics and age bands |
| `dim_departments` | Department and job role hierarchy |
| `dim_satisfaction_scores` | Satisfaction scores and composite bands |

---

## 🔄 Pipeline Layers

### Staging
- Cleans and renames all 35 raw columns
- Casts data types and standardizes boolean fields
- Source: `RAW.RAW_HR_EMPLOYEES`

### Intermediate
| Model | Purpose |
|---|---|
| `int_employee_satisfaction` | Combines 5 satisfaction scores into a composite score and band |
| `int_tenure_bands` | Buckets years at company into tenure bands and career stages |
| `int_compensation_analysis` | Compares employee salary against role average, flags underpaid employees |
| `int_attrition_flags` | Builds attrition risk score (0-5) and risk label per employee |

### Marts
- Star schema design optimized for analytical queries
- Fact table materialized as table, staging and intermediate as views

---

## 🚨 Attrition Risk Score

Each employee is scored on 5 risk factors:

| Risk Factor | Condition |
|---|---|
| Overtime | Works overtime |
| Travel | Travels frequently |
| Low Satisfaction | Composite score below 2.5 |
| Underpaid | Earns 20%+ below role average |
| Stagnation | No promotion in 3+ years |

Scores are classified as:
- **Low Risk** — 0-1 factors
- **Medium Risk** — 2 factors  
- **High Risk** — 3+ factors

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Snowflake | Cloud data warehouse |
| dbt Cloud | Data transformation and modeling |
| GitHub | Version control |
| IBM HR Analytics Dataset | Source data (via Kaggle) |

---

## 📁 Project Structure
```
hr-attrition-dbt/
├── models/
│   ├── staging/          # Raw data cleaning
│   ├── intermediate/     # Business logic
│   └── marts/            # Star schema output
├── seeds/                # Static reference data
├── macros/               # Reusable SQL logic
├── tests/                # Custom data tests
└── dbt_project.yml
```

---

## 🚀 How to Run

1. Clone this repository
2. Set up a Snowflake account and load the IBM HR dataset into `RAW.RAW_HR_EMPLOYEES`
3. Connect dbt Cloud to Snowflake and this GitHub repository
4. Run the pipeline:
```bash
dbt deps
dbt build
dbt docs generate
```

---

## 📈 Key Business Questions Answered

- Which departments have the highest attrition rate?
- Do employees who work overtime leave more often?
- Is there a relationship between salary and attrition?
- Which tenure band has the highest turnover risk?
- Which employees are currently high risk of leaving?

---

## 📂 Data Source

[IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset) — Kaggle
