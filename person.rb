class Person
  attr_accessor :age, :name
  attr_reader :id

  def initialize(name, age, parent_permission: false)
    @id = rand(1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end

  private

  def of_age?
    @age >= 18
  end
end
