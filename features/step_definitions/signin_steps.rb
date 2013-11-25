require 'uri'
require 'cgi'
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Then /^(?:|I )sign in as admin$/ do
  visit signin_path
  fill_in('Email', :with => 'admin@tsinghuax.org')
  fill_in('Password', :with => 'foobar')
  click_button('Sign in')
end

Then /^(?:|I )sign in as "([^"]*)"$/ do |user|
  visit signin_path
  fill_in "Email",    with: "#{user}@tsinghuax.org"
  fill_in "Password", with: "password"
  click_button "Sign in"
end