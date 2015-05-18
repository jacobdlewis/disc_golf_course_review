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

  def add_additional_review(name, comment)
    if Review.exists?(name)
      course_id = Review.get_course_ID(name)
      Review.new(name, course_id, comment).save
      "\nNew review of #{name} added successfully."
    else
      "Course not found"
    end
  end

  def submenu_prompt
    choose do |submenu|
    submenu.prompt = ""
    say("Would you like to...\n")
    submenu.choice("Add a review to a course") {
      course = ask("What is the name of the course you want to review?")
      comment = ask("Please add a brief review for #{course}.")
      say(ReviewsController.new.add_additional_review(course, comment))
    }
    submenu.choice("Return to main menu") {}
    end
  end

end