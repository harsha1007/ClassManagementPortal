require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    def setup
    @user = User.new(name:"Example user",email:"example@ncsu.edu",password:"1234",usertype:"Admin")
    end

    test "should be valid" do
      assert @user.valid?, "User details not saved"
    end

    test "name should be present" do
      @user.name = "     "
      assert_not @user.valid?
    end

    test "name should not be too long" do
      @user.name = "h" * 100
      assert_not @user.valid?
    end
    
    test "email should be present" do
      @user.email = "     "
      assert_not @user.valid?
    end

    test "email should not be too long" do
      @user.email = "h" * 280 + "@ncsu.edu"
      assert_not @user.valid?
    end
    
    test "email addresses should be unique" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
    end

    test "password should be present (nonblank)" do
      @user.password =  " "
      assert_not @user.valid?
    end
end
