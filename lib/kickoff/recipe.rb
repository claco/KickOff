module KickOff
  class Recipe

    attr_reader :requirements

    def initialize
      @requirements = []
    end

    def execute!
      self.requirements.map(&:verify!)
    end

  end
end
