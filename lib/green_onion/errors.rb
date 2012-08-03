module GreenOnion
  class Errors
    #Base class for all errors
    class Error < StandardError; end

    class IllformattedURL < Error; end

    class ThresholdOutOfRange < Error; end
  end
end