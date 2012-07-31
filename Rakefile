#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rack'

desc "Running server..."
task :server do
  require File.dirname(__FILE__) + '/spec/sample_app/sample_app.rb'
  Rack::Handler::WEBrick.run SampleApp, :Port => 8070
end

desc "Running specs..."
task :specs do
  system "rspec spec"
end

desc "Running specs on test server"
task :spec do
  # have the server run on its own thread so that it doesn't block the spec task
  server = Thread.new do  
    task("server").execute
  end
  task("specs").execute
  server.kill
end