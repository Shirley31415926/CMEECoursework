import csv


def load_observations(path):
    with open(path, newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))

def parse_count(count_text):
    if count_text == "":
        return None
        
    elif not isinstance(count_text, str):
        raise ValueError("the input must be text.")
    
    try:
        count = int(count_text)
    except ValueError:
        raise ValueError()
    
    if count < 0:
        raise ValueError()
    return count


def summarise_site(rows, site):
    if not isinstance(rows, list):
        raise ValueError()

    if not isinstance(site, str) or not site.strip():
        raise ValueError()

    for row in rows:
        if not isinstance(row, dict):
            raise ValueError()

        if set(row.keys()) != {"site", "date", "count"}:
            raise ValueError()

        if not isinstance(row["site"], str) or not row["site"].strip():
            raise ValueError()

        if not isinstance(row["date"], str) or not row["date"].strip():
            raise ValueError()

        parse_count(row["count"])

    site_rows = [row for row in rows if row["site"] == site]

    missing_count = 0
    known_total = 0
    counted_rows = set()

    for row in site_rows:
        row_key = (row["site"], row["date"], row["count"])

        if row_key in counted_rows:
            continue

        counted_rows.add(row_key)

        count = parse_count(row["count"])

        if count is None:
            missing_count += 1
        else:
            known_total += count

    if not counted_rows or missing_count == len(counted_rows):
        known_total = None

    return known_total, missing_count


if __name__ == "__main__":
    rows = load_observations("data/bootcamp_observations.csv")
    print(rows[0])
    print(rows[2])