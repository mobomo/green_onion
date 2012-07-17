require 'capybara/dsl'

module GreenOnion
	class Screenshot
		include Capybara::DSL

		def initialize
			Capybara.default_driver = :selenium
		end

		def take_screenshot(page, path)
			visit page
			Capybara.page.driver.browser.save_screenshot(path)
		end
	end
end