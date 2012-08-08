require 'capybara/dsl'
require 'capybara-webkit'
require "fileutils"

module GreenOnion
  class Screenshot
    include Capybara::DSL

    attr_accessor :dir, :dimensions, :skin_name
    attr_reader :paths_hash

    def initialize(params = {})
      Capybara.default_driver = :webkit
      @dimensions = params[:dimensions]
      @dir = params[:dir]
      @skin_name = params[:skin_name]
      @paths_hash = {}
    end

    def snap_screenshot(url, path)
      visit url
      Capybara.page.driver.render(path, @dimensions)
    end

    def test_screenshot(url)
      url_to_path(url)
      snap_screenshot(url, @shot_path)
    end

    def url_to_path(url)
      get_path(url)
      if File.exist?(@paths_hash[:original])
        @paths_hash[:fresh] = @paths_hash[:original].dup.insert(-5, '_fresh')
        @shot_path = @paths_hash[:fresh]
      else
        @shot_path = @paths_hash[:original]
      end
    end  

    def url_matcher(url)
      url_match = url.match(/^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/).to_a.compact
      if url_match.length >= 5
        @filename = url_match[5]
      else
        raise Errors::IllformattedURL.new "Your URL is incorrectly formatted. Please make sure to use http://"
      end
    end

    def file_namer
      @filename.slice!(/^\//) # remove the beginning "/" if there is one
      @filename = @filename.gsub(@skin_name[:match], @skin_name[:replace]) # by default, all "/" in a URI string will be replaced with "_"
      @filename = @skin_name[:prefix] + @filename if @skin_name[:prefix] # add on a prefix defined in the configuration block
      @paths_hash[:original] = "#{@dir}/#{@filename}.png"
    end

    def get_path(url)
      url_matcher(url)
      if @filename.empty? || @filename == '/' 
        @paths_hash[:original] = "#{@dir}/#{@skin_name[:root]}.png"
      else
        file_namer
      end
    end

    def destroy(url)
      get_path(url)
      destroy_files(@paths_hash[:original], @paths_hash[:fresh])
    end

    def destroy_files(org, fresh)
      if File.exist?(org)
        FileUtils.rm(org)
        if File.exist?(fresh)
          FileUtils.rm(fresh) 
        end
      end
    end

  end
end