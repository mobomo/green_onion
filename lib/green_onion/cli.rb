require "thor"
require "green_onion"

module GreenOnion
  class CLI < Thor
    include Thor::Actions

    source_root File.expand_path('../generators', __FILE__)

    class_option :dir, :aliases => "-d", :type => :string

    desc "skin <url>", "Creates skins from <url> and compares them"
    method_option :method, :aliases => "-m", :type => :string
    method_option :threshold, :aliases => "-t", :type => :numeric
    method_option :driver, :aliases => "-b", :type => :string
    method_option :width, :aliases => "-w", :type => :numeric
    method_option :height, :aliases => "-h", :type => :numeric
    def skin(url)
      GreenOnion.configure do |c|
        c.skins_dir = options[:dir] if options[:dir]
        c.threshold = options[:threshold] if options[:threshold]
        c.dimensions = { :width => options[:width], :height => options[:height] } if options[:width] && options[:height]
        c.driver = options[:driver].to_sym if options[:driver]
      end
      case options[:method]
      when "v"
        GreenOnion.skin_visual(url)
      when "p"
        GreenOnion.skin_percentage(url)
      else
        GreenOnion.skin_visual_and_percentage(url)
      end
    end

    desc "generate", "Generates a 'skinner' file to test only Rails routes without params"
    method_option :url, :aliases => "-u", :type => :string
    def generate_skinner
      options[:dir] ? dir = options[:dir] : dir = "spec"
      options[:url] ? config = { :url => options[:url] } : config = { :url => "http://localhost:3000" }
      template('skinner.erb', "#{dir}/skinner.rb", config)
    end
  end
end