require 'spec_helper'

describe GreenOnion::Screenshot do

  describe 'Snap single screenshot' do

		before(:each) do
			@tmp_path = './spec/tmp'
			FileUtils.mkdir(@tmp_path)

  		@screenshot = GreenOnion::Screenshot.new(
				:dir => @tmp_path
  		)
			@url = 'http://www.google.com/maps'
			@file = "#{@tmp_path}/maps.png"
  	end

		after(:each) do
			FileUtils.rm_r(@tmp_path, :force => true)
		end

	  it 'should build the path from the URI' do
  		@screenshot.url_to_path(@url).should eq(@file)
	  end

	  it 'should build the path from root' do
  		@screenshot.url_to_path('http://www.google.com').should eq("#{@tmp_path}/root.png")
	  end

	  it 'should build the path from root (even with trailing slash)' do
  		@screenshot.url_to_path('http://www.google.com/').should eq("#{@tmp_path}/root.png")
	  end

	  it 'should snap and save screenshot' do
  		@screenshot.snap_screenshot(@url, @file)
  		File.exist?(@file).should be_true
	  end

		it "should destroy a singular screenshot" do
		  @screenshot.destroy(@url)
  		File.exist?(@file).should be_false
		end
	end

	describe 'Snap two screenshots' do

		before(:each) do
			@tmp_path = './spec/tmp'
			FileUtils.mkdir(@tmp_path)

			@screenshot = GreenOnion::Screenshot.new(
				:dir => @tmp_path
			)
			@url = 'http://www.google.com/maps'
			@file1 = "#{@tmp_path}/maps.png"
			@file2 = "#{@tmp_path}/maps_fresh.png"
			2.times do
				@screenshot.test_screenshot(@url)
			end
		end

		after(:each) do
			FileUtils.rm_r(@tmp_path, :force => true)
		end

		it "should create the paths_hash correctly" do
		  ( (@screenshot.paths_hash[:original].should eq(@file1)) && (@screenshot.paths_hash[:fresh].should eq(@file2)) ).should be_true
		end

		it "should snap and save another screenshot if a screenshot already exists" do
			if File.exist?(@file1)
				File.exist?(@file2).should be_true
			end
		end

		it "should destroy a set of screenshots" do
		  @screenshot.destroy(@url)
		  ( File.exist?(@file1) && File.exist?(@file2) ).should be_false
		end
	end
end