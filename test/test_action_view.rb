require "test_helper"

class TestActionView < ActionView::TestCase
  sub_test_case "sub 1" do
    sub_test_case "sub 2" do
      def test_test_under_double_nexted_sub_test_case_works
        assert_true true
      end
    end
  end
end
