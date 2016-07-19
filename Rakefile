# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'coveralls/rake/task'
require File.expand_path('../config/application', __FILE__)
require 'rubocop/rake_task'

Coveralls::RakeTask.new
StoicChess::Application.load_tasks

task test: :rubocop

task :rubocop do
  sh 'rubocop'
end
