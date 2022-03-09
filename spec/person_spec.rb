require_relative '../person'

describe Person do
  before :all do
    @first_person = Person.new(age: 25, name: 'Sinyinza')
    @seconed_person = Person.new(age: 15, name: 'Sinyinza', parent_permission: false)
  end

  describe 'new person' do
    it 'should return a Person object' do
      expect(@first_person).to be_an_instance_of(Person)
    end
  end

  describe 'check name' do
    it 'should returns correct name' do
      expect(@first_person.name).to eql 'Sinyinza'
    end
  end

  describe 'check id' do
    it 'should returns id of person' do
      expect(@first_person.id).to be_kind_of Numeric
    end
  end

  describe 'check can_use_services? methods' do
    it 'should returns boolean value: true' do
      expect(@first_person.can_use_services?).to be true
    end
  end

  describe 'check can_use_services? methods' do
    it 'returns boolean value: false' do
      expect(@seconed_person.can_use_services?).to be false
    end
  end
end
