# Write methods that return SQL queries for each part of the challeng here

def guest_with_most_appearances
  <<-SQL
    SELECT raw_guest_list, COUNT(raw_guest_list)
    FROM guests
    GROUP BY raw_guest_list 
    ORDER BY COUNT(raw_guest_list) DESC
    LIMIT 1;   
  SQL
end

def most_popular_profession_each_year
  <<-SQL
  SELECT googleknowlege_occupation, year
  FROM 
    (SELECT googleknowlege_occupation, COUNT(googleknowlege_occupation) AS counted, year
     FROM guests
     GROUP BY googleknowlege_occupation
     ORDER BY year, COUNT(googleknowlege_occupation) DESC)  
  GROUP BY year 
  ORDER BY year, counted DESC ;  
  SQL
end

def most_profession_overall
  <<-SQL 
    SELECT group_type, MAX(professions) FROM 
      (SELECT group_type, COUNT(group_type) as professions
      FROM guests
      GROUP BY group_type);
    SQL
end

def count_guests_named_bill
  sql = <<-SQL
    SELECT COUNT(raw_guest_list)
    FROM guests
    WHERE raw_guest_list like "bill%"
  SQL
  $db.execute(sql)[0][0]
end

def dates_patrick_stwart_on_show
  sql = <<-SQL
      SELECT show
      FROM guests
      WHERE raw_guest_list like "Patrick Stewart"
    SQL

    $db.execute(sql).flatten
end

def year_with_most_guests
  sql = <<-SQL
      SELECT year, max(year_counts)
      FROM (SELECT year, Count(year) as year_counts
            FROM guests
            GROUP by year)
    SQL
    $db.execute(sql).flatten

end