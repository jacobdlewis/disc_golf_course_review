require_relative '../test_helper'

describe Course do
  describe "#all" do
    describe "if there are no courses in the database" do
      it "should return an empty array" do
        assert_equal [], Course.all
      end
    end
    describe "if there are courses" do
      before do
        course_1 = Course.new("Seven Oaks Park", "Nashville", "TN")
        course_1.save
        course_2 = Course.new("Rollin Ridge", "Baraboo", "WI")
        course_2.save
      end
      it "should return an array" do
        assert_equal Array, Course.all.class
      end
      it "should return the courses in alphabetical order" do
        expected = [["Rollin Ridge", "Baraboo", "WI"],
                    ["Seven Oaks Park", "Nashville", "TN"]]
        actual = Course.all
        actual[0].shift
        actual[1].shift
        assert_equal expected, actual
      end
    end
  end

  describe "#getCourseInfo" do
    it "should return the course_id, name, city of the course" do
      Course.new("Seven Oaks Park", "Nashville", "TN").save
      actual_without_id = Course.getCourseInfo("Seven Oaks Park")
      actual_without_id.delete_at(1)
      assert_equal ["Seven Oaks Park", "Nashville", "TN"], actual_without_id
    end
  end

  describe "#count" do
    describe "if there are no courses in the database" do
      it "should return 0" do
        assert_equal 0, Course.count
      end
    end
    describe "if there are courses" do
      before do
        Course.new("Seven Oaks Park", "Nasvhille", "TN").save
        Course.new("Rollin Ridge", "Nowhere", "WI").save
      end
      it "should return the correct count" do
        assert_equal 2, Course.count
      end
    end
  end

  describe "#delete" do
    describe "if the specified course doesn't exist" do
      it "should return false" do
        assert_equal false, Course.delete("Seven Springs Resort")
      end
    end
    describe "if the specified course does exist" do
      before do
        Course.new("Seven Oaks Park", "Nashville", "TN").save
        Course.new("Rollin Ridge", "Nowhere", "WI").save
      end
      it "should return true when the course is deleted" do
        assert_equal true, Course.delete("Rollin Ridge")
      end
    end
  end

  describe ".initialize" do
    describe "if a name is provided" do
      it "sets the name attribute" do
        course = Course.new('foo', "bar", "baz")
        assert_equal "foo", course.name
      end
    end
  end

  describe "#insert" do
    describe "if the name isn't valid" do
      it "indicate that the name is invalid" do
        course = Course.new("Elver", "Madison", "WI")
        course.save
        expected = "new name invalid"
        assert_equal expected, Course.insert("Elver", "")
        assert_equal expected, Course.insert("Elver", nil)
        assert_equal expected, Course.insert("Elver", "%$adkf#")
      end

    end
    describe "if the name is valid" do
      it "shouldn't update the model's ID" do
        course = Course.new("Elver", "Madison", "WI")
        course.save
        id = course.id
        Course.insert("Elver", "Heistand")
        assert_equal id, Database.execute("Select id from courses where name like 'Heistand'")[0][0]
      end
      it "should update the model's name" do
        course = Course.new("Elver", "Madison", "WI")
        course.save
        id = course.id
        Course.insert("Elver", "Heistand")
        assert_equal id, Database.execute("Select id from courses where name like 'Heistand'")[0][0]
        assert_equal 'Heistand', Database.execute("Select name from courses where name like 'Heistand'")[0][0]
      end
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:course){ Course.new("Elver", "Madison", "WI") }
      it "should return true" do
        assert course.save
      end
      it "should save the model to the database" do
        course.save
        assert_equal 1, Course.count
        last_row = Database.execute("SELECT * FROM courses")
        database_name = last_row[0][1]
        assert_equal "Elver", database_name
      end
      it "should populate the model with id from the database" do
        course.save
        database_id = Database.execute("SELECT * FROM courses")[0][0]
        assert_equal database_id, course.id
      end
    end

    describe "with a previously invalid name" do
      let(:course){ Course.new("666", "Bad City", "NV") }
      before do
        refute course.valid?
        course.name = "Eat a pop tart"
        assert_equal "Eat a pop tart", course.name
      end
      it "should return true" do
        assert course.valid?
      end
      it "should not have an error message" do
        course.valid?
        assert_nil course.errors
      end
    end
  end

  describe ".exists?" do
    before do
      Course.new("Seven Oaks Park", "Nashville", "TN").save
    end
    it "should return true if the course is in the courses table" do
      assert_equal true, Course.exists?("Seven Oaks Park")
    end
    it "should return false if the course isn't in the courses table" do
      assert_equal false, Course.exists?("Eagle Ridge Bluff Park")
    end
    describe "if the input is bad" do
      it "should return false for empty string" do
        assert_equal false, Course.exists?("")
      end
      it "should return false for nil" do
        assert_equal false, Course.exists?(nil)
      end
      it "should return false for non-word characters" do
        assert_equal false, Course.exists?("$$%()$*()*:JSLKFJS:;SLdfkjSelect*From courses;")
      end
    end
  end

  describe "#get_most_represented_state" do
    describe "when there are no courses" do
      it "should return 'N/A'" do
        assert_equal "N/A", Course.get_most_represented_state
      end
    end
    describe "when there are multiple courses" do
      it "should return an array with the most represented state and its count" do
        Course.new("Seven Oaks Park", "Nashville", "TN").save
        Course.new("Cedar Hill", "Nashville", "TN").save
        Course.new("Elver Park", "Madison", "WI").save
        Course.new("Heistand Isle", "Madison", "WI").save
        Course.new("Rollin Ridge", "Eu Claire", "WI").save
        assert_equal ["WI", 3], Course.get_most_represented_state
      end
    end
  end

end