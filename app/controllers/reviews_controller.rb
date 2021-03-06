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

  def show_reviews(course)
    result = ""
    if Review.exists?(course)
      result = ""
      x = 0
      Review.where(name: course).find_each do |review|
        x += 1
        result << ("\nReviews for #{review.name}:\n\n") if x == 1
        result << "#{review.completion_date.strftime('%B %d, %Y')} - #{review.comment}\n\n"
      end
      result
    else
      result << "Course not found"
    end
    result
  end

  def add(name, city, state, course_id, comment)
    Review.new(name, city, state, course_id, comment).save
    "#{name} has been marked as complete"
  end

  def add_additional_review(name, comment)
    return "Course not found" if name == "" || name.nil?
    if Review.exists?(name)
      course = Review.find_by(name: name)
      Review.new(course.name, course.city, course.state, course.course_id, comment).save
      "\nNew review of #{name} added successfully."
    else
      "Course not found"
    end
  end

  def state_with_most_reviewed_courses
    result = Review.get_most_represented_state
    review_noun = Review.count == 1 ? "course" : "courses"
    return "* Most of your completed courses are in #{result[0]} (#{result[1]} #{review_noun})"
  end

  def submenu_prompt
    choose do |submenu|
    submenu.prompt = ""
    say("Would you like to...\n")
    submenu.choice("See all reviews for a course") {
      course = ask("What is the name of the course for which you want to see reviews?")
      say(ReviewsController.new.show_reviews(course))
    }
    submenu.choice("Add a review to a course") {
      course = ask("What is the name of the course you want to review?", String)
      comment = ask("Please add a brief review for #{course}.")
      say(ReviewsController.new.add_additional_review(course, comment))
    }
    submenu.choice("Return to main menu") {}
    end
  end

  def show_user_stats
    say("\n")
    say("User Stats:\n\n")
    review_noun = Review.count == 1 ? "review" : "reviews"
    course_noun = Course.count == 1 ? "course" : "courses"
    say("* You have written #{Review.count} #{review_noun}")
    say("* You have #{Course.count} Wish List #{course_noun}")
    say(ReviewsController.new.state_with_most_reviewed_courses)
    say(CoursesController.new.state_with_most_wish_list_courses)
  end

end