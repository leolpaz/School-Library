class Corrector
  def correct_name(name)
    name = name.capitalize
    name = name[0, 10] if name.size > 10
    name
  end
end
