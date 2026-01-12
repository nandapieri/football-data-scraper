-- Team-level performance overview (La Liga 2024/25)

SELECT
    team,
    -- Volume
    COUNT(*) AS matches_played,

    -- Goals & Results
    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goals_for) - SUM(goals_against) AS goal_difference,

    SUM(points) AS points,
    ROUND(1.0 * SUM(points) / COUNT(*), 2) AS points_per_match,

    -- Expected Goals
    ROUND(SUM(xg_for), 2) AS xg_for,
    ROUND(SUM(xg_against), 2) AS xg_against,
    ROUND(SUM(xg_for) - SUM(xg_against), 2) AS xg_difference,

    -- Efficiency
    ROUND(SUM(goals_for) - SUM(xg_for), 2) AS goals_minus_xg,
    ROUND(SUM(goals_against) - SUM(xg_against), 2) AS goals_conceded_minus_xg,

    -- Home vs Away splits
    ROUND(SUM(CASE WHEN home_away = 'home' THEN xg_for END), 2) AS xg_home,
    ROUND(SUM(CASE WHEN home_away = 'away' THEN xg_for END), 2) AS xg_away,

    SUM(CASE WHEN home_away = 'home' THEN points END) AS points_home,
    SUM(CASE WHEN home_away = 'away' THEN points END) AS points_away

FROM team_matches

GROUP BY team

ORDER BY points DESC;
