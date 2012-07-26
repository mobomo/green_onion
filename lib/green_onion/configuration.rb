module GreenOnion
	class Configuration
		
		attr_accessor :skins_dir

		def skins_dir=(directory)
			@skins_dir ||= directory
		end

	end
end