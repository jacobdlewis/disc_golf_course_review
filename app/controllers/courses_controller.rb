class CoursesController

  def index
    if Course.count > 0
      courses = Course.all # all of the courses in an array
      say("\nYour Wish List Courses are:\n")
      courses.each_with_index do |course, index|
        say("#{index + 1}. #{course.name}")
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

  def add(name)
    clean_name = name.strip
    course = Course.new(clean_name)
    if course.save
      "Thank you. #{name} has been added to your course Wish List."
    else
      course.errors
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
    response = add(name)
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
        course = ask("Which course wouldyou like to mark as complete?")
      }
      submenu.choice("Return to main menu") {}
    end
  end

end
