require_relative '../test_helper'

describe Review do

  describe "#count" do
    describe "if there are no courses in the database" do
      it "should return 0" do
        assert_equal 0, Review.count
      end
    end
    describe "if there are scenarios" do
      it "should return the correct count" do
        Review.new("The Park", "Nashville", "TN", 1, "Great course").save
        Review.new("SevenOaksPark", "Nashville", "TN", 1, "Great course").save
        assert_equal 2, Review.count
      end
    end
  end

  describe "#get_courses_and_review_count" do
    describe "if there are no courses in the database" do
      it "should return an empty array" do
        assert_equal [], Review.get_courses_and_review_count
      end
    end
    describe "if there are courses" do
      before do
        Review.new("Seven Oaks Park", "Nashville", "TN", 1, "Great course!" ).save
        Review.new("Rollin Ridge", "Nowhere", "WI", 2, "One of the best!").save
      end
      it "should return an array" do
        assert_equal Array, Review.get_courses_and_review_count.class
      end
      it "should return the courses in alphabetical order" do
        expected = [["Seven Oaks Park", "Nashville", "TN", 1],["Rollin Ridge", "Nowhere", "WI", 1]]
        actual = Review.get_courses_and_review_count
        actual[0].pop
        actual[1].pop
        assert_equal expected, actual
      end
    end
  end

  describe ".save" do
    before do
      Review.new("Seven Oaks Park", "Nashville", "TN", 1, "Great course!").save
    end
    it "should save the model to the database" do
      assert_equal 1, Review.count
      course = Review.find_by(name: "Seven Oaks Park")
      assert_equal "Nashville", course.city
    end
  end


  describe "#exists?" do
    it  "should return true if the named course exists" do
      Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
      assert_equal true, Review.exists?("Seven Oaks Park")
    end
    it "should return false if the named course doesn't exist" do
      Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
      assert_equal false, Review.exists?("Ocean Salty Park")
    end
    describe "if the input is bad" do
      it "should return false for empty string" do
        assert_equal false, Review.exists?("")
      end
      it "should return false for nil" do
        assert_equal false, Review.exists?(nil)
      end
      it "should return false for non-word characters" do
        assert_equal false, Review.exists?("$$%()$*()*:JSLKFJS:;SLdfkjSelect*From courses;")
      end
    end
  end

  describe "#get_reviews" do
    before do
      Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
      Review.new("Cedar Hill Park", "Nashville", "TN", 23, "Awesome!").save
    end
    describe "if the specified course exists" do
      it "should return an array of the requested data" do
        result = Review.get_reviews("Seven Oaks Park")
        assert_equal true, result
      end
    end
    describe "If the specified course doesn't exist" do
      it "should return an error message" do
        result = Review.get_reviews("Paradise Park")
        assert_equal result, "Course not found"
      end
    end
  end

  describe "#get_most_represented_state" do
    describe "when there are no courses" do
      it "should return 'N/A'" do
        assert_equal "N/A", Review.get_most_represented_state
      end
    end
    describe "when there are multiple courses" do
      it "should return an array with the most represented state and its count" do
        Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
        Review.new("Cedar Hill", "Nashville", "TN", 20, "Awesome!").save
        Review.new("Elver Park", "Madison", "WI", 25, "Super!").save
        Review.new("Scottish Isle", "Phoenex", "AZ", 18, "Awesome!").save
        Review.new("Crockett", "Brentwood", "TN", 2, "Super!").save
        assert_equal ["TN", 3], Review.get_most_represented_state
      end
    end
  end

end