class ReviewsController

  def index
    if Review.count > 0
      reviews = Review.get_courses_and_review_count # all of the courses in an array
      say("\nCompleted Courses:\n\n")
      reviews.each_with_index do |review, index|
        say("#{index + 1}. #{review[0]} (#{review[1]}, #{review[2]}) Reviews: #{review[3]}\n\n")
      end
    else
      say("No courses found. Add a course.\n")
    end
  end

  def add(name, city, state, course_id, comment)
    Review.new(name, city, state, course_id, comment).save
    "#{name} has been marked as complete"
  end

  def add_additional_review(name, comment)
    if Review.exists?(name)
      course_info = Review.get_course_info(name)
      course_id = course_info[0]
      city = course_info[1]
      state = course_info[2]
      Review.new(name, city, state, course_id, comment).save
      "\nNew review of #{name} added successfully."
    else
      "Course not found"
    end
  end

  def submenu_prompt
    choose do |submenu|
    submenu.prompt = ""
    say("Would you like to...\n")
    submenu.choice("See all reviews for a course") { }
    submenu.choice("Add a review to a course") {
      course = ask("What is the name of the course you want to review?")
      comment = ask("Please add a brief review for #{course}.")
      say(ReviewsController.new.add_additional_review(course, comment))
    }
    submenu.choice("Return to main menu") {}
    end
  end

end