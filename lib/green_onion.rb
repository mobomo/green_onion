require "green_onion/version"
require "green_onion/screenshot"
require "green_onion/compare"
require "green_onion/configuration"
module GreenOnion
	class << self

		attr_reader :compare, :screenshot

		def configure
			yield configuration
		end

		def configuration
			@configuration ||= GreenOnion::Configuration.new
		end

		def skin(url)
			@screenshot = Screenshot.new(
				:dir => self.configuration.skins_dir
			)
			@compare = GreenOnion::Compare.new

			@screenshot.test_screenshot(url)
		end

		def skin_percentage(url)
			self.skin(url)
			if(@screenshot.paths_hash.length > 1)
				self.compare.percentage_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
			end
		end

		def skin_visual(url)
			self.skin(url)
			if(@screenshot.paths_hash.length > 1)
				self.compare.visual_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
			end
		end

	end
end
