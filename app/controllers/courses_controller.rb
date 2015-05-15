class CoursesController

  def index
    if Course.count > 0
      courses = Course.all # all of the courses in an array
      courses.each_with_index do |course, index|
        say("#{index + 1}. #{course.name}")
      end
    else
      say("No courses found. Add a course.\n")
    end
  end

  def prompt
    name = ask("What is the name of the course?")
    city = ask("In what city is the course located?")
    state = ask("In what state is the course located?")
    Course.new(name)
    say("Thank you. #{name} has been added to your course Wish List.")
  end

end
