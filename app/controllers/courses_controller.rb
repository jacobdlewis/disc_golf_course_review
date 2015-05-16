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

  def add(name)
    clean_name = name.strip
    course = Course.new(clean_name)
    if course.save
      "Thank you. #{name} has been added to your course Wish List."
    else
      course.errors
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
      }
      submenu.choice("Delete a course") {
        course = ask("What is the name of the course you'd like to delete?")
      }
      submenu.choice("Mark a course as complete") {
        course = ask("Which course wouldyou like to mark as complete?")
      }
      submenu.choice("Return to main menu") {}
    end
  end

end
