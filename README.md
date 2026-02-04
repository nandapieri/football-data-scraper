# La Liga 2024/25 — Match Data Pipeline & League Analysis Base (FBref)

This project builds a **robust and reproducible data pipeline** to collect, structure, and prepare match-level data from the **2024/25 La Liga season**, using FBref as the source.

The objective is not scraping for its own sake, but to transform raw match data into a **clean, analysis-ready dataset** suitable for:
- league-level analysis  
- team-level storytelling  
- SQL-based exploration  
- downstream visualization and modeling  

---

## 🎯 Project Objective

Create a **reliable analytical foundation** for La Liga by:

- collecting complete match-level data,
- handling real-world scraping constraints,
- structuring data to support football-specific questions,
- separating raw data from analytical logic.

This project serves as the **baseline dataset** later reused in contextual league analysis and cross-league comparisons.

---

## 📊 Data Collected

### Match-level dataset (raw)

Each row represents **one match** from the 2024/25 season.

Fields include:
- date  
- home team  
- away team  
- final score  
- expected goals (xG) — home and away  
- attendance  
- venue  
- match report URL  

**Total matches:** 380

Raw data is preserved without analytical assumptions.

---

### Team-level analytical view

To enable team-based analysis, match data is transformed in SQLite into a **team-level analytical view**.

Design principles:
- each match becomes **two rows** (one per team),
- all metrics are derived from match outcomes,
- no information is duplicated before context is resolved.

Derived metrics include:
- goals for / against  
- goal difference  
- xG difference  
- match result (W / D / L)  
- points earned (3 / 1 / 0)  
- home / away flag  

This structure supports:
- cumulative analysis  
- distribution-based insights  
- narrative-driven exploration  

---

## 🧱 Pipeline & Architecture

The pipeline is intentionally simple, transparent, and reproducible:

1. **Data collection**
   - Browser-based scraping of FBref match tables
2. **Raw data storage**
   - CSV for inspection and portability
3. **Analytical modeling**
   - SQLite views for team-level analysis

All analytical logic is implemented **in SQL**, keeping data preparation and interpretation clearly separated.

---

## 🛠️ Tech Stack

- **Python** — orchestration and data collection  
- **Playwright** — browser automation to handle Cloudflare protection  
- **BeautifulSoup** — HTML parsing  
- **CSV** — raw data storage  
- **SQLite** — lightweight analytical database  

---

## 🧠 Key Design Decisions

- **Browser-based scraping instead of HTTP requests**  
  FBref uses Cloudflare protection, which blocks standard requests.  
  A real browser context ensures reliable and complete data extraction.

- **Semantic filtering of matches**  
  Only rows containing a valid *Match Report* link are treated as matches, avoiding headers, separators, and partial rows.

- **Attribute-based selectors**  
  Data extraction relies on `data-stat` attributes rather than HTML structure, improving resilience to layout changes.

- **Clear separation of concerns**
  - raw data stored as collected  
  - analytical logic implemented exclusively in SQL  
  This keeps the pipeline auditable, extensible, and league-agnostic.

---

## 📦 Outputs

- Clean match-level CSV dataset  
- SQLite database with team-level analytical views  
- Reproducible SQL logic for football analysis  

The dataset is suitable as a foundation for:
- league context analysis  
- home vs away studies  
- efficiency and outcome-based metrics  
- cross-league comparison (e.g. La Liga vs Segunda División)

---

## 📂 Project Structure

```text
football-data-scraper/
│
├── scraper.py
├── requirements.txt
├── data/
│   ├── la_liga_2024_25_matches.csv
│   └── la_liga_2024_25.db
├── sql/
│   └── team_matches.sql
└── README.md
