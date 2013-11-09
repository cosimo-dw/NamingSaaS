require 'spec_helper'

describe "Order pages" do

  subject { page }

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "order page" do
      let(:order) { FactoryGirl.create(:order) }
      before { visit order_path(order) }

      it { should have_content(order.user.name) }
      it { should have_content(order.product_id) }
    end

    describe "new order page" do
      before { visit new_order_path }

      it { should have_content('New Order') }
      it { should have_full_title('New Order') }
    end

    describe "new order" do

      before { visit new_order_path }

      let(:submit) { "Create new order" }

      describe "with invalid information" do
        it "should not create a order" do
          expect { click_button submit }.not_to change(Order, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_title('New Order') }
          it { should have_error }
        end
      end

      #describe "with valid information" do
      #  before do
      #    fill_in "Name",         with: "Example User"
      #    fill_in "Email",        with: "user@example.com"
      #    fill_in "Password",     with: "foobar"
      #    fill_in "Confirm Password", with: "foobar"
      #  end
      #
      #  it "should create a order" do
      #    expect { click_button submit }.to change(Order, :count).by(1)
      #  end
      #
      #  describe "after saving the order" do
      #    before { click_button submit }
      #    let(:order) { User.find_by(email: 'user@example.com') }
      #
      #    it { should have_link('Sign out') }
      #    it { should have_title(user.name) }
      #    it { should have_success_message('Welcome') }
      #  end
      #end
    end
  end
end