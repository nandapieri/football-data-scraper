-- Base table: matches
-- One row per match (raw data imported from CSV)

CREATE TABLE IF NOT EXISTS matches (
    match_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    home_team TEXT NOT NULL,
    away_team TEXT NOT NULL,
    score TEXT NOT NULL,
    xg_home REAL NOT NULL,
    xg_away REAL NOT NULL,
    attendance INTEGER,
    venue TEXT,
    match_report_url TEXT NOT NULL
);
