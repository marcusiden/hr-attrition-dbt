with stg as (
    select * from {{ ref('stg_hr_employees') }}
)

select
    employee_id,
    job_satisfaction,
    environment_satisfaction,
    relationship_satisfaction,
    work_life_balance,
    job_involvement,

    -- composite satisfaction score (average of all 5 scores)
    round(
        (job_satisfaction + environment_satisfaction + relationship_satisfaction + work_life_balance + job_involvement) / 5.0
    , 2) as composite_satisfaction_score,

    -- satisfaction band
    case
        when (job_satisfaction + environment_satisfaction + relationship_satisfaction + work_life_balance + job_involvement) / 5.0 < 2 then 'Low'
        when (job_satisfaction + environment_satisfaction + relationship_satisfaction + work_life_balance + job_involvement) / 5.0 < 3 then 'Medium'
        when (job_satisfaction + environment_satisfaction + relationship_satisfaction + work_life_balance + job_involvement) / 5.0 < 3.5 then 'High'
        else 'Very High'
    end as satisfaction_band

from stg