require 'spec_helper'

describe Message do

  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order) }
  before do
    #@message = Message.new(content: "Hello world!", is_user: true, order_id: orders.id)
    @message = order.messages.build(content: "Hello world!", is_user: true)
  end

  subject { @message }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:time_stamp) }
  it { should respond_to{:order_id} }
  it { should respond_to(:is_user) }
  its(:order) { should eq order }

  it {should be_valid}

  describe "when user_id is not present" do
    before { @message.order_id = nil }
    it { should_not be_valid }                # 我去 这么神奇？
  end

  describe "with blank content" do
    before { @message.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @message.content = "a" * 501 }
    it { should_not be_valid }
  end

end
