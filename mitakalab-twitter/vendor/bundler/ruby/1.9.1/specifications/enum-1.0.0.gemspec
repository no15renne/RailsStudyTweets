# -*- encoding: utf-8 -*-
# stub: enum 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "enum"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["capnregex"]
  s.date = "2010-09-14"
  s.description = "A java like Enum class for ruby. \n\nA while ago I was exploring Java, and came across the Enum class, which had\nsome interesting functionality, and I decided that I would like something like\nit. \n\nConceptually if you just need a unique identifier you may be perfectly happy using a :symbol, and that would likely be a simpler way of having a controll flag. However, if you want to have a set of unique identifiers that you can address, iterate over, assign properties to, etc, then this may be something you would be interested in."
  s.email = ["capnregex@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "http://github.com/capnregex/enum"
  s.rdoc_options = ["--main", "README.txt"]
  s.rubyforge_project = "enum"
  s.rubygems_version = "2.4.1"
  s.summary = "A java like Enum class for ruby"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.2"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.2"])
  end
end
