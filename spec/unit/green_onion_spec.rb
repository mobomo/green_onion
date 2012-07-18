require 'spec_helper'

describe GreenOnion::Screenshot do

	before(:all) do
		@tmp_path = './spec/tmp'
	  FileUtils.mkdir(@tmp_path)
	end

	after(:all) do
	  FileUtils.rm_r(@tmp_path, :force => true)
	end

  describe 'Screenshot' do

  	before(:each) do
  		@screenshot = GreenOnion::Screenshot.new(
  			:dir => @tmp_path
  		)
	  	@url = 'http://www.google.com/maps'
	  	@file = "#{@tmp_path}/maps.png"
  		@screenshot.take_screenshot(@url, @file)
  	end

	  it 'should build the path from the URI' do
  		@screenshot.url_to_path(@url).should eq(@file)
	  end

	  it 'should build the path from root' do
  		@screenshot.url_to_path('http://www.google.com').should eq("#{@tmp_path}/root.png")
	  end

	  it 'should take and save screenshot if one does not exist' do
  		File.exist?(@file).should be_true
	  end
	end

	describe 'Comparing Screenshots' do

  	before(:each) do
  		@screenshot = GreenOnion::Screenshot.new(
  			:dir => @tmp_path
  		)
	  	@url = 'http://www.google.com/maps'
	  	@file = "#{@tmp_path}/maps.png"
	  	2.times do
  			@screenshot.test_screenshot(@url)
  		end
  	end

	  it "should take and save another screenshot if a screenshot already exists" do
	    pending
	    # if File.exist?(@file)
	    # 	File
	    # end
	  end
	  it 'should compare screenshots' do
	  	pending
	  end

	  it 'should print results' do
	  	pending
	  end
	end
end