# La Liga 2024/25 — Match Data Scraper (FBref)

This project scrapes match-level data from the 2024/25 La Liga season using FBref as the data source.

The goal was to build a **robust and reproducible data collection pipeline**, producing a clean dataset ready for SQL analysis and visualization tools such as Tableau.

---

## 📌 Data Collected

Each row represents one match. The final dataset includes:

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

## 🛠️ Tech Stack

- **Python**
- **Playwright** — used to bypass Cloudflare protection and load dynamic content
- **BeautifulSoup** — HTML parsing
- **CSV** — final dataset output

---

## 🧠 Key Design Decisions

- **Playwright instead of requests**  
  FBref uses Cloudflare, which blocks traditional HTTP requests. A real browser session was required.

- **Semantic filtering**  
  Only rows containing a "Match Report" link were considered valid matches, avoiding header rows and visual separators.

- **HTML-driven selectors**  
  Data extraction relies on `data-stat` attributes rather than tag types (`td` / `th`) to ensure robustness.

- **Data quality over volume**  
  Matches without mandatory fields (date, teams, score) are excluded to keep the dataset analysis-ready.

---

## 📂 Project Structure

```text
football-data-scraper/
│
├── scraper.py
├── requirements.txt
├── data/
│   └── la_liga_2024_25_matches.csv
└── README.md
