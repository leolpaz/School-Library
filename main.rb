require_relative 'book'
require_relative 'teacher'
require_relative 'person'
require_relative 'student'
require_relative 'rental'

class App
  def initialize
    @booklist = []
    @users = ['a', 'b', 'c']
    @rentals = []
  end

  def list_all_books
    @booklist.each do |book|
      puts book
    end
  end

  def list_all_users
    @users.each do |user|
      puts user
    end
  end

  def create_user
    puts "Do you want to create a student (1) or a teacher (2)? [Input the number]"
    person_type = gets.chomp
    puts "Age:"
    age = gets.chomp
    puts "Name:"
    name = gets.chomp
    puts "Has parent permission? [Y/N]:"
    permission = gets.chomp
  end
end

def main
  instance = App.new
end

main()
