require 'spec_helper'

describe Order do

  let(:user) { FactoryGirl.create(:user) }
  before { @order = user.orders.build(product_id: 1, price: 0.1) }

  subject { @order }

  it { should respond_to(:user_id) }
  it { should respond_to(:product_id) }
  it { should respond_to(:price) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @order.user_id = nil }
    it { should_not be_valid }
  end

  describe "when product_id is not present" do
    before { @order.product_id = nil }
    it { should_not be_valid }
  end
end
