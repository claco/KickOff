require 'spec_helper'
require 'kickoff/dsl'
require 'kickoff/recipe'
require 'kickoff/requirement'

describe KickOff::DSL do
  subject(:dsl)     { KickOff::DSL.new }
  let(:recipe)      { dsl.to_recipe }
  let(:requirement) { dsl.requirements.first }

  describe '.evaluate' do
    it 'evaluates a string' do
      content = "requires 'rspec'"

      dsl = KickOff::DSL.evaluate(content)

      requirement = dsl.requirements.first
      requirement.should be_an_instance_of(KickOff::Requirement)
      requirement.name.should eq('rspec')
    end
  end

  describe '#initialize' do
    it 'accepts a yield style block' do
      dsl = KickOff::DSL.new do
        requires 'rspec'
      end

      requirement = dsl.requirements.first
      requirement.should be_an_instance_of(KickOff::Requirement)
      requirement.name.should eq('rspec')
    end

    it 'accepts a instance_eval style block' do
      dsl = KickOff::DSL.new do |r|
        r.requires 'rspec'
      end

      requirement = dsl.requirements.first
      requirement.should be_an_instance_of(KickOff::Requirement)
      requirement.name.should eq('rspec')
    end
  end

  describe '#requirements' do
    it 'creates requirements from a string' do   
      dsl.requires('rspec')
      
      requirement.should be_an_instance_of(KickOff::Requirement)
      requirement.name.should eq('rspec')
    end
  end

  describe '#to_recipe' do
    it 'converts the KickOff::DSL instance to a KickOff::Recipe' do
      dsl.requires 'rspec'

      recipe.should be_an_instance_of(KickOff::Recipe)
      recipe.requirements.should eq dsl.requirements
    end
  end
end
