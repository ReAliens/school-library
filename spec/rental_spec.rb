require_relative '../person'
require_relative '../book'
require_relative '../rental'

describe Rental do
  context 'When providing a book and a person' do
    book = Book.new('The Art of Deception', 'Kevin Mitnick')
    person = Person.new(age: 28, name: 'Ahmed', parent_permission: true)
    rental = Rental.new('18/12/2021', book, person)

    it 'should create a rental for person' do
      expect(person.rentals).to include(rental)
    end

    it 'should create a rental for book' do
      expect(book.rentals).to include(rental)
    end
  end
end
