require 'capybara/dsl'
require 'capybara-webkit'

module GreenOnion
  class Browser
    include Capybara::DSL

    attr_reader :driver, :dimensions

    def initialize(params={})
      @driver = params[:driver]
      @dimensions = params[:dimensions]
      Capybara.default_driver = @driver
    end


    def snap_screenshot(url, path)
      visit url
      if @driver == :webkit
        Capybara.page.driver.render(path, @dimensions)
      else
        Capybara.page.driver.browser.save_screenshot(path)
      end
    end

  end
end