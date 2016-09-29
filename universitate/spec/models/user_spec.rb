# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  first_name             :string
#  last_name              :string
#  date_of_birth          :datetime
#  gender                 :string
#

require "rails_helper"

RSpec.describe User, type: :model do
  describe "conversations method for user :one" do
    it "should be one" do
      user = users(:one)

      assert_equal user.conversations.size, 1
    end
  end

  describe "unreaded_messages method for user :one" do
    it "should be zero" do
      user = users(:one)

      assert_equal user.unreaded_messages, 0
    end

    it "should be one when user :two send one" do
      user = users(:one)
      Message.create(sender: users(:two), receiver: users(:one), message: 'Otro mensaje', conversation: conversations(:one))

      assert_equal user.unreaded_messages, 1
    end
  end

  describe "has_already_been_rate_by? method for user :one to user :two" do
    it "should be false" do
      user = users(:one)

      assert_equal user.has_already_been_rate_by?(users(:two)).present?, false
    end

    it "should be true when user :two rate user :one" do
      user = users(:one)

      Rating.create(comment: 'Un comentario', value: 3, user: users(:two), teacher_profile: users(:one).teacher_profile)
      assert_equal user.has_already_been_rate_by?(users(:two)).present?, true
    end
  end
end
