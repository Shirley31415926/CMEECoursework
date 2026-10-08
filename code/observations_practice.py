import csv

def load_observations(path):
    with open(path, newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))

if __name__ == "__main__":
    rows = load_observations("data/bootcamp_observations.csv")
    print(rows[0])
    print(rows[2])



"""
def parse_count(count_text):
    if count_text == "":
        return None
    elif count_text.isnumeric():                                #improved cf
         if int(count_text) < 0:
            raise ValueError("Count cannot be negative")
         else:
            return int(count_text)
    else:
        raise ValueError("Invalid count format")
test_list = ["", "0", "1", "2", "-1", "many", "1.5"]
for count in test_list:
    try:
        print(f"parse_count('{count}') = {parse_count(count)}")
    except ValueError as e:
        print(f"parse_count('{count}') raised ValueError: {e}")

def summarise_site(rows, site):
    site_rows = [row for row in rows if row[0] == site]
    total_count = 0
    for row in site_rows:
        try:
            count = parse_count(row[2])
            if count is not None:
                total_count += count
        except ValueError as e:
            print(f"Error parsing count for site '{site}': {e}")
    return total_count
"""