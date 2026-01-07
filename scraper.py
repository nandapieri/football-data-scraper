from playwright.sync_api import sync_playwright
from bs4 import BeautifulSoup
import csv
import os

URL = "https://fbref.com/en/comps/12/2024-2025/schedule/2024-2025-La-Liga-Scores-and-Fixtures"

# ─────────────────────────────────────────────
# Abrir a página com Playwright
# ─────────────────────────────────────────────
with sync_playwright() as p:
    browser = p.chromium.launch(headless=False)
    page = browser.new_page()
    page.goto(URL, timeout=60000)

    html = page.content()
    browser.close()

# ─────────────────────────────────────────────
# Parsear HTML com BeautifulSoup
# ─────────────────────────────────────────────
soup = BeautifulSoup(html, "html.parser")

table = soup.find("table", id="sched_2024-2025_12_1")
if table is None:
    raise Exception("Tabela Scores & Fixtures não encontrada")

rows = table.find_all("tr")
print("Total de <tr> encontradas:", len(rows))

# ─────────────────────────────────────────────
# Filtrar apenas jogos reais
# (linhas com Match Report)
# ─────────────────────────────────────────────
valid_rows = []

for row in rows:
    match_report_cell = row.find("td", {"data-stat": "match_report"})
    link = match_report_cell.find("a") if match_report_cell else None

    if not link:
        continue

    valid_rows.append(row)

print("Jogos reais encontrados:", len(valid_rows))

# ─────────────────────────────────────────────
# Extrair dados
# ─────────────────────────────────────────────
matches = []

for row in valid_rows:
    date_cell = row.find(attrs={"data-stat": "date"})
    home_cell = row.find(attrs={"data-stat": "home_team"})
    away_cell = row.find(attrs={"data-stat": "away_team"})
    score_cell = row.find(attrs={"data-stat": "score"})
    xg_home_cell = row.find(attrs={"data-stat": "home_xg"})
    xg_away_cell = row.find(attrs={"data-stat": "away_xg"})
    attendance_cell = row.find(attrs={"data-stat": "attendance"})
    venue_cell = row.find(attrs={"data-stat": "venue"})
    report_cell = row.find(attrs={"data-stat": "match_report"})

    # campos obrigatórios de dado
    if not all([
        date_cell,
        home_cell,
        away_cell,
        score_cell,
        xg_home_cell,
        xg_away_cell,
        report_cell
    ]):
        continue

    # link é obrigatório, mas validado separado
    link_tag = report_cell.find("a") if report_cell else None
    if not link_tag:
        continue

    attendance_text = attendance_cell.text.strip() if attendance_cell else None
    attendance = int(attendance_text.replace(",", "")) if attendance_text else None

    matches.append({
        "date": date_cell.text.strip(),
        "home_team": home_cell.text.strip(),
        "away_team": away_cell.text.strip(),
        "score": score_cell.text.strip(),
        "xg_home": xg_home_cell.text.strip(),
        "xg_away": xg_away_cell.text.strip(),
        "attendance": attendance,
        "venue": venue_cell.text.strip() if venue_cell else None,
        "match_report_url": "https://fbref.com" + link_tag["href"]
    })

if matches:
    print("Exemplo de jogo:", matches[0])
else:
    print("Nenhum jogo extraído")

# ─────────────────────────────────────────────
# Salvar CSV
# ─────────────────────────────────────────────
os.makedirs("data", exist_ok=True)

csv_path = "data/la_liga_2024_25_matches.csv"

with open(csv_path, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.DictWriter(
        file,
        fieldnames=[
            "date",
            "home_team",
            "away_team",
            "score",
            "xg_home",
            "xg_away",
            "attendance",
            "venue",
            "match_report_url"
        ]
    )
    writer.writeheader()
    writer.writerows(matches)

print(f"CSV salvo com sucesso em: {csv_path}")
print("Jogos finais no CSV:", len(matches))
