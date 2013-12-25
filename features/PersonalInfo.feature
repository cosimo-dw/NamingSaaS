Feature: Admin can see information about the company of an order

  As an admin
  I want to get the company information from my customer if the category of the order is "company naming"
  So that I can provide the company with the service of naming

Background:
  Given I sign up as "user-1"

Scenario: Try to add a company order

  Given I sign in as "user-1"
  Then I should see "新的个人取名服务"
  And I go to the new order page
  Then I should see "父亲姓名"
  And I should see "母亲出生日期及时间"


