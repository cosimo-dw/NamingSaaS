require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('登陆') }
    it { should have_title('登陆') }
  end

  describe "before signin" do
    before { visit root_path }
    it { should_not have_link('个人信息') }
    it { should_not have_link('设置') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "登陆" }

      it { should have_title('登陆') }
      it { should have_error_message('错误') }

      describe "after visiting another page" do
        before { click_link "主页" }
        it { should_not have_error }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in (user) }

      it { should have_title(user.name) }
      it { should_not have_link('Users',   href: users_path) }
      it { should have_link('个人信息',     href: user_path(user)) }
      it { should have_link('设置',    href: edit_user_path(user)) }
      it { should have_link('登出',    href: signout_path) }
      it { should_not have_link('登陆', href: signin_path) }

      describe "followed by signout" do
        before { click_link "登出" }
        it { should have_link('登陆') }
      end
    end
  end

  describe "authorization" do

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user, no_capybara: true }

      describe "using a 'new' action" do
        before { get signup_path }
        specify { response.should redirect_to(root_path) }
      end

      describe "using a 'create' action" do
        before { post users_path }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('更改个人信息')
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              sign_in user
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('登陆') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('登陆') }
        end
      end

      describe "in the Orders controller" do

        describe "submitting to the create action" do
          before { post orders_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        #describe "submitting to the destroy action" do
        #  before { delete order_path(FactoryGirl.create(:order)) }
        #  specify { expect(response).to redirect_to(signin_path) }
        #end
      end

      describe "in the Messages controller" do

        describe "submitting to the create action" do
          before { post messages_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete message_path(FactoryGirl.create(:message)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end

      describe "visit the index page of users" do
        before { get users_path }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

  end
end
