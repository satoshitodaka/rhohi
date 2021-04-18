require "test_helper"

class CompanyTest < ActiveSupport::TestCase

  def setup
    @company = companies(:TDK)
  end

  test "should be valid" do
    assert @company.valid?  
  end

  test "department_name should be presence" do
    @company.name = ""
    assert_not @company.valid?  
  end

  test "company_id should be presence" do
    @company.address = ""
    assert_not @company.valid?  
  end
end