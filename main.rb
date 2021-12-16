require_relative 'book'
require_relative 'teacher'
require_relative 'person'
require_relative 'student'
require_relative 'rental'

class App
  def initialize
    @booklist = []
    @users = []
    @rentals = []
  end

  def list_all_books
    @booklist.each_with_index do |book, index|
      puts "#{index+1}) title: #{book.title}, author: #{book.author}"
    end
  end

  def list_all_users
    @users.each_with_index do |user, index|
      puts "#{index+1}) name: #{user.name}, age: #{user.age}, id: #{user.id}, type: #{user.class}"
    end
  end

  def create_user
    person_type = ''
    while person_type != "1" && person_type != "2"
      puts "Do you want to create a student (1) or a teacher (2)? [Input the number]"
      person_type = gets.chomp
    end
    puts "Age:"
    age = gets.chomp
    puts "Name:"
    name = gets.chomp
    if person_type == '1'
      puts "Has parent permission? [Y/N]:"
      permission = false
      has_permission = gets.chomp
      permission = true unless has_permission.downcase == 'n'
      puts "Insert student classroom:"
      classroom = gets.chomp
      @users << Student.new(age, classroom, name, parent_permission: permission)
    else
      puts "Insert specialization"
      specialization = gets.chomp
      @users << Teacher.new(age, specialization, name)
    end
  end

  def create_book
    puts "Title:"
    title = gets.chomp
    puts "Author:"
    author = gets.chomp
    @booklist << Book.new(title, author)
  end

  def create_rental
    book_selected = @booklist.length + 1
    if @booklist.length == 0
      puts "No books were found"
      return
    end
    while !@booklist[book_selected - 1]
      puts "Select a book from the following list by number"
      self.list_all_books
      book_selected = gets.chomp.to_i
      book_selected = @booklist.length + 1 if book_selected == 0
    end
    user_selected = @users.length + 1
    if @users.length == 0
      puts "No users were found"
      return
    end
    while !@users[user_selected - 1]
      puts "Select a user from the following list by number"
      self.list_all_users
      user_selected = gets.chomp.to_i
      user_selected = @users.length + 1 if user_selected == 0
    end
    date = Time.now
    @rentals << Rental.new(date, @booklist[book_selected-1], @users[user_selected-1])
  end
end

def main
  instance = App.new
end

main()
