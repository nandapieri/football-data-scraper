-- Defensive efficiency analysis
-- Goal: identify teams that conceded more or fewer goals than expected (xG against)

SELECT
    team,
    COUNT(*) AS matches_played,

    SUM(goals_against) AS goals_conceded,
    ROUND(SUM(xg_against), 1) AS xg_conceded,

    ROUND(SUM(goals_against) - SUM(xg_against), 1) AS defensive_delta,

    ROUND(AVG(goals_against), 2) AS goals_conceded_per_match,
    ROUND(AVG(xg_against), 2) AS xg_conceded_per_match

FROM team_matches
GROUP BY team
ORDER BY defensive_delta ASC;
