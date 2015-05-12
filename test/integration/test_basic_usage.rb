require_relative '../test_helper'

class TestBasicUsage < Minitest::Test

  def test_shows_menu_on_load
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
    pipe.close_write
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

  def test_exiting_program
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
      pipe.puts "7"
      expected_output << "Goodbye!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end