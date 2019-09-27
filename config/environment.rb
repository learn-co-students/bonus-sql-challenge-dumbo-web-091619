require 'bundler'
require "sqlite3"
require_relative "../lib/queries.rb"
Bundler.require

# Setup a DB connection here
$db = SQLite3::Database.new "daily_show_db"

