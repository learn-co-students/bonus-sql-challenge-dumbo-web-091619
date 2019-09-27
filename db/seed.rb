# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require_relative '../config/environment.rb'
require 'csv'

def get_rows_from_csv
  CSV.read("daily_show_guests.csv")
end

def create_table 
  sql = <<-SQL
      CREATE TABLE IF NOT EXISTS guests(
        id INTEGER PRIMARY KEY,
        year INTEGER,
        googleknowlege_occupation TEXT,
        show TEXT,
        group_type TEXT,
        raw_guest_list TEXT
      )
    SQL
  $db.execute(sql)
end

def insert_row_into_db(row)
  sql = <<-SQL
      INSERT INTO guests (year, googleknowlege_occupation, show, group_type, raw_guest_list)
      VALUES (?,?,?,?,?)
    SQL
  $db.execute(sql, row[0], row[1], row[2], row[3], row[4])

end
#START---------------------------------------------
rows_from_csv = get_rows_from_csv
titles = rows_from_csv[0]
rows_data = rows_from_csv[1..]
# create_table
rows_data.each do |row|
  insert_row_into_db(row)
end
