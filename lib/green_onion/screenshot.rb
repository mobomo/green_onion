require 'capybara/dsl'

module GreenOnion
	class Screenshot
		include Capybara::DSL

		attr_accessor :dir

		def initialize(params = {})
			Capybara.default_driver = :selenium
			@dir = params[:dir]
		end

		def take_screenshot(url, path)
			visit url
			Capybara.page.driver.browser.save_screenshot(path)
		end

		def test_screenshot(url)
			url_to_path(url)
			if File.exist?(@path)
				take_screenshot(url, @path)
			else
				take_screenshot(url, @path)
			end
		end

		def url_to_path(url)
			@filename = url.match(/^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/)[5]
			if @filename.empty?
				@path = "#{@dir}/root.png"
			else
				@filename = @filename.gsub(/[\/]/, '')
				@path = "#{@dir}/#{@filename}.png"
			end
			return @path
		end

	end
end