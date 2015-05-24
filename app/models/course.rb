class Course < ActiveRecord::Base

validates :name,
presence: true,
format: { with: /[a-zA-Z]/, allow_blank: false,
numericality: false },
length: { minimum: 5}
validates :city,
presence: true,
format: { with: /[a-zA-Z]/, allow_blank: false,
numericality: false }
validates :state,
presence: true,
format: { with: /[a-zA-Z]/, allow_blank: false,
numericality: false }

  def initialize(name, city, state)
    super(name: name, city: city, state: state)
  end

  def self.getCourseInfo(name)
    return Database.execute("SELECT name, id, city, state from courses WHERE name LIKE '%#{name}%'")[0]
  end

  def self.exists?(name)
    return false if name == "" || name.nil?
    clean_name = name
    clean_name.gsub!(/[!@#$%^&*(){}:;]/, "")
    result = Course.find_by(name: name)
    if result.nil?
      return false
    else
      return true
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

end