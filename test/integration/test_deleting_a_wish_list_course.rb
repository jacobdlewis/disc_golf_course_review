require_relative '../test_helper'
class TestDeletingWishListCourses < Minitest::Test

  def test_delete_a_course
    Course.new("Seven Oaks Park")
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Nashville"
      expected_output << "In what state is the course located?\n"
      pipe.puts "TN"
      expected_output << "Thank you. Seven Oaks Park has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park\n"
      expected_output << view_courses_submenu
      pipe.puts "2"
      expected_output << "What is the name of the course you'd like to delete?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "Seven Oaks Park was deleted successfully\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "No courses found. Add a course.\n"
      expected_output << main_menu
      pipe.puts "4"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end