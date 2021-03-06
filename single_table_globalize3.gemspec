require File.expand_path('../lib/single_table_globalize3/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'single_table_globalize3'
  s.version      = SingleTableGlobalize3::VERSION
  s.authors      = ['Sven Fuchs', 'Joshua Harvey', 'Clemens Kofler', 'John-Paul Bader', 'Tomasz Stachewicz', 'Philip Arndt', 'Trong Tran']
  s.email        = 'trong.v.tran@gmail.com'
  s.homepage     = 'http://github.com/trongrg/single_table_globalize3'
  s.summary      = 'Globalize3 successor which uses only one table to store all the translations'
  s.description  = "#{s.summary}."

  s.files        = Dir['{lib/**/*,[A-Z]*}']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  if ENV['RAILS_3_0']
    s.add_dependency 'activerecord', '~> 3.0.0'
    s.add_dependency 'activemodel', '~> 3.0.0'
  elsif ENV['RAILS_3_1']
    s.add_dependency 'activerecord', '~> 3.1.0'
    s.add_dependency 'activemodel', '~> 3.1.0'
  elsif ENV['RAILS_3_2']
    s.add_dependency 'activerecord', '~> 3.2.0'
    s.add_dependency 'activemodel', '~> 3.2.0'
  else
    # normal case
    s.add_dependency 'activerecord', '>= 3.0.0'
    s.add_dependency 'activemodel', '>= 3.0.0'
  end
  s.add_dependency 'paper_trail',  '~> 2.7.1'

  s.add_development_dependency 'database_cleaner', '~> 0.9.1'
  s.add_development_dependency 'mocha', '~> 0.13.3'
  s.add_development_dependency 'pathname_local', '~> 0.0.2'
  s.add_development_dependency 'test_declarative', '~> 0.0.5'

  s.add_development_dependency 'sqlite3', '~> 1.3.7'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc', '~> 3.12.2'
end
