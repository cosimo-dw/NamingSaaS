include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "电子邮箱",    with: user.email
    fill_in "密码", with: user.password
    click_button "登陆"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_error do
  match do |page|
    expect(page).to have_selector('div.alert.alert-error')
  end
end

RSpec::Matchers.define :have_full_title do |title|
  match do |page|
    expect(page).to have_title(full_title(title))
  end
end