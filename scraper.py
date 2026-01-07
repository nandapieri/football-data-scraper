from playwright.sync_api import sync_playwright
from bs4 import BeautifulSoup

URL = "https://fbref.com/en/comps/12/2024-2025/schedule/2024-2025-La-Liga-Scores-and-Fixtures"

with sync_playwright() as p:
    browser = p.chromium.launch(headless=False)
    page = browser.new_page()
    page.goto(URL, timeout=60000)
    html = page.content()
    browser.close()

soup = BeautifulSoup(html, "html.parser")

# 1️⃣ pegar a tabela
table = soup.find("table", id="sched_2024-2025_12_1")

# 2️⃣ pegar TODAS as linhas
rows = table.find_all("tr")

print("Total de <tr>:", len(rows))

# 3️⃣ FILTRO AQUI ⬇️
valid_rows = []

for row in rows:
    match_report_cell = row.find("td", {"data-stat": "match_report"})
    link = match_report_cell.find("a") if match_report_cell else None

    if not link:
        continue  # pula linhas que NÃO são jogos

    valid_rows.append(row)

print("Jogos reais:", len(valid_rows))
