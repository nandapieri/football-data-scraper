# La Liga 2024/25 — Match Data Scraper & Analysis (FBref)

This project collects and models match-level data from the **2024/25 La Liga season**, using FBref as the data source.

The goal is to build a **robust, reproducible data pipeline**, transforming raw match data into an **analysis-ready dataset** for SQL-based exploration and visualization (e.g. Tableau).

---

## 📌 Data Collected

### Raw dataset (match-level)

Each row represents **one match**. The scraped dataset includes:

- Date  
- Home team  
- Away team  
- Final score  
- Expected Goals (xG) — home and away  
- Attendance  
- Venue  
- Match report URL  

Total matches: **380**

---

### Analytical model (team-level)

To enable team-based analysis, the raw match data is transformed in SQLite into a **team-level analytical view**:

- Each match is represented by **two rows** (one per team)
- Metrics are derived directly from match data, including:
  - Goals for / against
  - Goal difference
  - xG difference
  - Match result (W / D / L)
  - Points earned (3 / 1 / 0)
  - Home / away flag

This structure allows cumulative, comparative and storytelling-driven analysis at team level.

---

## 🛠️ Tech Stack

- **Python** — data collection and orchestration  
- **Playwright** — browser automation to bypass Cloudflare and load dynamic content  
- **BeautifulSoup** — HTML parsing  
- **CSV** — raw data output  
- **SQLite** — lightweight analytical database for SQL exploration  

---

## 🧠 Key Design Decisions

- **Playwright instead of requests**  
  FBref uses Cloudflare protection, which blocks traditional HTTP requests. A real browser session was required to reliably access the data.

- **Semantic filtering of matches**  
  Only rows containing a *Match Report* link are treated as valid matches, avoiding header rows, separators and incomplete entries.

- **HTML-driven selectors**  
  Data extraction relies on `data-stat` attributes rather than tag types (`td` / `th`), making the scraper more resilient to layout changes.

- **Separation of raw data and analytics**  
  - Raw match data is stored as-is  
  - All analytical logic (results, points, differentials) is implemented in SQL views  
  This keeps the pipeline transparent, reproducible and easy to extend.

---

## 📂 Project Structure

```text
football-data-scraper/
│
├── scraper.py
├── requirements.txt
├── data/
│   └── la_liga_2024_25_matches.csv
│   └── la_liga_2024_25.db
├── sql/
│   └── team_matches.sql
└── README.md
