class Course
  attr_accessor :name
  attr_reader :id, :errors, :city, :state

  def initialize(name, city, state)
    @name = name
    @city = city
    @state = state
    @id
  end

  def self.count
    Database.execute("select count(id) FROM courses")[0][0]
  end

  def self.all
    Database.execute("select * FROM courses order by name ASC").map do |row|
      row
    end
  end

  def self.getCourseInfo(name)
    return Database.execute("SELECT id, city, state from courses WHERE name LIKE '%#{name}%'")[0]
  end

  def self.exists?(name)
    result = Database.execute("SELECT count(name) FROM courses WHERE name LIKE '%#{name}%'")[0][0]
    if result > 0
      return true
    else
      return false
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
    Database.execute("INSERT INTO courses (name, city, state) VALUES (?, ?, ?)", name, city, state)
    @id = Database.execute("SELECT last_insert_rowid()")[0][0]
  end

  def valid?
    if name.nil? or name.empty? or /\d+$/.match(name)
      @errors = "\"#{name}\" is not a valid course name."
      return false
    elsif city.nil? or city.empty? or /\d+$/.match(city)
      @errors = "\"#{city}\" is not a valid city name."
      return false
    elsif state.nil? or state.empty? or /\d+$/.match(state)
      @errors = "\"#{state}\" is not a valid state name."
      return false
    else
      @errors = nil
      return true
    end
  end

end