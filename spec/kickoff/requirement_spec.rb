require 'spec_helper'
require 'kickoff/requirement'

describe KickOff::Requirement do
  subject(:requirement) { KickOff::Requirement.new(name) }
  let(:name) { 'rspec' }

  describe '#initialize' do
    it 'accepts the name of a requirement' do
      requirement.name.should eq(name)
    end
  end

  context 'with a satisified requirement' do
    describe '#satisfied?' do
      it 'returns true' do
        requirement.satisfied?.should be_true
      end
    end

    describe '#verify!' do
      it 'does not throw an exception' do
        expect{ requirement.verify! }.to_not raise_error
      end
    end
  end

  context 'with an unsatisfied requirement' do
    let(:name) { 'bogons' }

    describe '#satisfied?' do
      it 'returns false' do
        requirement.satisfied?.should be_false
      end
    end

    describe '#verify!' do
      it 'throws a RequirementError exception' do
        expect{ requirement.verify! }.to raise_error(KickOff::RequirementError, "Requirement 'bogons' not found")
      end
    end
  end
end
