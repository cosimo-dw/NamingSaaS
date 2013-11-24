require 'spec_helper'

describe "Order pages" do

  subject { page }

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:product) { FactoryGirl.create(:product) }
    let!(:orders) { FactoryGirl.create(:orders, product: product, user: user, price: 12.3) }
    before { sign_in user }

    describe "orders page" do
      before { visit order_path(order) }

      it { should have_content(order.user.name) }
      it { should have_content(order.product_id) }
    end

    describe "new orders page" do
      before { visit new_order_path }

      it { should have_content('Order') }
      it { should have_full_title('New Order') }
    end

    #describe "new orders" do
    #
    #  before { visit new_order_path }
    #
    #  let(:submit) { "Create new orders" }
    #
    #  describe "with invalid information" do
    #    it "should not create a orders" do
    #      expect { click_button submit }.not_to change(Order, :count)
    #    end
    #
    #    describe "after submission" do
    #      before { click_button submit }
    #
    #      it { should have_title('New Order') }
    #      it { should have_error }
    #    end
    #  end
    #
    #  #describe "with valid information" do
    #  #  before do
    #  #    fill_in "Name",         with: "Example User"
    #  #    fill_in "Email",        with: "user@example.com"
    #  #    fill_in "Password",     with: "foobar"
    #  #    fill_in "Confirm Password", with: "foobar"
    #  #  end
    #  #
    #  #  it "should create a orders" do
    #  #    expect { click_button submit }.to change(Order, :count).by(1)
    #  #  end
    #  #
    #  #  describe "after saving the orders" do
    #  #    before { click_button submit }
    #  #    let(:orders) { User.find_by(email: 'user@example.com') }
    #  #
    #  #    it { should have_link('Sign out') }
    #  #    it { should have_title(user.name) }
    #  #    it { should have_success_message('Welcome') }
    #  #  end
    #  #end
    #end

    describe "orders page" do
      #let(:orders) { FactoryGirl.create(:orders) }
      let!(:m1) { FactoryGirl.create(:message, orders: order, content: "Foo", is_user: true) }
      let!(:m2) { FactoryGirl.create(:message, orders: order, content: "Bar", is_user: true) }

      before { visit order_path(order) }

      it { should have_content(order.id) }
      #it { should have_title(orders.id) }

      describe "messages" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
        it { should have_content("Messages(#{order.messages.count})") }     # there is a bug here  #now no bug hahahahahaha
      end
    end
  end
end