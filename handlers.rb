require_relative 'person'
require_relative 'student'
require_relative 'book'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'rental'
require 'json'

module Handlers
  def list_all_books
    puts 'No books in the database! Please add a book.' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    sleep 0.75
  end

  def list_all_people
    puts 'No people in the database! Please add a person.' if @people.empty?
    @people.map { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    sleep 0.75
  end

  def create_person
    print 'Would you like to create a student(1) or a teacher(2) [Please input a number]: '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option. Please select 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase

    student = Student.new(name: name, age: age, parent_permission: parent_permission, classroom: @classroom)
    @people.push(student)

    puts 'Student created successfully'
    sleep 0.75
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age: age, specialization: specialization, name: name)
    @people << teacher

    puts 'Teacher created successfully'
    sleep 0.75
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book

    puts 'Book added successfully'
    sleep 0.75
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_id = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"

      person_id = gets.chomp.to_i

      print 'Date: '
      date = gets.chomp.to_s

      rental = Rental.new(date, @books[book_id], @people[person_id])
      @rentals << rental

      puts 'Rental created successfully'
      sleep 0.75
    end
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
      sleep 0.75
    end
  end

  def store_data
    File.write('books.json', JSON.generate(@books))
    File.write('people.json', JSON.generate(@people))
    File.write('rentals.json', JSON.generate(@rentals))
  end

  def parse_books
    file = 'books.json'
    return [] unless File.exist? file

    data = JSON.parse(File.read(file), create_additions: true)
    data.each do |book|
      @books.push(Book.new(book['title'], book['author']))
    end
  end

  def parse_people
    file = 'people.json'
    return [] unless File.exist? file

    JSON.parse(File.read(file)).map do |people|
      if people['json_class'] == 'Student'
        student = Student.new(age: people['age'], name: people['name'], parent_permission: people['permission'],
                              classroom: @classroom.label)
        @people.push(student)
      else
        teacher = Teacher.new(age: people['age'], name: people['name'], parent_permission: people['permission'],
                              specialization: people['specialization'])
        @people.push(teacher)
      end
      @people.last.id = people['id']
    end
  end

  def parse_rentals
    file = 'rentals.json'

    if File.exist? file
      JSON.parse(File.read(file)).map do |rental|
        book = @books.find { |rental_book| rental_book.title == rental['book_title'] }
        person = @people.find { |rental_person| rental_person.id == rental['person_id'] }

        rental = Rental.new(rental['date'], book, person)
        @rentals.push(rental)
      end
    else
      []
    end
  end
end
