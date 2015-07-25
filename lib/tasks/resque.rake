# Resque tasks
require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment

namespace :resque do
  task :setup do
    require 'resque'

    # you probably already have this somewhere
    Resque.redis = '127.0.01:6379'
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'
    Resque.schedule = YAML.load_file('config/resque_schedule.yml')
  end

  task :scheduler => :setup_schedule
end
