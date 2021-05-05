require 'test_helper'

class ExpencesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @expence = expences(:one_1)
  end

  # test "should redirect create not logged in" do
  #   assert_no_difference 'Expence.count' do
  #     post trip_statement_expences_path, params: { expence: { date: '2021-05-01',
  #                                                            transportation: "train",
  #                                                            bording: "tokyo",
  #                                                            get_off: "shimbashi",
  #                                                            fare: 154 }
  #     }
  #   end
  #   assert_redirected_to new_user_session_url
  # end

end
