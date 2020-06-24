require 'rails_helper'

RSpec.describe "wash_types/edit", type: :view do
  before(:each) do
    @wash_type = assign(:wash_type, WashType.create!(
      name: "MyString",
      cost: 1.5,
      price: 1.5
    ))
  end

  it "renders the edit wash_type form" do
    render

    assert_select "form[action=?][method=?]", wash_type_path(@wash_type), "post" do

      assert_select "input[name=?]", "wash_type[name]"

      assert_select "input[name=?]", "wash_type[cost]"

      assert_select "input[name=?]", "wash_type[price]"
    end
  end
end
