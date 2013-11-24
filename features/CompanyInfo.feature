Feature: Admin can see information about the company of an order

  As an admin
  I want to get the company information from my customer if the category of the order is "company naming"
  So that I can provide the company with the service of naming

Scenario: Try to add a company order

  Given I sign in as "user-1"
  And I follow "New Company Order"
  Then I should see "公司名前缀"
  And I should see "公司名后缀"


