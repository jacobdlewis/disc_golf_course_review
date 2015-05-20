class Review
  attr_accessor :name
  attr_reader :id, :course_id, :comment, :city, :state, :completion_date

  def initialize(name, city, state, course_id, comment)
    @name = name
    @city = city
    @state = state
    @course_id = course_id
    @comment = comment
    @id
  end

  def self.get_courses_and_review_count
    Database.execute("select name, city, state, count(id), completion_date FROM reviews group by course_id order by completion_date asc").map do |row|
      row
    end
  end

  def self.get_reviews(course_name)
    if exists?(course_name)
      Database.execute("SELECT name, city, state, comment, completion_date FROM reviews WHERE name like \"%#{course_name}%\" order by completion_date asc")
    else
      return "Course not found"
    end
  end

  def self.count
    Database.execute("select count(id) FROM reviews")[0][0]
  end

  def save
    Database.execute("INSERT INTO reviews (name, city, state, course_id, comment) VALUES (?, ?, ?, ?, ?)", name, city, state, course_id, comment)
    @id = Database.execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.exists?(name)
    return false if name == "" || name.nil?
    clean_name = name
    clean_name.gsub!(/[!@#$%^&*(){}:;'"]/, "")
    result = Database.execute("SELECT count(name) FROM reviews WHERE name LIKE '%#{clean_name}%'")[0][0]
    if result > 0
      return true
    else
      return false
    end
  end

  def self.get_course_info(name)
    if exists?(name)
      return Database.execute("SELECT course_id, city, state from reviews WHERE name LIKE '%#{name}%'")[0]
    else
      return "ID not found"
    end
  end

  def self.get_most_represented_state
    result = Database.execute <<-SQL
SELECT state, COUNT(state) as 'state_count'
FROM (SELECT * FROM reviews GROUP BY course_id)
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