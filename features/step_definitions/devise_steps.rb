Given /^I am not authenticated$/ do
  visit('/users/sign_out')
end

Given /^I am authenticated$/ do
  When %{I go to the login page}
  And %{I fill in "user_username" with "exampleuser"}
  And %{I fill in "user_password" with "loremipsum"}
  And %{I press "Sign in"}
end

Given /^I sign up as user$/ do
  username = 'exampleuser'
  firstname = 'Example'
  lastname = 'User'
  email = 'user@example.org'
  password = 'loremipsum'
  
  When %{I go to the the registration page}
  And %{I fill in "user_username" with "#{username}"}
  And %{I fill in "user_firstname" with "#{firstname}"}
  And %{I fill in "user_lastname" with "#{lastname}"}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I fill in "user_password_confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should receive an email}
  When %{I open the email}
  And %{they click the first link in the email}
end