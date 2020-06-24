require 'rails_helper'

RSpec.describe "wash_types/new", type: :view do
  before(:each) do
    assign(:wash_type, WashType.new(
      name: "MyString",
      cost: 1.5,
      price: 1.5
    ))
  end

  it "renders new wash_type form" do
    render

    assert_select "form[action=?][method=?]", wash_types_path, "post" do

      assert_select "input[name=?]", "wash_type[name]"

      assert_select "input[name=?]", "wash_type[cost]"

      assert_select "input[name=?]", "wash_type[price]"
    end
  end
end
