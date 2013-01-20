# encoding: utf-8

require 'minitest_helper'

describe "Add a student acceptance test" do
  before do
    @admin = FactoryGirl.create(:admin, password: 'secret', password_confirmation: 'secret')
    visit resumes_path
    fill_in "login", with: @admin.login
    fill_in "password", with: 'secret'
    click_button "Logga in"
  end

  it "can add a student user" do
    visit users_path
    click_link "Skapa"
    fill_in "Användarnamn", with: "svenneb"
    select "student", from: "Roll"
    fill_in "Namn", with: "Svenne Banan"
    fill_in "Epostadress", with: "svenneb@example.com"
    fill_in "user_password", with: "bananer"
    fill_in "user_password_confirmation", with: "bananer"
    click_button "Skapa"

    user = User.last
    user.name.must_equal "Svenne Banan"
    user.login.must_equal "svenneb"
    user.email.must_equal "svenneb@example.com"
    user.role.must_equal "student"
  end
end
