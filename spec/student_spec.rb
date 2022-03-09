require_relative '../student'
require_relative '../classroom'

describe Student do
  before :all do
    @student = Student.new(classroom: Classroom.new('new Classes'), age: 25, name: 'Ahmed')
  end

  describe 'new student' do
    it 'check creating new student' do
      expect(@student).to be_an_instance_of(Student)
    end
  end

  describe 'age' do
    it 'returns correct student age' do
      expect(@student.age).to eql 25
    end
  end

  describe 'name' do
    it 'returns correct student name' do
      expect(@student.name).to eql 'Ahmed'
    end
  end

  describe 'parent_permission' do
    it 'returns correct parent_permisson' do
      expect(@student.parent_permission).to eql true
    end
  end
end
