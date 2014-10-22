# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
#  units        :integer
#  cost         :integer
#  manufacturer :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string(255)
#

class Product < ActiveRecord::Base
  attr_accessible :cost, :description, :manufacturer, :name, :units, :image, :remote_image_url
  has_many :order_items
  has_many :orders, through: :order_items
  validates :cost, presence: true, :numericality => {:only_integer => true}
  validates :name, presence: true
  validates :description, presence: true
  validates :manufacturer, presence: true
  validates :units, presence: true, :numericality => {:only_integer => true}
  mount_uploader :image, ProductImageUploader

  def self.search(search)
    if search
      where('name like ? or manufacturer like ?',"%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
