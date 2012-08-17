module GreenOnion
  class Configuration

    attr_writer :threshold, :skins_dir, :driver

    def dimensions=(options)
      @dimensions = options
    end
    
    def dimensions
      @dimensions ||= { :height => 768, :width => 1024 }
    end

    def threshold
      @threshold ||= 100
    end

    def skins_dir
      @skins_dir ||= './spec/skins'
    end

    def driver
      @driver ||= :webkit
    end

    # Uses the driver and dimensions configuration vars to return a Browser object
    def browser
      @browser = Browser.new(
        :dimensions => dimensions,
        :driver => driver
      )
    end

    def skin_name=(options)
      @skin_name = skin_namespace_hash(options)
    end

    def skin_name
      @skin_name ||= skin_namespace_hash
    end

    # Serves as a template for skin_name getter/setter
    def skin_namespace_hash(options = {})
      { 
        :match   =>  options[:match] ? options[:match] : /[\/]/, 
        :replace =>  options[:replace] ? options[:replace] : "_", 
        :prefix  =>  options[:prefix] ? options[:prefix] : nil,
        :root    =>  options[:root] ? options[:root] : "root"
      }
    end

  end
end