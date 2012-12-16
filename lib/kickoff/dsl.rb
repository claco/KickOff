require 'kickoff/recipe'
require 'kickoff/requirement'

module KickOff
  class DSL

    attr_reader :requirements

    def initialize(&block)
      @requirements = []

      if block_given?
        if block.arity == 1
          yield self
        else
          instance_eval(&block)
        end
      end
    end

    def self.evaluate(content)
      builder = new
      builder.instance_eval(content)
      builder
    end
    
    def requires(name)
      self.requirements << KickOff::Requirement.new(name)
    end

    def to_recipe
      recipe = KickOff::Recipe.new
      recipe.requirements.concat(self.requirements)
      recipe
    end

  end
end
