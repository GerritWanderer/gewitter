Feature: Open profile pages of users
  In order to read the profile of a existing user
  As a guest
  I want to see all public details of a existing user
  
  Scenario: List the 5 newest profiles
    Given 10 users exist
    And I am not authenticated
    When I go to the profiles page
    Then I should see the 5 newest profiles
    
  Scenario: Read profile successfully
    Given I sign up as user
    And I am not authenticated
    When I go to my public profile page
    Then I should see "Profile of exampleuser"
  
  Scenario: Try to read a profile of a unknown user
    Given 10 users exist
    When I go to a profile page of a unknown user
    Then I should be on the profiles page
    And I should see the 5 newest profiles
    
  Scenario: Subcribe a profile successfully
    Given I sign up as user
    And a user exist with username: "not_subscribed_user"
    And 5 messages exist with user_id: 1
    And 5 messages exist with user_id: 2
    When I go to a profile page of not_subscribed_user user
    Then I should see "Profile of not_subscribed_user"
    When I follow "Subscribe"
    Then I should see "You have successfully subscribed"
    And I should be on my profile page
    Then I should see all my messages
    And I should see the subscribed messages
    
  Scenario: Unsubcribe a profile successfully
    Given I sign up as user
    And a user exist with username: "not_subscribed_user"
    And a subscription exist with user_id: 1, profile: 2
    When I go to a profile page of not_subscribed_user user
    And I follow "Unsubscribe"
    Then I should see "Subscription was successfully deleted"