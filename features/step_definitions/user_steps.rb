# frozen_string_literal: true
Then /^I should have an user$/ do
  expect(User.all.size).to be >= 1
end

Then /^I should have an adminuser$/ do
  expect(User.admin_users.size).to be >= 1
end

Then /^I should have one adminuser$/ do
  expect(User.admin_users.size).to eq(1)
end

Then /^I should have two adminusers$/ do
  expect(User.admin_users.size).to eq(2)
end

Then /^I should have one manageruser$/ do
  expect(User.manager_users.size).to eq(1)
end

Then /^I should have zero managerusers$/ do
  expect(User.manager_users.size).to eq(0)
end

Given /^I am authenticated user$/ do
  @user = FactoryGirl.create(:user, email: 'test_user@sample.com', first_name: 'Pepe', last_name: 'Moreno', active: true)
  email = @user.email
  password = @user.password
  visit '/manage/account/login'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end

Given /^I am authenticated adminuser$/ do
  @user = FactoryGirl.create(:adminuser, active: true, role: 'admin', email: 'admin@sample.com')
  email = @user.email
  password = @user.password
  visit '/manage/account/login'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end

Given /^I am registrated user$/ do
  @user = FactoryGirl.create(:user, email: 'test-user@sample.com', password: 'password')
end

Given /^user$/ do
  FactoryGirl.create(:user, email: 'pepe-moreno@sample.com')
end

Given /^adminuser$/ do
  FactoryGirl.create(:adminuser, first_name: 'Juanito', last_name: 'Lolito', email: 'admin@sample.com')
  FactoryGirl.create(:user, active: true, role: 'admin')
end

Given /^manageruser$/ do
  FactoryGirl.create(:manageruser, first_name: 'Pepe', last_name: 'Moreno', email: 'pepe-moreno@sample.com', active: true)
end
