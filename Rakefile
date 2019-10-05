require_relative 'config/environment'
require_relative './lib/show.rb'

desc 'starts a console'
task :console do
  Pry.start
end

namespace :db do
  desc "migrate changes to your database"
  task :migrate => :environment do
    Show.create_table
  end

  desc "requires environment"
  task :environment do
    require_relative './config/environment'
  end
  
  desc "seeds db"
  task :seed do
    require_relative './db/seeds.rb'
  end
end