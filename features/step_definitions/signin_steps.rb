require 'uri'
require 'cgi'
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Then /^(?:|I )sign in as admin$/ do
  visit signin_path
  fill_in('电子邮箱', :with => 'admin@tsinghuax.org')
  fill_in('密码', :with => 'foobar')
  click_button('登陆')
end

Then /^(?:|I )sign up as "([^"]*)"$/ do |user|
  visit signup_path
  fill_in '用户名',    with: "#{user}"
  fill_in '电子邮箱',   with: "#{user}@tsinghuax.org"
  fill_in '密码',       with: 'password'
  fill_in '确认密码',   with: 'password'
  click_button '创建我的账户'
  click_link '登出'
end

Then /^(?:|I )sign in as "([^"]*)"$/ do |user|
  visit signin_path
  fill_in '电子邮箱',    with: "#{user}@tsinghuax.org"
  fill_in '密码',       with: 'password'
  click_button '登陆'
end