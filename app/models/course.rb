class Course
  attr_accessor :name

  def self.count
    Database.execute("select count(id) from courses")[0][0]
  end


  def self.all
    Database.execute("select name from courses order by name ASC").map do |row|
      course = Course.new
      course.name = row[0]
      course
    end
  end

  def self.create(name, city, state, address, zip, holes, paid)
    Database.execute("INSERT INTO courses (name, city, state, address, zip, holes, paid) VALUES (?, ?, ?, ?, ?, ?, ?)", name, city, state, address, zip, holes, paid)
  end

  def self.delete(name)
    course = Database.execute("select name from courses where name like '%#{name}%'")
    if course == []
      return "Course not found."
    else
      Database.execute("delete from courses where name like '%#{name}%'")
      return "#{name} was deleted successfully."
    end
  end

end