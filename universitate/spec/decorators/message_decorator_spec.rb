require "rails_helper"

RSpec.describe 'MessageDecorator', type: :controller do
  describe "css_class method for message which" do
    it "was send it by logged user should be left" do
      sign_in(users(:one))
      message = messages(:one_with_two).decorate

      assert_equal message.css_class, 'left'
    end

    it "was receive it by logged user should be right" do
      sign_in(users(:two))
      message = messages(:one_with_two).decorate

      assert_equal message.css_class, 'right'
    end
  end


  describe "sender_display_name method for message which" do
    it "was send it by logged user should be Yo" do
      sign_in(users(:one))
      message = messages(:one_with_two).decorate

      assert_equal message.sender_display_name, 'Yo'
    end

    it "was receive it by logged user should be Pedro Perez" do
      sign_in(users(:two))
      message = messages(:one_with_two).decorate

      assert_equal message.sender_display_name, 'Pedro Perez'
    end
  end

  describe "message method for message" do
    it "should be Hola, cómo andás?" do
      message = messages(:one_with_two).decorate

      assert_equal message.message, 'Hola, cómo andás?'
    end
  end

  describe "datetime_creation method for message" do
    it "should be 9/27/2016 16:30" do
      message = messages(:one_with_two)
      message.created_at = DateTime.new(2016, 9, 27, 16, 30, 0)

      assert_equal message.decorate.datetime_creation, '09/27/16 04:30'
    end
  end
end