# Write methods that return SQL queries for each part of the challeng here
require_relative '../config/environment.rb'
def shows_1999
  # write your query here!
  sql = <<-SQL
    SELECT * FROM shows
    WHERE shows.year = 1999;
  SQL
  DB[:conn].execute(sql)
end

def most_frequent_guest
  sql = <<-SQL
    SELECT raw_guest_list
    FROM shows
    GROUP BY raw_guest_list
    ORDER BY COUNT(raw_guest_list) DESC
    LIMIT 1;
  SQL
DB[:conn].execute(sql)
end

def most_popular_profession
  sql = <<-SQL
    SELECT googleknowlege_occupation
    FROM shows
    GROUP BY googleknowlege_occupation
    ORDER BY COUNT(googleknowlege_occupation) DESC
    LIMIT 1
  SQL
  DB[:conn].execute(sql)
end

def most_popular_profession_by_year
  sql = <<-SQL
    SELECT googleknowlege_occupation
    FROM
      (
      SELECT googleknowlege_occupation, year, occupation_count,
      RANK () OVER (
        PARTITION BY year
        ORDER BY occupation_count DESC
      ) occupation_count_rank
      FROM (
        SELECT googleknowlege_occupation, year, COUNT(googleknowlege_occupation) AS occupation_count
        FROM shows
        GROUP BY year, googleknowlege_occupation
      )
      GROUP BY year, googleknowlege_occupation
      )
      WHERE occupation_count_rank = 1
  SQL
  DB[:conn].execute(sql)
end

def num_of_bills
  sql = <<-SQL
    SELECT COUNT(raw_guest_list) AS num_of_guests
    FROM shows
    WHERE raw_guest_list LIKE 'Bill%'
    ORDER BY num_of_guests
  SQL
  DB[:conn].execute(sql)
end

def patrick_stewart_appearance_dates
  sql = <<-SQL
    SELECT show 
    FROM shows
    WHERE raw_guest_list LIKE 'Patrick Stewart'
    ORDER BY year
  SQL
  DB[:conn].execute(sql)
end

def most_guests_year
  sql = <<-SQL
    SELECT year, COUNT(raw_guest_list) AS num_of_guests
    FROM shows
    GROUP BY year
    ORDER BY num_of_guests DESC
    LIMIT 1
  SQL
  DB[:conn].execute(sql)
end

def most_popular_genre_by_year
  sql = <<-SQL
  SELECT genre
  FROM 
      (SELECT genre, year, genre_count,
      RANK() OVER(
        PARTITION BY year
        ORDER BY genre_count DESC
      ) genre_count_rank
      FROM
        (SELECT genre, year, COUNT(genre) AS genre_count
      FROM shows
      GROUP BY year, genre))
      WHERE genre_count_rank = 1
  SQL
  DB[:conn].execute(sql)
end

#puts shows_1999
# puts most_frequent_guest
# puts most_popular_profession
# puts most_popular_profession_by_year
# puts num_of_bills
# puts patrick_stewart_appearance_dates
# puts most_guests_year
# puts most_popular_genre_by_year
