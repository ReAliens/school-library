require_relative 'rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, self, person)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      :title => @title,
      :author => @author
    }.to_json(*args)
  end

  def self.from_json(obj)
    new(obj['title'], obj['author'])
  end
end
