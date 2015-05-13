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

end
