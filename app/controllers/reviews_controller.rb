class ReviewsController

  def index
    if Review.count > 0
      reviews = Review.all # all of the courses in an array
      say("\nYour Completed Courses are:\n")
      reviews.each_with_index do |review, index|
        say("#{index + 1}. #{review}")
      end
      say("\n")
    else
      say("No courses found. Add a course.\n")
    end
  end

  def add(name, course_id, comment)
    Review.new(name, course_id, comment).save
    "#{name} has been marked as complete"
  end

  def submenu_prompt
    choose do |submenu|
    submenu.prompt = ""
    say("Would you like to...\n")
    submenu.choice("Add a review to a course") {}
    submenu.choice("Return to main menu") {}
    end
  end

end