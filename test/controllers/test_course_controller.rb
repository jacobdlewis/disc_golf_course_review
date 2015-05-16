require_relative "../test_helper"

describe CoursesController do

  describe ".add" do
    let(:course_controller) {CoursesController.new}

    it "should add a scenario" do
      course_controller.add("Anna Paige Park")
      assert_equal 1, Course.count
    end

    it "should not add a course name with all blanks" do
      course_name = "      "
      result = course_controller.add(course_name)
      assert_equal "\"\" is not a valid course name.", result
    end

    it "should not add a course name comprised of all numbers" do
      course_name = "5656565"
      result = course_controller.add(course_name)
      assert_equal "\"5656565\" is not a valid course name.", result
    end

  end


end