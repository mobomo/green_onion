require 'spec_helper'

describe GreenOnion::Screenshot do
	
	TmpPath = './spec/tmp'

	before(:all) do
	  FileUtils.mkdir(TmpPath)
	end

	after(:all) do
	  FileUtils.rm_r(TmpPath, :force => true)
	end

  describe 'Screenshots', :type => :request do
  	before(:each) do
  		@screenshot = GreenOnion::Screenshot.new
  	end

	  it 'should take and save screenshot' do
	  	page = 'http://www.google.com'
	  	path = "#{TmpPath}/test.png"
  		@screenshot.take_screenshot(page, path)
  		File.exist?(path).should be_true
	  end
	end

	describe 'Comparing' do
	  it 'should compare screenshots' do
	  	pending
	  end

	  it 'should print results' do
	  	pending
	  end
	end
end