require "application_system_test_case"

class MainTest < ApplicationSystemTestCase
test "login_successfully" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	assert_text "Login successfully"
end

test "login_failed" do
	visit login_path
	fill_in "Email" , with: "Error laaaa"
	fill_in "Password", with: "secret"
	click_on "Login"
	assert_text "Email/password not valid"
end

test "create_user_fail" do
	visit login_path
	click_on "Register"
	fill_in "Username", with: "test1"
	fill_in "Email" , with: "a"
	fill_in "Password" , with: ""
	click_on "Create User"
	assert_text "Password can't be blank"
end

test "create_user_successfully" do
	visit login_path
	click_on "Register"
	fill_in "Username", with: "test1"
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Create User"
	assert_text "User was successfully created."
end

test "clink_home" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "Home"
	assert_text "MAIN"
end

test "click_all_tag" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "Tag"
	assert_text "ALL TAG"
end

test "click_all_tag_from_main" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "Tag"
	find("#fortest_findvideo").click
	assert_text "Selectd Tag"
end
test "click_all_channel" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "All Channel"
	assert_text "ALL CHANNEL"
end
test "follow_channel" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "All Channel"
	find("#see_channel").click
	click_on "Follow"
	assert_text "Follow"
end
test "unfollow_channel" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "All Channel"
	find("#see_channel").click
	click_on "Follow"
	assert_selector "h4", text: "followed for testcase"
	click_on "Unfollow"
end
test "see video" do
	visit login_path
	fill_in "Email" , with: "test1"
	fill_in "Password" , with: "a"
	click_on "Login"
	click_on "All Channel"
	find("#see_channel").click
	assert_text "Follow"
end

end



