require 'spec_helper'

describe "bin/green_onion" do

  before(:all) do
    @tmp_path = './spec/tmp'
    @url = 'http://localhost:8070'
    @file1 = "#{@tmp_path}/root.png"
    @skinner_file = "#{@tmp_path}/skinner.rb"
  end

  describe "Skin Utility" do

    before(:each) do  
      FileUtils.mkdir(@tmp_path)
    end

    after(:each) do
      FileUtils.rm_r(@tmp_path, :force => true)
    end     

    it "should run the skin task w/o any flags (need the --dir flag to keep spec directory clean)" do
      `bin/green_onion skin #{@url} -d=#{@tmp_path}`
      File.exist?(@file1).should be_true
    end

  end

  describe "Generator" do

    before(:each) do  
      FileUtils.mkdir(@tmp_path)
    end

    after(:each) do
      FileUtils.rm_r(@tmp_path, :force => true)
    end     

    it "should build the skinner file" do
      `bin/green_onion generate --url=#{@url} --dir=#{@tmp_path}`
      File.exist?(@skinner_file).should be_true
    end
    
  end
end