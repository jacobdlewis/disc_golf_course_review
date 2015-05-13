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

end