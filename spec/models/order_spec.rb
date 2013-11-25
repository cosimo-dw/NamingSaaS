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

  describe "message associations" do
    before { @order.save }
    let!(:older_message) do
      FactoryGirl.create(:message, order: @order, created_at: 1.day.ago)
    end
    let!(:newer_message) do
      FactoryGirl.create(:message, order: @order, created_at: 1.hour.ago)
    end

    it "should have the right messages in the right orders" do
      expect(@order.messages.to_a).to eq [newer_message, older_message]
    end

    it "should destroy associated messages" do
      m = @order.messages.to_a
      @order.destroy
      expect(m).not_to be_empty
      m.each do |message|
        expect(Message.where(id: message.id)).to be_empty
      end
    end
  end
end
