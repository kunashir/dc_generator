#!/usr/bin/env ruby

require "erb"
require "byebug"

# it generates Dockerfile and docker-compose.yml
# for Rails app
#

def generate_compose_config(rails_path)
  # figure out dependencies: db redis
  @db_user = "postgres"
  @db_password = "secret"
  template = File.read("./lib/docker-compose.yml.template")
  ERB.new(template, trim_mode: "%<>").result
end

def ruby_version(rails_path)
  if File.exists?("#{rails_path}/.ruby-version")
    return File.read("#{rails_path}/.ruby-version").strip.match(/(\d+\.*){3}/).to_s
  end
  # extract version from Gemfile
  if File.exists?("${rails_path}/Gemfile")

  end
  # default version
  "3.2.0"
end

def bundle_version(rails_path)
end

def generate_dockerfile(rails_path)
  @ruby_version = ruby_version(rails_path)
  @bundle_version = "2.2.3"
  template = File.read("./lib/Dockerfile.template")
  docker_file = ERB.new(template, trim_mode: "%<>")
  docker_file.result
end

path = "/Users/aleksandrkorolev/dalia/home_assignments/cran_indexer"
puts generate_dockerfile(path)

puts "=" * 40

puts generate_compose_config(path)
