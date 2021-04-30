# frozen_string_literal: true

require "bundler/gem_tasks"

begin
  require "rubocop/rake_task"
  require "yard"
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)

  RuboCop::RakeTask.new

  YARD::Rake::YardocTask.new do |t|
    t.files = ["lib/**/*.rb", "spec/**/*.rb"]
    t.stats_options = ["--list-undoc"]
  end

  task default: :rubocop
rescue LoadError
end
