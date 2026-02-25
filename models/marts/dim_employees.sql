with stg as (
    select * from {{ ref('stg_hr_employees') }}
)

select
    employee_id,
    age,
    gender,
    marital_status,
    education_level,
    education_field,
    distance_from_home,
    over_18,

    -- age band
    case
        when age < 25 then 'Under 25'
        when age < 35 then '25-34'
        when age < 45 then '35-44'
        when age < 55 then '45-54'
        else '55+'
    end as age_band

from stg