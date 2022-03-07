require_relative 'handlers'

class App
  include Handlers
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def start
    puts 'Welcome to School Library!😀'
    loop do
      menu
      option = gets.chomp
      break if option == '7'

      get_num option
    end
    puts 'Thank you for using our Library!😀'
  end

  def menu
    puts
    puts ['Please select an option by entering an option number:😊',
          '1 - List all books 📖',
          '2 - List all people 👪',
          '3 - Create a person 👨',
          '4 - Create a book 📖',
          '5 - Create a rental 🏠,',
          '6 - List all rentals for a given person id 👨',
          '7 - Exit 🚫']
  end

  def get_num(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_by_person_id
    else
      puts 'Please select a number between 1 and 7. ❌'
    end
  end
end

def main
  app = App.new
  app.start
end
main
