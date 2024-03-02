-- Data Exploration
use nga_conflict

-- The Number of Conflict events by year:
SELECT year, state, conflict_name, COUNT(*) AS num_events
FROM (
    SELECT DISTINCT year, state, conflict_name
    FROM dbo.nga_conflict_data_clean
) AS distinct_states
GROUP BY year, state, conflict_name
ORDER BY year;


-- Total Number of Deaths by Conflict sides
SELECT side_a AS conflict_side, SUM(deaths_a) AS total_deaths_a, SUM(deaths_b) AS total_deaths_b, SUM(deaths_civilians) AS total_deaths_civilians, SUM(deaths_unknown) AS total_deaths_unknown
FROM dbo.nga_conflict_data_clean
GROUP BY side_a
ORDER BY total_deaths_a DESC, total_deaths_b DESC, total_deaths_civilians DESC, total_deaths_unknown DESC;

-- Conflict Events with the Highest number of Total deaths
SELECT TOP 10 *
FROM dbo.nga_conflict_data_clean
ORDER BY total_deaths DESC;


-- Perpetrators of Conflict 
SELECT side_b AS rebel_group, 
       type_of_violence AS form_of_violence, 
       COUNT(*) AS num_events
FROM dbo.nga_conflict_data_clean
WHERE side_b IS NOT NULL
GROUP BY side_b, type_of_violence
ORDER BY num_events DESC;


--	Total Fatalities by location
SELECT
    state,
    place_description as town,
    latitude,
    longitude,
    SUM(deaths_a + deaths_b + deaths_civilians + deaths_unknown) AS total_fatalities
FROM
    ..nga_conflict_data_clean
GROUP BY
    state, place_description, latitude, longitude
ORDER BY
    total_fatalities DESC;

-- Duration of Each conflict
SELECT
    c.conflict_name,
    c.date_start,
    c.date_end,
    DATEDIFF(day, c.date_start, c.date_end) AS conflict_duration_days,
    c.type_of_violence,
    c.deaths_a + c.deaths_b + c.deaths_civilians + c.deaths_unknown AS total_fatalities
FROM
    dbo.nga_conflict_data_clean c
WHERE
    c.date_start IS NOT NULL
    AND c.date_end IS NOT NULL
ORDER BY
    conflict_duration_days DESC;

-- Death Counts in each region
SELECT
    state,
    conflict_name,
    SUM(deaths_a) AS total_deaths_a,
    SUM(deaths_b) AS total_deaths_b,
    SUM(deaths_civilians) AS total_deaths_civilians,
    SUM(deaths_unknown) AS total_deaths_unknown,
    SUM(deaths_a + deaths_b + deaths_civilians + deaths_unknown) AS total_deaths
FROM
    dbo.nga_conflict_data_clean
GROUP BY
    state, conflict_name
ORDER BY
    total_deaths DESC;

-- News Reports of Conflicts
SELECT
    c.state,
    c.conflict_name,
    c.source_article,
    SUM(c.deaths_a) AS total_deaths_a,
    SUM(c.deaths_b) AS total_deaths_b,
    SUM(c.deaths_civilians) AS total_deaths_civilians,
    SUM(c.deaths_unknown) AS total_deaths_unknown,
    SUM(c.deaths_a + c.deaths_b + c.deaths_civilians + c.deaths_unknown) AS total_deaths
FROM
    dbo.nga_conflict_data_clean c
GROUP BY
    c.state, c.conflict_name, c.source_article
ORDER BY
    total_deaths DESC;


-- Overall satistics 
SELECT
    COUNT(*) AS total_conflicts,
    SUM(DATEDIFF(day, c.date_start, c.date_end)) AS total_conflict_duration_days,
    SUM(c.deaths_a + c.deaths_b + c.deaths_civilians + c.deaths_unknown) AS total_fatalities
FROM
    dbo.nga_conflict_data_clean c
WHERE
    c.date_start IS NOT NULL
    AND c.date_end IS NOT NULL;

