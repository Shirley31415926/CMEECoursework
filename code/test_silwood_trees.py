from clean_silwood_trees import validate_record, process_records, summarise_oaks

# 1. test validate_record
row = {
    "record_id": "ST008",
    "location": "Near Hamilton",
    "genus": "Quercus" ,
    "species": "pseudoplatanus",
    "distance_m": "200",
    "angle_degrees": "-10"
}
source_row = 999
acc_ids = set()
acc_ids.add("ST008")
acc_ids.add("ST009")

print(validate_record(row, source_row, acc_ids))
# (None, ['duplicate record_id', 'invalid location', 'invalid genus/species combination', 'distance_m out of range', 'angle_degrees out of range'])

# 2. test process_records
row1 = {
    "record_id": "ST001",
    "location": "Silwood bottom",
    "genus": "Quercus" ,
    "species": "Pdoplatanus",
    "distance_m": "100",
    "angle_degrees": "0"
}
row2 = {
    "record_id": "ST001",
    "location": "Near Hamilton",
    "genus": "Quercus" ,
    "species": "pseudoplatanus",
    "distance_m": "200",
    "angle_degrees": "-10"
}
row3 = {
    "record_id": "ST003",
    "location": "Nash's Field",
    "genus": "Quercus" ,
    "species": "robur",
    "distance_m": "20",
    "angle_degrees": "10"
}
row4 = {
    "record_id": "ST004",
    "location": " Manor House",
    "genus": "Acer" ,
    "species": "pseudoplatanus",
    "distance_m": "100",
    "angle_degrees": "10"
}
rows = [row1, row2, row3, row4]
print(process_records(rows))
#([{'record_id': 'ST003', 'location': "Nash's Field", 'genus': 'Quercus', 'species': 'robur', 'distance_m': '20.0', 'angle_degrees': '10.0'}, 
# {'record_id': 'ST004', 'location': 'Manor House', 'genus': 'Acer', 'species': 'pseudoplatanus', 'distance_m': '100.0', 'angle_degrees': '10.0'}], 
# [{'source_row': 2, 'record_id': 'ST001', 'reasons': 'invalid species;angle_degrees out of range'}, 
# {'source_row': 3, 'record_id': 'ST001', 'reasons': 'invalid location;invalid genus/species combination;distance_m out of range;angle_degrees out of range'}])

# 3. test summarise_oaks
clean_records, issues = process_records(rows)
print(summarise_oaks(clean_records))
# [{'species': 'robur', 'count': 1}]