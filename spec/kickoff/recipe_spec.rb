require 'spec_helper'
require 'kickoff/recipe'
require 'kickoff/requirement'

describe KickOff::Recipe do
  subject(:recipe)  { KickOff::Recipe.new }
  let(:requirement) { KickOff::Requirement.new('rspec') }

  context 'with no requirements' do
    describe '#requirements' do
      it 'should be empty' do
        recipe.requirements.should be_an_instance_of(Array)
        recipe.requirements.should be_empty
      end
    end

    describe '#execute!' do
      it 'throws no exceptions' do
        expect{ recipe.execute! }.to_not raise_error
      end
    end
  end

  context 'with valid requirements' do
    describe '#execute!' do
      it 'verifies the requirements' do
        requirement.should_receive(:verify!)

        recipe.requirements << requirement
        recipe.execute!
      end
    end
  end

  context 'with invalid requirements' do
    let(:requirement) { KickOff::Requirement.new('bogons') }

    describe '#execute!' do
      it 'throws a RequirementError exception' do
        recipe.requirements << requirement
        expect{ recipe.execute! }.to raise_error(KickOff::RequirementError)
      end
    end
  end
end
