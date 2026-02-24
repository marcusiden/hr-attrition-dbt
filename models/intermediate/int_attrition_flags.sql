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
)

select
    s.employee_id,
    s.is_attrition,

    -- risk factors
    case when s.overtime = 'Yes' then true else false end       as has_overtime,
    case when s.business_travel = 'Travel_Frequently' then true else false end as travels_frequently,
    sat.composite_satisfaction_score,
    sat.satisfaction_band,
    c.is_underpaid,
    t.tenure_band,
    t.career_stage,

    -- attrition risk score (count of risk factors)
    (
        case when s.overtime = 'Yes' then 1 else 0 end +
        case when s.business_travel = 'Travel_Frequently' then 1 else 0 end +
        case when sat.composite_satisfaction_score < 2.5 then 1 else 0 end +
        case when c.is_underpaid = true then 1 else 0 end +
        case when s.years_since_last_promotion > 3 then 1 else 0 end
    ) as attrition_risk_score,

    -- risk label
    case
        when (
            case when s.overtime = 'Yes' then 1 else 0 end +
            case when s.business_travel = 'Travel_Frequently' then 1 else 0 end +
            case when sat.composite_satisfaction_score < 2.5 then 1 else 0 end +
            case when c.is_underpaid = true then 1 else 0 end +
            case when s.years_since_last_promotion > 3 then 1 else 0 end
        ) >= 3 then 'High Risk'
        when (
            case when s.overtime = 'Yes' then 1 else 0 end +
            case when s.business_travel = 'Travel_Frequently' then 1 else 0 end +
            case when sat.composite_satisfaction_score < 2.5 then 1 else 0 end +
            case when c.is_underpaid = true then 1 else 0 end +
            case when s.years_since_last_promotion > 3 then 1 else 0 end
        ) = 2 then 'Medium Risk'
        else 'Low Risk'
    end as attrition_risk_label

from stg s
left join satisfaction sat on s.employee_id = sat.employee_id
left join compensation c on s.employee_id = c.employee_id
left join tenure t on s.employee_id = t.employee_id