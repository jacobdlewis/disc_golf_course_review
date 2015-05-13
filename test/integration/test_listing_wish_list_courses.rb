require_relative '../test_helper'
class TestListingWishListCourses < Minitest::Test

  def test_show_no_courses
    setup_database
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "No courses found. Add a course.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_scenarios
    setup_database
    create_course("Seven Oaks Park", "Nashville", "TN", "3457 School Ln", "37217", "21", "free");
    shell_output = ""
    expected_output = ""
    IO.popen('./disc_golf_course_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "2"
      expected_output << "1. Seven Oaks Park\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end