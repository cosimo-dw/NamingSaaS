require 'spec_helper'

describe Product do
  before do
    @product = Product.new(name: "Personal Naming", price: 100)
  end

  subject { @product }

  it { should respond_to(:name) }
  it { should respond_to(:price) }
  it { should respond_to(:orders) }
  it { should respond_to(:product_attributes) }

  describe "orders associations" do

    before { @product.save }
    let(:user) { FactoryGirl.create(:user) }
    let!(:older_order) do
      FactoryGirl.create(:orders, user: user, product: @product, created_at: 1.day.ago)
    end
    let!(:newer_order) do
      FactoryGirl.create(:orders, user: user, product: @product, created_at: 1.hour.ago)
    end

    it "should have the right orders in the right orders" do
      expect(@product.orders.to_a).to eq [newer_order, older_order]
    end

    it "should destroy associated orders" do
      orders = @product.orders.to_a
      @product.destroy
      expect(orders).not_to be_empty
      orders.each do |order|
        expect(Order.where(id: order.id)).to be_empty
      end
    end
  end
end
