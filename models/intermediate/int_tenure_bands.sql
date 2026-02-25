with stg as (
    select * from {{ ref('stg_hr_employees') }}
)

select
    employee_id,
    years_at_company,
    years_in_current_role,
    years_since_last_promotion,
    years_with_current_manager,
    total_working_years,
    num_companies_worked,

    -- tenure band
    case
        when years_at_company <= 1 then '0-1 Years'
        when years_at_company <= 3 then '1-3 Years'
        when years_at_company <= 5 then '3-5 Years'
        when years_at_company <= 10 then '5-10 Years'
        else '10+ Years'
    end as tenure_band,

    -- career stage
    case
        when total_working_years <= 5 then 'Early Career'
        when total_working_years <= 15 then 'Mid Career'
        else 'Senior Career'
    end as career_stage

from stg