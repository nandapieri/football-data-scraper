-- Season overview KPIs for La Liga 2024/25

-- 1. Basic season totals
SELECT
    COUNT(*) AS total_matches,
    SUM(
        CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) +
        CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
    ) AS total_goals,
    ROUND(
        AVG(
            CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) +
            CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
        ), 2
    ) AS avg_goals_per_match,
    ROUND(SUM(xg_home + xg_away), 2) AS total_xg,
    ROUND(AVG(xg_home + xg_away), 2) AS avg_xg_per_match
FROM matches;

-- 2. Attendance overview
SELECT
    ROUND(AVG(attendance), 0) AS avg_attendance,
    MAX(attendance) AS max_attendance,
    MIN(attendance) AS min_attendance
FROM matches
WHERE attendance IS NOT NULL;

-- 3. Goals vs xG difference (league-level)
SELECT
    ROUND(
        SUM(
            CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) +
            CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
        ) - SUM(xg_home + xg_away),
    2
    ) AS goals_minus_xg
FROM matches;
