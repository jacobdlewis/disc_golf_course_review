class CoursesController

  def index
    if Course.count > 0
      courses = Course.all # all of the courses in an array
      say("\nYour Wish List Courses are:\n")
      courses.each_with_index do |course, index|
        say("#{index + 1}. #{course}")
      end
      say("\n")
      submenu
    else
      say("No courses found. Add a course.\n")
    end
  end

  def update(current_name, new_name)
    if Course.insert(current_name, new_name) == "original name invalid"
      return "#{current_name} isn't a valid course name.\n"
    elsif Course.insert(current_name, new_name) == "new name invalid"
      return "#{new_name} isn't a valid name.\n"
    else
      Course.insert(current_name, new_name)
      return "Thank you. #{current_name} is now stored as #{new_name}."
    end
  end

  def add(name, city, state)
    clean_name = name.strip
    clean_city = city.strip
    clean_state = state.strip
    course = Course.new(clean_name, clean_city, clean_state)
    if course.save
      "Thank you. #{name} has been added to your course Wish List."
    else
      course.errors
    end
  end

  def complete(name, comment)
    if Course.exists?(name)
      courseInfo = Course.getCourseInfo(name)
      course_id = courseInfo[0]
      city = courseInfo[1]
      state = courseInfo[2]
      Review.new(name, city, state, course_id, comment).save
      Course.delete(name)
      "#{name} was successfully marked as completed."
    else
      "Course not found"
    end
  end

  def remove(name)
    if Course.delete(name)
      "#{name} was deleted successfully"
    else
      "Course not found"
    end
  end

  def prompt
    name = ask("What is the name of the course?")
    city = ask("In what city is the course located?")
    state = ask("In what state is the course located?")
    response = add(name, city, state)
    say(response) unless response.nil?
  end

private

  def submenu
    choose do |submenu|
      submenu.prompt = ""
      say("Would you like to...\n")
      submenu.choice("Update a course") {
        course = ask("What is the name of the course you'd like to update?")
        new_course = ask("What is the new name for #{course}?")
        say(CoursesController.new.update(course, new_course))
      }
      submenu.choice("Delete a course") {
        course = ask("What is the name of the course you'd like to delete?", String) { |q| q.validate = /\w/}
        say(CoursesController.new.remove(course))
      }
      submenu.choice("Mark a course as complete") {
        course = ask("Which course would you like to mark as complete?")
        comment = ask("Please enter a quick review of the course.")
        say(CoursesController.new.complete(course, comment))
      }
      submenu.choice("Return to main menu") {}
    end
  end

end
