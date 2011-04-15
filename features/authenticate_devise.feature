Feature: Use authentication from devise
  In order to use the authentication functionality
  As a guest
  I want to use all features for signup/signin actions
  
  Scenario: Sign up successfully
    Given I am not authenticated
    When I go to the registration page
    And I fill in "user_username" with "exampleuser"
    And I fill in "user_email" with "user@example.org"
    And I fill in "user_password" with "loremipsum"
    And I fill in "user_password_confirmation" with "loremipsum"
    And I press "Sign up"
    And I should see "You have signed up successfully."
    Then I should receive an email
    When I open the email
    And they click the first link in the email
    Then I should see "Your account was successfully confirmed"
    
  Scenario: Sign up unsuccessfully
    Given I am not authenticated
    When I go to the registration page
    And I fill in "user_username" with "eu"
    And I fill in "user_email" with "userexample.org"
    And I fill in "user_password" with "eu"
    And I fill in "user_password_confirmation" with "eü"
    And I press "Sign up"
    Then I should see "4 errors prohibited"
    And I should see "Username is too short"
    And I should see "Email is invalid"
    And I should see "Password doesn't match confirmation"
    And I should see "Password is too short (minimum is 6 characters)"
    
  Scenario: Sign in successfully
    Given I sign up as user
    And I am not authenticated
    When I go to the login page
    And I fill in "user_username" with "exampleuser"
    And I fill in "user_password" with "loremipsum"
    And I press "Sign in"
    Then I should see "Signed in successfully."
    
  Scenario: Sign in unsuccessfully
    Given I sign up as user
    And I am not authenticated
    When I go to the login page
    And I fill in "user_username" with "exampleuser"
    And I fill in "user_password" with "wrong_password"
    And I press "Sign in"
    And I should see "Invalid username or password."
  
  @wip
  Scenario: Update Profile as authenticated User successfully
    Given I sign up as user
    When I go to the works page
    And I follow "Profile" within "div#navigation ul li.small"
    And I fill in "user_firstname" with "Bugs"
    And I fill in "user_lastname" with "Bunny"
    And I fill in "user_current_password" with "loremipsum"
    And I press "Update"
    Then I should be on the root page
    And I should see "You updated your account successfully."