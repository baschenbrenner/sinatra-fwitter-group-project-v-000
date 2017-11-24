ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'


task :con do
  Pry.start
end

task :drop do
  system('rm db/development.sqlite && rm db/test.sqlite && rm db/schema.rb')
end

task :mig do
  system('rake db:migrate && rake db:migrate SINATRA_ENV=test')
end
# Type `rake -T` on your command line to see the available rake tasks.
