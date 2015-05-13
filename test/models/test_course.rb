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
        create_course("Seven Oaks Park", "Nashville", "TN", "3457 School Ln", "37217", "21", "free");
        create_course("Rollin Ridge", "Baraboo", "WI", "333 Nowheresville", "53234", "36", "paid - $5");
      end
      it "should return the correct count" do
        assert_equal 2, Course.count
      end
    end
  end
end