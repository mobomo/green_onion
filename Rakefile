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

namespace :benchmarks do
  require 'benchmark'
  task("server").execute
  @tmp_path = './spec/tmp'

  desc "WebKit benchmark"
  task :webkit do
    require File.expand_path('../lib/green_onion', __FILE__)
    GreenOnion.configure do |c|
      c.skins_dir = @tmp_path
      c.driver = "webkit"
    end
    Benchmark.bm do |x|
      x.report("webkit:")   { 2.times do; GreenOnion.skin_visual('http://localhost:8070'); end }
    end
    FileUtils.rm_r(@tmp_path, :force => true)
  end

  desc "PhantomJS benchmark"
  task :phantomjs do
    require File.expand_path('../lib/green_onion', __FILE__)
    GreenOnion.configure do |c|
      c.skins_dir = @tmp_path
      c.driver = "poltergeist"
    end
    Benchmark.bm do |x|
      x.report("poltergeist:")   { 2.times do; GreenOnion.skin_visual('http://localhost:8070'); end }
    end
    FileUtils.rm_r(@tmp_path, :force => true)
  end

  desc "Selenium benchmark"
  task :selenium do
    require File.expand_path('../lib/green_onion', __FILE__)
    GreenOnion.configure do |c|
      c.skins_dir = @tmp_path
      c.driver = "selenium"
    end
    Benchmark.bm do |x|
      x.report("selenium:")   { 2.times do; GreenOnion.skin_visual('http://localhost:8070'); end }
    end
    FileUtils.rm_r(@tmp_path, :force => true)
  end
end