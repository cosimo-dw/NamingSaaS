require 'spec_helper'

describe ProductAttribute do
  let(:product) { FactoryGirl.create(:product) }
  before { @prod_attr = product.product_attributes.build(name: "Birth", attr_type: "input") }

  subject { @prod_attr }

  it { should respond_to(:product_id) }
  it { should respond_to(:name) }
  it { should respond_to(:attr_type) }
  it { should respond_to(:params) }
  it { should respond_to(:product) }
  its(:product) { should eq product }

  it { should be_valid }

  describe "when product_id is not present" do
    before { @prod_attr.product_id = nil }
    it { should_not be_valid }
  end

  #describe "when product_id is not present" do
  #  before { @order.product_id = nil }
  #  it { should_not be_valid }
  #end
end
