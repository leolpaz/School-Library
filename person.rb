require_relative 'corrector'

class Person
  attr_accessor :age, :name
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = rand(1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @corrector = Corrector.new
  end

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end

  def validade_name
    @name = @corrector.correct_name(@name)
  end

  private

  def of_age?
    @age >= 18
  end
end
