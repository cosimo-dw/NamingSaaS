require 'spec_helper'

describe ProductAttributeValue do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product) }
  let!(:order) { FactoryGirl.create(:order, product: product, user: user, price: 12.3) }
  let!(:prod_attr) { FactoryGirl.create(:product_attribute, product: product) }
  before do
    @prod_attr_value = order.product_attribute_values.build(product_attribute: prod_attr, value: "1992-5-15")
  end

  subject { @prod_attr_value }

  it { should respond_to(:product_attribute) }
  it { should respond_to(:order) }
  it { should respond_to(:value) }
  its(:order) { should eq order }

  it { should be_valid }

  describe "when product_attribute_id is not present" do
    before { @prod_attr_value.product_attribute_id = nil }
    it { should_not be_valid }
  end

  #describe "when order_id is not present" do
  #  before { @prod_attr_value.order_id = nil }
  #  it { should_not be_valid }
  #end

  #describe "when product_id is not present" do
  #  before { @order.product_id = nil }
  #  it { should_not be_valid }
  #end
end
