Feature: Manage messages
  In order to to manage messages
  As a user
  I want to create and delete messages
  
  Scenario: List my messages successfully
    Given I sign up as user
    And 20 messages exist with user_id: 1
    When I go to my public profile page
    Then I should see all my messages
    And I should be on my public profile page
    
  Scenario: Create a messages successfully
    Given I sign up as user
    And 3 messages exist with user_id: 1
    When I go to my public profile page
    And I fill in "message_text" with "Some text for my new message"
    And I press "Create Message"
    Then I should see "Message was successfully created"
    And I should see "Some text for my new message"
    And I should be on my profile page
    
  Scenario: Try to create a messages with invalid input
    Given I sign up as user
    And 3 messages exist with user_id: 1
    When I go to my public profile page
    And I fill in "message_text" with ""
    And I press "Create Message"
    Then I should see "Text is too short"
    When I fill in "message_text" with to much letters
    And I press "Create Message"
    Then I should see "Text is too long"
    
  Scenario: Delete a messages successfully
    Given I sign up as user
    And 3 messages exist with user_id: 1
    When I go to my public profile page
    And I click "Delete" in the 2nd message row
    Then message should not exist with id: 2
    And I should see "Message was successfully deleted"
    And I should be on my profile page