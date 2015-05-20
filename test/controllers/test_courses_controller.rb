require_relative "../test_helper"

describe CoursesController do

  describe ".add" do
    let(:courses_controller) {CoursesController.new}

    it "should add a course" do
      courses_controller.add("Anna Paige Park", "Rochester", "IL")
      assert_equal 1, Course.count
    end

    it "should not add a course name with all blanks" do
      course_name = "      "
      result = courses_controller.add(course_name, "Nowhere", "XX")
      assert_equal "\"\" is not a valid course name.", result
    end

    it "should not add a course name comprised of all numbers" do
      course_name = "5656565"
      result = courses_controller.add(course_name, "Nowhere", "XX")
      assert_equal "\"5656565\" is not a valid course name.", result
    end

  end

  describe ".remove" do
    let(:courses_controller) {CoursesController.new}
    before do
      courses_controller.add("Rollin Ridge", "Madison", "WI")
    end
    it "should remove a course" do
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
      courses_controller.add("Elver", "Madison", "WI")
    end
    it "should ask for another name if the first is invalid" do
      assert_equal "  isn't a valid course name.\n", courses_controller.update(" ", "Elver")
    end
    it "should confirm that the name was updated" do
      assert_equal "Thank you. Elver is now stored as Heistand.", courses_controller.update("Elver", "Heistand")
    end
  end

  describe ".complete" do
    let(:courses_controller) { CoursesController.new }
    describe "when the course exists"do
      before do
        courses_controller.add("Elver", "Madison", "WI")
        courses_controller.complete("Elver", "Heavily wooded, but fun!")
      end
      it "should remove the course from the courses table" do
        assert_equal 0, Course.count
        assert_equal 1, Review.count
      end
    end
    describe "when the course doesn't exist" do
      it "should return an error message" do
        expected = "Course not found"
        assert_equal expected, courses_controller.complete("Capital Springs", "Short but fun!")
      end
      before do
        courses_controller.add("Elver", "Madison", "WI")
      end
      it "should not delete a course from the courses table" do
        course_count = Course.count
        response = courses_controller.complete("Olympic Course", "Best in the world!")
        assert_equal "Course not found", response
        assert_equal 1, course_count
      end
    end
    describe "when the course name is bad input" do
      describe "when the name is blank" do
        it "should return course not found" do
        expected = "Course not found"
        actual = courses_controller.complete("Olympia Springs Park", "Doesn't even exist!")
        assert_equal expected, actual
        end
      end
      describe "when the name is non-word" do
        it "should return course not found" do
          expected = "Course not found"
          actual = courses_controller.complete("@#@;select * from courses where name like \"%\";%!#@$&}", "Doesn't even exist!")
          assert_equal expected, actual
        end
      end
    end
  end

end