require_relative '../test_helper'
class TestUpdatingWishListCourses < Minitest::Test

  def test_update_a_course_happy_path
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
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park (Nashville, TN)\n"
      expected_output << view_courses_submenu
      pipe.puts "1"
      expected_output << "What is the name of the course you'd like to update?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "What is the new name for Seven Oaks Park?\n"
      pipe.puts "Elver Park"
      expected_output << "Thank you. Seven Oaks Park is now stored as Elver Park.\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "\nYour Wish List Courses are:\n1. Elver Park (Nashville, TN)\n"
      expected_output << view_courses_submenu
      pipe.puts "4"
      expected_output << main_menu
      pipe.puts "5"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_update_a_course_sad_path
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
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park (Nashville, TN)\n"
      expected_output << view_courses_submenu
      pipe.puts "1"
      expected_output << "What is the name of the course you'd like to update?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "What is the new name for Seven Oaks Park?\n"
      pipe.puts "*****"
      expected_output << "Update unsuccessful. Name is invalid\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park (Nashville, TN)\n"
      expected_output << view_courses_submenu
      pipe.puts "4"
      expected_output << main_menu
      pipe.puts "5"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end