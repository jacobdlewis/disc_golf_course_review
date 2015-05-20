require_relative "../test_helper"

describe CoursesController do
  describe ".add" do
    let(:reviews_controller) {ReviewsController.new}
    it "should add a scenario" do
      reviews_controller.add("Anna Paige Park", "Rochester", "IL", 12, "The best!")
      assert_equal 1, Review.count
    end
  end
  describe ".add_additional_review" do
    let(:reviews_controller) {ReviewsController.new}
    it "should add a scenario" do
      reviews_controller.add("Lisbon Park", "Lisbon", "MA", 12, "Great!")
      reviews_controller.add_additional_review("Lisbon Park", "Fabulous")
      assert_equal 2, Review.count
    end
  end
  describe ".show_reviews" do
    let(:reviews_controller) {ReviewsController.new}
    before do
      Review.new("Rollin Ridge", "Nowhere", "WI", 2, "One of the Best!").save
      Review.new("Rollin Ridge", "Nowhere", "WI", 2, "Lots of bugs today, but the grass was freshly mowed.").save
    end
    it "should format a list of reviews & timestamps for a given course" do
      expected = "\nReviews for Rollin Ridge:\n\nMay 20, 2015 - One of the Best!\n\nMay 20, 2015 - Lots of bugs today, but the grass was freshly mowed.\n\n"
      assert_equal expected, reviews_controller.show_reviews("Rollin Ridge")
    end
  end
end