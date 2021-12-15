require_relative 'corrector'
# Create the has-many side of Person and Rental (a person has many rentals).
# Create the belongs-to side of Rental and Person (a rental belongs to a person).
class Person
  attr_accessor :age, :name
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = rand(1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end

  def validade_name
    @name = @corrector.correct_name(@name)
  end

  def create_rental(_person, date)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    @age >= 18
  end
end
