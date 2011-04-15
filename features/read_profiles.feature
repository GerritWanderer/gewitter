Feature: Open profile pages of users
  In order to read the profile of a existing user
  As a guest
  I want to see all public details of a existing user
  
  @test
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
    Given I sign up as user
    And I am not authenticated
    When I go to a profile page of a unknown user
    Then I should see "A profile error occurred"