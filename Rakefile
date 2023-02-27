require 'sinatra/activerecord'
require './app'
require 'sinatra/activerecord/rake'

task :environment do
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
    ActiveRecord::Base.establish_connection(:development)
  end

namespace :db do
  desc 'Create the database'
  task :db => :environment do
    # Get the name of the database from the configuration
    db_name = ActiveRecord::Base.connection_db_config.database
  
    # Create the database
    ActiveRecord::Base.connection.create_database(db_name)
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: './db/database.sqlite3'
    )
    ActiveRecord::Base.connection.drop_database(
      ActiveRecord::Base.connection_config
    )
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: './db/database.sqlite3'
    )
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate(
      './db/migrate',
      ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    )
  end

  desc 'Rollback the last migration'
  task :rollback do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: './db/database.sqlite3'
    )
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback(
      './db/migrate',
      ENV['VERSION'] ? ENV['VERSION'].to_i : 1
    )
  end

  desc 'Seed the database'
  task :seed do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: './db/database.sqlite3'
    )
    load './db/seeds.rb'
  end



end
