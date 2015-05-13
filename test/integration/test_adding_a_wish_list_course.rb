require_relative '../test_helper'

class AddNewCourseTest < Minitest::Test

  def test_adding_a_course
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
      expected_output << "What is the street address for the course?\n"
      pipe.puts "3457 School Ln"
      expected_output << "What is the ZIP code for the course?\n"
      pipe.puts "37217"
      expected_output << "How many holes does the course have?\n"
      pipe.puts "18"
      expected_output << "Is the course paid or free?\n"
      pipe.puts "free"
      expected_output << "Thank you. Seven Oaks Park has been added to your course Wish List.\n"
      expected_output << main_menu
      pipe.puts "7"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_importing_data_from_CSV
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "6"
      expected_output << "What is the file path to the .CSV file you'd like to import? Import must be in the format of (id, name, city, state, zip code, street address, holes, paid?)\n"
      pipe.puts "../users/desktop/database.db"
      expected_output << "Your course information has been uploaded successfully.\n"
      expected_output << main_menu
      pipe.puts "7"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end