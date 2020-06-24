require 'rails_helper'

RSpec.describe "wash_types/show", type: :view do
  before(:each) do
    @wash_type = assign(:wash_type, WashType.create!(
      name: "Name",
      cost: 2.5,
      price: 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
  end
end
