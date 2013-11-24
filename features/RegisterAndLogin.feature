Feature: User can register and sign in

  As a user
  I want to register and access privately constantly
  So that I can make sure that other people will not see my information

Background:

  Given I am on the signup page
  And I fill in the following:
     | Name               | Example User      |
     | Email              | user@example.org  |
     | Password           | foobar            |
     | Confirm Password   | foobar            |
  And I press "Create my account"
  Then I should see "Welcome to the Sample App!"
  And I should see "Example User"
  When I follow "Sign out"
  Then I should not see "Example User"

Scenario:

  Given I am on the signin page
  And I fill in the following:
    | Email              | user@example.org  |
    | Password           | foobar            |
  And I press "Sign in"
  Then I should see "Example User"
