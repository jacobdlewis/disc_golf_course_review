class Course
  attr_accessor :name, :city, :state
  attr_reader :id, :errors

  def initialize(name = nil)
    @name = name
    @id
  end

  def self.count
    Database.execute("select count(id) FROM courses")[0][0]
  end

  def self.all
    Database.execute("select name FROM courses order by name ASC").map do |row|
      course = Course.new
      course.name = row[0]
      course
    end
  end

  def self.delete(name)
    course = Database.execute("select name FROM courses WHERE name LIKE '%#{name}%'")
    if course == []
      false
    else
      Database.execute("delete FROM courses WHERE name LIKE '#{name}%'")
      true
    end
  end

  def self.insert(old_name, updated_name)
    if old_name.nil? || old_name.empty? || old_name.length < 3 || old_name.match(/[!@#$%&*()]/)
      return "original name invalid"
    elsif updated_name.nil? || updated_name.empty? || updated_name.length < 3 || updated_name.match(/[!@#$%&*()]/)
      return "new name invalid"
    else
      Database.execute("UPDATE courses SET name = \"#{updated_name}\" WHERE name = \'#{old_name}\'")
      return "update successful"
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT INTO courses (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0][0]
  end

  def valid?
    if name.nil? or name.empty? or /\d+$/.match(name)
      @errors = "\"#{name}\" is not a valid course name."
      false
    else
      @errors = nil
      true
    end
  end

end