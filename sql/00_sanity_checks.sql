-- Sanity checks for La Liga 2024/25 match dataset
-- Expected number of matches: 380

-- 1. Total number of matches
SELECT COUNT(*) AS total_matches
FROM matches;

-- 2. Check for NULLs in mandatory fields
SELECT
    COUNT(*) AS rows_with_missing_data
FROM matches
WHERE
    date IS NULL
    OR home_team IS NULL
    OR away_team IS NULL
    OR score IS NULL
    OR xg_home IS NULL
    OR xg_away IS NULL
    OR match_report_url IS NULL;

-- 3. Check for duplicated match report URLs
SELECT
    COUNT(*) - COUNT(DISTINCT match_report_url) AS duplicated_matches
FROM matches;

-- 4. Check score format consistency (should contain a dash)
SELECT
    COUNT(*) AS invalid_score_format
FROM matches
WHERE score NOT LIKE '%–%';
