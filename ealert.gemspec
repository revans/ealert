# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ealert}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert R Evans"]
  s.date = %q{2010-07-15}
  s.default_executable = %q{stream}
  s.description = %q{Command line utility to stream twitter events.}
  s.email = %q{robert@codewranglers.org}
  s.executables = ["stream"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/stream",
     "ealert.gemspec",
     "lib/config/events.yaml",
     "lib/ealert.rb",
     "lib/ealert/calais.rb",
     "lib/ealert/config.rb",
     "lib/ealert/options.rb",
     "lib/ealert/store.rb",
     "lib/ealert/stream.rb",
     "lib/ealert/twitter_filter.rb",
     "lib/ealert/version.rb",
     "spec/ealert/calais_spec.rb",
     "spec/ealert/parse_spec.rb",
     "spec/ealert/store_spec.rb",
     "spec/ealert/twitter_filter_spec.rb",
     "spec/ealert/version_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/revans/ealert}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Event Alert Daemon}
  s.test_files = [
    "spec/ealert/calais_spec.rb",
     "spec/ealert/parse_spec.rb",
     "spec/ealert/store_spec.rb",
     "spec/ealert/twitter_filter_spec.rb",
     "spec/ealert/version_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0.5.8"])
      s.add_runtime_dependency(%q<mongo>, ["= 0.19.1"])
      s.add_runtime_dependency(%q<mongo_ext>, ["= 0.19.1"])
      s.add_runtime_dependency(%q<twitter-stream>, ["= 0.1.6"])
      s.add_runtime_dependency(%q<yajl-ruby>, ["= 0.7.7"])
      s.add_runtime_dependency(%q<simplegeo>, ["= 0.0.3"])
      s.add_runtime_dependency(%q<calais>, ["= 0.0.9"])
      s.add_runtime_dependency(%q<em-http-request>, ["= 0.2.7"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0.5.8"])
      s.add_dependency(%q<mongo>, ["= 0.19.1"])
      s.add_dependency(%q<mongo_ext>, ["= 0.19.1"])
      s.add_dependency(%q<twitter-stream>, ["= 0.1.6"])
      s.add_dependency(%q<yajl-ruby>, ["= 0.7.7"])
      s.add_dependency(%q<simplegeo>, ["= 0.0.3"])
      s.add_dependency(%q<calais>, ["= 0.0.9"])
      s.add_dependency(%q<em-http-request>, ["= 0.2.7"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0.5.8"])
    s.add_dependency(%q<mongo>, ["= 0.19.1"])
    s.add_dependency(%q<mongo_ext>, ["= 0.19.1"])
    s.add_dependency(%q<twitter-stream>, ["= 0.1.6"])
    s.add_dependency(%q<yajl-ruby>, ["= 0.7.7"])
    s.add_dependency(%q<simplegeo>, ["= 0.0.3"])
    s.add_dependency(%q<calais>, ["= 0.0.9"])
    s.add_dependency(%q<em-http-request>, ["= 0.2.7"])
  end
end

