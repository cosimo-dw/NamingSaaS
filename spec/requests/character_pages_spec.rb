require 'spec_helper'

describe "Character pages" do

  subject { page }

  describe "index" do

    let!(:admin) { FactoryGirl.create(:admin) }
    before(:all) { 60.times { FactoryGirl.create(:character) } }
    after(:all)  { Character.delete_all }

    before do
      sign_in admin
      visit characters_path
    end

    it { should have_title('汉字检索') }
    it { should have_button('搜索') }

    it { should have_content('结构') }

    describe "pagination" do

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
          select '⿰', from: 'search[structure]'
          click_button "搜索"
        end

        it "should list each character" do
          Character.where(structure: '独').each do |ch|
            expect(page).to have_link(ch.unichr, character_path(ch))
          end
        end

      end

      describe "for zongbihua only" do
        before do
          fill_in 'search[zongbihua]', with: 10
          click_button "搜索"
        end

        it "should list each character" do
          Character.where(zongbihua: 10).each do |ch|
            expect(page).to have_link(ch.unichr, character_path(ch))
          end
        end

      end
    end

    describe "edit" do
      let(:character)  { Character.first }
      before do
        sign_in admin
        visit edit_character_path(character)
      end

      describe "page" do
        it { should have_content("更改汉字信息") }
        it { should have_title("编辑汉字") }
      end

      describe "with invalid information" do
        before do
          fill_in "笔画", with: ''
          click_button "保存"
        end

        it { should have_content('错误') }
      end

      describe "with valid information" do
        let(:new_bihua)  { 20 }
        before do
          fill_in "character_zongbihua", with: new_bihua
          click_button "保存"
        end

        it { should have_title('汉字检索') }
        it { should have_success_message('信息已被更新') }
        specify { expect(character.reload.zongbihua).to  eq new_bihua }
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

    #describe "forbidden attributes" do
    #  let(:params) do
    #    { user: { admin: true, password: user.password,
    #              password_confirmation: user.password } }
    #  end
    #  before { patch user_path(user), params }
    #  specify { expect(user.reload).not_to be_admin }
    #end
end