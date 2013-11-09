require 'spec_helper'

describe Order do

  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  before { @order = user.orders.build(product: product, price: 0.1) }

  subject { @order }

  it { should respond_to(:user_id) }
  it { should respond_to(:product_id) }
  it { should respond_to(:price) }
  it { should respond_to(:user) }
  it { should respond_to(:product) }
  its(:user) { should eq user }
  its(:product) { should eq product }

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
