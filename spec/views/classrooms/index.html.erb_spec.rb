require 'rails_helper'

RSpec.describe "classrooms/index", type: :view do
  before(:each) do
    assign(:classrooms, [
      Classroom.create!(
        name: "Name"
      ),
      Classroom.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of classrooms" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
