require_relative '../test_helper'

describe Review do

  describe "#count" do
    describe "if there are no courses in the database" do
      it "should return 0" do
        assert_equal 0, Review.count
      end
    end
    describe "if there are scenarios" do
      before do
        Review.new("Seven Oaks Park", "Nashville", "TN", 1, "Great course!" ).save
        Review.new("Rollin Ridge", "Nowhere", "WI", 2, "One of the Best!").save
      end
      it "should return the correct count" do
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
    let (:review) { Review.new("Seven Oaks Park", "Nashville", "TN", 1, "Great course!").save }
    it "should save the model to the database" do
      review
      assert_equal 1, Review.count
      last_row = Database.execute("SELECT * FROM reviews")
      database_name = last_row[0][1]
      assert_equal "Seven Oaks Park", database_name
    end
    it "should populate the model with id from the database" do
      review
      database_id = Database.execute("SELECT * FROM reviews")[0][0]
      assert_equal database_id, review
    end
  end

  describe "#get_course_info" do
    it "should return the course_id of the named course" do
      Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
      assert_equal [23, "Nashville", "TN"], Review.get_course_info("Seven Oaks Park")
    end
    it "should return an error message if the id doesn't exist" do
      Review.new("Elver Park", "Madison", "WI", 14, "Amazing! Huzzah!").save
      assert_equal "ID not found", Review.get_course_info("Spanish Moss Course")
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
  end

  describe "#get_reviews" do
    before do
      Review.new("Seven Oaks Park", "Nashville", "TN", 23, "Awesome!").save
    end
    describe "if the specified course exists" do
      it "should return an array of arrays containing name, city, state, comment, and completion dates" do
        result = Review.get_reviews("Seven Oaks Park")
        result[0].pop
        assert_equal result, [["Seven Oaks Park", "Nashville", "TN", "Awesome!"]]
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