require_relative "../test_helper"

describe CoursesController do

  describe ".add" do
    let(:courses_controller) {CoursesController.new}

    it "should add a scenario" do
      courses_controller.add("Anna Paige Park")
      assert_equal 1, Course.count
    end

    it "should not add a course name with all blanks" do
      course_name = "      "
      result = courses_controller.add(course_name)
      assert_equal "\"\" is not a valid course name.", result
    end

    it "should not add a course name comprised of all numbers" do
      course_name = "5656565"
      result = courses_controller.add(course_name)
      assert_equal "\"5656565\" is not a valid course name.", result
    end

  end

  describe ".remove" do
    let(:courses_controller) {CoursesController.new}
    before do
      courses_controller.add("Rollin Ridge")
    end
    it "should remove a scenario" do
      courses_controller.remove("Rollin Ridge")
      assert_equal 0, Course.count
    end
    it "should confirm deletion with an error message" do
      assert_equal "Rollin Ridge was deleted successfully", courses_controller.remove("Rollin Ridge")
    end
    it "should print an error message if the specified course isn't found" do
      assert_equal "Course not found", courses_controller.remove("Spanish Ridge")
    end
  end

  describe ".update" do
    let(:courses_controller) {CoursesController.new}
    before do
      courses_controller.add("Elver")
    end
    it "should ask for another name if the first is invalid" do
      assert_equal "  isn't a valid course name.\n", courses_controller.update(" ", "Elver")
    end
    it "should confirm that the name was updated" do
      assert_equal "Thank you. Elver is now stored as Heistand.", courses_controller.update("Elver", "Heistand")
    end
  end


end