require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	test "login with invalid information" do
		get login_path # go to login page
		assert_template 'sessions/new' # check that you go to the login page
		post login_path, params: { session: { email: "", password: "" } } # enter bad login info
		assert_template 'sessions/new' # check that you get sent back to login page
		assert_not flash.empty? # make sure the invalid login flash pops up
		get root_path # go to the home page
		assert flash.empty? # make sure that the flash does not pop up on the home page
	end
end
