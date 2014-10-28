# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#

class Review < ActiveRecord::Base
  attr_accessible :content, :product_id, :user_id, :title
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :title, presence: true
end
