with stg as (
    select * from {{ ref('stg_hr_employees') }}
),

dept_avg as (
    select
        department,
        job_role,
        round(avg(monthly_income), 2) as avg_income_by_role
    from stg
    group by department, job_role
)

select
    s.employee_id,
    s.monthly_income,
    s.percent_salary_hike,
    s.stock_option_level,
    d.avg_income_by_role,

    -- how much above or below average is this employee
    round(s.monthly_income - d.avg_income_by_role, 2) as income_vs_role_avg,

    -- flag underpaid employees (more than 20% below role average)
    case
        when s.monthly_income < d.avg_income_by_role * 0.8 then true
        else false
    end as is_underpaid

from stg s
left join dept_avg d
    on s.department = d.department
    and s.job_role = d.job_role