require 'spec_helper'

describe GreenOnion::Compare do

  describe 'Comparing Screenshots' do

    before(:each) do
      @comparison = GreenOnion::Compare.new
      @spec_shot1 = './spec/skins/spec_shot.png'
      @spec_shot2 = './spec/skins/spec_shot_fresh.png'
      @diff_shot = './spec/skins/spec_shot_diff.png'
    end

    after(:all) do
      FileUtils.rm('./spec/skins/spec_shot_diff.png', :force => true)
    end

    it 'should get a percentage of difference between two shots' do
      @comparison.percentage_diff(@spec_shot1, @spec_shot2)
      @comparison.percentage_changed.should eq(66.0)
    end

    it 'should create a new file with a visual diff between two shots' do
      @comparison.visual_diff(@spec_shot1, @spec_shot2)
      File.exist?(@diff_shot).should be_true
    end
  end
end