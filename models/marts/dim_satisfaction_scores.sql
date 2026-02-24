with sat as (
    select * from {{ ref('int_employee_satisfaction') }}
)

select
    employee_id,
    job_satisfaction,
    environment_satisfaction,
    relationship_satisfaction,
    work_life_balance,
    job_involvement,
    composite_satisfaction_score,
    satisfaction_band

from sat