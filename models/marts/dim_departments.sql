with stg as (
    select * from {{ ref('stg_hr_employees') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['department', 'job_role']) }} as department_key,
    department,
    job_role

from stg
