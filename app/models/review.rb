class Review
  attr_accessor :name
  attr_reader :id

  def initialize(name, course_id, comment)
    @name = name
    @id
    @course_id = course_id
    @comment = comment
  end

  def self.all
    Database.execute("select name FROM reviews order by name ASC").map do |row|
      row[0]
    end
  end

  def self.count
    Database.execute("select count(id) FROM reviews")[0][0]
  end

  def save
    Database.execute("INSERT INTO reviews (name, course_id, comment) VALUES (?, ?, ?)", @name, @course_id, @comment)
    @id = Database.execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.exists?(name)
    result = Database.execute("SELECT count(name) FROM reviews WHERE name LIKE '%#{name}%'")[0][0]
    if result > 0
      return true
    else
      return false
    end
  end

  def self.get_course_ID(name)
    if exists?(name)
      return Database.execute("SELECT course_id from reviews WHERE name LIKE '%#{name}%'")[0][0]
    else
      return "ID not found"
    end
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