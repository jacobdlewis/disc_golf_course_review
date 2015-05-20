require_relative '../test_helper'

class TestMarkingCourseComplete < Minitest::Test

  def test_mark_course_complete_happy_path
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts"1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Nashville"
      expected_output << "In what state is the course located?\n"
      pipe.puts "TN"
      expected_output << "Thank you. Seven Oaks Park has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Token Creek"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Madison"
      expected_output << "In what state is the course located?\n"
      pipe.puts "WI"
      expected_output << "Thank you. Token Creek has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park (Nashville, TN)\n2. Token Creek (Madison, WI)\n"
      expected_output << view_courses_submenu
      pipe.puts "3"
      expected_output << "Which course would you like to mark as complete?\n"
      pipe.puts "Token Creek"
      expected_output << "Please enter a quick review of the course.\n"
      pipe.puts "Great Course!"
      expected_output << "Token Creek was successfully marked as completed.\n"
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "\nCompleted Courses:\n\n1. Token Creek (Madison, WI) Reviews: 1\n\nWould you like to...\n1. See all reviews for a course\n2. Add a review to a course\n3. Return to main menu\n"
      pipe.puts "3"
      expected_output << main_menu
      pipe.puts "5"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_mark_course_complete_happy_path
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts"1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Seven Oaks Park"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Nashville"
      expected_output << "In what state is the course located?\n"
      pipe.puts "TN"
      expected_output << "Thank you. Seven Oaks Park has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "What is the name of the course?\n"
      pipe.puts "Token Creek"
      expected_output << "In what city is the course located?\n"
      pipe.puts "Madison"
      expected_output << "In what state is the course located?\n"
      pipe.puts "WI"
      expected_output << "Thank you. Token Creek has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "\nYour Wish List Courses are:\n1. Seven Oaks Park (Nashville, TN)\n2. Token Creek (Madison, WI)\n"
      expected_output << view_courses_submenu
      pipe.puts "3"
      expected_output << "Which course would you like to mark as complete?\n"
      pipe.puts ""
      expected_output << "Please enter a quick review of the course.\n"
      pipe.puts ""
      expected_output << "Course not found\n"
      expected_output << main_menu
      pipe.puts "5"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end