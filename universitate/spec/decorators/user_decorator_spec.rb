require "rails_helper"

RSpec.describe 'UserDecorator', type: :controller do
  describe "display_name method for user whose" do
    it "first_name is Pedro and last_name is Perez its equal to Pedro Perez" do
      user = users(:one)
      sign_in(user)

      assert_equal user.decorate.display_name, 'Pedro Perez'
    end
  end

  
end
