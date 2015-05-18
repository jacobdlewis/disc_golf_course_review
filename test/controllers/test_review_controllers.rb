require_relative "../test_helper"

describe CoursesController do
  describe ".add" do
    let(:reviews_controller) {ReviewsController.new}
    it "should add a scenario" do
      reviews_controller.add("Anna Paige Park", 12, "The best!")
      assert_equal 1, Review.count
    end
  end
  describe ".add_additional_review" do
    let(:reviews_controller) {ReviewsController.new}
    it "should add a scenario" do
      reviews_controller.add("Lisbon Park", 12, "Great!")
      reviews_controller.add_additional_review("Lisbon Park", "Fabulous")
      assert_equal 2, Review.count
    end
  end
end