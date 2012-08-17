require 'capybara/dsl'
require 'capybara/poltergeist'

module GreenOnion
  class Poltergeist
    include Capybara::DSL

    def initialize
      Capybara.default_driver = :poltergeist
    end

    def record(url, path, dimensions)
      visit url
      page.driver.resize(dimensions[:width], dimensions[:height])
      page.driver.render(path, :full => true)
    end

  end
end