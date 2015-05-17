require_relative '../test_helper'

describe Course do
  describe "#all" do
    describe "if there are no courses in the database" do
      it "should return an empty array" do
        assert_equal [], Course.all
      end
    end
    describe "if there are scenarios" do
      before do
        create_course("Seven Oaks Park", "Nashville", "TN", "3457 School Ln", "37217", "21", "free");
        create_course("Rollin Ridge", "Baraboo", "WI", "333 Nowheresville", "53234", "36", "paid - $5");
      end
      it "should return an array" do
        assert_equal Array, Course.all.class
      end
      it "should return the courses in alphabetical order" do
        expected = ["Rollin Ridge", "Seven Oaks Park"]
        actual = Course.all.map { |course| course.name }
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no courses in the database" do
      it "should return 0" do
        assert_equal 0, Course.count
      end
    end
    describe "if there are scenarios" do
      before do
        Course.new("Seven Oaks Park").save
        Course.new("Rollin Ridge").save
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
        Course.new("Seven Oaks Park").save
        Course.new("Rollin Ridge").save
      end
      it "should return true when the course is deleted" do
        assert_equal true, Course.delete("Rollin Ridge")
      end
    end
  end

  describe ".initialize" do
    describe "if a name is provided" do
      it "sets the name attribute" do
        course = Course.new('foo')
        assert_equal "foo", course.name
      end
    end
    describe "if a name isn't provided" do
      it "sets the name attribute to nil" do
        course = Course.new()
        assert_equal nil, course.name
      end
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:course){ Course.new("Elver") }
      it "should return true" do
        course.city = "Madison"
        course.state = "WI"
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
    let(:course){ Course.new("666") }
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


end