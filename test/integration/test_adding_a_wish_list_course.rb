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

  def test_adding_a_course
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a course to your Wish List
2. View your course Wish List
3. Remove a course from your Wish List
4. View your played courses
5. Review a played course
6. Import Data
7. Exit
EOS
      pipe.puts "1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Nashville"
      expected_output << "In what state is the course located?\n"
      pipe.puts "TN"
      expected_output << "What is the street address for the course?\n"
      pipe.puts "3457 School Ln"
      expected_output << "What is the ZIP code for the course?\n"
      pipe.puts "37217"
      expected_output << "How many holes does the course have?\n"
      pipe.puts "18"
      expected_output << "Is the course paid or free?\n"
      pipe.puts "free"
      expected_output << "Thank you. Seven Oaks Park has been added to your course Wish List.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_importing_data_from_CSV
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output = <<EOS
1. Add a course to your Wish List
2. View your course Wish List
3. Remove a course from your Wish List
4. View your played courses
5. Review a played course
6. Import Data
7. Exit
EOS
      pipe.puts "6"
      expected_output << "What is the file path to the .CSV file you'd like to import? Import must be in the format of (id, name, city, state, zip code, street address, holes, paid?)\n"
      pipe.puts "../users/desktop/database.db"
      expected_output << "Your course information has been uploaded successfully.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end