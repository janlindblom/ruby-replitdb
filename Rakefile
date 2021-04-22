# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "yard"

RuboCop::RakeTask.new

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
end

task default: :rubocop
