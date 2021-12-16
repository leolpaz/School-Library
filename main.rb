require_relative 'book'
require_relative 'teacher'
require_relative 'person'
require_relative 'student'
require_relative 'rental'
# rubocop: disable Metrics/CyclomaticComplexity, Metrics/MethodLength
class App
  def initialize
    @booklist = []
    @users = []
    @rentals = []
  end

  def list_all_books
    if @booklist.length.zero?
      puts 'Currently we have no books'
      return
    end
    @booklist.each_with_index do |book, index|
      puts "#{index + 1}) title: #{book.title}, author: #{book.author}"
    end
  end

  def list_all_users
    if @users.length.zero?
      puts 'Currently we have no users'
      return
    end
    @users.each_with_index do |user, index|
      puts "#{index + 1}) name: #{user.name}, age: #{user.age}, id: #{user.id}, type: #{user.class}"
    end
  end

  def create_user
    person_type = ''
    while person_type != '1' && person_type != '2'
      puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]'
      person_type = gets.chomp
    end
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    if person_type == '1'
      create_user_student(age, name)
    else
      create_user_teacher(age, name)
    end
  end

  def create_user_student(age, name)
    puts 'Has parent permission? [Y/N]:'
    permission = false
    has_permission = gets.chomp
    permission = true unless has_permission.downcase == 'n'
    puts 'Insert student classroom:'
    classroom = gets.chomp
    @users << Student.new(age, classroom, name, parent_permission: permission)
  end

  def create_user_teacher(age, name)
    puts 'Insert specialization'
    specialization = gets.chomp
    @users << Teacher.new(age, specialization, name)
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    @booklist << Book.new(title, author)
  end

  def create_rental
    book_selected = @booklist.length + 1
    if @booklist.length.zero?
      puts 'No books were found to rent'
      return false
    end
    until @booklist[book_selected - 1]
      puts 'Select a book from the following list by number'
      list_all_books
      book_selected = gets.chomp.to_i
      book_selected = @booklist.length + 1 if book_selected.zero?
    end
    user_selected = @users.length + 1
    if @users.length.zero?
      puts 'No users were found to rent'
      return false
    end
    until @users[user_selected - 1]
      puts 'Select a user from the following list by number'
      list_all_users
      user_selected = gets.chomp.to_i
      user_selected = @users.length + 1 if user_selected.zero?
    end
    time = Time.new
    date = "#{time.year}/#{time.month}/#{time.day}"
    @rentals << Rental.new(date, @booklist[book_selected - 1], @users[user_selected - 1])
  end

  def rentals_by_id
    puts 'Type person id:'
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}" if id == rental.person.id
    end
  end
end

def main
  instance = App.new
  user_response = ''
  until user_response == '7'
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all users'
    puts '3 - Create a user'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    user_response = gets.chomp

    case user_response.to_i
    when 1
      instance.list_all_books
      puts 'Press anything to return'
      gets.chomp
    when 2
      instance.list_all_users
      puts 'Press anything to return'
      gets.chomp
    when 3
      instance.create_user
      puts 'User created successfully'
      puts 'Press anything to return'
      gets.chomp
    when 4
      instance.create_book
      puts 'Book created successfully'
      puts 'Press anything to return'
      gets.chomp
    when 5
      puts 'Rental created successfully' if instance.create_rental
      puts 'Press anything to return'
      gets.chomp
    when 6
      instance.rentals_by_id
      puts 'Press anything to return'
      gets.chomp
    when 7
      puts 'Thank you for using this app!'
    else
      puts 'Invalid command'
      puts 'Press anything to return'
      gets.chomp
    end
  end
end
# rubocop: enable Metrics/CyclomaticComplexity, Metrics/MethodLength

main
