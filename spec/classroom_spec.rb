require_relative '../classroom'
require_relative '../student'

describe Classroom do
  before :all do
    @classroom = Classroom.new('new Classes')
  end

  describe 'classroom label' do
    it 'should return a Classroom label' do
      expect(@classroom.label).to eql 'new Classes'
    end
  end

  describe 'classroom adding student' do
    it 'should add new students to the classroom' do
      new_student = Student.new(name: 'Ahmed', age: 28, classroom: @classroom)
      @classroom.add_students new_student
      expect(@classroom.students).to include(new_student)
    end
  end

  describe 'students inside classroom' do
    it 'check classroom of newly added student' do
      student = Student.new(name: 'Ahmed', age: 28, classroom: @classroom)
      @classroom.add_students student
      expect(student.classroom).to eql(@classroom)
    end
  end
end
