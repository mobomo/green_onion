require 'spec_helper'

describe GreenOnion::Compare do

	describe 'Comparing Screenshots' do

		before(:each) do
			@comparison = GreenOnion::Compare.new
			@spec_shot1 = './spec/skins/spec_shot.png'
			@spec_shot2 = './spec/skins/spec_shot_fresh.png'
		end

		it 'should get a percentage of difference between two shots' do
			@comparison.percentage_diff(@spec_shot1, @spec_shot2)
			@comparison.percentage_changed.should eq(66.0)
		end

		it 'should create a new file with a visual diff between two shots' do
			@comparison.visual_diff(@spec_shot1, @spec_shot2)
		end
	end
end