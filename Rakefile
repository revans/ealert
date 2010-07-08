require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name          = "ealert"
    gem.summary       = %Q{Event Alert Daemon}
    gem.description   = %Q{Command line utility to stream twitter events.}
    gem.email         = "robert@codewranglers.org"
    gem.homepage      = "http://github.com/revans/ealert"
    gem.authors       = ["Robert R Evans"]
    gem.version       = File.read('VERSION').chomp!

    gem.add_development_dependency "rspec",     ">= 1.2.9"
    gem.add_development_dependency "yard",      ">= 0.5.8"
    gem.add_development_dependency 'yardstick', '>= 0.1.0'
    
    gem.add_dependency 'mongo',             '= 0.19.1'
    gem.add_dependency 'mongo_ext',         '= 0.19.1'
    gem.add_dependency 'yajl-ruby',         '= 0.7.6'
    gem.add_dependency 'simplegeo',         '= 0.0.3'
    gem.add_dependency 'calais',            '= 0.0.9'
    gem.add_dependency 'em-http-request',   '= 0.2.7'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern    = 'spec/**/*_spec.rb'
  spec.rcov_opts  = ["--sort coverage",  
                     "--profile",
                     "--rails",
                     "--exclude /gems/,/Library/,spec"]
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
