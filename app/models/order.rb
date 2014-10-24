# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address    :string(255)
#  status     :string(255)      default("Initiated")
#  amount     :integer          default(0)
#

class Order < ActiveRecord::Base
  attr_accessible :user_id, :address, :status
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :user_id, presence: true
  validates :address, presence: true
end
