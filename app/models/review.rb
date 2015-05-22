class Review < ActiveRecord::Base
  
  validates :name, presence: true, format: { with: /[a-zA-Z]/,
            allow_blank: false}
  validates :city, presence: true, format: { with: /[a-zA-Z]/,
            allow_blank: false, numericality: false}
  validates :state, presence: true, format: { with: /[a-zA-Z]/,
            allow_blank: false, numericality: false}
  validates :course_id, presence: true,
            allow_blank: false, numericality: true
  validates :comment, presence: true, allow_blank: false
  validates :completion_date, presence: true

  def initialize(name, city, state, course_id, comment)
    super(name: name, city: city, state: state, course_id: course_id, comment: comment)
  end

  def self.get_courses_and_review_count
    Database.execute("select name, city, state, count(id), completion_date FROM reviews group by course_id order by completion_date asc").map do |row|
      row
    end
  end

  def self.get_reviews(course_name)
    if exists?(course_name)
      Review.find_each do |review|
        print(review)
      end
    else
      return "Course not found"
    end
  end

  def self.exists?(name)
    return false if name == "" || name.nil?
    clean_name = name
    clean_name.gsub!(/[!@#$%^&*(){}:;'"]/, "")
    result = Review.find_by(name: name)
    if result.nil?
      return false
    else
      return true
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

end