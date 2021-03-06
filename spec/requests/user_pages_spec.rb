require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }
    let!(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit users_path
    end

    it { should have_title('所有用户') }
    it { should have_content('所有用户') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should have_link('删除', href: user_path(User.first)) }
      it "should be able to delete another user" do
        expect do
          click_link('删除', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('删除', href: user_path(admin)) }

    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:order, user: user) }
    let!(:m2) { FactoryGirl.create(:order, user: user) }

    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "orders" do
      it { should have_content(m1.id) }
      it { should have_content(m2.id) }
      it { should have_content(user.orders.count) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('注册') }
    it { should have_full_title('注册') }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "创建我的账户" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('注册') }
        it { should have_error }
      end
    end

    describe "with valid information" do
      before do
        fill_in "用户名",         with: "Example User"
        fill_in "电子邮箱",        with: "user@example.com"
        fill_in "密码",     with: "foobar"
        fill_in "确认密码", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('登出') }
        it { should have_title(user.name) }
        it { should have_success_message('欢迎！') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("更改个人信息") }
      it { should have_title("更改个人信息") }
      it { should have_link('更改', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "保存更改" }

      it { should have_error_message('错误') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "用户名",             with: new_name
        fill_in "电子邮箱",            with: new_email
        fill_in "密码",         with: user.password
        fill_in "确认密码", with: user.password
        click_button "保存更改"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('登出', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
  end
end