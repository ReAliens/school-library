require_relative '../book'

describe Book do
  before :all do
    @book = Book.new 'Harry Potter', 'J. K. Rowling'
  end

  describe 'new' do
    it 'check creating new book' do
      expect(@book).to be_an_instance_of(Book)
    end
  end

  describe 'title' do
    it 'returns correct title' do
      expect(@book.title).to eql 'Harry Potter'
    end
  end

  describe 'author' do
    it 'returns correct author' do
      expect(@book.author).to eql 'J. K. Rowling'
    end
  end
end
