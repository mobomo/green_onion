require "green_onion/version"
require "green_onion/screenshot"
require "green_onion/compare"
require "green_onion/configuration"
require "rainbow"

module GreenOnion
  class << self

    attr_reader :compare, :screenshot

    # Pass configure block to set Configuration object
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= GreenOnion::Configuration.new
    end

    # Bring the Screenshot and Compare classes together to create a skin
    def skin(url)
      @screenshot = Screenshot.new(
        :dir => @configuration.skins_dir,
        :dimensions => @configuration.dimensions
      )
      @compare = GreenOnion::Compare.new

      @screenshot.test_screenshot(url)
    end

    # Finds the percentage of change between skins
    # Threshold can be set in configuration, or as an argument itself, and can be specific to an instance
    def skin_percentage(url, threshold=@configuration.threshold)
      skin(url)
      if(@screenshot.paths_hash.length > 1)
        puts "\n" + url.color(:cyan)
        @compare.percentage_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
        threshold_alert(@compare.percentage_changed, threshold)
      else
        puts "\n#{url}".color(:cyan) + " has been saved to #{@screenshot.paths_hash[:original]}".color(:yellow)
      end
    end

    # Creates a diffed screenshot between skins
    def skin_visual(url)
      skin(url)
      if(@screenshot.paths_hash.length > 1)
        puts "\n" + url.color(:cyan)
        @compare.visual_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
      else
        puts "\n#{url}".color(:cyan) + " has been saved to #{@screenshot.paths_hash[:original]}".color(:yellow)
      end
    end

    # Creates a diffed screenshot between skins AND prints percentage changed
    def skin_visual_and_percentage(url, threshold=@configuration.threshold)
      skin(url)
      if(@screenshot.paths_hash.length > 1)
        puts "\n" + url.color(:cyan)
        @compare.percentage_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
        @compare.visual_diff(@screenshot.paths_hash[:original], @screenshot.paths_hash[:fresh])
        threshold_alert(@compare.percentage_changed, threshold)
      else
        puts "\n#{url}".color(:cyan) + " has been saved to #{@screenshot.paths_hash[:original]}".color(:yellow)
      end
    end

    # This is used in skin_percentage to better alert if a set of skins are ok or not
    def threshold_alert(actual, threshold)
      if actual > threshold
        $stderr.puts "#{actual - threshold}% above threshold set @ #{threshold}%".color(:red)
        $stderr.puts "pixels changed (%):     #{@compare.percentage_changed}%"
        $stderr.puts "pixels changed/total:  #{@compare.changed_px}/#{@compare.total_px}"
      else
        puts "pixels changed/total:  #{@compare.changed_px}/#{@compare.total_px}"
      end
    end

  end
end
