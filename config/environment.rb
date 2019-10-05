require 'bundler'
Bundler.require
require 'sqlite3'

# Setup a DB connection here
DB = {:conn => SQLite3::Database.new("db/shows.db")}

