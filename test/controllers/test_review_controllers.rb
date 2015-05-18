require_relative "../test_helper"

describe CoursesController do
  describe ".add" do
    let(:reviews_controller) {ReviewsController.new}
    it "should add a scenario" do
      reviews_controller.add("Anna Paige Park", 12, "The best!")
      assert_equal 1, Review.count
    end
  end
end