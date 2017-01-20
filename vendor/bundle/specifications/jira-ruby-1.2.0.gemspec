# -*- encoding: utf-8 -*-
# stub: jira-ruby 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jira-ruby".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["SUMO Heavy Industries".freeze]
  s.date = "2016-12-30"
  s.description = "API for JIRA".freeze
  s.homepage = "http://www.sumoheavy.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubyforge_project = "jira-ruby".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Ruby Gem for use with the Atlassian JIRA REST API".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0.5.0", "~> 0.5"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<railties>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.0.0", "~> 3.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10.3"])
      s.add_development_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_development_dependency(%q<guard-rspec>.freeze, [">= 4.6.5", "~> 4.6"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0.10.3", "~> 0.10"])
    else
      s.add_dependency(%q<oauth>.freeze, [">= 0.5.0", "~> 0.5"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<railties>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.0.0", "~> 3.0"])
      s.add_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10.3"])
      s.add_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
      s.add_dependency(%q<guard-rspec>.freeze, [">= 4.6.5", "~> 4.6"])
      s.add_dependency(%q<pry>.freeze, [">= 0.10.3", "~> 0.10"])
    end
  else
    s.add_dependency(%q<oauth>.freeze, [">= 0.5.0", "~> 0.5"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<railties>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 1.18.0", "~> 1.18"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0.0", "~> 3.0"])
    s.add_dependency(%q<rake>.freeze, [">= 10.3.2", "~> 10.3"])
    s.add_dependency(%q<guard>.freeze, [">= 2.13.0", "~> 2.13"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 4.6.5", "~> 4.6"])
    s.add_dependency(%q<pry>.freeze, [">= 0.10.3", "~> 0.10"])
  end
end
