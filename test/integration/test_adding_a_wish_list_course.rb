require_relative '../test_helper'

# Add course to Wish List

# In order to keep track of courses that the user wants to play in the future, the user should be able to add disc golf courses to a course wish list.

# Usage Example:

# ./disc_golf_course_tracker

# Add a Course Name
# "What is the name of the course"

# "Seven Oaks Park"
# "In what city is the course located?"

# "Nashville"
# "In what state is the course located?"

# "TN"
# "What is the street address for the course? (optional)"

# "3474 McGavock Pike"
# "What is the ZIP code for the course? (optional)"

# "37217"
# "How many holes does the course have? (optional)"

# "18"
# "Is the course paid or free? (optional)"

# "paid"
# "Thank you. Seven Oaks Park has been added to your course Wish List"

# Acceptance Criteria:

# Adding a course creates a new course listing in the database's courses table
# Adding a course creates a new listing in the wish_list table

class AddNewCourseTest < Minitest::Test

  def test_shows_menu_on_load
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker') do |pipe|
      expected_output = <<EOS
What would you like to do?

1. Add a course to you Wish List
2. View your course Wish List
3. Remove a course from your Wish List
4. View your played courses
5. Review a played course
6. Import Data
EOS
    shell_output = pipe.read
    end
  assert_equal expected_output, shell_output
  end

  def test_running_program_with_unnecessary_argument
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker add_course') do |pipe|
      expected_output = "[Help] Unnecessary argument. Run as: ./disc_golf_course_tracker"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end