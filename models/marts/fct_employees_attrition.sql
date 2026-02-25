with stg as (
    select * from {{ ref('stg_hr_employees') }}
),

satisfaction as (
    select * from {{ ref('int_employee_satisfaction') }}
),

compensation as (
    select * from {{ ref('int_compensation_analysis') }}
),

tenure as (
    select * from {{ ref('int_tenure_bands') }}
),

flags as (
    select * from {{ ref('int_attrition_flags') }}
)

select
    -- keys
    {{ dbt_utils.generate_surrogate_key(['stg.employee_id']) }} as attrition_key,
    stg.employee_id,

    -- employee profile
    stg.department,
    stg.job_role,
    stg.job_level,
    stg.business_travel,
    stg.overtime,

    -- compensation
    stg.monthly_income,
    comp.avg_income_by_role,
    comp.income_vs_role_avg,
    comp.is_underpaid,
    stg.percent_salary_hike,
    stg.stock_option_level,

    -- satisfaction
    sat.composite_satisfaction_score,
    sat.satisfaction_band,

    -- tenure
    ten.years_at_company,
    ten.tenure_band,
    ten.career_stage,
    ten.years_since_last_promotion,

    -- performance
    stg.performance_rating,
    stg.training_times_last_year,

    -- attrition risk
    flags.attrition_risk_score,
    flags.attrition_risk_label,

    -- target
    stg.is_attrition

from stg
left join satisfaction sat  on stg.employee_id = sat.employee_id
left join compensation comp on stg.employee_id = comp.employee_id
left join tenure ten        on stg.employee_id = ten.employee_id
left join flags             on stg.employee_id = flags.employee_id