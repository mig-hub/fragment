require_relative './lib/fragment/version'

Gem::Specification.new do |s| 

  s.name = 'fragment'
  s.version = Fragment.version
  s.summary = "Lightweight HTML builder"
  s.description = "An HTML builder heavily based on Gestalt from the Ramaze framework. Its main purpose is to create fragments (hence the name), but is perfectly suited for building full pages."
  s.author = "Mickael Riga"
  s.email = "mig@mypeplum.com"
  s.homepage = "https://github.com/mig-hub/fragment"
  s.licenses = ['MIT']

  s.platform = Gem::Platform::RUBY
  s.require_path = './lib'
  s.files = `git ls-files`.split("\n").sort
  s.test_files = s.files.select { |p| p =~ /^spec\/.*_spec.rb/ }

  s.add_development_dependency("rspec")
end

