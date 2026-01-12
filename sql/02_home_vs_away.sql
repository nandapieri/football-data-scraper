-- Home vs Away: goals and xG comparison

SELECT
    'Home' AS team_type,
    COUNT(*) AS matches,
    SUM(CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER)) AS goals,
    ROUND(AVG(CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER)), 2) AS goals_per_match,
    ROUND(SUM(xg_home), 2) AS total_xg,
    ROUND(AVG(xg_home), 2) AS xg_per_match
FROM matches

UNION ALL

SELECT
    'Away' AS team_type,
    COUNT(*) AS matches,
    SUM(CAST(substr(score, instr(score, '–') + 1) AS INTEGER)) AS goals,
    ROUND(AVG(CAST(substr(score, instr(score, '–') + 1) AS INTEGER)), 2) AS goals_per_match,
    ROUND(SUM(xg_away), 2) AS total_xg,
    ROUND(AVG(xg_away), 2) AS xg_per_match
FROM matches;

-- Match result distribution

SELECT
    CASE
        WHEN CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) >
             CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
            THEN 'Home win'
        WHEN CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER) <
             CAST(substr(score, instr(score, '–') + 1) AS INTEGER)
            THEN 'Away win'
        ELSE 'Draw'
    END AS result,
    COUNT(*) AS matches
FROM matches
GROUP BY result;

-- Finishing efficiency: goals minus xG

SELECT
    'Home' AS team_type,
    ROUND(
        SUM(CAST(substr(score, 1, instr(score, '–') - 1) AS INTEGER)) - SUM(xg_home),
    2) AS goals_minus_xg
FROM matches

UNION ALL

SELECT
    'Away' AS team_type,
    ROUND(
        SUM(CAST(substr(score, instr(score, '–') + 1) AS INTEGER)) - SUM(xg_away),
    2) AS goals_minus_xg
FROM matches;
