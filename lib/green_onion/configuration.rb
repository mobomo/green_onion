module GreenOnion
  class Configuration

    attr_writer :threshold, :skins_dir

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

    def skin_name=(options)
      @skin_name = skin_namespace_hash(options)
    end

    def skin_name
      @skin_name ||= skin_namespace_hash
    end

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