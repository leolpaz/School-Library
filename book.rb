class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def create_rental(person, date)
    Rental.new(date, self, person)
  end
end

# Create the has-many side of Book and Rental (a book has many rentals).
