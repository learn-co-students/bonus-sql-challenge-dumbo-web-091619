# Parse the CSV and seed the row_hashbase here! Run 'ruby db/seed' to execute this code.
require 'csv'
require 'sqlite3'
require 'pry'
require_relative '../config/environment.rb'
require_relative'../lib/show.rb'


CSV.foreach("lib/seeds/daily_show_guests.csv", {:headers => true, :header_converters => :symbol}) do |row|
    row_hash = row.to_h
    DB[:conn].execute(
        'INSERT INTO shows (year, googleknowlege_occupation, show, genre, raw_guest_list) values (?, ?, ?, ?, ?)',
        row_hash[:year], row_hash[:googleknowlege_occupation], row_hash[:show], row_hash[:genre], row_hash[:raw_guest_list]
    )end



