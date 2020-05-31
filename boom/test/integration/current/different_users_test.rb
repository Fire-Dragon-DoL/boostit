# frozen_string_literal: true

# require 'test_helper'

# module Current
#   class DifferentUsersTest < IntegrationCase
#     test 'When getting current integer of different users, number differs' do
#       user = User::Sample.random
#       user.save!
#       other_user = User::Sample.random
#       other_user.save!
#       sign_in user

#       get current_serial_url

#       assert @response.status >= 200 && @response.status <= 299
#     end
#   end
# end
