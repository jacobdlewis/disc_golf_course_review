class Course
  attr_accessor :name, :city, :state
  attr_reader :id, :errors

  def initialize(name = nil)
    @name = name
    @id
  end

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

  def save
    return false unless valid?
    Database.execute("INSERT INTO courses (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0][0]
  end

  def valid?
    if name.nil? or name.empty? or /^\d+$/.match(name)
      @errors = "\"#{name}\" is not a valid course name."
      false
    else
      @errors = nil
      true
    end
  end

end