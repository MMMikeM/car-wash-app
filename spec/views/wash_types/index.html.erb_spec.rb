require 'rails_helper'

RSpec.describe "wash_types/index", type: :view do
  before(:each) do
    assign(:wash_types, [
      WashType.create!(
        name: "Name",
        cost: 2.5,
        price: 3.5
      ),
      WashType.create!(
        name: "Name",
        cost: 2.5,
        price: 3.5
      )
    ])
  end

  it "renders a list of wash_types" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
  end
end
