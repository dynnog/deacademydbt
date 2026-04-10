{{
    config
    (
        materialized = 'table'
    )
}}

with session_src as
(
    select
        SESSION_ID,
    USER_ID,
    BROWSER,
    DEVICE_TYPE,
    b.COUNTRY_NAME AS COUNTRY_NAME,
    b.CONTINENT AS CONTINENT,
    b.CURRENCY AS CURRENCY,
    START_TIME,
    END_TIME,
    PAGES_VISITED INT,
    CURRENT_TIMESTAMP as INSERT_DTS
    from {{source('session','SESSION_SRC')}} a left join {{ref('country_code')}} b
    on a.COUNTRY_CODE = b.COUNTRY_CODE
)

select * from session_src