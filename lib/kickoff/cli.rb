# -*- encoding: utf-8 -*-
require 'mixlib/cli'
require 'kickoff/dsl'

module Kickoff
  class CLI
    include Mixlib::CLI

    banner 'Usage: kickoff recipe (options)'

    option :help,
      :short        => '-h',
      :long         => '--help',
      :description  => 'Show this message',
      :on           => :tail,
      :boolean      => true,
      :show_options => true,
      :exit         => 0

    def run( argv=ARGV )
      begin
        parse_options(argv)

        if no_recipe_given?
          puts self.opt_parser
        else
          recipe = KickOff::DSL.evaluate(File.read(ARGV[0])).to_recipe
          recipe.execute!
        end
      rescue Exception => ex
        $stderr.puts ex

        exit 1
      end
    end

    private

    def no_recipe_given?
      ARGV.empty? || ARGV[0] =~ /^-/
    end

  end
end
