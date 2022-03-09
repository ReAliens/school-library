require_relative '../corrector'

describe Corrector do
  before :all do
    @corrector = Corrector.new
  end

  describe 'correct name' do
    it 'should returns corrected name uppercased first letter' do
      expect(@corrector.correct_name('ahmed')).to eql 'Ahmed'
    end
  end
end
