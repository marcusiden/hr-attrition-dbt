with source as (
    select * from {{ source('raw', 'RAW_HR_EMPLOYEES') }}
),

renamed as (
    select
        -- employee identifiers
        EMPLOYEENUMBER                  as employee_id,
        EMPLOYEECOUNT                   as employee_count,

        -- demographics
        AGE                             as age,
        GENDER                          as gender,
        MARITALSTATUS                   as marital_status,
        EDUCATION                       as education_level,
        EDUCATIONFIELD                  as education_field,

        -- job info
        DEPARTMENT                      as department,
        JOBROLE                         as job_role,
        JOBLEVEL                        as job_level,
        BUSINESSTRAVEL                  as business_travel,
        OVERTIME                        as overtime,

        -- compensation
        MONTHLYINCOME                   as monthly_income,
        MONTHLYRATE                     as monthly_rate,
        DAILYRATE                       as daily_rate,
        HOURLYRATE                      as hourly_rate,
        PERCENTSALARYHIKE               as percent_salary_hike,
        STOCKOPTIONLEVEL                as stock_option_level,

        -- satisfaction scores (1-4 scale)
        JOBSATISFACTION                 as job_satisfaction,
        ENVIRONMENTSATISFACTION         as environment_satisfaction,
        RELATIONSHIPSATISFACTION        as relationship_satisfaction,
        WORKLIFEBALANCE                 as work_life_balance,
        JOBINVOLVEMENT                  as job_involvement,

        -- performance
        PERFORMANCERATING               as performance_rating,
        TRAININGTIMESLASTYEAR           as training_times_last_year,

        -- tenure
        YEARSATCOMPANY                  as years_at_company,
        YEARSINCURRENTROLE              as years_in_current_role,
        YEARSSINCELASTPROMOTION         as years_since_last_promotion,
        YEARSWITHCURRMANAGER            as years_with_current_manager,
        TOTALWORKINGYEARS               as total_working_years,
        NUMCOMPANIESWORKED              as num_companies_worked,

        -- attrition
        case
            when ATTRITION = 'Yes' then true
            else false
        end                             as is_attrition,

        -- other
        DISTANCEFROMHOME                as distance_from_home,
        STANDARDHOURS                   as standard_hours,
        OVER18                          as over_18

    from source
)

select * from renamed