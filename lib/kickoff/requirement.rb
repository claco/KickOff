module KickOff
  class RequirementError < StandardError;end

  class Requirement

    attr_reader :name

    def initialize(name)
      @name = name     
    end

    def satisfied?
      !`which #{self.name}`.empty? 
    end

    def verify!
      if !self.satisfied?
        raise RequirementError, "Requirement '#{self.name}' not found"
      end

      return
    end

  end
end
