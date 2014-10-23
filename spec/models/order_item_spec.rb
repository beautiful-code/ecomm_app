# == Schema Information
#
# Table name: order_items
#
#  id           :integer          not null, primary key
#  order_id     :integer
#  product_id   :integer
#  quantity     :integer
#  price        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_name :string(255)
#

require 'spec_helper'

describe OrderItem do
  let(:order) { FactoryGirl.create(:order) }
  let(:product) { FactoryGirl.create(:product) }
  let(:order_item) { FactoryGirl.create(:order_item, :order => order, :product => product) }

  subject { order_item }

  it { should respond_to(:id) }
  it { should respond_to(:order_id) }
  it { should respond_to(:product_id) }
  it { should respond_to(:quantity) }
  it { should respond_to(:price) }
  it { should respond_to(:address) }
  it { should be_valid }

  describe "if order id is not present" do
    before { order_item.order_id = "" }
    it { should_not be_valid }
  end

  describe "product_id is not present" do
    before { order_item.product_id = "" }
    it { should_not be_valid }
  end

  describe "quantity is less then 1" do
    before { order_item.quantity = -1 }
    it { should_not be_valid }
  end

  describe "quantity is 0" do
    before { order_item.quantity = 0 }
    it { should_not be_valid }
  end

  describe "pricee is not present" do
    before { order_item.price = "" }
    it { should_not be_valid }
  end

  describe "address is not present" do
    before { order_item.address = "" }
    it { should_not be_valid }
  end

end
