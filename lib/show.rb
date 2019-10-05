require_relative '../config/environment.rb'
require 'pry'

class Show
    

    attr_accessor :year, :googleknowlege_occupation, :show, :genre, :raw_guest_list
    attr_reader :id

    @@all = []

    def initialize(id, year, googleknowlege_occupation, show, genre, raw_guest_list)
        @id = id
        @year = year
        @googleknowlege_occupation = googleknowlege_occupation
        @show = show
        @genre = genre
        @raw_guest_list = raw_guest_list
        @@all << self
    end

    def self.all
        sql = <<-SQL
        SELECT * FROM shows
        SQL
        shows = DB[:conn].execute(sql)
        shows.each do |row|
            Show.new(row[0], row[1], row[2], row[3], row[4], row[5])
        end
    end

    def self.create_table
        sql =<<-SQL
        CREATE TABLE IF NOT EXISTS shows (
        id INTEGER PRIMARY KEY,
        year INTEGER,
        googleknowlege_occupation TEXT,
        show TEXT,
        genre TEXT,
        raw_guest_list TEXT
        )
        SQL
    DB[:conn].execute(sql)
    end


end