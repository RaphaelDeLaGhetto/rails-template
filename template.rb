# 2015-8-25
# Adapted from: https://github.com/mattbrictson/rails-template/blob/master/template.rb

RAILS_REQUIREMENT = "~> 4.2.0"

def apply_template!
#  assert_minimum_rails_version
#  assert_valid_options
#  assert_postgresql
  add_template_repository_to_source_path
  
  # Bootstrap
  gem 'bootstrap-sass'
  gem 'bootstrap-will_paginate'
  
  # Use ActiveModel has_secure_password
  gem 'bcrypt'
  
  gem 'faker'
  gem 'will_paginate'
  gem 'figaro'
  gem 'react-rails'
  
  # capistrano
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'
  gem 'capistrano-passenger'
  gem 'highline'
  
  # browserify
  gem 'browserify-rails'
  
  # Authentication
  gem 'devise'
  
  gem_group :test do
    gem "shoulda"
  end

  copy_file ".gitignore", ".gitignore", :force => true
#  template "DEPLOYMENT.md.tt"

  # Config
#  copy_file 'config/application.yml', 'config/application.yml'


  after_bundle do
    setup_devise
#    directory 'db/migrate', 'db/migrate'
    rake("db:migrate")
#    rake("db:setup")

    git :init
  end
end

#require "fileutils"
require "shellwords"

# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    source_paths.unshift(tempdir = Dir.mktmpdir("rails-template-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git :clone => [
      "--quiet",
      "https://github.com/RaphaelDeLaGhetto/rails-template",
      tempdir
    ].map(&:shellescape).join(" ")
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

#
# setup devise
#
def setup_devise
  run 'rails generate devise:install'
#  generate('devise:install')
#  generate(:devise, 'Agent')
end



#
# assert_minimum_rails_version
#
#def assert_minimum_rails_version
#  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
#  rails_version = Gem::Version.new(Rails::VERSION::STRING)
#  return if requirement.satisfied_by?(rails_version)
#
#  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
#           "You are using #{rails_version}. Continue anyway?"
#  exit 1 if no?(prompt)
#end
#
##
## assert_valid_options
##
## Bail out if user has passed in contradictory generator options.
#def assert_valid_options
#  valid_options = {
#    :skip_gemfile => false,
#    :skip_bundle => false,
#    :skip_git => false,
#    :skip_test_unit => false,
#    :edge => false
#  }
#  valid_options.each do |key, expected|
#    next unless options.key?(key)
#    actual = options[key]
#    unless actual == expected
#      fail Rails::Generators::Error, "Unsupported option: #{key}=#{actual}"
#    end
#  end
#end
#
#def assert_postgresql
#  puts "THIS SHOULD FAIL---------------------------------------------------------------------------", IO.read("Gemfile") =~ /^\s*gem ['"]pg['"]/
#  return if IO.read("Gemfile") =~ /^\s*gem ['"]pg['"]/
#  fail Rails::Generators::Error,
#    "This template requires PostgreSQL, "\
#    "but the pg gem isn’t present in your Gemfile."
#end
#
#def gemfile_requirement(name)
#  @original_gemfile ||= IO.read("Gemfile")
#  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d\.\w'"]*).*$/, 1]
#  req && req.gsub("'", %(")).strip.sub(/^,\s*"/, ', "')
#end

apply_template!
