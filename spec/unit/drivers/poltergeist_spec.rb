require "spec_helper"

describe 'Using Poltergeist' do

  before(:all) do
    @url = 'http://localhost:8070'
    @url_w_uri = @url + '/fake_uri'
    @tmp_path = './spec/tmp'
    @browser = GreenOnion::Browser.new(
      :dimensions => { :width => 1024, :height => 768 },
      :driver => "poltergeist"
    )
  end

  before(:each) do
    @screenshot = GreenOnion::Screenshot.new(
      :browser => @browser,
      :dir => @tmp_path,
      :skin_name => { 
        :match => /[\/]/,
        :replace => "_",
        :prefix => nil,
        :root => "root"
      }
    )
    @file = "#{@tmp_path}/fake_uri.png"
  end

  after(:each) do
    FileUtils.rm_r(@tmp_path, :force => true)
  end

  it "should snap and save screenshot w/ Poltergeist" do
    @screenshot.test_screenshot(@url_w_uri)
    File.exist?(@file).should be_true
  end
end