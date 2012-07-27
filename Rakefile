#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Running specs..."
task :specs do
	system "rspec spec"
end

desc "Running specs on test server"
task :spec do
	server = Thread.new do	
		require File.dirname(__FILE__) + '/spec/sample_app/sample_app.rb'
		Rack::Handler::WEBrick.run SampleApp, :Port => 8070
	end
	task("specs").execute
	server.kill
end