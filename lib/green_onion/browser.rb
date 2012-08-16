require 'capybara/dsl'
require 'capybara-webkit'

module GreenOnion
  class Browser
    include Capybara::DSL

    attr_reader :dimensions

    def initialize(params={})
      Capybara.default_driver = :webkit
      @dimensions = params[:dimensions]
    end


    def snap_screenshot(url, path)
      visit url
      Capybara.page.driver.render(path, @dimensions)
    end

  end
end