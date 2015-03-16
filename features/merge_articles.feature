Feature: Merge Articles
  As a blog administrator
  In order to add interesting ideas from other users
  I want to be able to merge similar articles

  Background:
    Given the blog is set up
    When publisher "Hououin Kyouma" creates an article with title "Foo" and content "El. Psy."
    Then publisher "Makise Kurisu" creates an article with title "Bar" and content "Congroo."
    Then publisher "Mayuri Shiina" comments on article "Bar" with "Tuturuu!"
    Then publisher "Itaru Hashida" comments on article "Foo" with "I am super hacker"
    When I am logged into the admin panel
    And I merge "Foo" with "Bar"
    Then I go to logout page
    
  Scenario: Check that a non-admin cannot merge
    When I login as Pub Lisher
    And I create an article with title "Pub" and content "Lisher"
    When I edit the article "Pub"
    Then I should not see "Merge Articles"
    Then I go to logout page

  Scenario: Check that merged article has text of both previous articles
    When I am on the home page
    And I visit either "Foo" or "Bar"
    Then I should see "El. Psy."
    And I should see "Congroo."

  Scenario: Check that merged article has only one author
    When I go to the home page
    Then the author of "Foo" or "Bar" should be "Hououin Kyouma" or "Makise Kurisu"

  Scenario: Check that merged article contains comments of both articles
    When I am on the home page
    And I visit either "Foo" or "Bar"
    Then I should see "Tuturuu!"
    And I should see "I am super hacker"

  Scenario: Check that merged article has only one title
    When I go to the home page
    Then I should see "Foo" or "Bar"
    But I should not see both "Foo" and "Bar"