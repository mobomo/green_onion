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

  end
end