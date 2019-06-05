require 'bundler/setup'
require 'English'
require './app/app'
require 'yaml'

RACK_ENV = ENV['RACK_ENV'] ||= ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

if %w[development test travis staging].include?(RACK_ENV)

  task :all do
    ['rubocop', 'rake spec', 'rake cucumber'].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
    end
  end

  task :build_server do
    ['rake spec_report', 'rake cucumber_report'].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
    end
  end

  namespace :db do
    require_relative 'config/database'
    require 'sequel/core'
    task :migrate do
      Sequel.extension :migration

      Sequel::Migrator.run(DB, 'db/migrations')
    end

    task :reset do
      Sequel.extension :migration
      Sequel::Migrator.run(DB, 'db/migrations', target: 0)
      Sequel::Migrator.run(DB, 'db/migrations')
    end
  end

  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:cucumber) do |task|
    Rake::Task['db:migrate'].invoke
    # Rake::Task['db:seed'].invoke
    task.cucumber_opts = ['features', '--tags ~@wip']
  end

  Cucumber::Rake::Task.new(:cucumber_report) do |task|
    Rake::Task['db:migrate'].invoke
    task.cucumber_opts = ['features', '--format html -o reports/cucumber.html']
  end

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*_spec.rb'
  end

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec_report) do |t|
    t.pattern = './spec/**/*_spec.rb'
    t.rspec_opts = %w[--format RspecJunitFormatter --out reports/spec/spec.xml]
  end

  require 'rubocop/rake_task'
  desc 'Run RuboCop on the lib directory'
  RuboCop::RakeTask.new(:rubocop) do |task|
    # run analysis on rspec tests
    task.requires << 'rubocop-rspec'
    # don't abort rake on failure
    task.fail_on_error = false
  end

  task default: [:all]

end
