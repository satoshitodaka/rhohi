require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  def setup
    # @company = companies(:TDK)
    @department = departments(:TGA)
  end

  test "should be valid" do
    assert @department.valid?  
  end

  test "department_name should be presence" do
    @department.department_name = ""
    assert_not @department.valid?  
  end

  test "company_id should be presence" do
    @department.department_name = ""
    assert_not @department.valid?  
  end
end
