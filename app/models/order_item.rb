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

class OrderItem < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity, :product_name
  belongs_to :order
  belongs_to :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
