Feature: User can register and sign in

  As a user
  I want to register and access privately constantly
  So that I can make sure that other people will not see my information

Background:

  Given I am on the signup page
  And I fill in the following:
     | user_name             | Example User      |
     | user_email            | user@example.org  |
     | user_password         | foobar            |
     | user_password_confirmation   | foobar            |
  And I press "创建我的账户"
  Then I should see "欢迎"
  And I should see "Example User"
  When I follow "登出"
  Then I should not see "Example User"

Scenario:

  Given I am on the signin page
  And I fill in the following:
    | session_email              | user@example.org  |
    | session_password           | foobar            |
  And I press "登陆"
  Then I should see "Example User"
