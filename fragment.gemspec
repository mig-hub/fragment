Gem::Specification.new do |s| 
  s.name = 'fragment'
  s.version = "1.0.0"
  s.platform = Gem::Platform::RUBY
  s.summary = "Lightweight HTML builder"
  s.description = "An HTML builder heavily based on Gestalt from the Ramaze framework. Its main purpose is to create fragments (hence the name), but is perfectly suited for building full pages."
  s.files = `git ls-files`.split("\n").sort
  s.require_path = './lib'
  s.author = "Mickael Riga"
  s.email = "mig@mypeplum.com"
  s.homepage = "https://github.com/mig-hub/fragment"
  s.add_development_dependency(%q<bacon>, "~> 1.1.0")
end
