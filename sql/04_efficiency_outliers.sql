SELECT
    team,
    COUNT(*) AS matches,

    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goals_for - goals_against) AS goal_diff,

    ROUND(SUM(xg_for), 1) AS xg_for,
    ROUND(SUM(xg_against), 1) AS xg_against,
    ROUND(SUM(xg_for - xg_against), 1) AS xg_diff,

    ROUND(SUM(goals_for - goals_against) - SUM(xg_for - xg_against), 1)
        AS finishing_delta,

    SUM(
        CASE
            WHEN goals_for > goals_against THEN 3
            WHEN goals_for = goals_against THEN 1
            ELSE 0
        END
    ) AS points,

    ROUND(
        1.0 * SUM(
            CASE
                WHEN goals_for > goals_against THEN 3
                WHEN goals_for = goals_against THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS points_per_game

FROM team_matches
GROUP BY team
ORDER BY finishing_delta DESC;
