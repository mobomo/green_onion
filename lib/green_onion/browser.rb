module GreenOnion
  class Browser

    attr_reader :driver, :dimensions

    def initialize(params={})
      @driver = params[:driver]
      @dimensions = params[:dimensions]
      load_driver
    end

    def load_driver
      begin
        require "green_onion/drivers/#{driver}"
        @driver_obj = GreenOnion.const_get(@driver.capitalize).new
      rescue LoadError => e
        raise e unless e.message.include?("green_onion/drivers")
        raise ArgumentError.new("#{@driver} is not supported by GreenOnion.")
      end
    end

    def snap_screenshot(url, path)
      @driver_obj.record(url, path, @dimensions)
    end

  end
end