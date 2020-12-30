require 'bundler/setup'

require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app/app'

include ActiveRecord::Tasks

DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
DatabaseTasks.env = ENV['ENV'] || 'development'