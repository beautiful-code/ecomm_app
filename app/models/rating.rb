# == Schema Information
#
# Table name: ratings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  product_id   :integer
#  rating_value :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :rating_value
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :rating_value, presence: true
end
