require 'spec_helper'

describe GreenOnion::Compare do

  describe 'Comparing Screenshots' do

    before(:each) do
      @comparison = GreenOnion::Compare.new
      @spec_shot1 = './spec/skins/spec_shot.png'
      @spec_shot2 = './spec/skins/spec_shot_fresh.png'
      @spec_shot_resize = './spec/skins/spec_shot_resize.png'
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

    it "should not throw error when dimensions are off" do
      expect { @comparison.visual_diff(@spec_shot1, @spec_shot_resize) }.to_not raise_error
    end

  end

  describe 'Clustering' do

    before(:each) do
      @comparison = GreenOnion::Compare.new
      @cluster_shot1 = './spec/skins/cluster_shot.png'
      @cluster_shot2 = './spec/skins/cluster_shot_fresh.png'
      @cluster_shot3 = './spec/skins/cluster3_shot_fresh.png'
    end

    it "should measure the clustering of changes on a skin w/ 2 clusters" do
      @comparison.diff_images(@cluster_shot1, @cluster_shot2)
      @comparison.pixel_clustering
      @comparison.clusters.size.should eq(2)
    end

    it "should measure the clustering of changes on a skin w/ 3 clusters" do
      @comparison.diff_images(@cluster_shot1, @cluster_shot3)
      @comparison.pixel_clustering
      @comparison.clusters.size.should eq(3)
    end
  end
end