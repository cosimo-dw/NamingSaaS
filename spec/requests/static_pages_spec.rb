require 'spec_helper'

describe "Static pages" do


  let(:base_title) { "易经命名" }

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_full_title(page_title) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading)    { 'saas 命名工程' }

    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| 主页') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { '帮助' }
    let(:page_title) { '帮助' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { '关于我们' }
    let(:page_title) { '关于我们' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { '联系方式' }
    let(:page_title) { '联系方式' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "关于我们"
    expect(page).to have_full_title('关于我们')
    click_link "帮助"
    expect(page).to have_full_title('帮助')
    click_link "联系方式"
    expect(page).to have_full_title('联系方式')
    click_link "主页"
    click_link "注册"
    expect(page).to have_full_title('')
    click_link "saas 命名工程"
    expect(page).to have_full_title('')
  end
end