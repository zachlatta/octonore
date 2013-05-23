<<<<<<< HEAD
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
=======
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/octonore/*_spec.rb']
  t.verbose    = true
end

task :default => :test
>>>>>>> edae0d218f92f541a124f880d6f215f39ac7c6fb
