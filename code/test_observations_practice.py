from observations_practice import load_observations, summarise_site

rows = load_observations("data/bootcamp_observations.csv")
assert summarise_site(rows, "A") == (2, 1)
assert summarise_site(rows, "B") == (0, 0)

boundary_rows = load_observations("data/bootcamp_observations_boundary.csv")
assert summarise_site(boundary_rows, "C") == (None, 2)
assert summarise_site(boundary_rows, "D") == (0, 0)
assert summarise_site([], "A") == (None, 0)
assert summarise_site(rows, "Z") == (None, 0)