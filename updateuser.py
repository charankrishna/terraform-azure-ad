from tempfile import NamedTemporaryFile
import shutil
import csv
import sys

# total arguments
n = len(sys.argv)
print("Total arguments passed:", n)

# Arguments passed
print("\nName of Python script:", sys.argv[0])
 
print("\nArguments passed:", end = " ")

filename = 'testusers.csv'
tempfile = NamedTemporaryFile(mode='w', delete=False)

fields = ["first_name","last_name","department","job_title"]

with open(filename, 'r') as csvfile, tempfile:
    reader = csv.DictReader(csvfile, fieldnames=fields)
    writer = csv.DictWriter(tempfile, fieldnames=fields)
    for row in reader:
        if row['first_name'] == str('krishna'):
            print('updating row', row['first_name'])
            row['first_name'], row['last_name'], row['department'], row['job_title'] = 'charan', 'sai', 'DevOps', 'Engineer'
        row = {'first_name': row['first_name'], 'last_name': row['last_name'], 'department': row['department'], 'job_title': row['job_title']}
        writer.writerow(row)

shutil.move(tempfile.name, filename)