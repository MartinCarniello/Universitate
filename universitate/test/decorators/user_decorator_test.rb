require 'test_helper'

class UserDecoratorTest < ActiveSupport::TestCase
  test 'display_name' do
    user = User.new(first_name: 'Jorge', last_name: 'Lopez', email: 'jorge@lopez.com').decorate
    assert_equal user.display_name, 'Jorge Lopez'
  end
end