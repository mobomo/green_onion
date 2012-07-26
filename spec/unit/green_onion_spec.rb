require "spec_helper"

describe GreenOnion do

	describe "Skins" do
	  
	  before(:each) do	
			@tmp_path = './spec/tmp'
			FileUtils.mkdir(@tmp_path)

	    GreenOnion.configure do |c|
	    	c.skins_dir = @tmp_path
	    end
	  end

		after(:each) do
			FileUtils.rm_r(@tmp_path, :force => true)
		end

	  it "should set/get custom directory" do
	    GreenOnion.configuration.skins_dir.should eq(@tmp_path)
	  end

	  it "should get the correct paths_hash" do
		  2.times do
			  GreenOnion.skin('http://www.google.com')
			end
		  ( (GreenOnion.screenshot.paths_hash[:original] == "#{@tmp_path}/root.png") && 
		  	(GreenOnion.screenshot.paths_hash[:fresh] == "#{@tmp_path}/root_fresh.png") ).should be_true
	  end

		it "should measure the percentage of diff between skins" do	      
		  2.times do
			  GreenOnion.skin_percentage('http://www.google.com')
			end
		  GreenOnion.compare.percentage_changed.should be <(1)
		end

		it "should create visual diff between skins"

		it "should create visual diff between skins (even when there is no change)" do	      
		  2.times do
			  GreenOnion.skin_visual('http://www.google.com')
			end
			GreenOnion.compare.diffed_image.should eq('./spec/tmp/root_diff.png')
		end

	end
end