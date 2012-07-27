require "spec_helper"

describe GreenOnion do

	describe "Skins" do
	  
	  before(:each) do	
			@tmp_path = './spec/tmp'
			@url = 'http://localhost:8070'
			@url_w_uri = @url + '/fake_uri'
			FileUtils.mkdir(@tmp_path)

	    GreenOnion.configure do |c|
	    	c.skins_dir = @tmp_path
	    	c.threshold = 1
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
			  GreenOnion.skin(@url)
			end
		  ( (GreenOnion.screenshot.paths_hash[:original] == "#{@tmp_path}/root.png") && 
		  	(GreenOnion.screenshot.paths_hash[:fresh] == "#{@tmp_path}/root_fresh.png") ).should be_true
	  end

		it "should measure the percentage of diff between skins" do	      
		  2.times do
			  GreenOnion.skin_percentage(@url)
			end
		  GreenOnion.compare.percentage_changed.should be > 0
		end

		it "should measure the percentage of diff between skins (even if there is no diff)" do	      
		  2.times do
			  GreenOnion.skin_percentage(@url_w_uri)
			end
		  GreenOnion.compare.percentage_changed.should be == 0
		end

		it "should alert when diff percentage threshold is surpassed" do
			$stdout.should_receive(:puts).exactly(4).times
		  2.times do
			  GreenOnion.skin_percentage(@url)
			end
		end

		it "should print just URL and changed/total when diff percentage threshold has not been surpassed" do
			$stdout.should_receive(:puts).exactly(2).times
		  2.times do
			  GreenOnion.skin_percentage(@url, 6)
			end
		end

		it "should create visual diff between skins" do      
		  2.times do
			  GreenOnion.skin_visual(@url)
			end
			GreenOnion.compare.diffed_image.should eq("#{@tmp_path}/root_diff.png")
		end


		it "should create visual diff between skins (even when there is no change)" do	      
		  2.times do
			  GreenOnion.skin_visual(@url_w_uri)
			end
			GreenOnion.compare.diffed_image.should eq("#{@tmp_path}/fake_uri_diff.png")
		end

		it "should measure the percentage of diff between skins AND create visual diff" do	      
		  2.times do
			  GreenOnion.skin_visual_and_percentage(@url)
			end
			( (GreenOnion.compare.diffed_image.should eq("#{@tmp_path}/root_diff.png")) &&
		  	(GreenOnion.compare.percentage_changed.should be > 0) ).should be_true
		end

	end
end