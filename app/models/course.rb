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
    return Database.execute("SELECT name, id, city, state from courses WHERE name LIKE '%#{name}%'")[0]
  end

  def self.exists?(name)
    return false if name == "" || name.nil?
    clean_name = name
    clean_name.gsub!(/[!@#$%^&*(){}:;'"]/, "")
    result = Database.execute("SELECT * FROM courses WHERE name LIKE '%#{clean_name}%'")
    if result == []
      false
    else
      true
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

  def self.get_most_represented_state
    result = Database.execute <<-SQL
SELECT state, COUNT(state) as 'state_count'
FROM (SELECT * FROM courses GROUP BY name)
GROUP BY state
ORDER BY state_count DESC
LIMIT 1;
SQL
    if result == []
      return "N/A"
    else
      return result[0]
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