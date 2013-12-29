require 'spec_helper'

describe "Order pages" do

  subject { page }

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:product) { FactoryGirl.create(:product) }
    let!(:order) { FactoryGirl.create(:order, product: product, user: user, price: 12.3) }
    let!(:attribute1) { FactoryGirl.create(:non_blank_attribute, product: product)}
    let!(:attribute2) { FactoryGirl.create(:product_attribute, product: product)}
    let!(:attribute3) { FactoryGirl.create(:product_attribute, product: product, multiple: true)}
    before { sign_in user }

    describe "orders page" do
      before { visit order_path(order) }

      it { should have_content(order.user.name) }
      it { should have_content(order.product_id) }
    end

    describe "new orders page" do
      before { visit new_order_path }

      it { should have_content('新的') }
      it { should have_full_title('新订单') }
      it { should have_link('返回')}
    end

    describe "new orders" do

      before { visit new_order_path }

      let(:submit) { "创建新订单" }

      describe "with invalid information" do
        it "should not create a orders" do
          expect { click_button submit }.not_to change(Order, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_title('新订单') }
          it { should have_error }
        end
      end

      describe "with valid information" do
        before do
          fill_in "*Name",         with: "Tsinghua"
          fill_in "Name",          with: "Beijing" , match: :first
        end

        it "should create a orders" do
          expect { click_button submit }.to change(Order, :count).by(1)
        end

        describe "after saving the orders" do
          before { click_button submit }

          it { should have_success_message('创建订单成功！') }
        end
      end
    end

    describe "orders page" do
      #let(:orders) { FactoryGirl.create(:orders) }
      let!(:m1) { FactoryGirl.create(:message, order: order, content: "Foo", is_user: true) }
      let!(:m2) { FactoryGirl.create(:message, order: order, content: "Bar", is_user: true) }

      before { visit order_path(order) }

      it { should have_content(order.id) }
      #it { should have_title(orders.id) }

      describe "messages" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
        it { should have_content("所有留言(#{order.messages.count})") }     # there is a bug here  #now no bug hahahahahaha

        describe "as correct user" do
          before { visit order_path(order) }

          it "should delete a micropost" do
            expect { click_button "删除", match: :first }.to change(Message, :count).by(-1)
          end
        end

        describe "creation" do
          before { visit order_path(order)}

          describe "with invalid information" do

            it "should not create a message" do
              expect { click_button "留言" }.not_to change(Message, :count)
            end

            describe "error messages" do
              before { click_button "留言" }
              it { should have_content('留言失败！') }
            end
          end

          describe "with valid information" do

            before { fill_in 'message_content', with: "Lorem ipsum" }
            it "should create a message" do
              expect { click_button "留言" }.to change(Message, :count).by(1)
            end
          end
        end
      end
    end
  end
end
