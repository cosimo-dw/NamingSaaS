require 'spec_helper'

describe "Character pages" do

  subject { page }

  describe "index" do

    let!(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit characters_path
    end

    it { should have_title('Characters') }
    it { should have_button('Search') }

    it { should have_content('结构') }

    describe "pagination" do

      before(:all) { 60.times { FactoryGirl.create(:character) } }
      after(:all)  { Character.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each character" do
        get characters_path
        Character.paginate(page: 1).each do |ch|
          expect(page).to have_link(ch.unichr, character_path(ch))
        end
      end
    end

    describe "search" do
      describe "for structure only" do
        before do
          select '⿰', from: 'character[structure]'
          click_button "Search"
        end

        it "should list each character" do
          Character.search({structure: '独'},1).each do |ch|
            expect(page).to have_link(ch.unichr, character_path(ch))
          end
        end

      end

      describe "for zongbihua only" do
        before do
          fill_in 'character[zongbihua]', with: 10
          click_button "Search"
        end

        it "should list each character" do
          Character.search({zongbihua: 10},1).each do |ch|
            expect(page).to have_link(ch.unichr, character_path(ch))
          end
        end

      end
    end
  end

  #describe "profile page" do
  #  let(:user) { FactoryGirl.create(:user) }
  #  let!(:m1) { FactoryGirl.create(:order, user: user) }
  #  let!(:m2) { FactoryGirl.create(:order, user: user) }
  #
  #  before { visit user_path(user) }
  #
  #  it { should have_content(user.name) }
  #  it { should have_title(user.name) }
  #
  #  describe "orders" do
  #    it { should have_content(m1.id) }
  #    it { should have_content(m2.id) }
  #    it { should have_content(user.orders.count) }
  #  end
  #end

  #describe "edit" do
  #  let(:user) { FactoryGirl.create(:user) }
  #  before do
  #    sign_in user
  #    visit edit_user_path(user)
  #  end
  #
  #  describe "page" do
  #    it { should have_content("Update your profile") }
  #    it { should have_title("Edit user") }
  #    it { should have_link('change', href: 'http://gravatar.com/emails') }
  #  end
  #
  #  describe "with invalid information" do
  #    before { click_button "Save changes" }
  #
  #    it { should have_content('error') }
  #  end
  #
  #  describe "with valid information" do
  #    let(:new_name)  { "New Name" }
  #    let(:new_email) { "new@example.com" }
  #    before do
  #      fill_in "Name",             with: new_name
  #      fill_in "Email",            with: new_email
  #      fill_in "Password",         with: user.password
  #      fill_in "Confirm Password", with: user.password
  #      click_button "Save changes"
  #    end
  #
  #    it { should have_title(new_name) }
  #    it { should have_selector('div.alert.alert-success') }
  #    it { should have_link('Sign out', href: signout_path) }
  #    specify { expect(user.reload.name).to  eq new_name }
  #    specify { expect(user.reload.email).to eq new_email }
  #  end
  #
  #  describe "forbidden attributes" do
  #    let(:params) do
  #      { user: { admin: true, password: user.password,
  #                password_confirmation: user.password } }
  #    end
  #    before { patch user_path(user), params }
  #    specify { expect(user.reload).not_to be_admin }
  #  end
  #end
end