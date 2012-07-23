require 'capybara/dsl'
require "fileutils"

module GreenOnion
	class Screenshot
		include Capybara::DSL

		attr_accessor :dir

		def initialize(params = {})
			Capybara.default_driver = :selenium
			@dir = params[:dir]
		end

		def snap_screenshot(url, path)
			visit url
			Capybara.page.driver.browser.save_screenshot(path)
		end

		def test_screenshot(url)
			url_to_path(url)
			snap_screenshot(url, @path)
		end

		def url_to_path(url)
			get_path(url)
			accepted?(@path)
			return @path
		end	

		def get_path(url)
			@filename = url.match(/^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/)[5]
			if @filename.empty?
				@path = "#{@dir}/root.png"
			else
				@filename = @filename.gsub(/[\/]/, '')
				@path = "#{@dir}/#{@filename}.png"
			end
			return @path
		end

		def accepted?(path)
			if File.exist?(path)
				return path.insert(-5, '_fresh')
			else
				return path
			end
		end

		def destroy(url)
			get_path(url)
			fresh_path = @path.insert(-5, '_fresh')

			if File.exist?(@path)
				FileUtils.rm(@path)
				if File.exist?(fresh_path)
					FileUtils.rm(fresh_path) 
				end
			end
		end

	end
end