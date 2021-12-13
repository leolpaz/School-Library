require_relative 'person'

class Student < Person
  def initialize(name, age, classroom, parent_permission: false)
    super(name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
