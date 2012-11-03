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
    fill_in "Namn", with: "Svenne Banan"
    fill_in "Användarnamn", with: "svenneb"
    fill_in "Epostaddress", with: "svenneb@example.com"
    fill_in "Lösenord", with: "bananer"
    fill_in "Lösenordsbekräftelse", with: "bananer"
    select "student", from: "Roll"
    click_button "Skapa"

    user = User.last
    user.name.must_equal "Svenne Banan"
    user.login.must_equal "svenneb"
    user.email.must_equal "svenneb@example.com"
    user.role.must_equal "student"
  end
end
